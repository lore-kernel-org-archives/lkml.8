Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4006C3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7E1206D3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSu+7wq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBBVT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40979 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgBBVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so5016404plr.8;
        Sun, 02 Feb 2020 13:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XfjR187NXdISi2xn1LCKRhzqRpFgh+EYN6/XoOzH7QE=;
        b=bSu+7wq9db2iSb/oq37AULgd0rrkKEniBWxHhxiWsz4MZR+ZkUtcZZWoucYeKwwiff
         T01eGU/hMPf3ZIt75OcoK8eGR08R84+ECLoBNPdTAybXeZPnefQtaecDVTKCbvhQcVU4
         hhOezpkMXHu18lsPq9iX6+gjghOS6NHOvzoMXzG9x8IFOTEZDj8L0UOIM8gw5xC7r51m
         7EtY6eHG5SZqHqtFLJAjVOQDPVGwnFE9vUcILmihdXOSKJYd5ILnrxsnpigAx5Mwqz4g
         Np+tRBqeQFWbuKgZHZxHEU2GQCW7QLu2qNSnTCJEMzDIvOemLee5gRyR9D0LAynNEIN5
         PMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XfjR187NXdISi2xn1LCKRhzqRpFgh+EYN6/XoOzH7QE=;
        b=U7GrqPIYtxCBgAeIbItKlsXmR4/DGe+elJshlVhBG9PDfECbdsiCz6vgC7ppIhFUO6
         ghU6MVvOYFP24qAbEJBaxLyWjjpH0c8ohplMwtuNFgKK3tGTCjrOor4oAtvYsTcuz0tC
         Kmom9mDQdvjlYIvQ0LqQi/cF2hqPMzG2GKR1JrE7haCL68j21oOtR6aZvYEY3TetwOto
         T3xP5WBoQ7bI6X/rc2sh6On24Bd5GTrJRIQcBs78Rk6V+dv4jPOfTVHo6Yze7LPS69Wu
         FzvqhpGb2tAf17g8yVFLoROzJp43Oy7LjlvSFHFZJaUyvUsCeKS5h5BHROBTYYYSqUiW
         ZBMQ==
X-Gm-Message-State: APjAAAV7eJ0xPEQ83+D9UZY0uNO1vhrelL1bv/HAQljQIAtPASWvFH7s
        276Y5qGgoIpfDa/bBziyGNW6SdJA
X-Google-Smtp-Source: APXvYqziE6DxBqxEoMo21k/aFZUUW0d950vCCF9swRBLnIWa1mvipMR0xnR4DoQiN2oGuecP0oaHtw==
X-Received: by 2002:a17:902:8545:: with SMTP id d5mr19658713plo.116.1580678356002;
        Sun, 02 Feb 2020 13:19:16 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 11/12] dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg'
Date:   Sun,  2 Feb 2020 13:18:26 -0800
Message-Id: <20200202211827.27682-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate and move the 'secondary-boot-reg' property from the 3
existing bindingn document into the main cpus.yaml documentation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../arm/bcm/brcm,bcm11351-cpu-method.txt      | 36 -----------------
 .../arm/bcm/brcm,bcm23550-cpu-method.txt      | 36 -----------------
 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt  | 39 -------------------
 .../devicetree/bindings/arm/cpus.yaml         | 16 ++++++++
 4 files changed, 16 insertions(+), 111 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
deleted file mode 100644
index e3f996920403..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Broadcom Kona Family CPU Enable Method
---------------------------------------
-This binding defines the enable method used for starting secondary
-CPUs in the following Broadcom SoCs:
-  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155, BCM21664
-
-The enable method is specified by defining the following required
-properties in the "cpu" device tree node:
-  - enable-method = "brcm,bcm11351-cpu-method";
-  - secondary-boot-reg = <...>;
-
-The secondary-boot-reg property is a u32 value that specifies the
-physical address of the register used to request the ROM holding pen
-code release a secondary CPU.  The value written to the register is
-formed by encoding the target CPU id into the low bits of the
-physical start address it should jump to.
-
-Example:
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <0>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <1>;
-			enable-method = "brcm,bcm11351-cpu-method";
-			secondary-boot-reg = <0x3500417c>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
deleted file mode 100644
index a3af54c0e404..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Broadcom Kona Family CPU Enable Method
---------------------------------------
-This binding defines the enable method used for starting secondary
-CPUs in the following Broadcom SoCs:
-  BCM23550
-
-The enable method is specified by defining the following required
-properties in the "cpu" device tree node:
-  - enable-method = "brcm,bcm23550";
-  - secondary-boot-reg = <...>;
-
-The secondary-boot-reg property is a u32 value that specifies the
-physical address of the register used to request the ROM holding pen
-code release a secondary CPU.  The value written to the register is
-formed by encoding the target CPU id into the low bits of the
-physical start address it should jump to.
-
-Example:
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <0>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <1>;
-			enable-method = "brcm,bcm23550";
-			secondary-boot-reg = <0x3500417c>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
deleted file mode 100644
index 677ef9d9f445..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Broadcom Northstar Plus SoC CPU Enable Method
----------------------------------------------
-This binding defines the enable method used for starting secondary
-CPU in the following Broadcom SoCs:
-  BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
-
-The enable method is specified by defining the following required
-properties in the corresponding secondary "cpu" device tree node:
-  - enable-method = "brcm,bcm-nsp-smp";
-  - secondary-boot-reg = <...>;
-
-The secondary-boot-reg property is a u32 value that specifies the
-physical address of the register which should hold the common
-entry point for a secondary CPU. This entry is cpu node specific
-and should be added per cpu. E.g., in case of NSP (BCM58625) which
-is a dual core CPU SoC, this entry should be added to cpu1 node.
-
-
-Example:
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			next-level-cache = <&L2>;
-			reg = <0>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			next-level-cache = <&L2>;
-			enable-method = "brcm,bcm-nsp-smp";
-			secondary-boot-reg = <0xffff042c>;
-			reg = <1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index c23c24ff7575..6f56a623c1cd 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -272,6 +272,22 @@ properties:
       While optional, it is the preferred way to get access to
       the cpu-core power-domains.
 
+  secondary-boot-reg:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      Required for systems that have an "enable-method" property value of
+      "brcm,bcm11351-cpu-method", "brcm,bcm23550" or "brcm,bcm-nsp-smp".
+
+      This includes the following SoCs: |
+      BCM11130, BCM11140, BCM11351, BCM28145, BCM28155, BCM21664, BCM23550
+      BCM58522, BCM58525, BCM58535, BCM58622, BCM58623, BCM58625, BCM88312
+
+      The secondary-boot-reg property is a u32 value that specifies the
+      physical address of the register used to request the ROM holding pen
+      code release a secondary CPU. The value written to the register is
+      formed by encoding the target CPU id into the low bits of the
+      physical start address it should jump to.
+
 required:
   - device_type
   - reg
-- 
2.17.1

