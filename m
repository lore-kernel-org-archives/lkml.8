Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA4D20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cCKgut1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCMJH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:07:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39702 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCMJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:07:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so11061534wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yoy0Boq040f9O0QHUfL99rfr3yZcYOtkMxHX2mJBUoI=;
        b=cCKgut1i8Sc+EKPT9DRFmKJrBypE/0XUpuzxQIHOMtV+E+MOlxyOuqm5Z4pGLVP971
         kvv3q1TgjWtqKM9jeZhNgb5ec9MOGKi+w5ry+E4RQLrxtRw1FH8jteBEe/tqJmtj9UL4
         V7eKJtym3FVR15PjDhy7+Kf2FjwjR5iA3ThwPmGT2nk+yoIHNgZidgJ8OLIX1kz36DbF
         HpVqtJFGyR8zzJ8kJLBxgIML6dZIWV5hOMVR5gHliu37f2kstA1mXrH5F4ploIAHUtKI
         yx9P3sAXan4JzAEJzbLqflO6ItYqJpJFx4OItfbk/Ic1Ss/fVRtBwict6neAU1fmfycs
         M8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yoy0Boq040f9O0QHUfL99rfr3yZcYOtkMxHX2mJBUoI=;
        b=d+jI8fbZ5uQDAdZHMAZdr4ptmaY6aQNGI0zb8531xK7odQHM928N6bxy62ZYa3x8E8
         vEiZvMwAJDG9R6a4cMrlM7yyZ90KWXRWwiiNoCfYRcjXsxrhFJhTsb6tnxPjVbmYLA9h
         wIrwvgbh/JM6/wzQEOkOOGzdPXWA73MyAtT70rueyU20oapsYppXemXV/L5DjlxDSumJ
         wKVsvbFhxjEU8WppFcccsX2e4k1T3PUoaCVdS02VhfGUOUZzpriCVXZkoQZW/QYcAstV
         N7fCEumHtom3WisDF0jepI/zt2SZIEFN0rV16NxNenRIWmKJ+4wOGjccAWu7iL0v38at
         HOwQ==
X-Gm-Message-State: ANhLgQ1iKfWKphLaAIIk7EMJ42TkiVQBmRN8leb9dtlVkH923mEYVtTP
        RABn7As5iMcqE0K5T7/UdAigOA==
X-Google-Smtp-Source: ADFU+vsZuMu3i6rVyy8NzpYVntivu5t4nefjuS0CH3GYC/pYx7aDo3sECAdmYZqRmUHyXeo/gKr6eg==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr17457196wrn.29.1584090441559;
        Fri, 13 Mar 2020 02:07:21 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id i1sm61872399wrs.18.2020.03.13.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:07:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/4] arm64: dts: meson-g12b-odroid-n2: add SPIFC controller node
Date:   Fri, 13 Mar 2020 10:07:13 +0100
Message-Id: <20200313090713.15147-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200313090713.15147-1-narmstrong@baylibre.com>
References: <20200313090713.15147-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add disabled SPIFC controller node with instruction on how to enable
it while lowering capabilities of the eMMC controller from 8bits bus
width to 4bits bus width, it's data pins 4 to 7 being shared with
the SPI NOR controller pins.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index b59ae1a297f2..169ea283d4ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -451,6 +451,27 @@
 	vqmmc-supply = <&flash_1v8>;
 };
 
+/*
+ * EMMC_D4, EMMC_D5, EMMC_D6 and EMMC_D7 pins are shared between SPI NOR pins
+ * and eMMC Data 4 to 7 pins.
+ * Replace emmc_data_8b_pins to emmc_data_4b_pins from sd_emmc_c pinctrl-0,
+ * and change bus-width to 4 then spifc can be enabled.
+ * The SW1 slide should also be set to the correct position.
+ */
+&spifc {
+	status = "disabled";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	mx25u64: spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mxicy,mx25u6435f", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+	};
+};
+
 &tdmif_b {
 	status = "okay";
 };
-- 
2.22.0

