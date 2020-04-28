Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC2C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002A2206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVlmoGNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD1KzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD1KzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:55:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC39C03C1A9;
        Tue, 28 Apr 2020 03:55:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so22476200wrx.3;
        Tue, 28 Apr 2020 03:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlAa5M7UQwKTbD3evwN5h/gQVPwTCCDR3BLzruxeyOM=;
        b=RVlmoGNuTj5gM08jHagV5UFb97gC8S/EbTRO2VzQoVW3FSH4XvKzo7QqY+D2NigPrO
         QefkWOBapZ8naeOL+71yoU8VWUYv7FGvC3tXpY13FPDK75//R2qpopBNY8PicQZABgXg
         oKrmztDMs40j+9CZ27gC7DtinaKUAGXDGExfr/ZxYwsLlp2BtnkkoSgVjHo+7CxFOu5R
         352LxyHCicB1GCxykVanXdqeu8HvgIw1MtK/xHtFFrihX3pLEDxii5m2Ree+Yxr5um1p
         W9p0E1CKEsd+4yjndwZU51TU5MQ1SQU+Hcw2LqKWzGZB8vwDfpfh0lkw8YlP4X1OBYRI
         Oezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlAa5M7UQwKTbD3evwN5h/gQVPwTCCDR3BLzruxeyOM=;
        b=ub3wR3Q71S31361qKx+0HcIGWqS7GcVPrIWP9DpuX4/kTcj5GbmgyhqDQ57K29yadG
         50bxPptzDA+No8T/uj1ol4uYDCcYPOU6txZnUiyW2ZZSOIleGMdUk/BxiSfrrb9r35KW
         1U0xWB3PIouIkxh5FGirL52xcukTIuZwcngCSOOjOVG8gC0bh8REUbVPDb5+JIOf3FOn
         u6nT6qEJoOC5B4WyiyxH03qHMyvnt9VHoi0ziPUTEynLxe1cGuNUMgA/lR5TEIiZjt/n
         hzvNn6zwt+YaNtivRlp0XZ3SXQwvrgCtRv5uotyl1LBm2e5q4/6Vda3fCrs3znqQ3v23
         TilQ==
X-Gm-Message-State: AGi0PuYIjPBde3PPYeUhrP13tZKZW5rKBPAvbdaXVXzgNt+OPlhGMEBr
        AKi6Kk/Q2D3oFYw+s68bz2Q=
X-Google-Smtp-Source: APiQypKCDp6JU/2UpUb0E1CaEI/qyfZAqwOUKJkBl1W+EA9TjHn50KGvo6zkjaxU3rxMHuIsGtwG2w==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr31455390wrx.62.1588071312750;
        Tue, 28 Apr 2020 03:55:12 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id s8sm24920992wru.38.2020.04.28.03.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:55:11 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:55:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 6/8] phy: tegra: xusb: Add support for charger detect
Message-ID: <20200428105510.GH3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-7-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-7-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:06PM +0530, Nagarjuna Kristam wrote:
> Perform charger-detect operation if corresponding dt property is enabled.
> Update usb-phy with the detected charger state and max current values.
> Register charger-detect API's of usb-phy to provide needed functionalitie=
s.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/Makefile        |   2 +-
>  drivers/phy/tegra/xusb-tegra-cd.c | 300 ++++++++++++++++++++++++++++++++=
++++++
>  drivers/phy/tegra/xusb.c          |  80 ++++++++++
>  drivers/phy/tegra/xusb.h          |   7 +
>  4 files changed, 388 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/phy/tegra/xusb-tegra-cd.c

Looks mostly good to me, just a few small nits.

>=20
> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
> index 89b8406..25ea9a9 100644
> --- a/drivers/phy/tegra/Makefile
> +++ b/drivers/phy/tegra/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_PHY_TEGRA_XUSB) +=3D phy-tegra-xusb.o
> =20
> -phy-tegra-xusb-y +=3D xusb.o
> +phy-tegra-xusb-y +=3D xusb.o xusb-tegra-cd.o

Splitting this off into a separate file seems a little arbitrary. If
adding this to xusb.c is really making things too unwieldy, I'd suggest
a different name. Perhaps something like xusb-charger.c, or just cd.c.
This is already in a directory called "tegra" and it's obvious also that
this is part of the XUSB PHY driver.

