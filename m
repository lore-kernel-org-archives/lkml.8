Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C2BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20FE2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A07pKi2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFQQs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgFQQsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C0C06174E;
        Wed, 17 Jun 2020 09:48:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so3125644eja.7;
        Wed, 17 Jun 2020 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbtFhwo2fqQ8/gIQgNvQA6jb7MjlC2oHnaaRv7v1IUo=;
        b=A07pKi2LYvpXZf86f3a4g7sReKjO1U7SOzTgDaNnc/97/L9D0FW47EJvtPHPstA309
         2mIVuhTx3sOVsqo2afHlc+SVcwD8uYqdgBOjn3iRWrMODrsZZr/IyDt+/F1o/+5BgYbi
         5kerLNuB7Kyo1xTxHuR/6ABuvfGG7qM7CkTh7wf9lTJNQIJmFvGnb/Mf+hOz0JsKAiPM
         rGHLrX2dsO8GB0b57TVodqMtY773pdHL5UFR8SxTswSh5WAuvJ4/XGkv6reN5iXBuG8M
         CYAnohV2Gsvt32oYF4MO612scOWHHNfAW45MnaoaqIFu9XbuOLNUmpyipMnDLQktP5RU
         cTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbtFhwo2fqQ8/gIQgNvQA6jb7MjlC2oHnaaRv7v1IUo=;
        b=fcGgs9vFpml6YAr1A7HyAFXkvnbFpcxK+aR17uuWkLypflYKfDEj0nJeYZ7c6VG5yR
         IDu7O9IAeudhqb1Fp2GCSUK2eOsMVrwkszG3ib5qYee6itaAsTs2yiwNTz7ahdnPQrHL
         DgHKjR6W8Q8GcinGl8s9p/ltnq5fcQDf4GbmJRePG3zCcpRciQQOZfMH35qf/tQzzCWL
         1aJV8T/+JXpmn6tFzZgNaSz1C2PLG56kwHZb3SgDaKLK4dhDZkaZZOlxorxhHnSrgNNk
         /WyKDj0nzZjuuQb4H+DJP9/jI8rtVwAjo4wDzlxK2/tGj4Tnny0QSfqFNo5v2EPkUkJl
         c3vw==
X-Gm-Message-State: AOAM5326MiHWDLJNfQU0rUgsPDtlAy+Rb6HrVu4rWWyqFXz0ZG83UliY
        1oPYDszT+M3heD48LNh668c=
X-Google-Smtp-Source: ABdhPJwpe09uu45N6nr4qcBknRYME+IG2U1ApAgHIb2wdtB6mfX4FJC13WILYduRAMnTW86xDre4wg==
X-Received: by 2002:a17:906:148b:: with SMTP id x11mr85532ejc.282.1592412498710;
        Wed, 17 Jun 2020 09:48:18 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:18 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] arm: dts: owl-s500: Set UART clock refs from CMU
Date:   Wed, 17 Jun 2020 19:48:03 +0300
Message-Id: <0dcd4186d4ecc420ce382977dd6624f6e63fefc7.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable using Clock Management Unit clocks for every UART node
of the Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 5d5ad9db549b..ac3d04c75dd5 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -131,6 +131,7 @@ uart0: serial@b0120000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0120000 0x2000>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART0>;
 			status = "disabled";
 		};
 
@@ -138,6 +139,7 @@ uart1: serial@b0122000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0122000 0x2000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART1>;
 			status = "disabled";
 		};
 
@@ -145,6 +147,7 @@ uart2: serial@b0124000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0124000 0x2000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART2>;
 			status = "disabled";
 		};
 
@@ -152,6 +155,7 @@ uart3: serial@b0126000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0126000 0x2000>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART3>;
 			status = "disabled";
 		};
 
@@ -159,6 +163,7 @@ uart4: serial@b0128000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb0128000 0x2000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART4>;
 			status = "disabled";
 		};
 
@@ -166,6 +171,7 @@ uart5: serial@b012a000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012a000 0x2000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART5>;
 			status = "disabled";
 		};
 
@@ -173,6 +179,7 @@ uart6: serial@b012c000 {
 			compatible = "actions,s500-uart", "actions,owl-uart";
 			reg = <0xb012c000 0x2000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_UART6>;
 			status = "disabled";
 		};
 
-- 
2.27.0

