Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59172C3524B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3050F2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ady2EW7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgBEAH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35244 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBEAH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so93023plt.2;
        Tue, 04 Feb 2020 16:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0o1JfZAxs99nKRdJ2oWN9NNkNqf7TeS9QHfOvRZ8cps=;
        b=Ady2EW7aC9hKOdFeZDBh3Ccw916VyfUqNOPm8vEDW9eLKjhGCOWbIyrSUdvVGY/NXF
         e88XdFQPRAaM19AtcUISe1Gz2UicOzlfHqVNncLfmEYNEO/HapeFCKJ3GB2fZwShsDZb
         eUjMEVzqtfcUxKLaRmcM2T+TN7gMOGP33bKdUC0/UCx+ULu2W+zSPyGR7Dx0WNzf/Gjc
         C0mQfYWElWDLga7Fc4bE/JVSyo9MIMQysHZa4OjniDYnIlhChndD3KjRMToOpI1r9hbS
         WekeeymbfYI5ZyCUSBAFNo9QoXcLLu16bpu7j7XJJyGFWadQ6rXk1aPlhHb7JHtn612w
         +7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0o1JfZAxs99nKRdJ2oWN9NNkNqf7TeS9QHfOvRZ8cps=;
        b=pxGIt8t9WHACJ4vnHDA/MHTMF5AHbeIFOqSy05MT6JSDLzDpuXKmL4k0TGuAFedbp4
         7btOTe5dmebrUg7sx6MWX7Y01RwRpLkBBQ2iHUeKHZ3DQtkzNVfOLue2HBQokAIrLB+V
         UtrurYASKkxS+XXHcRfqlmiTZwyfHMuzzebyH/h3WhBNHKS5bbvKv2fUfzUVrk2H445r
         xQQ/hPvcrzZ1i6cJQKQ2ISJSjfKp/a5hrDRG88Et1jLYgbinQUSj6EAtJWnh0utyMnDb
         1P6OKTV2EyjOd3B7pqwG/IN/gE3bBXew+5uwA7riIdCjhb4y6r9OaaPJ299MhLQ1Uzya
         8N0g==
X-Gm-Message-State: APjAAAVrsR4DrVaA/Sghc9unF/mhrx6DL9roLTMljYHmxvDGMhbB26G5
        hs8fVQOUwF2CTCa2ZFVSExo=
X-Google-Smtp-Source: APXvYqzFQwtp8Vz1BJtpAwSPZUwdpUqBoeZx+uR9xj8P3lLOwhA6lTw0BoqevnpkZwSKZGd96WJO/w==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr32847987pll.307.1580861246688;
        Tue, 04 Feb 2020 16:07:26 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:26 -0800 (PST)
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
Subject: [PATCH v2 01/12] dt-bindings: arm: bcm: Convert Cygnus to YAML
Date:   Tue,  4 Feb 2020 15:55:41 -0800
Message-Id: <20200204235552.7466-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadocom Cygnus SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,cygnus.txt          | 31 -------------------
 .../bindings/arm/bcm/brcm,cygnus.yaml         | 29 +++++++++++++++++
 2 files changed, 29 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
deleted file mode 100644
index 4c77169bb534..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Broadcom Cygnus device tree bindings
-------------------------------------
-
-
-Boards with Cygnus SoCs shall have the following properties:
-
-Required root node property:
-
-BCM11300
-compatible = "brcm,bcm11300", "brcm,cygnus";
-
-BCM11320
-compatible = "brcm,bcm11320", "brcm,cygnus";
-
-BCM11350
-compatible = "brcm,bcm11350", "brcm,cygnus";
-
-BCM11360
-compatible = "brcm,bcm11360", "brcm,cygnus";
-
-BCM58300
-compatible = "brcm,bcm58300", "brcm,cygnus";
-
-BCM58302
-compatible = "brcm,bcm58302", "brcm,cygnus";
-
-BCM58303
-compatible = "brcm,bcm58303", "brcm,cygnus";
-
-BCM58305
-compatible = "brcm,bcm58305", "brcm,cygnus";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
new file mode 100644
index 000000000000..fe111e72dac3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,cygnus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Cygnus device tree bindings
+
+maintainers:
+   - Ray Jui <rjui@broadcom.com>
+   - Scott Branden <sbranden@broadcom.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+        - brcm,bcm11300
+        - brcm,bcm11320
+        - brcm,bcm11350
+        - brcm,bcm11360
+        - brcm,bcm58300
+        - brcm,bcm58302
+        - brcm,bcm58303
+        - brcm,bcm58305
+      - const: brcm,cygnus
+
+...
-- 
2.19.1

