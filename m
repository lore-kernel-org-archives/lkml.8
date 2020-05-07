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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9A4C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7D62083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Eco3yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGJQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgEGJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:16:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7884EC061A41
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 02:16:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so1845238plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L4sM3AW3j6UIA7E8JtPyZaEOpo7L03/nH/zacWPyyAQ=;
        b=O+Eco3yTtSm5e3+ZZJEPQW7LYANk0ENsvTeGBvwhhxBe6+m53DXNgfqZ7KlDwc6zBf
         JCLRKcMxF6PEn50vbF+FNy9Ca9UdLt6ezVQyaiKWh8VK0EgLC+PocTQ/yPrm4+Do8wgf
         gNfYp2QPEOrvfTN3DnPJs5bycglTABJG+XJTlYpq1c+CQNHVVQcPLw8Y4+Ky6rXVAby3
         W4DbHEUaWenVwfWH88cdIn6tORbxYxpxeMuQxL6bfTI03XS2cSePVcvcab8cBgW5hFwB
         RPaIqLbrsfy9qwYdbvRIb21IB5r0QTfkx0wwZo5F6TEjBsFiD2XMmrhlYNbRyyISdZ5E
         5LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L4sM3AW3j6UIA7E8JtPyZaEOpo7L03/nH/zacWPyyAQ=;
        b=HF3869Ldw71DcJ7vnm9qbHtZkUiiG0yvnMYZJJdVqE+ky1zWdYJd//MfQnq7WmqX/d
         Ly+cdUrD+TlC4Z8ciloak0jDtV0q/xH2gJ4qh4waBeCwGz/XZ9UjSuaWEy4SCOSwe+Wc
         nAkihNnCFHPPAK1DtBs2rASMNhlEGKf/L+bSq/PYScCMEf50rA1enJJELEymXgNpddyN
         lyxAnREAzEwESX+6JnoSzJ/iPlRnwKHZ57jqBK2O6OrSwUj95oAm2tQG0TRsfyv/9yua
         1+fUc88B3vgzjxhWeGV00GqTODsXAntsaGSZITmi6FNKtLqEb6jxzL7AC0WIAZD/6jRW
         KAFw==
X-Gm-Message-State: AGi0PuYFjMtskElSlw8F+/Dcj8iiNHuf9p6EAASk0wda2TN19uf25TNG
        +EO77X5d1kFYevq64aLqCdo=
X-Google-Smtp-Source: APiQypLbcwB9R3OvqJ1MZo4353PGHtm6f1Og5xJlUP4Dg+wBN0WjbeLkBl8G7D4+ObVPV5HAMXpj6g==
X-Received: by 2002:a17:902:b711:: with SMTP id d17mr12427536pls.333.1588842986055;
        Thu, 07 May 2020 02:16:26 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id m8sm660100pjz.27.2020.05.07.02.16.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 02:16:25 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco board
Date:   Thu,  7 May 2020 17:16:11 +0800
Message-Id: <1588842971-20495-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588842971-20495-1-git-send-email-dillon.minfei@gmail.com>
References: <philippe.schenker@toradex.com>
 <1588842971-20495-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the stmpe811 touch screen on stm32429-disco board.

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

