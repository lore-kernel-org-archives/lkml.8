Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8D8C35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09EB206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582509779;
	bh=cHdXWjpBFusazvMN9LdKno9+AYhTzTc6BdgJplICU2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QEBAgbbAtmxHWb8I/o7uVlR8lx2gDxGGaTY8tpgputQ/O74cTa3R2VzSgKKTfTye5
	 /S2nkn9dp8oQlw5aE+d5Lx6kWFTbLlPXaoVTKnqDSaKwEKsRuyV8+ysKihTljJAx6I
	 UCHIa1UFZrycUcLPFl30lPJZXCwFJO7TWBvFmRiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBXCC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXCC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:02:58 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8D82051A;
        Mon, 24 Feb 2020 02:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582509777;
        bh=cHdXWjpBFusazvMN9LdKno9+AYhTzTc6BdgJplICU2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsznOYtCHh2XnqXgIpKmtke23itFEAACrRE3GJiz6WIYoGItnDbBIu3DMTSQtZ9R4
         kBmDpblUpygrz979M3SO6qGIspeWwJF31KLot86qxH5FCUJlWSgubL70CosOXXfP/V
         HKSE7N22nGHlH8PYegB3WYfXDm8KymJHCI5bOJoA=
Date:   Mon, 24 Feb 2020 10:02:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH v2 4/9] arm64: dts: librem5-devkit: allow modem to wake
 the system from suspend
Message-ID: <20200224020251.GF27688@dragon>
References: <20200218084942.4884-1-martin.kepplinger@puri.sm>
 <20200218084942.4884-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218084942.4884-5-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:49:37AM +0100, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> Connect the WoWWAN signal to a gpio key to wake up the system from suspend.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index ec12477d925d..9c81b07f43f3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -55,6 +55,15 @@
>  			wakeup-source;
>  			linux,code = <KEY_HP>;
>  		};
> +
> +		wwan_wake {

We prefer to use hyphen over underscore in node name.

Shawn

> +			label = "WWAN_WAKE";
> +			gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
> +			interrupt-parent = <&gpio3>;
> +			interrupts = <8 GPIO_ACTIVE_LOW>;
> +			wakeup-source;
> +			linux,code = <KEY_PHONE>;
> +		};
>  	};
>  
>  	leds {
> @@ -574,6 +583,7 @@
>  			MX8MQ_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x16
>  			MX8MQ_IOMUXC_SAI2_RXC_GPIO4_IO22	0x16
>  			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x180  /* HP_DET */
> +			MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80   /* nWoWWAN */
>  		>;
>  	};
>  
> -- 
> 2.20.1
> 
