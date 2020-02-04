Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA950C3524B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818CB217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBpgEloP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBEAHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43677 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgBEAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so76879plq.10;
        Tue, 04 Feb 2020 16:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSfcK/HqZKOCPjHvTh0wu7XrM6+iOjhpV9sQe4TP4q8=;
        b=GBpgEloP312WeultLakY+aI/u+kIW2DJdsc/8gUXJxBqpEWsQqsBEIdSzdHZILJln0
         WzScAuEh6WCNAUsaKFkGGl2W2fn2XI+epBLKOHOdkaWa0GMEtof4dmiWCv+JP6IJEGzC
         Vr1xuaYeoZ6Dsa8/i4TEcnGadVlRv7qu5EQDjn7hf4GRLPp5tSKVGkp6xE+CPP3qwE4C
         jVRCjaYzFpXid/LvuQOrAmDF2PB8odnyl7ZrsG/wnan1ntn7uk9mijDaX3pYHR8B6/8g
         fa72/h8HVqYMKsH0J26Y8LscB4Pfw/b+Hu3lsqQyD9aoc/4K7pNyaVL+vROZxjFdDgTJ
         I0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSfcK/HqZKOCPjHvTh0wu7XrM6+iOjhpV9sQe4TP4q8=;
        b=fhxMTuYgaXyXeRnDBe08RuZ6j5AFiKST3H4ZEOelTw2a0stCVCH4/hnj/xaqWgA53e
         dKMU0AN7DuE1zna+WNJFiVkjaK9652wvLDHxKE8PQMlcMEeaRtIhyhJj9WyizgyqbEsB
         q6D27jF5J36gLO+Nvs9uEAfRhFWJRb1EN/pIRk91i2OHHxJPiyEdvurFZHrMflcETxMO
         PpNCUOlQnDFVAEgutN4B42GP8+WNO+oklNGFrdcYoxdjajqPT8tfc89/5j/941AEr+ec
         9sbmENm2oJHueh2GXHurILgjbVjKpeWIriKZR2lrEUhNaOIFwhb3Buxnjx0UjCrFcPhP
         vb2g==
X-Gm-Message-State: APjAAAXYGJwaSig4LPPTMZ0LnoZphc3m/zYElVioa4MnC6OEv6Tan4Hl
        Kw6WQ/m1JPiCQMWxMamvTFk=
X-Google-Smtp-Source: APXvYqyUYhDUsNUdwpGM9rwBl+PfcWW3qWb4B67tTiRWr+eucFLOWgYzvM8+v4MNyYyzP4s0UU35Xw==
X-Received: by 2002:a17:902:9a82:: with SMTP id w2mr21170120plp.117.1580861255088;
        Tue, 04 Feb 2020 16:07:35 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:34 -0800 (PST)
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
Subject: [PATCH v2 06/12] dt-bindings: arm: bcm: Convert BCM21664 to YAML
Date:   Tue,  4 Feb 2020 15:55:46 -0800
Message-Id: <20200204235552.7466-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom BCM21664 SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,bcm21664.txt        | 15 -------------
 .../bindings/arm/bcm/brcm,bcm21664.yaml       | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)
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
index 000000000000..aafbd6a27708
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
@@ -0,0 +1,21 @@
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
+    items:
+      - enum:
+        - brcm,bcm21664-garnet
+      - const: brcm,bcm21664
+
+...
-- 
2.19.1

