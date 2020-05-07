Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF11C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D720CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSbG7BME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEGLPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgEGLP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:15:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 04:15:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so2521424pjw.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dzZv5l46H3vCVPERauYX1uGZ7zgOzPk4wkpAl/BDozc=;
        b=tSbG7BME/8vv5wmI/sQc+zwSPUoEoKgUp4LNjaY+Qkz0zVVKE0Rc1qtVsZEaOJLq+D
         T7zYpqzmNEPG8PPe3sDzQmIBrVsQ3YdZHaWVxolM7OaCc04AJ72uDYD8xMTigC8YZ73O
         DtHhv6NGLxThEGqUri6YXrisZZkQWhZux89L9reZ1ZM0TXb1FDtClGLs5Cn3ZioT6Iql
         HIsRp4uVK4sDNELmcnS2ni7fPUOeRRhGs0TKaajJ3SZlCaquvsun27EVEgONBnuQeCmM
         OwD+kegqJKmB4tqYRmpgHMdVurC9Ap7GZ9ZpV5TuKaJJXeD5aDbo5AIsWc3ulXRZ8dwr
         x4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dzZv5l46H3vCVPERauYX1uGZ7zgOzPk4wkpAl/BDozc=;
        b=WS8vJigXcMKtV7cAt8Z74At8yniez0NdYG+41mAPhwEnplIo5ChIsY9cM13lW2JHX5
         FnIYkRAX+6nYQJFIN7lVsfYv0ulfYQEBKSeabm+rZ3DXw6mM6KIH8qaBc0KGFcax3hDm
         7f3iwIFrz8V8t2N69idKKfNOm7DDeWgxYrtnIU2AwELdZ6eyBdb1ioEGIBv/O8/CepSg
         IXYu471J4C13h8tJ2Au0CTgKAfxpyVI5bYIzVZXd5+vRC/EslYCl59zCuUxQoLzXMPsk
         h6/btP2/xFLWm3Z4BIEPw2ZQBuo4wiBUZiAuXC7iiY48MfmBgtc6R70i9CvdWh4e7CMl
         iX2A==
X-Gm-Message-State: AGi0Pua+LUXSAwk7WSG9mQ4G1xZYqvPg+tHeD+5ip0l/4iHngY1MukaG
        uPzqrCbb7+mK/O2zesaWWbg=
X-Google-Smtp-Source: APiQypL0XwlSVSsL32FDaZck9swez03mevirdkbAAk25JZBdWGaET1BAU4+vusLEr5Iw20yBXb3YQA==
X-Received: by 2002:a17:90a:1f8f:: with SMTP id x15mr14723323pja.76.1588850129146;
        Thu, 07 May 2020 04:15:29 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id z1sm7056388pjn.43.2020.05.07.04.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 04:15:28 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH V2 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco board
Date:   Thu,  7 May 2020 19:15:25 +0800
Message-Id: <1588850125-24344-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the stmpe811 touch screen on stm32429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>

[PATCH 3/4]: ARM: dts: stm32: enable stmpe811 on stm32429-disco

V2:
patch 3: remove unused id, blocks, irq-trigger

V1:
patch 4: fix read touch screen xyz timeout bug
patch 3: enable stmpe_touchscreen on stm32f429-disco board
patch 2: add i2c3 pin mux for stm32f4
patch 1: add i2c3 controller interface for stm32f4

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..fad1ec1 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -49,6 +49,8 @@
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -127,3 +129,48 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	stmpe811@41 {
+		compatible = "st,stmpe811";
+		reg = <0x41>;
+		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpioa>;
+		/* 3.25 MHz ADC clock speed */
+		st,adc-freq = <1>;
+		/* 12-bit ADC */
+		st,mod-12b = <1>;
+		/* internal ADC reference */
+		st,ref-sel = <0>;
+		/* ADC converstion time: 80 clocks */
+		st,sample-time = <4>;
+
+		stmpe_touchscreen {
+			compatible = "st,stmpe-ts";
+			/* 8 sample average control */
+			st,ave-ctrl = <3>;
+			/* 7 length fractional part in z */
+			st,fraction-z = <7>;
+			/*
+			 * 50 mA typical 80 mA max touchscreen drivers
+			 * current limit value
+			 */
+			st,i-drive = <1>;
+			/* 1 ms panel driver settling time */
+			st,settling = <3>;
+			/* 5 ms touch detect interrupt delay */
+			st,touch-det-delay = <5>;
+		};
+
+		stmpe_adc {
+			compatible = "st,stmpe-adc";
+			/* forbid to use ADC channels 3-0 (touch) */
+			st,norequest-mask = <0x0F>;
+		};
+	};
+};
-- 
2.7.4

