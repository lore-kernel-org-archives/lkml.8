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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BC7C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99C820658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKDW/387"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBBVTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41003 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgBBVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id l3so2593956pgi.8;
        Sun, 02 Feb 2020 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hKGZ/ioDlISioFwoy3HH1kkLCDcsOhTRU9/FCQdF7VA=;
        b=hKDW/387XLb85MU5eYTzvBOAnPorjwHfIXwFSsGoOqmx/E/k3zlMBn/bV3PJcJFQ14
         mCl9Zm+0g2KOC7jtgz+abISksUlfTMyyvdUMyq8GYyclLtXdzTYBYoDYW9PiWerHa2eO
         sZlJnggyzE1fHoRMCiaMDXnzcno/FrCqSA8jXNuNYMzyO4CLgd9SoNJMrDZtuF2+ktNY
         ZhA2HHva+cyi7FJFmQJ9MFKCYha6W6WdyudYb9UhtGTeARyF/PO2TjsSHTKlDKT789Zf
         nlWx0esMzd/jfjVvCTbKyI17aoOM9gQlINud84YI1Vx9KGBlD1RXHCYruuAj4vUmtZDY
         Advw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hKGZ/ioDlISioFwoy3HH1kkLCDcsOhTRU9/FCQdF7VA=;
        b=qpiYaE4o4dlIslNP8ee/tfH2HpQR0qTLjKM2UW3VnLun1EF6Rj8ATBR/1U1gr63ewi
         nO5/w3NxrzRKXFiI6mWWwcOZo/NbXcc/Dx+EX0V4e/MMNZ7fga+g9f40JmtUJbc7GCce
         raE3T8YR2kTNMaI+jR3ES0kMF4RTLwR4iffENaMZhKp7vLTDgaT6wRI8UrwcxIApX+XR
         hXHP9yWA9Y8kRHW/K4EUdLAB16+MgXuyqDMgp3PhUVmITzSqHXQm8QjdlmaSWTPE0V5O
         dPWy6A8UgtMpPPTawOH1PxD2wwnhvJYmmVEunu5dWhNUgQLXVJcqOTtD5JTTNUy2XcgM
         V3mA==
X-Gm-Message-State: APjAAAV4tTi633Wq2I3ykh6zSdZRY6D4IouyO7G0SmWVJt7v6X/pBggf
        5Z9bVo3DkuGBAJ2AVvWGDux7iG9O
X-Google-Smtp-Source: APXvYqzpo1z0tFSbFuKhULwcH8kSyjuoUX1dyI6fogel39PO+3sKQPwBpvPl7GTuGCsKZd+iZcscOA==
X-Received: by 2002:a65:5381:: with SMTP id x1mr5191297pgq.236.1580678354248;
        Sun, 02 Feb 2020 13:19:14 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:13 -0800 (PST)
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
Subject: [PATCH 10/12] dt-bindings: arm: bcm: Convert Vulcan to YAML
Date:   Sun,  2 Feb 2020 13:18:25 -0800
Message-Id: <20200202211827.27682-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Vulcan SoC family binding document for boards/SoCs to use YAML.
Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,vulcan-soc.txt      | 10 --------
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml     | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
deleted file mode 100644
index 223ed3471c08..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Broadcom Vulcan device tree bindings
-------------------------------------
-
-Boards with Broadcom Vulcan shall have the following root property:
-
-Broadcom Vulcan Evaluation Board:
-  compatible = "brcm,vulcan-eval", "brcm,vulcan-soc";
-
-Generic Vulcan board:
-  compatible = "brcm,vulcan-soc";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
new file mode 100644
index 000000000000..0bfb45457150
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,vulcan-soc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Vulcan device tree bindings
+
+maintainers:
+  - Robert Richter <rrichter@marvell.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Northstar2 based boards
+        items:
+          - enum:
+              - brcm,vulcan-eval
+              - cavium,thunderx2-cn9900
+          - const: brcm,vulcan-soc
+
+...
-- 
2.17.1

