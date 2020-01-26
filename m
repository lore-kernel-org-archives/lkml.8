Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F37C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8952071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580055499;
	bh=mNmzdpdlN+DRC9Hv252ix7aTt4qzHeJuRD6QcUsDtBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FTXxtVzFgGC+EByj9qQcz3aTbi+Aot+4bbNi/6nhUzIqF7xqi8rpyoakO7aeBY3EN
	 5nc/1lNYng5Jr3d4p354ZEcCvN13LwpBS7vGww1fHK0mnDoCrtVj/ks3rksBUcqRnb
	 q4YFMPjk+D1Ooiw8ATszHTQRc6glL0rob6vXaO/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgAZQSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 11:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZQSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 11:18:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4084B2071A;
        Sun, 26 Jan 2020 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580055496;
        bh=mNmzdpdlN+DRC9Hv252ix7aTt4qzHeJuRD6QcUsDtBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXsKsK20OWJ+IVPj6XWepgXw1TEJFaXaMhmVCeNtxFXU1QywMkFnlTMGCLHIRLOe6
         5KcdjbdIGAa01QUgBOkKkq7Rv/60/tidUtcFZ0vPLcROoCyO9yeL3wHbEFauLbDpIw
         DQOEBnJ4SjsAnG0ka93XA2CN3rWjH9JymgXa50AM=
Date:   Sun, 26 Jan 2020 17:18:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] usb: musb: Fix external abort on non-linefetch
Message-ID: <20200126161812.GA4085985@kroah.com>
References: <20200126161156.GA20401@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126161156.GA20401@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 09:41:56PM +0530, Saurav Girepunje wrote:
> While accessing the usb mode/vbus from sysfs. Below error came on kernel
> version 4.19.
> 
> On latest kernel vserion api name changed. Therefore API
> name and backtrace API names are different.
> 
>     [  821.908066] Backtrace:
>     [  821.910695] [<bf078fc0>] (musb_default_readl [musb_hdrc]) from [<bf0af738>] (dsps_musb_set_mode+0x38/0x12c [musb_dsps])
>     [  821.922059] [<bf0af700>] (dsps_musb_set_mode [musb_dsps]) from [<bf07899c>] (musb_mode_store+0xc8/0x12c [musb_hdrc])
>     [  821.933105]  r7:a0010013 r6:0000000b r5:cd79d200 r4:cb634010
>     [  821.939096] [<bf0788d4>] (musb_mode_store [musb_hdrc]) from [<c0425184>] (dev_attr_store+0x20/0x2c)
>     [  821.948593]  r7:cd79d200 r6:c5abbf78 r5:00000000 r4:bf0788d4
>     [  821.954549] [<c0425164>] (dev_attr_store) from [<c0285b08>] (sysfs_kf_write+0x48/0x4c)
>     [  821.962859]  r5:00000000 r4:c0425164
>     [  821.966620] [<c0285ac0>] (sysfs_kf_write) from [<c0285274>] (kernfs_fop_write+0xfc/0x1fc)
>     [  821.975200]  r5:00000000 r4:cd79d080
>     [  821.978966] [<c0285178>] (kernfs_fop_write) from [<c020ec00>] (__vfs_write+0x34/0x120)
>     [  821.987280]  r10:00000000 r9:0000000b r8:00000000 r7:0000000b r6:c5abbf78 r5:c0285178
>     [  821.995493]  r4:cb67a3c0
>     [  821.998160] [<c020ebcc>] (__vfs_write) from [<c020fae8>] (vfs_write+0xa8/0x170)
>     [  822.005835]  r9:0000000b r8:00000000 r7:c5abbf78 r6:000def80 r5:cb67a3c0 r4:0000000b
>     [  822.013969] [<c020fa40>] (vfs_write) from [<c02108d0>] (SyS_write+0x44/0x98)
>     [  822.021371]  r9:0000000b r8:000def80 r7:00000000 r6:00000000 r5:cb67a3c0 r4:cb67a3c0
>     [  822.029517] [<c021088c>] (SyS_write) from [<c010d8a0>] (ret_fast_syscall+0x0/0x3c)
>     [  822.037467]  r9:c5aba000 r8:c010daa8 r7:00000004 r6:b6f0ad58 r5:000def80 r4:0000000b
>     [  822.045599] Code: e1a0c00d e92dd800 e24cb004 e0801001 (e5910000)
> 
> Without pm_runtime_{get,put}_sync calls in place,
> Similar issue come on "mode_show" and "vbus_store" also.
> 
> fix- call pm_runtime_{get,put}_sync before reading/writing
> usb mode/vbus from sysfs.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/usb/musb/musb_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 5ebf30b..a1ca8380 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1723,9 +1723,11 @@ int musb_mailbox(enum musb_vbus_id_status status)
>  	unsigned long flags;
>  	int ret;
> +	pm_runtime_get_sync(dev);
>  	spin_lock_irqsave(&musb->lock, flags);
>  	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->otg->state));
>  	spin_unlock_irqrestore(&musb->lock, flags);
> +	pm_runtime_put_sync(dev);
>  	return ret;
>  }

<snip>

Always run checkpatch.pl on patches so that you do not get grumpy
maintainers telling you to run checkpatch.pl on your patch :(

(hint, you need a new line after the variable definitions...)

greg k-h
