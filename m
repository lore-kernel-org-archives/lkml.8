Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE44C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF6A22B4E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS1kNoof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGSOKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:10:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D1FC0619D2;
        Sun, 19 Jul 2020 07:10:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so15378590wrv.9;
        Sun, 19 Jul 2020 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BO3/npBe/d3IU+Xb/V+yWFJYQheJQv/P5LLMxy6zjOI=;
        b=DS1kNoof5nEfvtqD86NpiQvO/pKycqZpLQzz8mUB3MWCkvVyMJmRQ1FbhDzVqfrp/6
         laMgFtXMutsiEfpZtMG8O5zv2v7Hgm9R1JHkdUp/eGAD1S4BLt32HCwzuoS+LDECAuUp
         OJ1rqdgCZBWhI9KbCEshgetYXCa6/HWhX24XTjk3eh/xU8X781tF2AytCVqTOCDomH7c
         ev+gtrNpA+urtRvUWMynwGeoRwTQOupGV5ItsQj7FTuLnO8Ts3Wh/WWGSkH3DRCRVDHT
         1Tl7iTcwy7I2wWGZ0XX9HWJkmYrgOal+usAs164luVeeqbShAFEJ3WLYSZhTYJIDX2Dz
         HEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BO3/npBe/d3IU+Xb/V+yWFJYQheJQv/P5LLMxy6zjOI=;
        b=VMgVm5rlVITuTfpzD1K3/dpIn24ezCGXOeaSNjiJN7fhr1eySMsKvuLUpJYSQ31IVZ
         aQbaNPc7y9tTBLSKN3tr22zA0TivRtGyn/2gn4ZYucMcTD4zSPCR03xMN3cXMfx7vcja
         Eb4gipQ40wpIaS4C8Sh7/byNyyWLRIrDFYvy626Gh6ZOWw6aRzFgt1wXRLg6qfTMGx7q
         CtNX+Uf16eRbTE3lASbsZPgHwVYotMKRcAqZyanaMe10tXyksv8HGN+2wwrZWhnt1oPP
         Onl/1gZj9oY+WgTY7dML1rPn5BIT8ODSc90ONtsgZ/B2T1X/CHNTBZ4McDU2mFWvZKy5
         mlUA==
X-Gm-Message-State: AOAM532T7B1cBCGFNLLtNrLdCKtTAp6PYuwPnv4xlapugEdq5PjzJDV6
        8PXl8ZeDrfkxxWCz+tuKSdi2eLKn
X-Google-Smtp-Source: ABdhPJyLN7KEli95FjWvMQPH5iNrxKCsln/FrY+b7WavAQ92CWP0VWbwceObDro0QbbWzaSdIEZH6Q==
X-Received: by 2002:adf:d084:: with SMTP id y4mr17959433wrh.161.1595167845879;
        Sun, 19 Jul 2020 07:10:45 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y11sm9215554wrs.80.2020.07.19.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 07:10:45 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@hardkernel.com>
Subject: [PATCH 3/3] arm64: dts: meson: add support for the ODROID-N2+
Date:   Sun, 19 Jul 2020 14:10:34 +0000
Message-Id: <20200719141034.8403-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719141034.8403-1-christianshewitt@gmail.com>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of higher
clock speeds than the original ODROID-N2. Hardkernel supports the big cpu
cluster at 2.4GHz and the little cpu cluster at 2.0GHz. Opp points and
regulator changess are from the HardKernel Linux kernel sources.

Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 53 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 5cac4d1d487d..6dc508b80133 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
new file mode 100644
index 000000000000..99e96be509f8
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "meson-g12b-odroid-n2.dtsi"
+
+/ {
+	compatible = "hardkernel,odroid-n2-plus", "amlogic,s922x", "amlogic,g12b";
+	model = "Hardkernel ODROID-N2+";
+
+	vddcpu_a: regulator-vddcpu-a {
+		regulator-min-microvolt = <680000>;
+		regulator-max-microvolt = <1040000>;
+
+		pwms = <&pwm_ab 0 1500 0>;
+	};
+
+	vddcpu_b: regulator-vddcpu-b {
+		regulator-min-microvolt = <680000>;
+		regulator-max-microvolt = <1040000>;
+
+		pwms = <&pwm_AO_cd 1 1500 0>;
+	};
+
+	cpu_opp_table_0: opp-table-0 {
+		opp-1908000000 {
+			opp-hz = /bits/ 64 <1908000000>;
+			opp-microvolt = <1030000>;
+		};
+
+		opp-2016000000 {
+			opp-hz = /bits/ 64 <2016000000>;
+			opp-microvolt = <1040000>;
+		};
+	};
+
+	cpub_opp_table_1: opp-table-1 {
+		opp-2304000000 {
+			opp-hz = /bits/ 64 <2304000000>;
+			opp-microvolt = <1030000>;
+		};
+
+		opp-2400000000 {
+			opp-hz = /bits/ 64 <2400000000>;
+			opp-microvolt = <1040000>;
+		};
+	};
+};
+
-- 
2.17.1

