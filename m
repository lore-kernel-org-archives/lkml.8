Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE125C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8935E208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jZlxt7KT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgH1PpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgH1Pou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:44:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED87FC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:44:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so1360356wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qhATtI2Zvpm0REij3LLNrIfTJ+M9IJenHThWHoBmGiI=;
        b=jZlxt7KTrCVhDvXreRYPXF1OaonK1xNxowFd4BZXZLk8gKF/Rn6OWLCASLtc3w2voo
         bLdKPEkFuWD15c1SxL8cDCyzdpPoBPwRkSch3AEsalSkHub1CJ8/XKGq/N1jVYsqhlAg
         vq4w5fX8sCDVW3OkN4y+5grd42JBAhd9jpaqtA/EJB/8eKFNW/cwAxF2TvavVSnohzu2
         S92LyqNN6sWps7hFT9ZaYLBANjOi0JzLZGJNwvy7+2tRMD1N8MJy+De6faPAtRCCcRfH
         GmHY8nv1EWmFSp9QnzVXfZSAbvlUQj5d5RCP0SfMXwSs/tuaJS5cXbqEQGtg1av+yg9g
         L/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qhATtI2Zvpm0REij3LLNrIfTJ+M9IJenHThWHoBmGiI=;
        b=Mxc4oBaoM2Ses3wG9x8Vn6G83x4682f7d92jfcph1WNPAvvK/j/CzYVFnWxMFmwUA4
         oo/9+ZolXJ/I+xwxiJsYe4TR4FlMQJ7XyHN4W/4J6/6gyymMqQxyqjXNTvzI91IndKRG
         xDvKdPCxkE96Vgor7bP46FNTjoNjH4RvG1dEW8DnbgPZrGiLTjtl7ixJsGvmTz+clDw5
         ErF7vEhn8i39ovOqZX6MLrrsgquELQyQMrifuSAh6dRbnZgRqEVUPlHUgEqT6K16IRMa
         w2LEe/ILQ1Aj+G74XMmNf48F4nMVN6w5rTHx+fGFAbA1BLG/kEoqSK24/GR1Tmofv5zl
         saRw==
X-Gm-Message-State: AOAM533S0j2kG6cZdrJtzlq6p7X/Z3GNSVQ6RqYRt/c5jWm1c5VT4x+Y
        4+flfP5Kmhk2mOMnhpnDeYgXHw==
X-Google-Smtp-Source: ABdhPJxy2BkyCiF+ZCqVarqOqzbgJgq5QLL1gC452i5Iiak7H6GWWdIiVdBq4rcxr6lqvt42K+4agg==
X-Received: by 2002:a7b:c00d:: with SMTP id c13mr2167709wmb.24.1598629488091;
        Fri, 28 Aug 2020 08:44:48 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 124sm3012467wmd.31.2020.08.28.08.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:44:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: vim3l: remove sound card definition
Date:   Fri, 28 Aug 2020 17:44:35 +0200
Message-Id: <20200828154435.419561-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sound card definition should have been removed when the common
definition was added to the vim3 dtsi but this slips through.
Remove it now.

Fixes: 7c9c06246cea ("arm64: dts: meson: vim3: make sound card common to all variants")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 86 -------------------
 1 file changed, 86 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index 0da56c051a0e..4b517ca72059 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -32,69 +32,6 @@ vddcpu: regulator-vddcpu {
 		regulator-boot-on;
 		regulator-always-on;
 	};
-
-	sound {
-		compatible = "amlogic,axg-sound-card";
-		model = "SM1-KHADAS-VIM3L";
-		audio-aux-devs = <&tdmout_a>;
-		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
-				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
-				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
-				"TDM_A Playback", "TDMOUT_A OUT";
-
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-		status = "okay";
-
-		dai-link-0 {
-			sound-dai = <&frddr_a>;
-		};
-
-		dai-link-1 {
-			sound-dai = <&frddr_b>;
-		};
-
-		dai-link-2 {
-			sound-dai = <&frddr_c>;
-		};
-
-		/* 8ch hdmi interface */
-		dai-link-3 {
-			sound-dai = <&tdmif_a>;
-			dai-format = "i2s";
-			dai-tdm-slot-tx-mask-0 = <1 1>;
-			dai-tdm-slot-tx-mask-1 = <1 1>;
-			dai-tdm-slot-tx-mask-2 = <1 1>;
-			dai-tdm-slot-tx-mask-3 = <1 1>;
-			mclk-fs = <256>;
-
-			codec {
-				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
-			};
-		};
-
-		/* hdmi glue */
-		dai-link-4 {
-			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
-
-			codec {
-				sound-dai = <&hdmi_tx>;
-			};
-		};
-	};
-};
-
-&arb {
-	status = "okay";
-};
-
-&clkc_audio {
-	status = "okay";
 };
 
 &cpu0 {
@@ -125,18 +62,6 @@ &cpu3 {
 	clock-latency = <50000>;
 };
 
-&frddr_a {
-	status = "okay";
-};
-
-&frddr_b {
-	status = "okay";
-};
-
-&frddr_c {
-	status = "okay";
-};
-
 &pwm_AO_cd {
 	pinctrl-0 = <&pwm_ao_d_e_pins>;
 	pinctrl-names = "default";
@@ -174,14 +99,3 @@ &usb {
 };
  */
 
-&tdmif_a {
-	status = "okay";
-};
-
-&tdmout_a {
-	status = "okay";
-};
-
-&tohdmitx {
-	status = "okay";
-};
-- 
2.25.4

