Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75391C3524B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FF12085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNoS8PP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgBEAHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33214 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgBEAHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so96660plb.0;
        Tue, 04 Feb 2020 16:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmvTxWNYbbqRFY29acB0Jj37QMjm3ZpkquLyekHQJRI=;
        b=DNoS8PP9tu+YUPFrfmW6JQUJYXKzBmqjG/9GECCG5e2iKZyK0jsegj9arM84i1hbKD
         E7DT5iFMEXPHF37KztAssbdIJ9qPrYfr24t6iB2dR3fDvlhPLxMYux5kkNf3m5GBQ1Y9
         q94CC2HUwlS1URG+7ogYn0B/MAMArA6/bm5KltugjqVAhS7Rm9Db4/1MItLxgFfIs5ng
         EsDOzpCV83cfDyoAfQsI+fuw6UcVEhW/b6DZLGBoCTxXMMai7ilEAq0211YqT5apFkWl
         OvaQzzCxoyvAxy3w2cUpiiixIL2GGboiuGbYjCfOHTwahWoSvSNbq4E7RjRCHvPvqbcw
         3MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmvTxWNYbbqRFY29acB0Jj37QMjm3ZpkquLyekHQJRI=;
        b=BiBl99RhY6/1QOVw3E0pZwvgA4RxI6+Rvb60LwAaZxkbTzF7D7ZGAMQvixvdO1MDYB
         PzoJnp/b5FCA38NSs1Ccz1FVrBy6wJVQsYlsZBgbkjh/L1wcZDhx7P3TcqeSLIr68m9r
         dVVUlTUtKUmg8hFGXeAQ37rSBOHPxiIvMz9J5bbCsOcXC9sRHX4Lg25/Xs31hfoOTJZj
         PYTfgYmU/cFBPxzuO7T6jZNERkiohVG/7pb3HkMyXbHO0XB+31i4IGQAiYDnpqNXgtDs
         gDcoW0Y81a/gssrpBwP7k5osTLgb4BCKwpIZbPJLufZgRHnJ/RARGCqADpzaMtjqFDjR
         pi/w==
X-Gm-Message-State: APjAAAUhtiWVjXEIKasguqC33KiozfuZCtog6sVoXshw8+Ryb4Gs7YCM
        aGVDb04Hc7rSsatcTynPk+4=
X-Google-Smtp-Source: APXvYqyECzfty9WFxy19O/11qgx+ClTmtK+jWrBXYMa0UuRFHceFgyp2EPfw/dGKOEBldi2u1pkVkg==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr31646320plb.202.1580861263934;
        Tue, 04 Feb 2020 16:07:43 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:43 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 11/12] dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg'
Date:   Tue,  4 Feb 2020 15:55:51 -0800
Message-Id: <20200204235552.7466-12-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate and move the 'secondary-boot-reg' property from the 3
existing binding documents into the main cpus.yaml documentation, also
make sure that the property is enforced when relevant.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../arm/bcm/brcm,bcm11351-cpu-method.txt      | 36 -----------------
 .../arm/bcm/brcm,bcm23550-cpu-method.txt      | 36 -----------------
 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt  | 39 -------------------
 .../devicetree/bindings/arm/cpus.yaml         | 33 ++++++++++++++++
 4 files changed, 33 insertions(+), 111 deletions(-)
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
index c23c24ff7575..d7b181a44789 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -272,6 +272,39 @@ properties:
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
+if:
+  # If the enable-method property contains one of those values
+  properties:
+    enable-method:
+      contains:
+        enum:
+          - brcm,bcm11351-cpu-method
+          - brcm,bcm23550
+          - brcm,bcm-nsp-smp
+  # and if enable-method is present
+  required:
+    - enable-method
+
+then:
+   required:
+     - secondary-boot-reg
+
 required:
   - device_type
   - reg
-- 
2.19.1

