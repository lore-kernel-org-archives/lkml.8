Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA4CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D88F2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PId0Flju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgGAJqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgGAJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:46:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57B7C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:46:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so21686934wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4XcfcAkqZ4hOUekNAJTnLH2TON/M34d5Vhe+YnBg/I=;
        b=PId0Flju4Q2mnrmD+zyXcMyBEX/vsGY7PaI1Jqf3GwnZ45nmIjaJKl71CR0hmJIihG
         SJTMuR80xK7ueQ+ZhlIv3mFmX74kZIeYpjZcf6J5/WZZYnVJyNFxMRhvqGTF9Z4T9+m4
         GNM3ScLuTEDLnSjWIo446YAVCYLBB3yxXeFip4mLplgBsl6cjjp2otK+1LZTPuMI4Bc5
         Typvtipqs3kyWZ7ISzuVtRu3pFRi2wobeJgZjCfSrU9vzUvSqP/7JJ1N5eBBwsTpnTQI
         WduSPKG8IxfrKAp1EohfeeP42Y/ltaL+eG6heWoZGWo7zhaHyi/DXGRBrS/KK3QB54ay
         hzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4XcfcAkqZ4hOUekNAJTnLH2TON/M34d5Vhe+YnBg/I=;
        b=VLAkEDjHW/Rkh0/g6Q2anIuvL/Z7mijGlHNFiODeT4dZEPmWMHjgcpD26e5Y8QJqXY
         taNLK0YF7l/xvWPkekAgCsAyhWqLtxJveHrLRc1ZdMyOrSz0Y1KTNAezOWWV+kdwnROI
         JU4HNBMfmc7ksj3cPFG/vBN3KZgVeEAMmAUC+HJR3gvPCuW3+i6rme63BaCbxvb490sl
         wBXfYzaJvO0ysNJagNBOfqjU5EaSn2ZNsfhvhcskbiukziROy7BEmKo2gv0XYHlbbtvv
         4lsOuBWqGxnwTm0WYXGznqxnxtGM2YsDzZSmrTml6/SYKiS1HK23TYqcxYW76/CxUYZY
         D91Q==
X-Gm-Message-State: AOAM533CgekbFfiJ7WsSgVzcx8mdRUSShZzR0LfwlTE00MAuw8r14U9Q
        zMHm7xmmPtg1Z3vE3zDi6ZgTofI4uuQ=
X-Google-Smtp-Source: ABdhPJwGYCx4064BPXe4yJCuTcAybc1uPAIFv4sHsqvIdcGQlkWgNAjEJ8RRaVlmu28j/JoPLobTAA==
X-Received: by 2002:a1c:c387:: with SMTP id t129mr18585253wmf.27.1593596763411;
        Wed, 01 Jul 2020 02:46:03 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f13sm6270472wmb.33.2020.07.01.02.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 02:46:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: meson: odroid-n2: enable audio loopback
Date:   Wed,  1 Jul 2020 11:45:55 +0200
Message-Id: <20200701094556.194498-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200701094556.194498-1-jbrunet@baylibre.com>
References: <20200701094556.194498-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add capture pcm interfaces and loopback routes to the odroid-n2

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 65 +++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 169ea283d4ee..d4421ad164bd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -209,11 +209,28 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,axg-sound-card";
 		model = "G12B-ODROID-N2";
-		audio-aux-devs = <&tdmout_b>;
+		audio-aux-devs = <&tdmout_b>, <&tdmin_a>, <&tdmin_b>,
+				 <&tdmin_c>, <&tdmin_lb>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
-				"TDM_B Playback", "TDMOUT_B OUT";
+				"TDM_B Playback", "TDMOUT_B OUT",
+				"TDMIN_A IN 4", "TDM_B Loopback",
+				"TDMIN_B IN 4", "TDM_B Loopback",
+				"TDMIN_C IN 4", "TDM_B Loopback",
+				"TDMIN_LB IN 1", "TDM_B Loopback",
+				"TODDR_A IN 0", "TDMIN_A OUT",
+				"TODDR_B IN 0", "TDMIN_A OUT",
+				"TODDR_C IN 0", "TDMIN_A OUT",
+				"TODDR_A IN 1", "TDMIN_B OUT",
+				"TODDR_B IN 1", "TDMIN_B OUT",
+				"TODDR_C IN 1", "TDMIN_B OUT",
+				"TODDR_A IN 2", "TDMIN_C OUT",
+				"TODDR_B IN 2", "TDMIN_C OUT",
+				"TODDR_C IN 2", "TDMIN_C OUT",
+				"TODDR_A IN 6", "TDMIN_LB OUT",
+				"TODDR_B IN 6", "TDMIN_LB OUT",
+				"TODDR_C IN 6", "TDMIN_LB OUT";
 
 		assigned-clocks = <&clkc CLKID_MPLL2>,
 				  <&clkc CLKID_MPLL0>,
@@ -236,8 +253,20 @@ dai-link-2 {
 			sound-dai = <&frddr_c>;
 		};
 
-		/* 8ch hdmi interface */
 		dai-link-3 {
+			sound-dai = <&toddr_a>;
+		};
+
+		dai-link-4 {
+			sound-dai = <&toddr_b>;
+		};
+
+		dai-link-5 {
+			sound-dai = <&toddr_c>;
+		};
+
+		/* 8ch hdmi interface */
+		dai-link-6 {
 			sound-dai = <&tdmif_b>;
 			dai-format = "i2s";
 			dai-tdm-slot-tx-mask-0 = <1 1>;
@@ -252,7 +281,7 @@ codec {
 		};
 
 		/* hdmi glue */
-		dai-link-4 {
+		dai-link-7 {
 			sound-dai = <&tohdmitx TOHDMITX_I2S_OUT>;
 
 			codec {
@@ -476,6 +505,22 @@ &tdmif_b {
 	status = "okay";
 };
 
+&tdmin_a {
+	status = "okay";
+};
+
+&tdmin_b {
+	status = "okay";
+};
+
+&tdmin_c {
+	status = "okay";
+};
+
+&tdmin_lb {
+	status = "okay";
+};
+
 &tdmout_b {
 	status = "okay";
 };
@@ -484,6 +529,18 @@ &tohdmitx {
 	status = "okay";
 };
 
+&toddr_a {
+	status = "okay";
+};
+
+&toddr_b {
+	status = "okay";
+};
+
+&toddr_c {
+	status = "okay";
+};
+
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.25.4

