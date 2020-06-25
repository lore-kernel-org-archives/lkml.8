Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07EEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64F420768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXG9NNHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgFYXfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgFYXed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F3C08C5DC;
        Thu, 25 Jun 2020 16:34:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cy7so5555467edb.5;
        Thu, 25 Jun 2020 16:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LofB2FAb1BCmJEIdnua6XnH33N6P1Z6/qz7coDIHQvs=;
        b=lXG9NNHilSmllTINI5qo8pVawfpC6TwZPKA2kS5AYPKHZ4yEPvTMJYHHE6OCu5TG//
         lxiwrI+Te1OV+1Ec4H8WNTvyg2RBjsTM+zz2clrxB0RNI4x2wf2YtluXe7avjwAfMUA1
         B0kPL2IuT+XHsKil8cVVSNguCpDo6BSPn4Z3toDzfsL3TbZno8La0ciPY9IARbCLIAkd
         UW0FX7Bq+RhViqeJg8bjeoWkWHC35fSXl301dXpYiOHKAXKtLMiCUe7ps9Ar3qmcAHMr
         kZlUNKLLExKS/KHp0TuCk/7v/0sXx2ZhqFBjv+vCHD0frIjTMs2ZvsLUjZn+Bn1aZCeb
         S+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LofB2FAb1BCmJEIdnua6XnH33N6P1Z6/qz7coDIHQvs=;
        b=R0u7uAHSLCQ/GLdNYNQ6bsLLr5t+0TdmD4PhpyxWw2+aXvE0SVbE32e6A0+2HVZSZD
         1c49MkFxZxJ2KxBxcRqD2hDGTOaxq/3YUPhHMw6OH/GU6Ihrd45qX/RXjggmQkD4hujE
         yD1iWjVohtjv/BTZXnjYPBOhI4QuQ/NflkIp4y4qrBV4G6xmECuLncqSvNAXBYYai2vm
         WLkTFgA632Hr1LouXPmAbUmUzZYoMurqM56gfSUkAnV5B8Fp9YBljcsDa5kxTeRd/o0H
         A9VIqi14V9D3a1miVaEYwUMkdfeZOqy+18absEnC0S2ddRJMaaZC3t+Ry81/giM39LJP
         k8kw==
X-Gm-Message-State: AOAM532a2mDphI9zp7ZF77PAPzkd/mbk66k/rufV4WFlZZ+9UwGB5pMx
        BmjpYZg2RI2GtMlQ7i3iquY=
X-Google-Smtp-Source: ABdhPJyNtNfC+ltkZdd/rPlX4llvGHORBcgRuLpGvioqcef6WQm8BPNGk0zVNKzn9xzPaSRVVvybqQ==
X-Received: by 2002:a05:6402:c09:: with SMTP id co9mr663015edb.238.1593128070835;
        Thu, 25 Jun 2020 16:34:30 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:30 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 05/10] arm: dts: owl-s500: Add pinctrl node
Date:   Fri, 26 Jun 2020 02:34:17 +0300
Message-Id: <b43c9d1a1ef689403bc17b2474aff20629b58263.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 0b7ba2926f0e..3b625358d786 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/clock/actions,s500-cmu.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
 #include <dt-bindings/reset/actions,s500-reset.h>
@@ -208,6 +209,25 @@ sps: power-controller@b01b0100 {
 			#power-domain-cells = <1>;
 		};
 
+		pinctrl: pinctrl@b01b0000 {
+			compatible = "actions,s500-pinctrl";
+			reg = <0xb01b0000 0x40>, /* GPIO */
+			      <0xb01b0040 0x10>,
+			      <0xb01b0060 0x18>,
+			      <0xb01b0080 0xc>;
+			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 132>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>, /* GPIOA */
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>, /* GPIOB */
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>, /* GPIOC */
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>, /* GPIOD */
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>; /* GPIOE */
+		};
+
 		dma: dma-controller@b0260000 {
 			compatible = "actions,s900-dma";
 			reg = <0xb0260000 0xd00>;
-- 
2.27.0

