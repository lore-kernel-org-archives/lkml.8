Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75952C3524D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402802080D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJQYV9aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgBBVTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:17 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35436 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBBVTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:08 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so5480603pjc.0;
        Sun, 02 Feb 2020 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qM36uHLgKaTgocqSHIh2izp9K4IaAcwcVCaZh91ximY=;
        b=TJQYV9aaM2l4PyRJTnUoacLJpHZ/16gnIs+QPF8P5h8jynmGHtlRXO6VPFKlD009lH
         Nsrvfw7rZmZPXzN8zpdDzK9sNFfU88nUTyJ4sfIznKcDJIcwx7IL1V2hYKmaDO/1PliE
         BOR3El+o0JZ3e9Mvia46qeovnUl98LT4GVqSHfdbrbyauqVQSFM/cVopo98bgHL8mJO8
         d1hR9ukziX5/0zJ68afUVWBzbLXVLJC4JiwkA6V2OQ2WNVyqBn7JGTAniMEY3kQ6WVc2
         EqMt05HMJrtKlG+zoBjaK5lXK5agJbHYDZdIWw8wyTIXzPrlI2TCYV2ULLxyjxaAuRP2
         0Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qM36uHLgKaTgocqSHIh2izp9K4IaAcwcVCaZh91ximY=;
        b=IYPXtMIcDLp6beVpF2b3jxVN32cn1FUw2Nd2jxQAB41wXDjQ8xIRGKmKi0SCozYAKJ
         FZXIivUKni963bSZuEe6/td1xt95B7OOAI3NysT/AovvP0+piToZBIi6nxKnv6eU1cgc
         UztiOtbRUAPSAX4pJzoGHegTBr9d5G3gssxfclw+6Sq8zHtwevqWRMw6QZbt6A/pOH4P
         7VkenrgscabuFgFF1T482jv8K6WYssXBCD1xPk6t+jXEtQhaO3ufrFRcTiRkcN+4QV9F
         YB0Njy6OmsdYbLnDZqCQV6zc7ddwkOyAdN0tEaYISHTSflaYyC9Q0Ugy/TwPnJqjzvtB
         HLXQ==
X-Gm-Message-State: APjAAAWRhyuBbssFTAT4bnwREr1MdR9P2fU7U6O1AELfj8MrUACFuCSx
        p8v/Z0R0zmCB7+T2hOT/r7MPjDQc
X-Google-Smtp-Source: APXvYqzch0A10fy9dSa3A8UR0+rBOgp9guvOvWHXh7fRmsV+HcU5+TqyyguWpKkkL4j1d+UXO/Fgtg==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr20089295plr.338.1580678347527;
        Sun, 02 Feb 2020 13:19:07 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:07 -0800 (PST)
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
Subject: [PATCH 06/12] dt-bindings: arm: bcm: Convert BCM21664 to YAML
Date:   Sun,  2 Feb 2020 13:18:21 -0800
Message-Id: <20200202211827.27682-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom BCM21664 SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,bcm21664.txt        | 15 ------------
 .../bindings/arm/bcm/brcm,bcm21664.yaml       | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
deleted file mode 100644
index e0774255e1a6..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom BCM21664 device tree bindings
---------------------------------------
-
-This document describes the device tree bindings for boards with the BCM21664
-SoC.
-
-Required root node property:
-  - compatible: brcm,bcm21664
-
-Example:
-	/ {
-		model = "BCM21664 SoC";
-		compatible = "brcm,bcm21664";
-		[...]
-	}
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
new file mode 100644
index 000000000000..8a38a6b68f60
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm21664.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM21664 device tree bindings
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BCM21664 based boards
+        items:
+          - enum:
+              - brcm,bcm21664-garnet
+          - const: brcm,bcm21664
+
+...
-- 
2.17.1

