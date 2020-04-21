Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF03CC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC62C206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T57H7Krn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgDUOSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728479AbgDUOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:18:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038F2C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:18:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k11so16686907wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd1xNgSjXGAbGjud1+4PrmDu/SrWjho/a3L7QhFqL0Y=;
        b=T57H7KrnGqqWTX9FJwdMm1LUVSSMAjQPbOVKMqSmRI20q7eKo7mDzjVSbwt+wtcZxQ
         IDGPKlyOCfaRS06nJ2oNgHCk0ePS0b840VjpaxemWyvGQ5U4v2W49olN7YZxcHOAzIXe
         zFBjT/lLPzP0VtoXZ1lsYpRGms166U1r48/arJyd8jFMX+bQ47U/UT78pLcV8uvPVUL2
         9MWszCj0Q7qPv69hzvV0MhNLdDhQ82Cm4k5lmL/sAMIVXsSvJ+mgm8IHU6dNfpm4rVSd
         mrphYBFKrYV1tK8U6ryIQPwQyfXcVfNynuG8zdvmCZbjO3MPVVv/YY04b0jIofbioIYQ
         1eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dd1xNgSjXGAbGjud1+4PrmDu/SrWjho/a3L7QhFqL0Y=;
        b=YeHCuyOvgFN6jUf1jvDlLX8rhCN97HeraoJHoliVr6CxtNzSKXzCEo7y7BjpeHCqQF
         dC5AiGQMHWd1jjuJnzPN+dhBTtfNizFRHmqr8ERxgS5G5XMrP+We8DnsoqFEN+CovvGt
         bnUxWyK1Jd9gh5hvshirV7sX8+QyUvLtkiciWzAqdpZCOIwSUceawQQjdMO/kkeHJ3fs
         ZuE0XB5UMvXsVv93iM36q5n+jLbWMSm47jEd2RRVvwbRsg4oUbnO+v/YTtPBpae5lZLz
         jdf/gMy3lmaPkcTpNw6x1UBe67mKW5LbTmbuN5/SgjTnTWGT7PdisHhYC+IW5TSWL92c
         mMlA==
X-Gm-Message-State: AGi0PubXYr2Gbn5bzlmiRB+Dt/L1IDogtv9i1nODxnzTU5K8X6k2gMNL
        Tq0Q4xowMctxNwT0iuqnAer58g==
X-Google-Smtp-Source: APiQypKWjn7ScAlsRHz7cWb6BgYjFrp3zgX1QXTfUUsgO8mep2kT5yfxm3jCvWwqqblG5ykXz4gSgQ==
X-Received: by 2002:adf:80ee:: with SMTP id 101mr12670641wrl.156.1587478697618;
        Tue, 21 Apr 2020 07:18:17 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id j17sm4238287wrb.46.2020.04.21.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:18:17 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: kvim3: move hdmi to tdm a
Date:   Tue, 21 Apr 2020 16:18:14 +0200
Message-Id: <20200421141814.639480-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tdmout b is physically routed to the 40 pin header and the tdmout c
is routed to the m2 connector. It makes these interfaces poor
candidates to handle the HDMI 8ch i2s link (2ch i2s * 4 lanes) as it would
force the same link format on the related connectors.

Instead use the TDM A interface. This one is not routed to the outside
world on the vim3, so it can only be used for HDMI.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index c6c8caed8327..224c890d32d3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -51,11 +51,11 @@ vddcpu_b: regulator-vddcpu-b {
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "G12B-KHADAS-VIM3";
-		audio-aux-devs = <&tdmout_b>;
-		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
-				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
-				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
-				"TDM_B Playback", "TDMOUT_B OUT";
+		audio-aux-devs = <&tdmout_a>;
+		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
+				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
+				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
+				"TDM_A Playback", "TDMOUT_A OUT";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -80,7 +80,7 @@ dai-link-2 {
 
 		/* 8ch hdmi interface */
 		dai-link-3 {
-			sound-dai = <&tdmif_b>;
+			sound-dai = <&tdmif_a>;
 			dai-format = "i2s";
 			dai-tdm-slot-tx-mask-0 = <1 1>;
 			dai-tdm-slot-tx-mask-1 = <1 1>;
@@ -89,7 +89,7 @@ dai-link-3 {
 			mclk-fs = <256>;
 
 			codec {
-				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
+				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_A>;
 			};
 		};
 
@@ -182,11 +182,11 @@ &pwm_AO_cd {
 	status = "okay";
 };
 
-&tdmif_b {
+&tdmif_a {
 	status = "okay";
 };
 
-&tdmout_b {
+&tdmout_a {
 	status = "okay";
 };
 
-- 
2.25.2

