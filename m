Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7518AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56559207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFIKbADW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHSTg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSTg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:36:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48AC061757;
        Wed, 19 Aug 2020 12:36:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k4so21699018ilr.12;
        Wed, 19 Aug 2020 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M6zxHA2un35cI+Abs7EVx0JkYNoXLdt+Zt/XvLPlDXg=;
        b=eFIKbADWPJzqOWgWLBKPNDwfXGBz6i9wY0NpNcT3g+TnnWMRdNmSLkv9VP/Qa+u97I
         Bqu9YOVUqxLDNzpk9STOxLbzbfbV30DMr9/EVbvczNH5iO95cYyNj2Aq8Tv48DESfcLz
         HBaavyNORq7C1A1cYsBfBSp4YhEu0b+jgnmYWOm2QuE62NORs4KTR/KG0ckueQSO8YbY
         wRIUsYqMU2/sRwSdHEHx5hOjC5M13zKX8D/oxdid4YFd6rMdBhFKJtl0+cnAtLAxkqMp
         GMzcqjckuXlXBo2pSMWl3ypFTE66/ZI3P6Pc7IE9kEROdtM5jFG9FfcVnFQ57184mMXM
         mYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M6zxHA2un35cI+Abs7EVx0JkYNoXLdt+Zt/XvLPlDXg=;
        b=fR5Uy7c/SkR2OS7DbNOqLHSD1UUF/orpe6J3/z6NQXI4AaUHsRGlqpxfxMkGrFSme8
         0S3GB2MFUNkGY3m00MRdFD/Dj8nm1A8VumtICgpMPmIkiaj4Hqn+IVMoP2MhmfZKl1ya
         akPzb52JiJMKMeXLRyVZI8ceJfWv4O8fWYHh2+3Us+P6hSgcqEYb2nyy2Y7QXO3UFLy1
         /7OXNWFk8WzLaTeyjc0OetBkigzivRfHIHyDMokd9NL/A+2W1uVH20wNXO4C15HfB+yx
         v39NEu2j+heunpOMAALeVdmZVkkxUK36jKGz57/3Y0TJ3cfpHOleAfH3IU6zW95NvzPx
         kShw==
X-Gm-Message-State: AOAM532RZglPORHyjasA6SJXPcmoDJ7OH+39wkDiC0fUQ2DaPg1Zb+cC
        mO6Uz8jJW2yABns4gnB15Ss=
X-Google-Smtp-Source: ABdhPJx6w7SX2UWP3z0sbQ/vfQ6kdB21SEiG6pp3VnXzu6K635uPTwZCRy5Mcj5ppV8w/eMA4k4Pcg==
X-Received: by 2002:a92:508:: with SMTP id q8mr22963688ile.181.1597865815965;
        Wed, 19 Aug 2020 12:36:55 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:b588:1a5f:55c3:870e])
        by smtp.gmail.com with ESMTPSA id q200sm14063265iod.5.2020.08.19.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:36:55 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6q-logicpd: Fix broken PWM
Date:   Wed, 19 Aug 2020 14:35:59 -0500
Message-Id: <20200819193559.2865826-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTC doesn't like the default PWM settings, because it's expecting
three cells.  This patch reduces adds the extra entry of 0 to the PWM
reference.

Fixes:  fa28d8212ede ("ARM: dts: imx: default to #pwm-cells = <3> in the SoC dtsi files")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
index 7a3d1d3e54a9..07819532d48e 100644
--- a/arch/arm/boot/dts/imx6q-logicpd.dts
+++ b/arch/arm/boot/dts/imx6q-logicpd.dts
@@ -13,7 +13,7 @@ / {
 
 	backlight: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 20000>;
+		pwms = <&pwm3 0 20000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		power-supply = <&reg_lcd>;
@@ -70,7 +70,7 @@ &clks {
 
 &hdmi {
 	ddc-i2c-bus = <&i2c3>;
-	status = "okay";
+	status = "disabled";
 };
 
 &i2c1 {
-- 
2.25.1

