Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C94CC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA8820705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585308646;
	bh=vba1+ff8GL/oR+HlvxVDHtEKjYfF8hxoXUDYxy50Jkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j6Svk98aYFcuVY+lmfEUYB/NWY9yM4fAKMk/97c7ViitN3n1tKJ0WPZNPlxg1yLLU
	 tcP0dEkKSQLIofv30cku3/oyOF8wunMYCzLu5M0nHDv+HLKRzrdrwQlVu5f9yXbA3i
	 /r66zEq//bRnZUpPCGVYfMs1p0dFKC+0ZcqA/6k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0Lap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgC0Lap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:30:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E53C206F1;
        Fri, 27 Mar 2020 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585308644;
        bh=vba1+ff8GL/oR+HlvxVDHtEKjYfF8hxoXUDYxy50Jkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUcEMILWrBSrbYydPksBHKHAgTNmurDKsRwoO5NuElUD/R+/0tno/6tkVcXCaxyZr
         veUjBr2R1ZIkwJhtbcxuuJjILJD9M7rYrzOMlYThTJc+Iou6qAYMRZdHPjxm+ZoeSx
         A3PXxCwLfXvJNR/ovfD749uREg4ilPMnziqKW/ls=
Date:   Fri, 27 Mar 2020 12:30:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] driver core: Set fw_devlink to "permissive"
 behavior by default
Message-ID: <20200327113041.GA1708599@kroah.com>
References: <20200321210305.28937-1-saravanak@google.com>
 <CGME20200327102554eucas1p1f848633a39f8e158472506b84877f98c@eucas1p1.samsung.com>
 <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd8b42d3-a35a-cc8e-0d06-2899416c2996@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:25:48AM +0100, Marek Szyprowski wrote:
> Hi,
> 
> On 2020-03-21 22:03, Saravana Kannan wrote:
> > Set fw_devlink to "permissive" behavior by default so that device links
> > are automatically created (with DL_FLAG_SYNC_STATE_ONLY) by scanning the
> > firmware.
> >
> > This ensures suppliers get their sync_state() calls only after all their
> > consumers have probed successfully. Without this, suppliers will get
> > their sync_state() calls at late_initcall_sync() even if their consuer
> >
> > Ideally, we'd want to set fw_devlink to "on" or "rpm" by default. But
> > that needs more testing as it's known to break some corner case
> > drivers/platforms.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> 
> This patch has just landed in linux-next 20200326. Sadly it breaks 
> booting of the Raspberry Pi3b and Pi4 boards, either in 32bit or 64bit 
> mode. There is no warning nor panic message, just a silent freeze. The 
> last message shown on the earlycon is:
> 
> [    0.893217] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled

Ugh, not good.

Saravana, mind if I revert this?

thanks,

greg k-h