>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) +=3D xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) +=3D xusb-tegra124.o
>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) +=3D xusb-tegra210.o
> diff --git a/drivers/phy/tegra/xusb-tegra-cd.c b/drivers/phy/tegra/xusb-t=
egra-cd.c
> new file mode 100644
> index 0000000..0fafc68
> --- /dev/null
> +++ b/drivers/phy/tegra/xusb-tegra-cd.c
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, NVIDIA CORPORATION.  All rights reserved.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +
> +#include "xusb.h"
> +
> +/* Data contact detection timeout */
> +#define TDCD_TIMEOUT_MS                         400
> +
> +#define USB2_BATTERY_CHRG_OTGPADX_CTL0(x)       (0x80 + (x) * 0x40)
> +#define  PD_CHG                                 (1 << 0)
> +#define  VDCD_DET_FILTER_EN                     (1 << 4)
> +#define  VDAT_DET                               (1 << 5)
> +#define  VDAT_DET_FILTER_EN                     (1 << 8)
> +#define  OP_SINK_EN                             (1 << 9)
> +#define  OP_SRC_EN                              (1 << 10)
> +#define  ON_SINK_EN                             (1 << 11)
> +#define  ON_SRC_EN                              (1 << 12)
> +#define  OP_I_SRC_EN                            (1 << 13)
> +#define  ZIP_FILTER_EN                          (1 << 21)
> +#define  ZIN_FILTER_EN                          (1 << 25)
> +#define  DCD_DETECTED                           (1 << 26)
> +
> +#define USB2_BATTERY_CHRG_OTGPADX_CTL1(x)       (0x84 + (x) * 0x40)
> +#define  PD_VREG                                (1 << 6)
> +#define  VREG_LEV(x)                            (((x) & 0x3) << 7)
> +#define  VREG_DIR(x)                            (((x) & 0x3) << 11)
> +#define  VREG_DIR_IN                            VREG_DIR(1)
> +#define  VREG_DIR_OUT                           VREG_DIR(2)
> +#define  USBOP_RPD_OVRD                         (1 << 16)
> +#define  USBOP_RPD_OVRD_VAL                     (1 << 17)
> +#define  USBOP_RPU_OVRD                         (1 << 18)
> +#define  USBOP_RPU_OVRD_VAL                     (1 << 19)
> +#define  USBON_RPD_OVRD                         (1 << 20)
> +#define  USBON_RPD_OVRD_VAL                     (1 << 21)
> +#define  USBON_RPU_OVRD                         (1 << 22)
> +#define  USBON_RPU_OVRD_VAL                     (1 << 23)
> +
> +#define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)

There's a bit of a mix of spaces and tabs for indentation here. Just
pick one and stick with it. I think checkpatch will want you to use tabs
first and then spaces if additional indentation is needed.

> +#define  USB2_OTG_PD2                           (1 << 27)
> +#define  USB2_OTG_PD2_OVRD_EN                   (1 << 28)
> +#define  USB2_OTG_PD_ZI                         (1 << 29)
> +
> +#define XUSB_PADCTL_USB2_BATTERY_CHRG_TDCD_DBNC_TIMER_0 (0x280)
> +#define   TDCD_DBNC(x)                          (((x) & 0x7ff) << 0)
> +
> +static void tegra_xusb_padctl_set_debounce_time(
> +				struct tegra_xusb_padctl *padctl, u32 val)

Perhaps rename "val" to something like "debounce", or "delay" or
something to avoid the "val" vs. "value" confusion. Also, wrapping
should be after the return type. Same for most functions below.

> +{
> +	u32 value;
> +
> +	value =3D padctl_readl(padctl,
> +		XUSB_PADCTL_USB2_BATTERY_CHRG_TDCD_DBNC_TIMER_0);
> +	value &=3D ~(TDCD_DBNC(0));
> +	value |=3D TDCD_DBNC(val);
> +	padctl_writel(padctl, value,
> +		XUSB_PADCTL_USB2_BATTERY_CHRG_TDCD_DBNC_TIMER_0);
> +}
> +
> +static void tegra_xusb_padctl_utmi_pad_charger_detect_on(
> +				struct tegra_xusb_padctl *padctl, u32 index)

In general these function names are a little long for my taste. Charger
detection can only happen on UTMI pads, right? So could we just drop the
_utmi_pad infix in these? That doesn't give us much, but at least it
should make splitting this across multiple lines less awkward.

