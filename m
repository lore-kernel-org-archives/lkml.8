Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF89C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3C420780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjLnSEq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgGBOyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbgGBOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D527C08C5C1;
        Thu,  2 Jul 2020 07:53:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so11413663plk.3;
        Thu, 02 Jul 2020 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xG+I+OhzhwmJtUntwedWWvLVF9hdPz7VJjHJ9UQuwVg=;
        b=WjLnSEq5QSel1YiqPF8jirofURmebUG6KhyUBCrXkhaDNdQWrSe3wqTAklpISsEMY8
         5b995mGnZbWC3CLjbGVd820M65pBbW1aVZCK8QuLw3138li6+JfLO1Cyxcy5ZYCoQ80I
         NX8jIHGJP+4XYZ9wQPdYI5vCsiE+GMIVr5Y7kd5F8+wIzv2y8oS1gSu+tSTIB45EVt7w
         qInGxlWZEq93iC5vmi3zIHy4BEnZ3TTm28YA4qEFJ+iMM//UOy0r8NOoPO2lpLNWaFnQ
         m0CR1KJJ7ONkEjiJlpBllmGpKxCyaWIjub6fUlwOljWl3H6jCDq7NhM9e0UyhOqBMxRl
         EjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xG+I+OhzhwmJtUntwedWWvLVF9hdPz7VJjHJ9UQuwVg=;
        b=STdHpBs6HLEBAK8AeqIlmdCGRDHCFUdugXXXKSioDKFZiaeX6w5CVvWYrK8/zBsry5
         +X3ZWswtomrWAB1SpISaJjXp5E1u2c8obG5WTooP7jk470kZr4HiWL1QZm9rw7JJOq7w
         Ck7/MBq0I/dXwwyd8KlPwKJ8WGB4S/3uE8bqFNcSX1rm5ue5bqi3C84MLH6Po9LsTPzY
         1WZiH0JjBjMEe6VB3koFsTM+jUN/MGksuYoA5NxaetxONaOWwIMf9VdjkirYquem9WqC
         40yi14rpjxnrbumddc/YTOP6gnbQO3eEStDSmIbaZv8YPZ6e9YK5Josui/QIdlLMOnWm
         2wTw==
X-Gm-Message-State: AOAM531TYMajPH8ZvXiFXsGD0Gd4C4M3hB44cnEiJSLEK8t3nZtqf4Vt
        wu2jm8thUpbdCGeAedMJrEo=
X-Google-Smtp-Source: ABdhPJym9JYnI8irA2HRmbdSHqii3UHpsFvDSpvttgbVeTn8plv+/3TQHwr+lTaFymLK80ioDAoctg==
X-Received: by 2002:a17:902:7204:: with SMTP id ba4mr25554410plb.250.1593701638478;
        Thu, 02 Jul 2020 07:53:58 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:57 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 09/10] arm64: dts: actions: Add MMC controller support for S700
Date:   Thu,  2 Jul 2020 20:22:55 +0530
Message-Id: <1593701576-28580-10-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds support for MMC controllers present on Actions S700 SoC,
there are 3 MMC controllers in this SoC which can be used for accessing
SD/EMMC/SDIO cards.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v4:
	* No change.
Changes since v3:
        * No change.
Changes since v2:
        * No change.
Changes since v1:
        * Added SoC specific compatibe string.
Changes since RFC:
        * No change
---
 arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 2c78caebf515..9ed88aafc2da 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -259,5 +259,38 @@
 			clocks = <&cmu CLK_DMAC>;
 			power-domains = <&sps S700_PD_DMA>;
 		};
+
+		mmc0: mmc@e0210000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0210000 0x0 0x4000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc1: mmc@e0214000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0214000 0x0 0x4000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD1>;
+			resets = <&cmu RESET_SD1>;
+			dmas = <&dma 3>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc2: mmc@e0218000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0218000 0x0 0x4000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD2>;
+			resets = <&cmu RESET_SD2>;
+			dmas = <&dma 4>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4

