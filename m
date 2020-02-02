Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8CC3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3279D206E6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2C6PvZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgBBVTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33312 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgBBVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so5033417plb.0;
        Sun, 02 Feb 2020 13:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vT7D46rNtqWVvxbI9rtqz5C9FcqGbTfaLxkBJQBHayw=;
        b=D2C6PvZVUx9xEL7/rgHr/IvxB9ojCf24EgGUc+9tG5qtVZzq8hpUq/pfSvKaVZ66Gz
         1jpIZ9i7KSsBQdAYeGLdYk3AC8hFQiUUakC622rySC8y2Cr/qfQRhADMDuGBv0TWBgFW
         vUuvKs7/KkczuTaVdDpac53bbtUTsbiiPTGQDaYv/V27Q01hFJUKfpyLx4/YEFucdskr
         B+WBeccWPjkel4mdeU4luPGLzePpAUPShzjDSFgBCuhU2teTAERseO5EXUIGIzbnp/28
         ITr4kBaYvj4QYKNDVIV26b1sLoKo+fPzmEKiZbzZvbj3S9WhE2iPj7jGDXai3TXBCAgH
         gl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vT7D46rNtqWVvxbI9rtqz5C9FcqGbTfaLxkBJQBHayw=;
        b=h3I2YW1XR4F1pcbsQtjyQ/4HE+gOCfxRn4Oj/IrSWbJBA7vgmPecrs2EFYyZchJzLn
         HVcFEsprgt/tUlZ5tFyknZx6auLKly/FfgHeiKdN8a3rI3/UIMwzhufao6wyKd1Kyqjg
         22nuvfMm+so3dCqjkAMcC8S6yiuUtxN2BwlmJa2ijPlMdYi7W0DA9A1jGnboiJjXN6Ip
         nrC9Om2HcFbp3HktCvQ1sAnlFtjUY/EJEUajcu1q9ozfDIVNlWYdyeEbboxHcFF5bpbx
         cbLKIXAHZak7teYitt1kZeLVxEhJ8AyX1YdhuvJODvH0ChymqQtF5qaQRDP8TuZ1I97i
         Foag==
X-Gm-Message-State: APjAAAVPBteD5Th1s/685PNo/Pm7HsTO0G+CuapJHKsMq1PWr3reMLS3
        4s2Mw0tRxexjztg42xVQHeIbif9s
X-Google-Smtp-Source: APXvYqyssLFpheMWXm8rEhTJhAajigs2uuLN08Ng2ewQylBb4tdQBLGMDdnq7oA15MNZXESAze/1rg==
X-Received: by 2002:a17:902:6a84:: with SMTP id n4mr20351768plk.294.1580678352669;
        Sun, 02 Feb 2020 13:19:12 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:11 -0800 (PST)
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
Subject: [PATCH 09/12] dt-bindings: arm: bcm: Convert BCM11351 to YAML
Date:   Sun,  2 Feb 2020 13:18:24 -0800
Message-Id: <20200202211827.27682-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom BCM11351 SoC family binding document for boards/SoCs
to use YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,bcm11351.txt        | 10 --------
 .../bindings/arm/bcm/brcm,bcm11351.yaml       | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
deleted file mode 100644
index 0ff6560e6094..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Broadcom BCM11351 device tree bindings
--------------------------------------------
-
-Boards with the bcm281xx SoC family (which includes bcm11130, bcm11140,
-bcm11351, bcm28145, bcm28155 SoCs) shall have the following properties:
-
-Required root node property:
-
-compatible = "brcm,bcm11351";
-DEPRECATED: compatible = "bcm,bcm11351";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml
new file mode 100644
index 000000000000..f69605da3e8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm11351.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM11351 device tree bindings
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BCM11351 based boards
+        items:
+          - enum:
+              - brcm,bcm28155-ap
+          - const: brcm,bcm11351
+
+...
-- 
2.17.1

