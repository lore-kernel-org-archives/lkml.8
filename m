Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BB42098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICJev4x2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgFPL2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPL2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:28:02 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218AC08C5C2;
        Tue, 16 Jun 2020 04:28:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i12so1300787pju.3;
        Tue, 16 Jun 2020 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C66Iy0udb87vhjoDYd71Ql6l2XA6eYACBYbwZNfMhzU=;
        b=ICJev4x2OgJ6X7xmSzWcGWWwJAyPTOuhILDrFDfIxcor78l92hde85mv/ysyicxvef
         iPNwenqBqzDbFYvb1JN0CUUfCD/bVIu8lN07+lYRk/zQ79/IhvUQXPkBOAMQHdCG5CLq
         w5Sq6/CXDDYr0RG7p6vn79pM30Dl03IYtNXE4GfkD0tlZFOzpYLWUvcRW0T2WAK+H2/S
         6dRw9Bh5DKve8/a1Nd85Gd7LTgTsOPUU1p2F6w3ozF/XkHf/bG/7J2lhs7lGUJtze0wc
         f8CojXLI6JoBPREEVLMQjgXwOSuemXoDk4DjB7x7zXK9YgYMX8a87KK7rZeLaVKjY4Xk
         I0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C66Iy0udb87vhjoDYd71Ql6l2XA6eYACBYbwZNfMhzU=;
        b=EdKzUrRfmbCbnmP49siiLiLPVE4Ex5tuQSJpIwaQKqb56z5lV3LOmNVz+jZ/OjMZll
         Xs250XTMjceZ+YezbuNS6r05vPddbE4FPJZic6NbYG1riAAl+bEDre71qGoqAUs5SPtC
         xVVvItWzj1YFNzBnJN6HmmzJRhrsFWpgLaPeRc0XrrAOtOZvG0a63gm7wqD17PIjkYaX
         qmQdK4mh7nUTpp812OXl+QOqaS8Eg6AXEkxTdtSwG6yPW59auPni//4wFmBmNKMLU0KP
         dlkueKLtgAEaJ4yOb7LWLek1sd1IX60i9qsUpDOhVttl8JH+ja4GZTQ7wkHYm9DpuLWJ
         U8aw==
X-Gm-Message-State: AOAM530Khz1/lnGEv1qJZP2OGElHGOq/4nqSmo5yojkF0ahUmjGYmYdy
        swxaowYDbetV5BIAhsIDBcQ=
X-Google-Smtp-Source: ABdhPJwaevj2Eg+de+5NM26vCPlyHzB6CcylDSU3H8uKvyfdS27T3gYBG5pWtcngruNnK1bLe2z5/A==
X-Received: by 2002:a17:90a:c85:: with SMTP id v5mr2248738pja.114.1592306882003;
        Tue, 16 Jun 2020 04:28:02 -0700 (PDT)
Received: from localhost.localdomain ([101.12.205.96])
        by smtp.gmail.com with ESMTPSA id b19sm16617701pft.74.2020.06.16.04.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 04:28:01 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH] dt-bindings: mfd: Add bindings for the Mediatek MT6360 PMIC
Date:   Tue, 16 Jun 2020 19:27:56 +0800
Message-Id: <1592306876-3504-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add devicetree binding document support Mediatek MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 Documentation/devicetree/bindings/mfd/mt6360.txt | 53 ++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.txt

diff --git a/Documentation/devicetree/bindings/mfd/mt6360.txt b/Documentation/devicetree/bindings/mfd/mt6360.txt
new file mode 100644
index 0000000..e25b5c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mt6360.txt
@@ -0,0 +1,53 @@
+MediaTek MT6360 Multifunction Device Driver
+
+MT6360 is a multifunction device with the following sub modules:
+- ADC
+- Battery Charger/OTG boost
+- Flash LED/RGB LED/moonlight LED
+- 2-channel Buck
+- 6-channel LDO
+- USB_PD
+
+It is interfaced to host controller using I2C interface.
+This document describes the binding for MFD device and its sub module.
+
+Required properties:
+- compatible:	Must be "mediatek,mt6360_pmu"
+- reg:			Specifies the I2C slave address of PMIC block, Must be <0x34>
+- interrupts:	I2C device IRQ line connected to the main SoC.
+
+Optional subnodes:
+- ADC
+	Required properties:
+		- compatible: "mediatek,mt6360_adc"
+- battery charger/OTG boost
+	Required properties:
+		- compatible: "mediatek,mt6360_chg"
+- Flash LED/RGB LED/moonlight LED
+	Required properties:
+		- compatible: "mediatek,mt6360_led"
+- 2-channel Buck
+	Required properties:
+		- compatible: "mediatek,mt6360_pmic"
+- 6-channel LDO
+	Required properties:
+		- compatible: "mediatek,mt6360_ldo"
+- USB_PD
+	Required properties:
+		- compatible: "mediatek,mt6360_tcpc"
+
+Example:
+
+	#include <dt-bindings/usb/pd.h>
+
+	pmu: mt6360_pmu@34 {
+		status = "ok";
+		compatible = "mediatek,mt6360_pmu";
+		reg = <0x34>;
+		wakeup-source;
+		interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "IRQB";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
-- 
2.7.4

