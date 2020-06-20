Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC939C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EE423ECE
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O6qDxq2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgFTQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:37:07 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A55C0613EE
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x93so10177704ede.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qI+KLgcHGZ3cTHvlkPTGBhsaWBLAUPc1zpeWREZblPA=;
        b=O6qDxq2yMHLFGGJbsYzsI+rIDfnFsX3XKNtroD0+uW16yAEWFPWutM0w0yHux3Z9+X
         gKXzwScCGY59HeJd2oHMZTXKA6wp+QjMoOSgRxTf2cw1kK00PaPWvfFFYNIBBL4foahL
         ONlv1VY4rjsO/CrAvP3wKYiT2wx6eRIUZoWleXBIGq/hj8D2TqKzq+Nl085RCT1XMeSs
         ZHe1Luhyewh50YyAL8aa/L/nOxFesF54Ae78aW7Fn3H0TPAq0M0AfphVYlUM5K+dkHKa
         T3U9zZvBu5shDX3wNAiDNzcuohhlbr/reutpA3aNpvS9hzxrcqZ70NG1dZvEd8PX1Ng+
         dXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qI+KLgcHGZ3cTHvlkPTGBhsaWBLAUPc1zpeWREZblPA=;
        b=kIWEVcF+Ldn8IY08110Yj+glAyAFl+/TJ5uQzbC9QStX9D3p2PR0yZ6aZeWDnv2FsW
         Y+5Pboc7lys2KchKFa2HbtBIFFYa7MclZ89PfwdPNI0RDmpzdD+VkC+/U4z3fz5vsx/o
         /lLRxe37SJgsRM5e+42CrJ8xCmT3oWz8bPjNiyeILC9I+hM3yHLkZyRjfNAum+eUP7ew
         NU7LYLO8xYo3pq+twYMeqOsO1pmSR/H9ni1FqKrITUps7f6dWCTo3HJz940xveFHkIDc
         1ijPmt4uQBowC4Oi0iQVNkarQlr2Vqpu0MgoTPL3FhbvgP6ObVDWZTqixZfWuGgxvbfz
         64tw==
X-Gm-Message-State: AOAM531eonKWDl6wYQeZHwcsVAvgfb3bCuABjKSP6mEh5HQCYNq5OOkX
        w1SZ6qsLFxyNsXgny43qdJI=
X-Google-Smtp-Source: ABdhPJyg/dkss/6p4dO79EJEEhEXYP+thVEqeGX7aTivWvxH3c9atiLcDkD1IPNAWMc27jcB5oB3Wg==
X-Received: by 2002:a50:9eaf:: with SMTP id a44mr8884095edf.121.1592671025708;
        Sat, 20 Jun 2020 09:37:05 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o90sm7839442edb.60.2020.06.20.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:37:05 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: odroidc1: enable the SDHC controller
Date:   Sat, 20 Jun 2020 18:36:54 +0200
Message-Id: <20200620163654.37207-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
References: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odroid-C1 has an eMMC connector where users can optionally install an
eMMC module. The eMMC modules run off a 1.8V VQMMC supply which means
that HS-200 mode can be used (this is the highest mode that the SDHC
controller supports). Enable the SDHC controller so eMMC modules can be
accessed.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index cb21ac9f517c..0c26467de4d0 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -15,6 +15,7 @@ / {
 	aliases {
 		serial0 = &uart_AO;
 		mmc0 = &sd_card_slot;
+		mmc1 = &sdhc;
 	};
 
 	chosen {
@@ -26,6 +27,11 @@ memory {
 		reg = <0x40000000 0x40000000>;
 	};
 
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		blue {
@@ -310,6 +316,26 @@ &saradc {
 	vref-supply = <&vcc_1v8>;
 };
 
+&sdhc {
+	status = "okay";
+
+	pinctrl-0 = <&sdxc_c_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <8>;
+	max-frequency = <100000000>;
+
+	disable-wp;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sdio;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+};
+
 &sdio {
 	status = "okay";
 
-- 
2.27.0

