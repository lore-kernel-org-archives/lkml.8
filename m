Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9C3C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D08B20736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcozJuek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHENb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgEHEN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:13:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA8C05BD43;
        Thu,  7 May 2020 21:13:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r4so278017pgg.4;
        Thu, 07 May 2020 21:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FwcBHEkgpi816HDa38k8dH6l9iAu/nO4Zhpk53Krt/4=;
        b=HcozJuektBhBGZGzSb6NtiZUXW+vXKMz+tmI9HpmNvc6WneM4GYTXNr8Z9jNyMKaqU
         dBp5dsPXy/FmQHQQa7/6hcGuKWjHXY+cS+0YcnQzvypM5GvJJ53YaxVfhPYQDZ0wMFTi
         K5G1Klp0fpWZmr5uy/5ziRvjbmpIEEzRldIjRVMrHGjbvCQ2SWIz3Lfe6jpPKyScPOEI
         n/F+Bh6qLaN4YVt1Btx61eEJlmLn3xN2UnNrjpiNOZ75aWOdPboleRsRNObFS4D4ejpx
         EWXHrFGCsgQdna0sMAdu06UzueA+PnpdEz/A9tNfKOFLDL9Y5Ea3RWq9nhabQeiz5Y6H
         MtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FwcBHEkgpi816HDa38k8dH6l9iAu/nO4Zhpk53Krt/4=;
        b=K9fgXNXFjLGN65FBLaE7Xvbri+lG1YYPKGqZhJ1+em8mSPKDrNK/+7FbucHzADPe25
         zEkhYdxIdw8F0VnGbtCZ7CkRsnibjO7ZxJ0pS/Hk9v5Jh+0vjSHB+kI/M4zpZi33kF77
         qbj4xvVPYOqDRGMe5UVd6Ud5pRlXyorn4dNga//9hLt+scYWavsTaMsyHILjyiv1t1/E
         pawOY/qPQShWlBIJYIlj9cbtcJqPprnom1/x1HhCaHQ4jERv2lO3lPsfsOlJ8KfvcwaF
         CeoEb7M8DXqdilsKnRRFfBnte3vQzL+/x6QvPaRcv5eqwQkJEfDZIK4Am4fVnODIoALy
         AgtA==
X-Gm-Message-State: AGi0PuaF5Ov+2gf2KCSPybxtsZu+jGRi9VvUhsL/d5kJpl8Dx6qmd5gT
        GFPg6kYXUHkTH/AECD2tNdA=
X-Google-Smtp-Source: APiQypLfzmDOwklw5AJIU1r5uLkQQrj0GcfwrLA3v2Q59+LXy/BZRcluqTxvpGbaYdlSHWH1dJyzWA==
X-Received: by 2002:a62:f941:: with SMTP id g1mr763602pfm.118.1588911209459;
        Thu, 07 May 2020 21:13:29 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id h12sm314868pfq.176.2020.05.07.21.13.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 21:13:29 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 2/5] ARM: dts: stm32: enable ltdc binding with ili9341 on stm32429-disco board
Date:   Fri,  8 May 2020 12:13:11 +0800
Message-Id: <1588911194-12433-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
References: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable the ltdc & ili9341 on stm32429-disco board.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 30c0f67..2d9637a 100644
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
@@ -127,3 +129,41 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&ltdc {
+	status = "okay";
+	pinctrl-0 = <&ltdc_pins_f429_disco>;
+	pinctrl-names = "default";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
+&spi5 {
+	status = "okay";
+	pinctrl-0 = <&spi5_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cs-gpios = <&gpioc 2 GPIO_ACTIVE_LOW>;
+	dmas = <&dma2 3 2 0x400 0x0>,
+	       <&dma2 4 2 0x400 0x0>;
+	dma-names = "rx", "tx";
+	display: display@0{
+		/* Connect panel-ilitek-9341 to ltdc */
+		compatible = "stm32f429,ltdc-panel", "ilitek,ili9341";
+		reg = <0>;
+		spi-3wire;
+		spi-max-frequency = <10000000>;
+		dc-gpios = <&gpiod 13 0>;
+		port {
+			panel_in_rgb: endpoint {
+			remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+};
+
-- 
2.7.4

