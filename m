Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE00206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3CHwd3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgEDQJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:09:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27867 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728294AbgEDQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588608566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOI+TMZk0mW52qGvJviHKz87dbXpvjDlm/3+gbp0a/U=;
        b=G3CHwd3NwXnSwLzZYKtPNyBTRJagaWxZopd1A+I8bzHx8TlEI9XaQeVVkbse0a+puHJFig
        vFQwM93PtZliy/ESqZhOuCFVrWnryQ2gsSJ+qLhBUOgDzIyp3HWJRpaCfBPmC6LG4ivu41
        Fxe/nyPjCxJ0SqogSnlHAtdTypcVlYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Ar8pQBrtMzebeUSBYqXFJw-1; Mon, 04 May 2020 12:09:23 -0400
X-MC-Unique: Ar8pQBrtMzebeUSBYqXFJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0DF88014D5;
        Mon,  4 May 2020 16:09:22 +0000 (UTC)
Received: from gondolin (ovpn-112-215.ams2.redhat.com [10.36.112.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D84232DE6B;
        Mon,  4 May 2020 16:09:18 +0000 (UTC)
Date:   Mon, 4 May 2020 18:09:16 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-pci: Mask cap zero
Message-ID: <20200504180916.0e90cad9.cohuck@redhat.com>
In-Reply-To: <158836927527.9272.16785800801999547009.stgit@gimli.home>
References: <158836927527.9272.16785800801999547009.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 May 2020 15:41:24 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> There is no PCI spec defined capability with ID 0, therefore we don't
> expect to find it in a capability chain and we use this index in an
> internal array for tracking the sizes of various capabilities to handle
> standard config space.  Therefore if a device does present us with a
> capability ID 0, we mark our capability map with nonsense that can
> trigger conflicts with other capabilities in the chain.  Ignore ID 0
> when walking the capability chain, handling it as a hidden capability.
> 
> Seen on an NVIDIA Tesla T4.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 87d0cc8c86ad..5935a804cb88 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1487,7 +1487,7 @@ static int vfio_cap_init(struct vfio_pci_device *vdev)
>  		if (ret)
>  			return ret;
>  
> -		if (cap <= PCI_CAP_ID_MAX) {

Maybe add a comment:

/* no PCI spec defined capability with ID 0: hide it */

?

> +		if (cap && cap <= PCI_CAP_ID_MAX) {
>  			len = pci_cap_length[cap];
>  			if (len == 0xFF) { /* Variable length */
>  				len = vfio_cap_len(vdev, cap, pos);
> 

Is there a requirement for caps to be strictly ordered? If not, could
len hold a residual value from a previous iteration?

