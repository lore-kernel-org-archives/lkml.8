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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96706C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC402082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/iG3RxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgBEAHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:46 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:36042 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgBEAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:43 -0500
Received: by mail-pl1-f181.google.com with SMTP id a6so90259plm.3;
        Tue, 04 Feb 2020 16:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbQmNjEgDYzzs2rJFk7fxPgigyR9od2RmRBDQINeABE=;
        b=X/iG3RxSH/LRG86sXEZeH4oKj2y1veejQAmKs62/kIub6x8uPw8l+bDx5XPj0KDIy/
         KLeTSVucR2LAQ5juvnr+f0OY0Uhs6wmsFC0u6negwJgppNl7T0TngviVpMDb9uCiiL3v
         Hkss/rexr+vuxFxB3zqzrCpxBG2uk3RXpazO9O9G2HmsPac55PXQkAPt2GfEarEFqjN/
         f2YjcvaoqXPT+APpNK8KNszcd5OmgvVqMPF8mEGwNZ8jyWilj7oPd0ubq+xxFoUNXVfz
         XapwKBgLTRjBUhP7tWbIeiZaniH9c03Bujkgj5Z+AMl4p3pleE26UG08Y7Qz0cNxbPs1
         7wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbQmNjEgDYzzs2rJFk7fxPgigyR9od2RmRBDQINeABE=;
        b=j3Y3i0bGuoMhADKJx1PvVhaMhZj2L9eUJyLrh08rvUHV0lkZtQF4Y5NVU9NCIuoUso
         q/MeaJIjqBDgJ46stDbO3asFIEEhyE8iOXQPY1eqZ0ey7TicUMwpSC5BjkMLg5z7/nf5
         6xVqlBlRNsokEIt8VFL8o/oAFjYi9RKOlStcwwj6PwjjWZTf7tvUavnsdt+Qx9nxhuZt
         uZQpkPU28MfgOjqb7RM3UKS/q5RZgoX7DKkK9fmS8jNDoM007+zDrzva68pGoy8502MT
         RS58azvKlYmmL0CVOUgWQFCAKpkuS3PYc9Twd6NkOAyTREb7B1RYWhvRPOGIFZM/kFCc
         oT2A==
X-Gm-Message-State: APjAAAWhnuGNYjP1dAMDsYG6AKZEOcsFHs4s+TB0+Svic3hZ/LoOIUmn
        GiRJJEy29dT9sPpO+FQ72SY=
X-Google-Smtp-Source: APXvYqwHUBZ6SUQPjfSqCn9aPbrL0AEWLGCduHWSGavhPaLzvwgmmufcEcD3bhZpquTizNdPtg32Nw==
X-Received: by 2002:a17:90a:d141:: with SMTP id t1mr2175313pjw.38.1580861262343;
        Tue, 04 Feb 2020 16:07:42 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:41 -0800 (PST)
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
Subject: [PATCH v2 10/12] dt-bindings: arm: bcm: Convert Vulcan to YAML
Date:   Tue,  4 Feb 2020 15:55:50 -0800
Message-Id: <20200204235552.7466-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Vulcan SoC family binding document for boards/SoCs to use YAML.
Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,vulcan-soc.txt      | 10 ---------
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml     | 22 +++++++++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)
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
index 000000000000..c5b6f31c20b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
@@ -0,0 +1,22 @@
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
+    items:
+      - enum:
+        - brcm,vulcan-eval
+        - cavium,thunderx2-cn9900
+      - const: brcm,vulcan-soc
+
+...
-- 
2.19.1

