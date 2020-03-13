Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB3C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ABB2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VeEpgcp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgCMJHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:07:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34538 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgCMJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:07:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so11052447wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HPMaT81MXCeebofnnf7zx0HVEbfvu9bFZLYLQmZDe4=;
        b=VeEpgcp6B7SCz97YksAWPlVAixQ9a1T2llnI8xmaAIqQWVuisecj1ExtzzyvhDYKNM
         zONGsxO4cTO0O891qd52BsaYjV8Tmc7P9OohTp3ZwOgF6r7cNP30MDODqLy7LYxXv+fU
         7WXw1rNmICnU4w1n4D6DQehhwBxR1iY5opur9vb4TsE4EDo/6CdWZJC/SAGZouNj+sco
         pKnfvceozF9c3esMmpUoPEZ1pJd65YVC4NUPxt1AxCX38ntIT/cSckmi5bALe3qluDxI
         TWRhDZH1lW5Hvh/aOwYr0xFdxxcVXyBIxu2ds74vHim4/9hR/vYZri672YWGRfqKZ1jj
         WU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HPMaT81MXCeebofnnf7zx0HVEbfvu9bFZLYLQmZDe4=;
        b=GWrDEnHsFoZKAC/ZKaRWUy5VX3CuOzLeHdpKKgWYdsbyGGHefsidDT/N4ZK35DOObp
         5kjRU4IJ8Gd8DGnIm4w9sUibyEfu5cG/JT/0hys6fKJ7DpcFrvfuy7RkS7xaJPorpcm+
         25qefHsgBkOvqqykN39h3s69pdfCCnPCs+t0Iq43bz4x+UzqHrSAlNoCN2Tyv3PuxAeB
         g6SoZ+Ja0ZDQT11BQF/buGAha7AuyeiT/tbidVYooMeydKYkvbwKYe+QV8nBOOYVUmWS
         F7gI5tOJ9JfegLzsx7x4gyvj5z7Sftl4RtZjc5UczPqT2HT/+ZIJK6pY9TtjcF93B2dr
         5q4Q==
X-Gm-Message-State: ANhLgQ0tTrza1BnPcodDes05igvLW+wKl/2P32dbqd122v6ilVEoSgP6
        x6CGmC8+UcOS8iTtO2wKX010uQ==
X-Google-Smtp-Source: ADFU+vtCUP2jexc1cRHOBRmdco0djB5phQgI4eSon4Q+TxQ5jXY0QSBxqsTqU+wd5RHjgAaSyI3+6A==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr16528447wrg.199.1584090439399;
        Fri, 13 Mar 2020 02:07:19 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id i1sm61872399wrs.18.2020.03.13.02.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 02:07:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/4] arm64: dts: meson-g12: add the SPIFC nodes
Date:   Fri, 13 Mar 2020 10:07:11 +0100
Message-Id: <20200313090713.15147-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200313090713.15147-1-narmstrong@baylibre.com>
References: <20200313090713.15147-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the controller and pinctrl nodes to enable the SPI Flash Controller
on the Amlogic G12A and compatible SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index d09efb86ec33..56a9f8eadf01 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -593,6 +593,17 @@
 						};
 					};
 
+					nor_pins: nor {
+						mux {
+							groups = "nor_d",
+							       "nor_q",
+							       "nor_c",
+							       "nor_cs";
+							function = "nor";
+							bias-disable;
+						};
+					};
+
 					pdm_din0_a_pins: pdm-din0-a {
 						mux {
 							groups = "pdm_din0_a";
@@ -2071,6 +2082,15 @@
 				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
 			};
 
+			spifc: spi@14000 {
+				compatible = "amlogic,meson-gxbb-spifc";
+				status = "disabled";
+				reg = <0x0 0x14000 0x0 0x80>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_CLK81>;
+			};
+
 			pwm_ef: pwm@19000 {
 				compatible = "amlogic,meson-g12a-ee-pwm";
 				reg = <0x0 0x19000 0x0 0x20>;
-- 
2.22.0

