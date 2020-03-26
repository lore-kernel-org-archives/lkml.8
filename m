Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D7EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4501120714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E0Av0gMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgCZRAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:00:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33927 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgCZRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:00:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so8773779wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9+ngUpmkFwCrrCCNM5K1pYaDR7H/QYUrPj981ohJpA=;
        b=E0Av0gMBUOqV1dPvKF2FITdx8Rf0uAaobKa9Ln4rw+eC7JsGjCT057RazyNLToqdYH
         uDM362SfMEaE7zSr81m7UtJQ2xDDpsqsxmUGaVfeKZBeqvv/vEe2gsnqwKSv4np35TFW
         8EFA1KJB9qJxQUbzq/UzRCCRMY4nBGQUaajRFRG9MMBwrp1LPEaDjWccAoThyaXXPfm+
         ZHpQR74vp4XXkR1gbn4lyQYMaZUHpO68kkbt/0dLeH/z8KMmdSSWBl/m09gMcbefsYKq
         4hjpimLD5O3WfuEsmeJvI1MXq8AvpVQ8HKEBwpsxvofC/mt+BL9LfjlSdxxwVGPvaGpo
         qdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9+ngUpmkFwCrrCCNM5K1pYaDR7H/QYUrPj981ohJpA=;
        b=m3/54O1ttNdo6rT1ctj4gkA7qaS/BX+Ap/Cfbf55FzD84CEm4q4evrN4V/CMBQIBfT
         fFj1PoWcgQluB7qL1SnumC8cIdWTAxA2zJ8bPKnNoOlX8D0q5nfv2ovoTE/Y5gDkOSoq
         YZgiA5NuEtxkm4tpgNUg0Kf9yLpS7PFp4/bAnDWZLqWoH6othFfohzz8osZ06kMz6bQ3
         F4J9tx4/CKGlRzxp73ePEn2HKkHtB06qVuLGjmV3fFbhdmNH4/9ncq58SFOT8mTgM6xE
         xPnU4rNiaAfdte2eq0VGAQcAgGNcvJ9FENTU2YH5aUed6byCQDsyfVQ19vBXknjTnlnm
         GQyQ==
X-Gm-Message-State: ANhLgQ33WbF8wQ57W5w5SLLKUR8fczAFrJz+BdaALKzyQUHhhmDij93O
        7USDHqnzzw7blwyUvBJd2Rl5zA==
X-Google-Smtp-Source: ADFU+vseedUJg+qIi0p0xgZxO6cJSY/Je6ly7V3VTm6ALURObymwtKpKsQpPYy2rJDKVcOfhXF3N0A==
X-Received: by 2002:adf:82b0:: with SMTP id 45mr10206215wrc.120.1585242006281;
        Thu, 26 Mar 2020 10:00:06 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id r15sm4609823wra.19.2020.03.26.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:00:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/5] arm64: dts: meson: fixup SCP sram nodes
Date:   Thu, 26 Mar 2020 17:59:55 +0100
Message-Id: <20200326165958.19274-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326165958.19274-1-narmstrong@baylibre.com>
References: <20200326165958.19274-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GX and AXG SCP sram nodes were using invalid compatible and
node names for the sram entries.

Fixup the sram entries node names, and use proper compatible for them.

It notably fixes:
sram@c8000000: 'scp-shmem@0', 'scp-shmem@200' do not match any of the regexes: '^([a-z]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi |  6 +++---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index aace3d32a3df..8e6281c685fa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1735,18 +1735,18 @@
 		};
 
 		sram: sram@fffc0000 {
-			compatible = "amlogic,meson-axg-sram", "mmio-sram";
+			compatible = "mmio-sram";
 			reg = <0x0 0xfffc0000 0x0 0x20000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0xfffc0000 0x20000>;
 
-			cpu_scp_lpri: scp-shmem@13000 {
+			cpu_scp_lpri: scp-sram@13000 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem@13400 {
+			cpu_scp_hpri: scp-sram@13400 {
 				compatible = "amlogic,meson-axg-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 03f79fe045b7..e2bb68ec8502 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -398,20 +398,20 @@
 		};
 
 		sram: sram@c8000000 {
-			compatible = "amlogic,meson-gx-sram", "amlogic,meson-gxbb-sram", "mmio-sram";
+			compatible = "mmio-sram";
 			reg = <0x0 0xc8000000 0x0 0x14000>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0xc8000000 0x14000>;
 
-			cpu_scp_lpri: scp-shmem@0 {
-				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
+			cpu_scp_lpri: scp-sram@0 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
 				reg = <0x13000 0x400>;
 			};
 
-			cpu_scp_hpri: scp-shmem@200 {
-				compatible = "amlogic,meson-gx-scp-shmem", "amlogic,meson-gxbb-scp-shmem";
+			cpu_scp_hpri: scp-sram@200 {
+				compatible = "amlogic,meson-gxbb-scp-shmem";
 				reg = <0x13400 0x400>;
 			};
 		};
-- 
2.22.0

