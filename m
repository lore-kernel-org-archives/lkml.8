Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90DAF20578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6WdZ4Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgGHNMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgGHNMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:12:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A70C08C5DC;
        Wed,  8 Jul 2020 06:12:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l12so50428165ejn.10;
        Wed, 08 Jul 2020 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vz7GdsV60WlH5Tliab73oe6u2+cpaoKJTOFlduCSiWQ=;
        b=N6WdZ4Kx0w7q7n14fzrZldnkCDBojmyIB33dJkkjLTrYxVi1aamp5PcMr+2CWXabJk
         HBwjM3JGIqt9JWfZf26iTtcSEYrXuBb1TPpkRWubKSYCTgbCLjmHuaAWRWE0rg+Uhiuu
         J6TTq/AKiqW2HgCYa7OlLk2z+WBH/Xe3cfLaWzE+6v0DM5eI/X39CcjwsYDW7COjwl5G
         UagqdT7R0GRrxRnTPagrAuL8t50NxLI4qirEE/xJ6Dn7tpwTWNS9v0nMfaZbIhm+EfBo
         HhPkCTjF93yYm1UD+UMrlIitS/HTmWBQiVSo32cTis/ksVLy+ivwSuYAAMW8bes6B/8I
         5rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vz7GdsV60WlH5Tliab73oe6u2+cpaoKJTOFlduCSiWQ=;
        b=rsUd4nrsFcT26pm8/IFdZ8FQPbZDv7pEelJg5xThqC+it4bJ41jo+K+Xp/YcpjMnJp
         zc4qp/7Q8SeHD0UfuldR2H0F/+p8YBW8HOnTJ5wEdD8LUBfx9eREyJWxoSMKM6eDNgph
         ezZ4qolRf61TqnxRo8/eT/gR+bT+iEJP1fG9gnpg9LZqsZ9J1uj0+fI6atJ6PoVXSZ9Y
         Xd9f3SsPxvZUY9P5vgvNUOmeGOny6R/MvtIgdEVRTzx2Lchk6sOzosGk13aRCBf0l610
         jyYqKyLOTbo3/hN/alYJBmR7EIzesM7koOLOi0aXEV4fovY7MS7lPMZ0KKIOZ4yXtirI
         ITgw==
X-Gm-Message-State: AOAM533h/BT3r1KiCQIFRpqMxdr/xPV96pJ0493ShJId1h2pJb1IUtrf
        qUgg4g7LWqgYjbnrXxVOEjA=
X-Google-Smtp-Source: ABdhPJxmWsfNuB7+zH2r4j4krbcGCx7zNSf0Hm7D1ZaLCQMQOVsTVuqiiDkP6dzVFcG6356GMsuAIg==
X-Received: by 2002:a17:906:2b50:: with SMTP id b16mr54062334ejg.410.1594213925047;
        Wed, 08 Jul 2020 06:12:05 -0700 (PDT)
Received: from localhost (124-155-N1.p43.customer.vsm.sh. [91.106.155.124])
        by smtp.gmail.com with ESMTPSA id a8sm1981388ejp.51.2020.07.08.06.12.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:12:03 -0700 (PDT)
Date:   Wed, 8 Jul 2020 12:38:36 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv7 2/3] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
Message-ID: <20200708103836.GA20983@portage>
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
 <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
 <CAOMZO5DX_-zSHJjDigK2c=dVLEMxvfd_dFCu=0fbyjht1gsr=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DX_-zSHJjDigK2c=dVLEMxvfd_dFCu=0fbyjht1gsr=A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19, Fabio Estevam wrote:
> Hi Oliver,
> 
> On Tue, Nov 12, 2019 at 4:22 PM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > +&lcdif {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_lcdif>;
> > +       display = <&display0>;
> > +       status = "okay";
> > +
> > +       display0: display0 {
> > +               bits-per-pixel = <16>;
> > +               bus-width = <24>;
> > +
> > +               display-timings {
> > +                       native-mode = <&timing0>;
> > +                       timing0: timing0 {
> > +                               clock-frequency =<35000000>;
> > +                               hactive = <800>;
> > +                               vactive = <480>;
> > +                               hfront-porch = <40>;
> > +                               hback-porch = <40>;
> > +                               hsync-len = <48>;
> > +                               vback-porch = <29>;
> > +                               vfront-porch = <13>;
> > +                               vsync-len = <3>;
> > +                               hsync-active = <0>;
> > +                               vsync-active = <0>;
> > +                               de-active = <1>;
> > +                               pixelclk-active = <0>;
> > +                       };
> > +               };
> > +       };
> > +};
> 
> You are using the deprecated bindings.
> 
> Please switch to the DRM bindings as stated at
> Documentation/devicetree/bindings/display/mxsfb.txt
> 
> You should also add your panel to the simple panel driver.


ok thx for you comments, coming back to this. I now added this to
panel-simple.c. Is this the way to go?

Best Regards,

Oliver

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c1374be..c2f20ac 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3139,6 +3139,29 @@ static const struct panel_desc satoz_sat050at40h12r2 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing sgd_gktw70sdad1sd_timing = {
+	.pixelclock = {35000000, 35000000, 35000000},
+	.hactive = { 800, 800, 800},
+	.hfront_porch = {39, 39, 39},
+	.hback_porch = {39, 39, 39},
+	.hsync_len = {48, 48, 48},
+	.vactive = {480, 480, 480},
+	.vfront_porch = {13, 13, 13},
+	.vback_porch = {29, 29, 29},
+	.vsync_len = {3, 3, 3},
+};
+
+static const struct panel_desc sgd_gktw70sdad1sd = {
+	.timings = &sgd_gktw70sdad1sd_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 153,
+		.height = 86,
+	},
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode sharp_ld_d5116z01b_mode = {
 	.clock = 168480,
 	.hdisplay = 1920,
@@ -3999,6 +4022,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "satoz,sat050at40h12r2",
 		.data = &satoz_sat050at40h12r2,
 	}, {
+		.compatible = "sgd,gktw70sdad1sd",
+		.data = &sgd_gktw70sdad1sd,
+	}, {
 		.compatible = "sharp,ld-d5116z01b",
