Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B3C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4ED206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="s5XV7mjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgELN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbgELN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:26:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E46C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:26:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so15376540wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=itZ8nYpO9rVwAB+XOSiZ1Zaz+WlUMeN8KYJbRrgai8w=;
        b=s5XV7mjGrnG0C7b3JFLWA/serjUzf8eM5Sv6bPOzzXrvy+bBn5NGBA9t3ERPFyJuv2
         SJow9GGfQvqbEJVESTH5XaRi90qYMpkAc+33nM7/TD7ZR1hX6v4OJx27XmVk0E2Ua+0d
         OqhN5SQaS1ajL2aQAdCfmyj6fWL1oVA/nBjIhPvI+Aj7x30jz7wxC2/JcETHuxaAcBB5
         L8ywmE6m4FE94yCLZXU+LyWBxWS25UJ7Yj6YtCist9nBGE0fUFb/fO7lTzHvgMgJr8k6
         5aV2w0izr+/SeOV1SgeR5tFhJsdUfk0n7g/S3Kdy+4sfHzBCmohoIfu8Us6qrTf3KT9/
         8JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=itZ8nYpO9rVwAB+XOSiZ1Zaz+WlUMeN8KYJbRrgai8w=;
        b=SSpVgPrV+DUrmE2JTG69RhGeQyUa+cl5eDuFj9u0v1CMlPiH6XSJXjMDTVfp8im7eO
         9VSYpMvdFaDR514tXAYuxob1tY3QP1xYEsHN9d2uEpWNVqe2YDIB3cBN/rgmuf0nDK5L
         pKKJggWtaCalXjMhnVCYJPZ+U5Y/uKV5m5qFZCFya3G+ClZqVLaF7pgupJ63vlBWX6Uv
         gWoL6kpS80H7y9sLkwgP6P05mxkvOeZ9uhC/aS83I/PNnv5wnbLdYmBTvKBJZN6EwR7W
         zq2mNrQnL8qMsy1EtK8EuFc1GzlLRUEpO1lh5QW7sMTOvIdXTZllCOkk2JmdODQF51rp
         06iw==
X-Gm-Message-State: AOAM5311IJeQUpt+Jb3uH5REmtjStyPG/0VGpYRfBtOVRQRZtsy+6dGy
        55rsnTiRPNTwIPkLYye9EKLKvg==
X-Google-Smtp-Source: ABdhPJygO+LIUhXBZipYlpV1NjUWfdUnA48iHtMRa0nv+p1cN8d+bHqiZL+GB9Ig3+I8VNBJDIQMug==
X-Received: by 2002:adf:de05:: with SMTP id b5mr1650574wrm.299.1589289986709;
        Tue, 12 May 2020 06:26:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id g15sm14441844wro.71.2020.05.12.06.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:26:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Tue, 12 May 2020 15:26:13 +0200
Message-Id: <20200512132613.31507-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200512132613.31507-1-narmstrong@baylibre.com>
References: <20200512132613.31507-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Khadas MCU node with active FAN thermal nodes for all the
Khadas VIM3 variants.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 094ecf2222bb..3325e54ea690 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -183,6 +183,23 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&cpu_thermal {
+	trips {
+		cpu_active: cpu-active {
+			temperature = <80000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&cpu_active>;
+			cooling-device = <&khadas_mcu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
 		/* Realtek RTL8211F (0x001cc916) */
@@ -222,6 +239,12 @@
 	pinctrl-0 = <&i2c_ao_sck_pins>, <&i2c_ao_sda_pins>;
 	pinctrl-names = "default";
 
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,mcu";
+		reg = <0x18>;
+		#cooling-cells = <2>;
+	};
+
 	gpio_expander: gpio-controller@20 {
 		compatible = "ti,tca6408";
 		reg = <0x20>;
-- 
2.22.0

