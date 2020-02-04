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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEEDC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24B4218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE+WUJAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBEAHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33357 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgBEAHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so214838pfn.0;
        Tue, 04 Feb 2020 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERKdQg+ZQ5/xsEYnaNIhskI/jM2cXI2orVLbvx3keIc=;
        b=VE+WUJAOudGGe1MdXO3cYv0Sr2+IgMUZ/Xs3ym3cceLyAkN1ZgnPmpAZmVraM/WzI9
         kS7OnM9/0wWjf89l8u6tKoOAniITN13YbZ5H7uNdNZUjVWFWTj3S+n8X4k00R/a46duX
         FqaYPZKuEdSnuSIn6xIlvRKUfP0ky7iug/LaCYhxtQfUK9DucOw1/vGYZwoBw4QeUIPm
         fyBSD3uZUmNdlaZEnXIvOoVrXqZrjzQTaBu+A6evQQ8W9TN65Lw3xHarY4BB/VFJuWDh
         mIwBMO0A2UbwE5kBpBFN6W5EvXD/J0auJ7rY6NV1wdvI6VKgI/s0ga3yCyqPh2z2ePj6
         LIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERKdQg+ZQ5/xsEYnaNIhskI/jM2cXI2orVLbvx3keIc=;
        b=pV1c0u0v57beiXPxPRFE+WU3X491IUjHYOyxP7CWWhe4swB4PiNCzPyH/9MrQFFXpR
         2wHcv8/QWAsiEVtrOvjcbpBNMNbeZP2y8V/RaQAoGA6mzBsd3Z/38RGYSMON4KNlxLj2
         VdJ8qoQ7p5nKTPEKAr//W/kKncKKMyVRYn8x4tdRIQVv7uaTrlNFzKQDgNPRmGHQB4qz
         OsEJW/JsAkc/invlvU7RJWGGianlZfbsXFueZAxzwC3Lfk7JBpA5Z0UgMnWPm96q1NwF
         tVinphfrN/YQCln/lfzUCyp9kohHuxX5GbEjzZvFVin6TDwJKx1W/LjzEGtytPigy7ub
         JCWA==
X-Gm-Message-State: APjAAAUZCDcj2y20z+Hn/NS1RUQoei+Kh/jsuBMHN2HzxiMH06NTVQrz
        /YTnPHQWrxzEkyM3JG5E6L4=
X-Google-Smtp-Source: APXvYqy8PcH/z7IK5Rdo7h24zwX6FiZnWQFvwh2ZrcJX3vYIQDvjpslqLAD8NwD3VkRzOBzHky+u0w==
X-Received: by 2002:a62:5183:: with SMTP id f125mr22345848pfb.201.1580861256962;
        Tue, 04 Feb 2020 16:07:36 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:36 -0800 (PST)
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
Subject: [PATCH v2 07/12] dt-bindings: arm: bcm: Convert BCM23550 to YAML
Date:   Tue,  4 Feb 2020 15:55:47 -0800
Message-Id: <20200204235552.7466-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom BCM23550 SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,bcm23550.txt        | 15 -------------
 .../bindings/arm/bcm/brcm,bcm23550.yaml       | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
deleted file mode 100644
index 080baad923d6..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom BCM23550 device tree bindings
---------------------------------------
-
-This document describes the device tree bindings for boards with the BCM23550
-SoC.
-
-Required root node property:
-  - compatible: brcm,bcm23550
-
-Example:
-	/ {
-		model = "BCM23550 SoC";
-		compatible = "brcm,bcm23550";
-		[...]
-	}
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml
new file mode 100644
index 000000000000..c4b4efd28a55
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm23550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM23550 device tree bindings
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
+        - brcm,bcm23550-sparrow
+      - const: brcm,bcm23550
+
+...
-- 
2.19.1

