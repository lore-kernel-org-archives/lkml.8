Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB18C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46BC20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEbG/vDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbgFSLyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbgFSLyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:54:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5606C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:54:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so3837265plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=649vrouwnwNw8hZJmDui7hqgFQ4vaLHMeburQrpsbms=;
        b=cEbG/vDax/+j3lSPHK8/nHyvCjYB2tiiBwqR60bvfnEHJoxK4blTHPBKwKhBAp3cIp
         bsErxLaZ49/662w8ilOcd5ylWAwD0KnZip+va+BWpfAEaTVqCMOFys5qfpr5zz+5RCwf
         UsROPptozBcXt43gbOg+mLqShquDKaQIcnZK/gyT6r9fSOhzJ8HR+5QE6h+cOo+W2TQz
         NebvFnXFTQUsFEtTGRAvNMyzvTLJXsmAWG4MrT5BeYFI8sDxmEv23yVSWjTr8xtc6xav
         U/ZZB9WSMhh2+Vw20ZeVI0yUS+mJ0JW95JiNp2Q90n/JktQZ+m4IualUzUEyrhDAloI6
         MZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=649vrouwnwNw8hZJmDui7hqgFQ4vaLHMeburQrpsbms=;
        b=aj7/AwNJzZqDnhGX3My/Mu2Uk0C3VP3eF0DosoM9ABdtdf4LqEiIK9+1yMH2LNWmYn
         M04mR25DXrySAaZ6xtSh6O+HZhyTztyWNu4zvJWZhJnAJGzvOK2wHHTKgevj2Wz4xnYC
         JeQlODqYaGsr48f3L0JgnZTAktsjcVxDEFu14LFSFSAMvs/VY6u8voWKh/Hw+IBBno3w
         FowO7HXckLPu3KThykpy2hBId5faXnruabk/HlJowE3CAfsJSiXGU5GzKkv60hMOyczx
         6bY2YauO2e0cUfCGQ55LXsM56sYy5IDdx+g+aShEq0coZgXuIGrTU7ZjSs0iBTXyLXI1
         0Esg==
X-Gm-Message-State: AOAM532m6GP1SLzR8XIW860e3Q1V/EUqWUYRMRU/ksqtv6QTjGLYMj3m
        DqU+a0BFlvsa5uelGL+thpU=
X-Google-Smtp-Source: ABdhPJzebrHgH8OaOUPSrWFqgAVqn30OWaq7q/7pjgpLWyM8CBheEmOSw1CN+ye0n7VavPf/P0ypMQ==
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr7667948plt.243.1592567671500;
        Fri, 19 Jun 2020 04:54:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46c:79b7:a5d3:5b37:1d99:175a])
        by smtp.gmail.com with ESMTPSA id n64sm5026712pga.38.2020.06.19.04.54.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 04:54:31 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, jic23@kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmurphy@ti.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v2 1/4] dt-bindings: mfd: Add bindings for the Mediatek MT6360 PMIC
Date:   Fri, 19 Jun 2020 19:53:48 +0800
Message-Id: <1592567631-20363-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add devicetree binding document support Mediatek MT6360 PMIC

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 Documentation/devicetree/bindings/mfd/mt6360.txt | 122 +++++++++++++++++++++++
 include/dt-bindings/mfd/mt6360.h                 |  15 +++
 2 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.txt
 create mode 100644 include/dt-bindings/mfd/mt6360.h

diff --git a/Documentation/devicetree/bindings/mfd/mt6360.txt b/Documentation/devicetree/bindings/mfd/mt6360.txt
new file mode 100644
index 0000000..7d7d349
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mt6360.txt
@@ -0,0 +1,122 @@
+MediaTek MT6360 PMIC Driver
+
+MT6360 is a multifunction device with the following sub modules:
+It is interfaced to host controller using I2C interface.
+This document describes the binding for PMIC device and its sub module.
+
+- ADC
+- Battery Charger/OTG boost
+- Flash LED/RGB LED/moonlight LED
+- 2-channel Buck and 6-channel LDO
+- USB_PD
+
+Required properties:
+- compatible:	Must be "mediatek,mt6360-pmu"
+- reg:		Specifies the I2C slave address of PMIC block, Must be <0x34>
+- interrupts:	I2C device IRQ line connected to the main SoC.
+
+Optional subnodes:
+- ADC
+	Required properties:
+		- compatible: "mediatek,mt6360-adc"
+- battery charger/OTG boost
+	Required properties:
+		- compatible: "mediatek,mt6360-chg"
+- Flash LED/RGB LED/moonlight LED
+	Required properties:
+		- compatible: "mediatek,mt6360-led"
+- 2-channel Buck and 6-channel LDO
+	Required properties:
+		- compatible: "mediatek,mt6360-regulator"
+- USB_PD
+	Required properties:
+		- compatible: "mediatek,mt6360-tcpc"
+
+Example:
+
+	#include <dt-bindings/interrupt-controller/irq.h>
+	#include <dt-bindings/mfd/mt6360.h>
+
+	mt6360@34 {
+		compatible = "mediatek,mt6360";
+		reg = <0x34>;
+		wakeup-source;
+		interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "IRQB";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		adc {
+			compatible = "mediatek,mt6360-adc";
+			#io-channel-cells = <1>;
+		};
+		regulator {
+			compatible = "mediatek,mt6360-regulator";
+			LDO_VIN3-supply = <&BUCK2>;
+			buck1 {
+				regulator-compatible = "BUCK1";
+				regulator-name = "mt6360,buck1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+			};
+			BUCK2: buck2 {
+				regulator-compatible = "BUCK2";
+				regulator-name = "mt6360,buck2";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+			};
+			ldo6 {
+				regulator-compatible = "LDO6";
+				regulator-name = "mt6360,ldo6";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+			ldo7 {
+				regulator-compatible = "LDO7";
+				regulator-name = "mt6360,ldo7";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+			ldo1 {
+				regulator-compatible = "LDO1";
+				regulator-name = "mt6360,ldo1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+			ldo2 {
+				regulator-compatible = "LDO2";
+				regulator-name = "mt6360,ldo2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+			ldo3 {
+				regulator-compatible = "LDO3";
+				regulator-name = "mt6360,ldo3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+			ldo5 {
+				regulator-compatible = "LDO5";
+				regulator-name = "mt6360,ldo5";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+		};
+	};
diff --git a/include/dt-bindings/mfd/mt6360.h b/include/dt-bindings/mfd/mt6360.h
new file mode 100644
index 0000000..6368388
--- /dev/null
+++ b/include/dt-bindings/mfd/mt6360.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for MT6360 device bindings.
+ *
+ * Copyright (c) 2020 Mediatek Inc.
+ */
+
+#ifndef __DT_BINDINGS_MT6360_H__
+#define __DT_BINDINGS_MT6360_H__
+
+#define MT6360_OPMODE_LP		(2)
+#define MT6360_OPMODE_ULP		(3)
+#define MT6360_OPMODE_NORMAL		(0)
+
+#endif /* __DT_BINDINGS_MT6360_H__ */
-- 
2.7.4

