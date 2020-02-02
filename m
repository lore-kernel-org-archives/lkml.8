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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F57C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53DE20658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzDfGeln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgBBVTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41751 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id j9so3380392pfa.8;
        Sun, 02 Feb 2020 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0jJJmK4Mx2WfiOTBPLN7HPig/djh+iM8ysjdKEjile4=;
        b=XzDfGelnW4RyxFB+tbeMszGkIjQoew0dqWwvQb5TtIrvYypWSAs6YWT2jyDjP5NqX3
         iBpWhrtf4wWZnK9NzX3vEBW4t5ZXAg0EpAO1iD+fOnXYqanIGNnYXH04nbAKIGU2jR1s
         dhDZeFZn1fLS1chq3kNCkVH12PEM7S+z1r2llw/KjUbmsTbVeRnFFikeE5Sbw/UWxj7m
         sUofKiy7vWBaZgP2VSdQ+GsMqzBioUhtLPgo1Asv6bKfKlBLk9r9velxrqzwxUpZj8rL
         8mOadA9ciLTlqnP99CdRrzmktHFv/4eLAUoemczu0IdKOei/MvbYGe0CnvX2ueIi0d6T
         wy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0jJJmK4Mx2WfiOTBPLN7HPig/djh+iM8ysjdKEjile4=;
        b=aGNhmeSacwHW+hlqrRjNpsKCYi+ktx261a3iElFh8N5IGX1rK1EZ5KavGqDUUBaBFn
         I8iBgiYfwWK0KOY15lFO3W0JWX8gudHOrMoqu+O9jq8Hf/I5t95kRSGWWkagG/T89xoM
         u/mSxDPY2xdAvrfwna5OrGJgX0katQCFLbkBVmqLjeFOnNaLO4xXIP7C+Y9qgH8iSwx7
         bBI2PSsDNcxIRiUETFYEp/UolMP612CKreCBvjzjTuUzIX4+C/Vx2gQ6N6t46X7SKv4+
         CZ4uwrNDZIhNKi9AHo/xoV1X4D+0GEzV38x1HYTHwJ9hlbrjvUp5T7dlmHWqVTgY2N38
         GYgw==
X-Gm-Message-State: APjAAAXElU6cJ37CI1fZmmX3TGiXxWHcz1Savweje4pvZAyqFH/DpnjJ
        xttgHCvCERUy2h/dVCv1SHNcS+OK
X-Google-Smtp-Source: APXvYqxRwOkofmsrr6lj+YNgcfcX5JRarYGSg7YEvrBpqLiB0axkrHcOuolx5Rno4QKcbzUacnd0HA==
X-Received: by 2002:a63:e4d:: with SMTP id 13mr2717798pgo.343.1580678339094;
        Sun, 02 Feb 2020 13:18:59 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:18:58 -0800 (PST)
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
Subject: [PATCH 01/12] dt-bindings: arm: bcm: Convert Cygnus to YAML
Date:   Sun,  2 Feb 2020 13:18:16 -0800
Message-Id: <20200202211827.27682-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadocom Cygnus SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,cygnus.txt          | 31 ---------
 .../bindings/arm/bcm/brcm,cygnus.yaml         | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 31 deletions(-)
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
index 000000000000..2606ca956caf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
@@ -0,0 +1,66 @@
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
+    oneOf:
+      - description: BCM11300 based boards
+        items:
+          - enum:
+              - brcm,bcm11300
+          - const: brcm,cygnus
+
+      - description: BCM11320 based boards
+        items:
+          - enum:
+              - brcm,bcm11320
+          - const: brcm,cygnus
+
+      - description: BCM11350 based boards
+        items:
+          - enum:
+              - brcm,bcm11350
+          - const: brcm,cygnus
+
+      - description: BCM11360 based boards
+        items:
+          - enum:
+              - brcm,bcm11360
+          - const: brcm,cygnus
+
+      - description: BCM58300 based boards
+        items:
+          - enum:
+              - brcm,bcm58300
+          - const: brcm,cygnus
+
+      - description: BCM58302 based boards
+        items:
+          - enum:
+              - brcm,bcm58302
+          - const: brcm,cygnus
+
+      - description: BCM58303 based boards
+        items:
+          - enum:
+              - brcm,bcm58303
+          - const: brcm,cygnus
+
+      - description: BCM58305 based boards
+        items:
+          - enum:
+              - brcm,bcm58305
+          - const: brcm,cygnus
+
+...
-- 
2.17.1

