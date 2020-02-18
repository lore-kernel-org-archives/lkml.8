Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764FEC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417602464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNwL8PSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBRRuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:50:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33877 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRRuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:50:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so23994765ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSPOPeuyv6X0CnInvNkcvya9Y67/qUcIjhk322wCKUc=;
        b=MNwL8PSYhHdSj1F1zhVgb+7VBSF2GVAdZDTKEogPx0XtmbvzwexdZ3jipmGBLXTbRc
         o35jq02YuHYhlPXIdY+Qtlf+byJ6ohM2WSIutfMQx23lgEMsBk9g3QC7SdWpfFUsr+Zx
         AvaBRrsjiWbknRZZdD2YF3Vox+CqRNM2vXz0MNLH+HYa7VmWXF4kWktNg8g6zlhfGeHX
         mhjg9O7mViWubwDH40xw72R8Se2+W6fzh82o6J3NivbLbZW+S2jgcWNvFM13O7DBfYXN
         E17NibKIOvgJB7/kc3Z82y1/kMdEiUC8lvl7Eyzbj7Za23CJCDduMjPCzs5YK/Dn1twh
         5jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSPOPeuyv6X0CnInvNkcvya9Y67/qUcIjhk322wCKUc=;
        b=TMZyOD/TDpZQG3tgbQ0FFN5B/CTpZmDXfIXsCQyuRUeZbwj3YQ/jgydn3Sfl1fkNFh
         RZYizN3srF2jMh/CmQ352VJINdPpW4wB8JW9HSQtC+jopI1wg29BqqvylC7oUTuL7GpT
         SCKoAtPP1nH2hwdldPygyaiT4ykPoHn/+ydfOjcjkFG58AZUtYCiS1YVCp8EbCcIVWrQ
         At8KsqbXuYeSHFImAR7x+t0RiS3tturm8WLySct1ZefFD0fQcVlf2QsOkFElu6lqn5DE
         zOOdlbsh4Ax1y6F8zb0frGSJnNUTz879hu/1WE8rU5tNHePV5ZpO6ZVLxHnWUDkPqn2k
         L1CQ==
X-Gm-Message-State: APjAAAWMItBO0dQ07kFdFFbftxBYAVu9WudDbnXAJqC3xTi5xB1GN7ZP
        2xVVpns8p5wi9WWUeUFcfpY=
X-Google-Smtp-Source: APXvYqzPg8ZPFXLqhoYWrAMxsQWiNN6rzoOF4CLEUYfXurUp+aoaYr4o1PdNBdL4SAqF69N/gjy1Aw==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr13653725ljl.83.1582048235775;
        Tue, 18 Feb 2020 09:50:35 -0800 (PST)
Received: from kedthinkpad ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id l22sm2948359ljb.2.2020.02.18.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:50:35 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:50:33 +0200
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH v2 2/2] ARM: sun7i: dts: Add LVDS panel support on A20
Message-ID: <20200218175033.GA25850@kedthinkpad>
References: <20200210195633.GA21832@kedthinkpad>
 <20200212222355.17141-2-andrey.lebedev@gmail.com>
 <20200213094304.hf3glhgmquypxpyf@gilmour.lan>
 <20200213200823.GA28336@kedthinkpad>
 <20200214075218.huxdhmd4qfoakat2@gilmour.lan>
 <20200214084358.GA25266@kedthinkpad>
 <20200214085351.2whnfyulrmyex2va@gilmour.lan>
 <20200214213231.GA6583@kedthinkpad>
 <20200217175135.ldtqji4mrwz2wbn5@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217175135.ldtqji4mrwz2wbn5@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 06:51:35PM +0100, Maxime Ripard wrote:
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> > index cfbf4e6c1679..bc87d28ee341 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> > @@ -235,6 +235,8 @@ struct sun4i_tcon_quirks {
> >  	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
> >  	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
> >  	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
> > +	/* "compatible" string of TCON that exclusively supports LVDS */
> > +	const char *lvds_compatible_tcon;
> 
> However this is far more complicated than needed, you can simply add a
> new quirks structure associated to the tcon0 compatible in
> sun4i_tcon_of_table, and that will do

Aha! Does this look good to you?

From 4ad2978e404c63d4cca1b7890bc5bdd4d1e8965d Mon Sep 17 00:00:00 2001
From: Andrey Lebedev <andrey@lebedev.lt>
Date: Tue, 18 Feb 2020 19:47:33 +0200
Subject: [PATCH] Mark tcon0 to be the only tcon capable of LVDS on sun7i-a20

This allows to avoid warnings about reset line not provided for tcon1.

Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
---
 arch/arm/boot/dts/sun7i-a20.dtsi   |  6 ++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index dc4f3f249aee..d50263c1ca9a 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -405,7 +405,8 @@
 		};
 
 		tcon0: lcd-controller@1c0c000 {
-			compatible = "allwinner,sun7i-a20-tcon";
+			compatible = "allwinner,sun7i-a20-tcon0",
+				     "allwinner,sun7i-a20-tcon";
 			reg = <0x01c0c000 0x1000>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&ccu RST_TCON0>, <&ccu RST_LVDS>;
@@ -460,7 +461,8 @@
 		};
 
 		tcon1: lcd-controller@1c0d000 {
-			compatible = "allwinner,sun7i-a20-tcon";
+			compatible = "allwinner,sun7i-a20-tcon1",
+				     "allwinner,sun7i-a20-tcon";
 			reg = <0x01c0d000 0x1000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&ccu RST_TCON1>;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 800a9bd86112..d9605d331010 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1479,7 +1479,7 @@ static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
 	.dclk_min_div		= 1,
 };
 
-static const struct sun4i_tcon_quirks sun7i_a20_quirks = {
+static const struct sun4i_tcon_quirks sun7i_a20_tcon0_quirks = {
 	.supports_lvds		= true,
 	.has_channel_0		= true,
 	.has_channel_1		= true,
@@ -1489,6 +1489,15 @@ static const struct sun4i_tcon_quirks sun7i_a20_quirks = {
 	.setup_lvds_phy		= sun4i_tcon_setup_lvds_phy,
 };
 
+static const struct sun4i_tcon_quirks sun7i_a20_tcon1_quirks = {
+	.supports_lvds		= false,
+	.has_channel_0		= true,
+	.has_channel_1		= true,
+	.dclk_min_div		= 4,
+	/* Same display pipeline structure as A10 */
+	.set_mux		= sun4i_a10_tcon_set_mux,
+};
+
 static const struct sun4i_tcon_quirks sun8i_a33_quirks = {
 	.has_channel_0		= true,
 	.has_lvds_alt		= true,
@@ -1534,7 +1543,8 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun5i-a13-tcon", .data = &sun5i_a13_quirks },
 	{ .compatible = "allwinner,sun6i-a31-tcon", .data = &sun6i_a31_quirks },
 	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = &sun6i_a31s_quirks },
-	{ .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks },
+	{ .compatible = "allwinner,sun7i-a20-tcon0", .data = &sun7i_a20_tcon0_quirks },
+	{ .compatible = "allwinner,sun7i-a20-tcon1", .data = &sun7i_a20_tcon1_quirks },
 	{ .compatible = "allwinner,sun8i-a23-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
-- 
2.20.1


-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/
