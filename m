Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC28C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAE42087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VL9tURqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgIIQwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbgIIQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:05:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B2C0617AB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:04:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so3583024wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Au2QdkdUnP8EeZ4UbPsH8YnCrRkIO2DW1cWc/fcx3ig=;
        b=VL9tURqRXlKVTpETSDPhsp9OXu+mCAJu68RSoKDCw/rICZKm+wxc5o59uYqrarCU37
         PoUPSO/k3gpZ838V7GjhNq8ebmlovfZZmTBTMfoGOCt8E7mRwy0cGY0kfWsUGJG541Vt
         I6n05WVOApPuahc/rZFaqWo4zyTjOLQ+J4Bpz+eLGvT7BFwrjUxRPsZ28baGDk2qRdAH
         1bPUTLnKshQzjbDin5njqmcRZMbKjpHXsnrPEjmDIBJsc9KwDr2xRFXTEhy6I0W0onOt
         tCq17mX7rlvjF3ICuekc3d7SUyvE9u4I9Gpk91gW/aFVpOtXEoCWaekp2VU7ABXdp/Rh
         OKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Au2QdkdUnP8EeZ4UbPsH8YnCrRkIO2DW1cWc/fcx3ig=;
        b=iZO2JAw7ysmAtU3fhHi4dP8IeOuu9R5Grzdp3GcuzxFs39RuibcGQf1Y3ZVZYYtqYx
         K3PSbHYJFMe3j7haAMSbjDPNDs6KDYw5xliSJtjzOSCmYCx0NFwjLjXFq9DILR3KnugW
         5y8T/eqjqVh5fqPoQv4QEe0QyKXiYqtVHM2Crd6A9P7ce05n6UfXngK744YMTZCFRHpf
         VaqyO4L12xbiWpFG5yoBPkpVvM3+3TMy08ejmdHQfmoZhmtTgK02o8yYZnOEWIl6LzKw
         jgaWoHw947w5f9IfvMeF7dG4mtpueezfFPu5UqtkkjTqVt1/f+Sp0uVR2vgDCuC+Hp8v
         XAXw==
X-Gm-Message-State: AOAM530ge2PW3gi6YqT6/jjjxxV0SZBsh7BVAj18g+/2k3wrxxCRwbXx
        qd7zIJvqJNZr58SwcA+SAhg4CjqrPEgdrtLT
X-Google-Smtp-Source: ABdhPJx0xnUqFOa8xZ+mrYiFHmMSMi9oSnXj2Z9eCllaqjr3+7vHVkBxxcyI9q6RTZGZeOoeqg06wg==
X-Received: by 2002:a5d:6784:: with SMTP id v4mr4476298wru.215.1599667461695;
        Wed, 09 Sep 2020 09:04:21 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id y6sm4850700wrn.41.2020.09.09.09.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:04:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/5] arm64: dts: meson-axg: add USB nodes
Date:   Wed,  9 Sep 2020 18:04:08 +0200
Message-Id: <20200909160409.8678-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200909160409.8678-1-narmstrong@baylibre.com>
References: <20200909160409.8678-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the USB Glue node, with the USB2 & USB3 controllers along the single
USB2 PHY node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 9ae6db16b8e6..0b68a383b60f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -171,6 +171,46 @@
 		#size-cells = <2>;
 		ranges;
 
+		usb: usb@ffe09080 {
+			compatible = "amlogic,meson-axg-usb-ctrl";
+			reg = <0x0 0xffe09080 0x0 0x20>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB>, <&clkc CLKID_USB1_DDR_BRIDGE>;
+			clock-names = "usb_ctrl", "ddr";
+			resets = <&reset RESET_USB_OTG>;
+
+			dr_mode = "otg";
+
+			phys = <&usb2_phy1>;
+			phy-names = "usb2-phy1";
+
+			dwc2: usb@ff400000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xff400000 0x0 0x40000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_USB1>;
+				clock-names = "otg";
+				phys = <&usb2_phy1>;
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+
+			dwc3: usb@ff500000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff500000 0x0 0x100000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				maximum-speed = "high-speed";
+				snps,dis_u2_susphy_quirk;
+			};
+		};
+
 		ethmac: ethernet@ff3f0000 {
 			compatible = "amlogic,meson-axg-dwmac",
 				     "snps,dwmac-3.70a",
@@ -1734,6 +1774,17 @@
 				clock-names = "core", "clkin0", "clkin1";
 				resets = <&reset RESET_SD_EMMC_C>;
 			};
+
+			usb2_phy1: phy@9020 {
+				compatible = "amlogic,meson-gxl-usb2-phy";
+				#phy-cells = <0>;
+				reg = <0x0 0x9020 0x0 0x20>;
+				clocks = <&clkc CLKID_USB>;
+				clock-names = "phy";
+				resets = <&reset RESET_USB_OTG>;
+				reset-names = "phy";
+				status = "okay";
+			};
 		};
 
 		sram: sram@fffc0000 {
-- 
2.22.0

