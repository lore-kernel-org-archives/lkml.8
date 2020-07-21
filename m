Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6095320729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595369575;
	bh=dI9lxg58mjt0Vo60nW5Ycuenb3uhXCAR65ohWNLBhS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=qBSGIgs+WYEC7tUpZck3yTqex/zlsRh7xhbEFFQVrcd/kfNWVDAjHeIHCp3Ll4OTD
	 xXgdlf15j8gR8XwQw+ITankTMDzZPEtrMr97DuUQ1ORbAF/kDRfrK6raK4qFFrE+G8
	 V3+GY3OiiAo6hDSrMy9cuvueyW3XYNS3GQsZ/eQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgGUWMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgGUWMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:12:53 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0005020717;
        Tue, 21 Jul 2020 22:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595369573;
        bh=dI9lxg58mjt0Vo60nW5Ycuenb3uhXCAR65ohWNLBhS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I/T/JAJuBiE5B7+bWgqxLEL/wIxAmm5LpWcCGwR20MNg7LBKmtL+VWlV6Cfj7QmrK
         T4UJl7jjdx3a3KyQJJlTe77bbPwZHG6/ynI+NNuY9INqcY0DBbA2DjGbTRetMP1qA+
         DjTGHTlTwjtO6v2YCYy4eIRCWLhq7AjxqJiECnyM=
Date:   Tue, 21 Jul 2020 17:12:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] virtio-mmio: Reject invalid IRQ 0 command line
 argument
Message-ID: <20200721221251.GA1164301@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <032d0424-4876-6322-76d2-d733db28addb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:06:11AM +0800, Jason Wang wrote:
> On 2020/7/2 上午6:10, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The "virtio_mmio.device=" command line argument allows a user to specify
> > the size, address, and IRQ of a virtio device.  Previously the only
> > requirement for the IRQ was that it be an unsigned integer.
> > 
> > Zero is an unsigned integer but an invalid IRQ number, and after
> > a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid"),
> > attempts to use IRQ 0 cause warnings.
> > 
> > If the user specifies IRQ 0, return failure instead of registering a device
> > with IRQ 0.
> > 
> > Fixes: a85a6c86c25be ("driver core: platform: Clarify that IRQ 0 is invalid")
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > ---
> >   drivers/virtio/virtio_mmio.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 9d16aaffca9d..627ac0487494 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -641,11 +641,11 @@ static int vm_cmdline_set(const char *device,
> >   			&vm_cmdline_id, &consumed);
> >   	/*
> > -	 * sscanf() must processes at least 2 chunks; also there
> > +	 * sscanf() must process at least 2 chunks; also there
> >   	 * must be no extra characters after the last chunk, so
> >   	 * str[consumed] must be '\0'
> >   	 */
> > -	if (processed < 2 || str[consumed])
> > +	if (processed < 2 || str[consumed] || irq == 0)
> >   		return -EINVAL;
> >   	resources[0].flags = IORESOURCE_MEM;
> 
> Acked-by: Jason Wang <jasowang@redhat.com>

Thanks, I applied this to my for-linus branch for v5.8.
