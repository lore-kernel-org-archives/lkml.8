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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70324C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1D02075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU2GkN1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgEGHrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:47:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C85C061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 00:47:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so2278196pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TqXy+vuqTjO3oqyIdtSWrtx+1Hrshv6ESnu5XJvj/E8=;
        b=NU2GkN1yjcH6u3KT3vkWXG9SlTvbwUqPD9S/3WdLd+Ohg7j9b+XdKAqIZCuUq9mP62
         Ew2ih5yFbth9vRsBaElXi+MSFMhj8P6wa6Tbhc5sMdqV3G91rjC686sIsyzzmwAjlKv2
         9jX6d5ig9dKA1YaCtAnvVWr2gggenToNSNKW2eXyKeTWKdypHml/OjW146/OSFq1CKM9
         BeptFZEPuYszkZ+VaPMa5/4OhRPjiD1pURw8gmUjz/6jQz2B1pggXEezGQF+8qTa+WZD
         lQj/DEU7cmLDm4JFVLl2pmfRhJwGClY1ddK66fM1eISD9suO5WVxP8muL4U2TLUkWPsp
         B5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TqXy+vuqTjO3oqyIdtSWrtx+1Hrshv6ESnu5XJvj/E8=;
        b=Mn5+pdTDUAvZhcuVEdPPRMf9xBzMIxBu2WbS+xwNea5mHg654v6gBEfLZn4gUDc2+Q
         Ic5Cr3uYFRzz+zwd3HKwZAF8+1yAUzKeIQEu8meKDOKDvm0vzu86f9ESZlwwloRS1bcZ
         r6FZbANh+sHDsylZw6mi52kmIiLS/vpTukBivlsflb9hRZ2xCSf2sKeUiutMVnVrL4ko
         w3G3KzbnOrH6pUvsuR8K1mmxSXEYQCn3XQARgQwimKd+3RAQRKJGEZ3tLykFQB2E4HQD
         Agz679LMum6UV7i9061p+UqOKSARqTTjzZShZUUiUjS5CHda9uCsqpeyPNxltsWwjc3I
         WPvw==
X-Gm-Message-State: AGi0PuYVgMgsVkGJExS2YQ+4Q84fn+su5g3E/uQefQIYePtLtNqWFINI
        NCUK6ir3QiR0JZASzX3i5zc=
X-Google-Smtp-Source: APiQypJCZvPn2WgwGdgm7EZr1FrGskXuaTUxgPsHrQygHo0xj1oOe2JLGZscA50x4REpF1O6/1Ky0g==
X-Received: by 2002:a17:902:aa94:: with SMTP id d20mr11658129plr.15.1588837658982;
        Thu, 07 May 2020 00:47:38 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id s22sm4020610pfd.51.2020.05.07.00.47.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 00:47:38 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        philippe.schenker@toradex.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 3/4] ARM: dts: stm32: enable stmpe811 on stm32429-disco board
Date:   Thu,  7 May 2020 15:47:34 +0800
Message-Id: <1588837654-14315-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the stmpe811 touch screen on stm32429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..f9f21c8 100644
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
@@ -127,3 +129,51 @@
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
+		id = <0>;
+		blocks = <0x5>;
+		irq-trigger = <0x1>;
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

