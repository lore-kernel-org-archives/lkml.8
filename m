Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11895C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58AD2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595331655;
	bh=KcPGx9QiMCmxNN2YSoGE/dQIrCs7akN/oOdzsJC69/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v8m5emqYZ4/8MiORs5U4KD2l8q5xDaWXEKTc8mBge1PIKgdWB7ZhPbFnfcP+7CGUb
	 xqjtziaWWdFqtXVEaDl4RdaBGYNDSsN5Nn2F+KIUmQpy96pNvme5Z3BEMppO07Iq5n
	 Whbn/0Byi0OwUt8PJtEzh9egp69Pc6tofzK4D5ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgGULky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbgGULky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:40:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300BF2073A;
        Tue, 21 Jul 2020 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595331653;
        bh=KcPGx9QiMCmxNN2YSoGE/dQIrCs7akN/oOdzsJC69/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mj34L9PXujfgj94Dv1Bc0pSVSYyGAuYifoobe26I7vzlECi2pAFm4j3KlfcCohwAR
         p2Xlcs9vVlaLLmXr5UwEacq0xvjx2j6aGix63EXm0A6cvXhD0RxBFXXcYjlXCn2LTW
         iK482uy/vXnfjeC8Wz2I5jBNfUU4affwg+F5EH04=
Date:   Tue, 21 Jul 2020 13:41:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional
 charger
Message-ID: <20200721114101.GA1761915@kroah.com>
References: <20200621224807.882184-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621224807.882184-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:48:07AM +0200, Paul Cercueil wrote:
> Register a power supply charger, if the Kconfig option
> USB_CONN_GPIO_CHARGER is set, whose online state depends on whether
> the USB role is set to device or not.
> 
> This is useful when the USB role is the only way to know if the device
> is charging from USB. The API is the standard power supply charger API,
> you get a /sys/class/power_supply/xxx/online node which tells you the
> state of the charger.
> 
> The sole purpose of this is to give userspace applications a way to
> know whether or not the charger is plugged.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/common/Kconfig         | 11 +++++++
>  drivers/usb/common/usb-conn-gpio.c | 47 ++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
> index d611477aae41..5405ae96c68f 100644
> --- a/drivers/usb/common/Kconfig
> +++ b/drivers/usb/common/Kconfig
> @@ -49,3 +49,14 @@ config USB_CONN_GPIO
>  
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called usb-conn-gpio.ko
> +
> +if USB_CONN_GPIO
> +
> +config USB_CONN_GPIO_CHARGER
> +	bool "USB charger support"
> +	select POWER_SUPPLY
> +	help
> +	  Register a charger with the power supply subsystem. This will allow
> +	  userspace to know whether or not the device is charging from USB.

Why make this an option at all?  Why wouldn't we always want this here?

As this is a charger, exporting that information to userspace should
probably always happen, right?

thanks,

greg k-h
