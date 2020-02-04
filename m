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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D1C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838DE2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD3NJvns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBEAHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:36 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:40187 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgBEAHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:34 -0500
Received: by mail-pg1-f182.google.com with SMTP id z7so17523pgk.7;
        Tue, 04 Feb 2020 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On0k+SoyB6waneVG08uGmZyC0wziXmj/SQNqmL9/E3Y=;
        b=uD3NJvnsWRkfelY26ZfWVwEuATt2f3ysSHricvAs3lFcicnDODj2v1qBsLvrwAaQbl
         6n7T1YwAGNqNz+Kq6y1CV8VLmgpobsnz5prNiG2xLsctB55zFb89ctTMPCtDaQmzdbKO
         bOstaUEYCBUzNacz0VESzD/Ukexa014P29xJkRMcZghl5jwp5LDh+Lf+x3TDwoDInb6c
         +Q5uXgyWVeWC5Up4kFIVHi8i1e1NkSyiuAUIjOGGVj5lafy80BRLNUIdJEclVEAvG75g
         jkkk+fAMvc/WuJinHJBUdbyhkO/iAkEqqGbyfaYtM7gM4+o7LPJGJAcpGY7JGU364a3c
         iNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On0k+SoyB6waneVG08uGmZyC0wziXmj/SQNqmL9/E3Y=;
        b=L8+3g3Mde96KRWnlNznbtI9d0OjhXU6Epg602ncnTjjq05J4RoSkNQ1x0JWwIa2FhM
         N5W6xZfqF/23KbRAcBmGMua4Ujk38LijLvUWEqgNZ/bq912sMqUGm3+TOZEM1kCE2luJ
         JjDBiUkBgcvxgp1LBbV4T8vQEaubHWbgQ/uVJdCwZzZ51iNHSponPlnuXRtWTKhA/k1y
         WE3NOIYMziBUm6qQWavo/SQqjVljUonI3ilrHNXElAvy9LLwnshdhx9KTkVhuVJzo8y3
         uHORhs5F7d9oUIJoO5MEqctynUMDnTXJ4dikjzFCBo+28XWF27C+lcYDpZ4DD/kPu/PL
         UhuA==
X-Gm-Message-State: APjAAAWFYir7wKoPDgA+i6NnR69PgJ6NJnhhpaI4oumDM1cMv4dd1UvU
        0qnXruEBOfj9PtDfovliyV4=
X-Google-Smtp-Source: APXvYqz7P9UuJ3pzVapnXVa4MwV4Z6jEFSgCPfSKlVn/1B5p0AnG96L2+cNF7XqqZMEPUWzmc2qt/A==
X-Received: by 2002:a63:d157:: with SMTP id c23mr33952813pgj.242.1580861253434;
        Tue, 04 Feb 2020 16:07:33 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:32 -0800 (PST)
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
Subject: [PATCH v2 05/12] dt-bindings: arm: bcm: Convert Stingray to YAML
Date:   Tue,  4 Feb 2020 15:55:45 -0800
Message-Id: <20200204235552.7466-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Stingray SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,stingray.txt        | 12 ----------
 .../bindings/arm/bcm/brcm,stingray.yaml       | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
deleted file mode 100644
index 23a02178dd44..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Broadcom Stingray device tree bindings
-------------------------------------------------
-
-Boards with Stingray shall have the following properties:
-
-Required root node property:
-
-Stingray Combo SVK board
-compatible = "brcm,bcm958742k", "brcm,stingray";
-
-Stingray SST100 board
-compatible = "brcm,bcm958742t", "brcm,stingray";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml
new file mode 100644
index 000000000000..4ad2b2124ab4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,stingray.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Stingray device tree bindings
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+        - brcm,bcm958742k
+        - brcm,bcm958742t
+        - brcm,bcm958802a802x
+      - const: brcm,stingray
+
+...
-- 
2.19.1