> +{
> +	u32 value;
> +
> +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +	value &=3D ~USB2_OTG_PD_ZI;
> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +
> +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +	value |=3D (USB2_OTG_PD2 | USB2_OTG_PD2_OVRD_EN);
> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value &=3D ~PD_CHG;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	/* Set DP/DN Pull up/down to zero by default */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +	value &=3D ~(USBOP_RPD_OVRD_VAL | USBOP_RPU_OVRD_VAL |
> +		USBON_RPD_OVRD_VAL | USBON_RPU_OVRD_VAL);
> +	value |=3D (USBOP_RPD_OVRD | USBOP_RPU_OVRD |
> +		USBON_RPD_OVRD | USBON_RPU_OVRD);
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +
> +	/* Disable DP/DN as src/sink */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value &=3D ~(OP_SRC_EN | ON_SINK_EN |
> +	ON_SRC_EN | OP_SINK_EN);
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +}
> +
> +static void tegra_xusb_padctl_utmi_pad_charger_detect_off(
> +				struct tegra_xusb_padctl *padctl, u32 index)
> +{
> +	u32 value;
> +
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +	value &=3D ~(USBOP_RPD_OVRD | USBOP_RPU_OVRD |
> +		 USBON_RPD_OVRD | USBON_RPU_OVRD);
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +
> +	/* power down necessary stuff */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value |=3D PD_CHG;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	value =3D padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +	value &=3D ~(USB2_OTG_PD2 | USB2_OTG_PD2_OVRD_EN);
> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +}
> +
> +
> +static void tegra_xusb_padctl_detect_filters(
> +				struct tegra_xusb_padctl *padctl, u32 index,
> +				bool on)
> +{
> +	u32 value;
> +
> +	if (on) {
> +		value =3D padctl_readl(padctl,
> +				     USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +		value |=3D (VDCD_DET_FILTER_EN | VDAT_DET_FILTER_EN |
> +			  ZIP_FILTER_EN | ZIN_FILTER_EN);
> +		padctl_writel(padctl, value,
> +			      USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	} else {
> +		value =3D padctl_readl(padctl,
> +				     USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +		value &=3D ~(VDCD_DET_FILTER_EN | VDAT_DET_FILTER_EN |
> +			   ZIP_FILTER_EN | ZIN_FILTER_EN);
> +		padctl_writel(padctl, value,
> +			      USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	}
> +}
> +
> +static void tegra_xusb_padctl_utmi_pad_dcd(struct tegra_xusb_padctl *pad=
ctl,
> +					      u32 index)
> +{
> +	u32 value;
> +	int dcd_timeout_ms =3D 0;
> +	bool ret =3D false;
> +
> +	/* Turn on IDP_SRC */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value |=3D OP_I_SRC_EN;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	/* Turn on D- pull-down resistor */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +	value |=3D USBON_RPD_OVRD_VAL;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +
> +	/* Wait for TDCD_DBNC */
> +	usleep_range(10000, 120000);

=46rom the comment this looks like we're waiting for some hardware
condition. Can we somehow obtain this rather than implementing a fixed
sleep? Especially since the range here is so large.

> +
> +	while (dcd_timeout_ms < TDCD_TIMEOUT_MS) {
> +		value =3D padctl_readl(padctl,
> +				     USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +		if (value & DCD_DETECTED) {
> +			dev_dbg(padctl->dev, "USB2 port %d DCD successful\n",
> +				index);
> +			ret =3D true;
> +			break;
> +		}
> +
> +		usleep_range(20000, 22000);
> +		dcd_timeout_ms +=3D 22;
> +	}

Can we just use a timed loop instead? You should be able to use
something like:

		unsigned int offset =3D USB2_BATTERY_CHRG_OTGPADX_CTL0(index);

		err =3D readl_poll_timeout(padctl->regs + offset, value,
					 value & DCD_DETECTED,
					 22000, TDCD_TIMEOUT_MS * 1000);

That's slightly suboptimal because it doesn't let you use padctl_readl,
but at least it gives you a standard way of doing this kind of loop.

> +
> +	if (!ret)
> +		dev_info(padctl->dev, "%s: DCD timeout %d ms\n", __func__,
> +			 dcd_timeout_ms);

Should this be a dev_err() or dev_warn()? Is this expected to happen?

> +
> +	/* Turn off IP_SRC, clear DCD DETECTED*/
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value &=3D ~OP_I_SRC_EN;
> +	value |=3D DCD_DETECTED;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	/* Turn off D- pull-down resistor */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +	value &=3D ~USBON_RPD_OVRD_VAL;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +
> +	dev_dbg(padctl->dev, "DCD: %d\n", ret);
> +}
> +
> +static bool tegra_xusb_padctl_utmi_pad_primary_charger_detect(
> +				struct tegra_xusb_padctl *padctl, u32 index)
> +{
> +	u32 value;
> +	int ret =3D false;

It doesn't look like there's a need to initialize this.

> +
> +	/* data contact detection */
> +	tegra_xusb_padctl_utmi_pad_dcd(padctl, index);
> +
> +	/* Source D+ to D- */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value |=3D OP_SRC_EN | ON_SINK_EN;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	/* Wait for TVDPSRC_ON */
> +	msleep(40);

Again, is this a hardware condition that we can wait on by polling a
register?

> +
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	ret =3D !!(value & VDAT_DET);
> +
> +	/* Turn off OP_SRC, ON_SINK, clear VDAT, ZIN status change */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value &=3D ~(OP_SRC_EN | ON_SINK_EN);
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	return ret;
> +}
> +
> +static bool tegra_xusb_padctl_utmi_pad_secondary_charger_detect(
> +				struct tegra_xusb_padctl *padctl, u32 index)
> +{
> +	u32 value;
> +	bool ret =3D false;
> +
> +	/* Source D- to D+ */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value |=3D ON_SRC_EN | OP_SINK_EN;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	/* Wait for TVDPSRC_ON */
> +	msleep(40);
> +
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	ret =3D !(value & VDAT_DET);
> +
> +	/* Turn off ON_SRC, OP_SINK, clear VDAT, ZIP status change */
> +	value =3D padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value &=3D ~(ON_SRC_EN | OP_SINK_EN);
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	return ret;
> +}

This seems to be mostly identical to the primary charger detect, so
perhaps this can be parameterized instead? I'm not generally opposed to
splitting functions up like this if they are fairly small, but in this
particular case, splitting up could make the name a lot shorter, and in
this case it's really quite excessive (I count 51 characters...) =3D)

> +
> +enum usb_charger_type tegra_xusb_padctl_charger_detect(
> +					  struct tegra_xusb_port *port)
> +{
> +	struct tegra_xusb_padctl *padctl =3D port->padctl;
> +	struct phy *phy =3D port->lane->pad->lanes[port->index];
> +	struct tegra_xusb_usb2_lane *usb2 =3D to_usb2_lane(port->lane);
> +	u32 index =3D port->index;
> +	enum usb_charger_type chrg_type;
> +	bool pad_power_off =3D false;
> +
> +	mutex_lock(&padctl->lock);
> +
> +	if (!usb2->powered_on) {
> +		padctl->soc->ops->utmi_pad_power_on(phy);
> +		pad_power_off =3D true;
> +	}
> +
> +	tegra_xusb_padctl_utmi_pad_charger_detect_on(padctl, index);
> +	tegra_xusb_padctl_set_debounce_time(padctl, 0xa);

Perhaps use 10 here because that's how we're usually used to read time
values.

> +	tegra_xusb_padctl_detect_filters(padctl, index, true);
> +
> +	if (tegra_xusb_padctl_utmi_pad_primary_charger_detect(padctl,
> +								 index)) {
> +		/*
> +		 * wait 20ms (max of TVDMSRC_DIS) for D- to be disabled
> +		 * from host side, before we perform secondary detection.
> +		 * Some hosts may not respond well if we do secondary
> +		 * detection right after primary detection.
> +		 */
> +		msleep(20);

Could use a blank line after this for readability.

> +		if (tegra_xusb_padctl_utmi_pad_secondary_charger_detect(padctl,
> +									index))
> +			chrg_type =3D CDP_TYPE;
> +		else
> +			chrg_type =3D DCP_TYPE;
> +	} else {
> +		chrg_type =3D SDP_TYPE;
> +	}
> +
> +	dev_dbg(&port->dev, "charger detected of type %d", chrg_type);

Do we have a string representation of this?

> +
> +	tegra_xusb_padctl_detect_filters(padctl, index, false);
> +	tegra_xusb_padctl_utmi_pad_charger_detect_off(padctl, index);
> +
> +	if (pad_power_off)
> +		padctl->soc->ops->utmi_pad_power_down(phy);
> +
> +	mutex_unlock(&padctl->lock);
> +	return chrg_type;
> +}
> +
> +MODULE_AUTHOR("Nagarjuna Kristam <nkristam@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra186 XUSB charger detect driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index de4a46f..e505ac4 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -591,6 +591,50 @@ static enum usb_phy_events to_usb_phy_event(enum usb=
_role role)
>  	}
>  }
> =20
> +#define VON_DIV2P0_DET BIT(0)
> +#define VON_DIV2P7_DET BIT(1)
> +#define VOP_DIV2P0_DET BIT(2)
> +#define VOP_DIV2P7_DET BIT(3)
> +
> +#define VREG_CUR_LEVEL_0        500
> +#define VREG_CUR_LEVEL_1        900
> +#define VREG_CUR_LEVEL_2        1500
> +#define VREG_CUR_LEVEL_3        2000
> +
> +#define IS_CUR_IN_RANGE(ma, low, high)  \
> +	((ma >=3D VREG_CUR_LEVEL_##low) && (ma <=3D (VREG_CUR_LEVEL_##high - 1)=
))
> +#define VREG_LVL(ma, level)     IS_CUR_IN_RANGE(ma, level, level + 1)
> +
> +static void tegra_xusb_padctl_vbus_pad_portection(struct tegra_xusb_port=
 *port)
> +{
> +	struct tegra_xusb_padctl *padctl =3D port->padctl;
> +	int level =3D 0;
> +	enum tegra_vbus_dir dir =3D TEGRA_VBUS_SINK;
> +	int max_ua, min_ua;
> +
> +	if (!padctl->soc->ops->utmi_pad_set_protection_level)
> +		return;
> +
> +	usb_phy_get_charger_current(&port->usb_phy, &min_ua, &max_ua);
> +
> +	if (max_ua =3D=3D 0) {
> +		level =3D -1;
> +		dir =3D TEGRA_VBUS_DEFAULT;
> +	} else if (VREG_LVL(max_ua, 0)) {
> +		level =3D 0;
> +	} else if (VREG_LVL(max_ua, 1)) {
> +		level =3D 1;
> +	} else if (VREG_LVL(max_ua, 2)) {
> +		level =3D 2;
> +	} else if (max_ua >=3D VREG_CUR_LEVEL_3) {
> +		level =3D 3;
> +	} else {
> +		return;
> +	}
> +
> +	padctl->soc->ops->utmi_pad_set_protection_level(port, max_ua, dir);
> +}

level seems to never be used in the above. Instead you just pass max_ua
to the set protection level callback.

> +
>  static void tegra_xusb_usb_phy_work(struct work_struct *work)
>  {
>  	struct tegra_xusb_port *port =3D container_of(work,
> @@ -598,6 +642,10 @@ static void tegra_xusb_usb_phy_work(struct work_stru=
ct *work)
>  						    usb_phy_work);
>  	enum usb_role role =3D usb_role_switch_get_role(port->usb_role_sw);
> =20
> +	/* Set role to none, if charger is DCP type */
> +	if (port->chrg_type =3D=3D DCP_TYPE)
> +		role =3D USB_ROLE_NONE;
> +
>  	usb_phy_set_event(&port->usb_phy, to_usb_phy_event(role));
> =20
>  	dev_dbg(&port->dev, "%s(): calling notifier for role %s\n", __func__,
> @@ -610,9 +658,26 @@ static int tegra_xusb_role_sw_set(struct usb_role_sw=
itch *sw,
>  				  enum usb_role role)
>  {
>  	struct tegra_xusb_port *port =3D usb_role_switch_get_drvdata(sw);
> +	enum usb_charger_state charger_state;
> =20
>  	dev_dbg(&port->dev, "%s(): role %s\n", __func__, usb_roles[role]);
> =20
> +	/* Do charger detect if role is Device and charger detect is enabled */
> +	if (port->charger_detect) {
> +		if (role =3D=3D USB_ROLE_DEVICE)
> +			port->chrg_type =3D
> +					 tegra_xusb_padctl_charger_detect(port);
> +		else
> +			port->chrg_type =3D UNKNOWN_TYPE;
> +
> +		charger_state =3D (port->chrg_type =3D=3D UNKNOWN_TYPE) ?
> +				 USB_CHARGER_ABSENT : USB_CHARGER_PRESENT;
> +
> +		usb_phy_set_charger_state(&port->usb_phy, charger_state);
> +
> +		tegra_xusb_padctl_vbus_pad_portection(port);
> +	}
> +
>  	schedule_work(&port->usb_phy_work);
> =20
>  	return 0;
> @@ -643,6 +708,14 @@ static int tegra_xusb_set_host(struct usb_otg *otg, =
struct usb_bus *host)
>  	return 0;
>  }
> =20
> +static enum usb_charger_type tegra_xusb_charger_detect(struct usb_phy *u=
sb_phy)
> +{
> +	struct tegra_xusb_port *port =3D container_of(usb_phy,
> +						    struct tegra_xusb_port,
> +						    usb_phy);
> +
> +	return port->chrg_type;
> +}
> =20
>  static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>  {
> @@ -693,6 +766,9 @@ static int tegra_xusb_setup_usb_role_switch(struct te=
gra_xusb_port *port)
>  	port->usb_phy.otg->set_peripheral =3D tegra_xusb_set_peripheral;
>  	port->usb_phy.otg->set_host =3D tegra_xusb_set_host;
> =20
> +	if (port->charger_detect)
> +		port->usb_phy.charger_detect =3D tegra_xusb_charger_detect;
> +
>  	err =3D usb_add_phy_dev(&port->usb_phy);
>  	if (err < 0) {
>  		dev_err(&port->dev, "Failed to add USB PHY: %d\n", err);
> @@ -727,6 +803,10 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegr=
a_xusb_usb2_port *usb2)
>  		usb2->mode =3D USB_DR_MODE_HOST;
>  	}
> =20
> +	if (port->padctl->soc->charger_detect &&
> +	    of_property_read_bool(np, "nvidia,charger-detect"))
> +		port->charger_detect =3D true;
> +
>  	/* usb-role-switch property is mandatory for OTG/Peripheral modes */
>  	if (usb2->mode =3D=3D USB_DR_MODE_PERIPHERAL ||
>  	    usb2->mode =3D=3D USB_DR_MODE_OTG) {
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index 79e96b0..714bca2 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -282,6 +282,9 @@ struct tegra_xusb_port {
>  	struct work_struct usb_phy_work;
>  	struct usb_phy usb_phy;
> =20
> +	bool charger_detect;
> +	enum usb_charger_type chrg_type;
> +
>  	const struct tegra_xusb_port_ops *ops;
>  };
> =20
> @@ -306,6 +309,9 @@ struct tegra_xusb_port *
>  tegra_xusb_find_port(struct tegra_xusb_padctl *padctl, const char *type,
>  		     unsigned int index);
> =20
> +enum usb_charger_type tegra_xusb_padctl_charger_detect(
> +					  struct tegra_xusb_port *port);
> +
>  struct tegra_xusb_usb2_port {
>  	struct tegra_xusb_port base;
> =20
> @@ -430,6 +436,7 @@ struct tegra_xusb_padctl_soc {
>  	unsigned int num_supplies;
>  	bool supports_gen2;
>  	bool need_fake_usb3_port;
> +	bool charger_detect;

Perhaps make this "supports_charger_detection" because it being in the
SoC structure means that it's a capability. "charger_detect" makes it
look like an option that we've enabled or not. That's what struct
tegra_xusb_port.charger_detect already is.

Thierry

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6oC4wACgkQ3SOs138+
s6GPShAArot5pNW48XElYdOivt8ORnvqm5dAF1NMaOct7iiVAP8ORILrn8vaQssl
KAoQ7zXbcZAq3vgY83lWd1RWqxJUOP6rBrDyz6WdQzrYxpk+S/6uTny2hdOPU6r7
KalkEqIb6KJXcaIrscIWT/jv00nkrL2cixkYdzVXVrjFyIe+jVTaAHA4/drbuTyA
42PVRS/2g6zgWW0zueaClyq6A9jASRcyEhRajZZOZDV6PM13psPQEmefqYcMgpNE
3CgHNIQQCStkVAxLNQIv0Q/u7zxjluwtW3bMPGV0a8Z72S1Uo1VXTuzOjBtVP+Vu
grd2ilkwR7KWfQhMKyVWyRtPtxN0Z5O6NsZrY/gPXp7eJLJTTvkTqdvU8hcRly5a
hTgTnLMMSai4X+ypErfo3iNo+wtV8TSJ1eBUtWkG0MHsNbAMPCvLRWslc3HnlADa
ybHiQKty0w55K5lBJAuosYo+afOIslmLwthXHxQsIwrfRs9MB+Jl8WOgLRbEjytR
R5/VcwLFEYz9hzkdeZWZpfEDmaZIXnwWd0pIFGjMWFFSU+AW9K/VSMjdEFwYHx5W
bURrwHDZhPA8FFF7RbH3F5/nqpLriEVchICMeDbwQhZC+Puq3QUDx5am34xnqUEF
u4M6mnfy3NPxj8jTbnfUBVKwv1pDRot0UlDpVu7NU27JfSkm01g=
=Nm+A
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
