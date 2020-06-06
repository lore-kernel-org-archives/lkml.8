Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D40CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18913206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591446470;
	bh=ML3S8CdEFed2kBmijE/zDiu+99L+DuJ4EM/NIgTJzU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fbpDF2X6YkaSdkn5LTVNKYvca9MdhG7MsfoWjYQvTaS1/tqjteqAbZtu5b5QQngU5
	 hRH+AT9wM9fB6P2JKIqjpzMRqx7iJSCxPwiWiGOQp3vlv+lt/T4YGAhjyjmUJDxDHH
	 n3/jagBVYFzCFqAvvs75l0tDBeztn3RfZO+YDCJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgFFM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 08:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgFFM1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 08:27:45 -0400
Received: from Mani-XPS-13-9360 (unknown [157.50.82.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11509206A2;
        Sat,  6 Jun 2020 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591446465;
        bh=ML3S8CdEFed2kBmijE/zDiu+99L+DuJ4EM/NIgTJzU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PARj/IYRAC+7cokvgctBmUVc3neIR7I9whdl/ScFEWGQrdfOMzeOH/mNPFJ6zdq/H
         7hwrDsoOJbgWoArYLN7pvaxG/Aci7MPG3xRv2EIV7YyK43sk+7oo0pxt7VfMFj9MBm
         +F6uJxwibIv/TsKy0OAL/EO93gt9Fq0nMcLG6c1w=
Date:   Sat, 6 Jun 2020 17:57:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com
Subject: Re: [PATCH v3 0/2] Add support for MaxLinear/Exar USB to serial
 converters
Message-ID: <20200606122735.GB31973@Mani-XPS-13-9360>
References: <20200430184924.31690-1-mani@kernel.org>
 <20200605131355.18107dbb@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605131355.18107dbb@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Fri, Jun 05, 2020 at 01:13:55PM +0200, Mauro Carvalho Chehab wrote:
> Em Fri,  1 May 2020 00:19:22 +0530
> mani@kernel.org escreveu:
> 
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Hello,
> > 
> > This series adds support for MaxLinear/Exar USB to serial converters.
> > This driver only supports XR21V141X series but it can easily be extended
> > to other series in future.
> > 
> > This driver is inspired from the initial one submitted by Patong Yang:
> > 
> > https://patchwork.kernel.org/patch/10543261/
> > 
> > While the initial driver was a custom tty USB driver exposing whole
> > new serial interface ttyXRUSBn, this version is completely based on USB
> > serial core thus exposing the interfaces as ttyUSBn. This will avoid
> > the overhead of exposing a new USB serial interface which the userspace
> > tools are unaware of.
> 
> Hmm... I guess you also need the enclosed patch, to ensure that cdc_acm
> won't try to hijack it, when the Kernel is built with both drivers.
> 

Ah right. I will include this patch in next iteration. Many thanks!

Regards,
Mani

> Thanks,
> Mauro
> 
> [PATCH] usb: cdc-acm: ignore Exar XR21V141X when serial driver is
>  built
> 
> The RTS/CTS line discipline for this device doesn't follow
> the standard. So, in order to properly support TX, a separate
> driver is needed.
> 
> Ensure that cdc_acm will ignore it during probe time, if the
> Kernel is built with support for it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index ded8d93834ca..f87288834ded 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1889,7 +1889,11 @@ static const struct usb_device_id acm_ids[] = {
>  	.driver_info = IGNORE_DEVICE,
>  	},
>  #endif
> -
> +#if IS_ENABLED(CONFIG_USB_SERIAL_XR)
> +	{ USB_DEVICE(0x04e2, 0x1410),   /* XR21V141X uses a different rts/cts discipline */
> +	.driver_info = IGNORE_DEVICE,
> +	},
> +#endif
>  	/*Samsung phone in firmware update mode */
>  	{ USB_DEVICE(0x04e8, 0x685d),
>  	.driver_info = IGNORE_DEVICE,
> 
