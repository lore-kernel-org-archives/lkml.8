Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3C3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2FF20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594475977;
	bh=VCNazDGXDe9TTx4C3+c6fx6cBMGJaPBEU1mA1ZaENlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UlUIjTnXFkVT0aRlP4J5SmX/eLmyZWYYYw21DKDc+SkRXkbTEb5P5Zhh/OetV4V6C
	 SZZ2X0hlfddNsnVZbEH+xQVI+zHVau3H1rIRzNWJPpxdmREAeTQVWOxpHyD32PHeY5
	 Tb0F6im0qsQZlfGRXWaHw7wnV5q01UlRgjqjI6Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgGKN7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgGKN7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:59:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213352075F;
        Sat, 11 Jul 2020 13:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594475974;
        bh=VCNazDGXDe9TTx4C3+c6fx6cBMGJaPBEU1mA1ZaENlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+W7r0lAu+n5kBPlQXWEaJ/aTq1lCoj4OaSn0YrYLCAEHCOSndm0TIII6UGMxVF6X
         dcpg9wjpFaat+fwrc+qTbN/VSsM/PToDEJUnQr0Atls5sJOvVNj/Jm4YkJEziXRIDd
         piOeBKbft3s/IIFZwG0nkHl6UH+R6ohKCueCanaY=
Date:   Sat, 11 Jul 2020 21:59:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Suniel Mahesh <sunil@amarulasolutions.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, gregkh@linuxfoundation.org,
        sashal@kernel.org, jagan@amarulasolutions.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2] arch: arm: imx6qdl-icore: Fix OTG_ID pin and sdcard
 detect
Message-ID: <20200711135925.GG21277@dragon>
References: <CAOf5uwkrjj98+_8Hn40ujn2bLz_oYb7FCWcuO8yNn2y0ewMehg@mail.gmail.com>
 <1592623696-21485-1-git-send-email-sunil@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592623696-21485-1-git-send-email-sunil@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 08:58:16AM +0530, Suniel Mahesh wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> The current pin muxing scheme muxes GPIO_1 pad for USB_OTG_ID
> because of which when card is inserted, usb otg is enumerated
> and the card is never detected.
> 
> [   64.492645] cfg80211: failed to load regulatory.db
> [   64.492657] imx-sdma 20ec000.sdma: external firmware not found, using ROM firmware
> [   76.343711] ci_hdrc ci_hdrc.0: EHCI Host Controller
> [   76.349742] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 2
> [   76.388862] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> [   76.396650] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.08
> [   76.405412] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [   76.412763] usb usb2: Product: EHCI Host Controller
> [   76.417666] usb usb2: Manufacturer: Linux 5.8.0-rc1-next-20200618 ehci_hcd
> [   76.424623] usb usb2: SerialNumber: ci_hdrc.0
> [   76.431755] hub 2-0:1.0: USB hub found
> [   76.435862] hub 2-0:1.0: 1 port detected
> 
> The TRM mentions GPIO_1 pad should be muxed/assigned for card detect
> and ENET_RX_ER pad for USB_OTG_ID for proper operation.
> 
> This patch fixes pin muxing as per TRM and is tested on a
> i.Core 1.5 MX6 DL SOM.
> 
> [   22.449165] mmc0: host does not support reading read-only switch, assuming write-enable
> [   22.459992] mmc0: new high speed SDHC card at address 0001
> [   22.469725] mmcblk0: mmc0:0001 EB1QT 29.8 GiB
> [   22.478856]  mmcblk0: p1 p2
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>

Do you need to have Fixes tag and copy stable kernel?

Also, subject prefix should be like 'ARM: dts: ...'

Shawn

> ---
> Changes for v2:
> - Changed patch description as suggested by Michael Trimarchi to make it
>   more readable/understandable.
> ---
>  arch/arm/boot/dts/imx6qdl-icore.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
> index 756f3a9..12997da 100644
> --- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
> @@ -397,7 +397,7 @@
>  
>  	pinctrl_usbotg: usbotggrp {
>  		fsl,pins = <
> -			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
> +			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
>  		>;
>  	};
>  
> @@ -409,6 +409,7 @@
>  			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17070
>  			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17070
>  			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17070
> +			MX6QDL_PAD_GPIO_1__GPIO1_IO01  0x1b0b0
>  		>;
>  	};
>  
> -- 
> 2.7.4
> 
