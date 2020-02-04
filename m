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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F86EC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B60217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpX4vcwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgBEAHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:34 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:37013 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgBEAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:32 -0500
Received: by mail-pl1-f182.google.com with SMTP id c23so88779plz.4;
        Tue, 04 Feb 2020 16:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wc/K2VBiaEoAX8ksH2pdKPCsC2it4+zxHWGi9pFTCR0=;
        b=LpX4vcwIJu2IyTR90vNarI+qCvGoHb1ZlWvp4HFsthjfhAQf+pTPZ9orM/1zzOjeGy
         IGh1grpjO6hNg1h5TXud/wIV6ZjPVsSa1ZSnQVxwO6BcZDFSt+rlWUKIdtC/UhNu7VXt
         lepq53wH10uOLMYt5JXvQk+Ps4jVMGIiz6Kw7aX4DzowJ+oCaFSxJN5xnLuPlKCg1BTG
         690+NA/POlrwDAohjK0Pz0ee5LJJx63gpaJiN8CZW/TsISwcPOmxhL5MO6wRh7p/t5kH
         tWskAuCKC3jODHl1IstXhxUHSvDx8hYy8m5iDgSMVnlVcxdJEiM3QMzBrBkXqzNwLM1Y
         fUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wc/K2VBiaEoAX8ksH2pdKPCsC2it4+zxHWGi9pFTCR0=;
        b=ud4cE9475AeToN8tZaJikyVWh7N0QKvhqMarO+pYIqxAnSF+xUNl5E+y7+3u4a7xwt
         xZFhMD9jTgsKUlIRpo3gMXd++zFJy9tVFudGVFpDZ9rgm+c5j9MHP0fERHx/so9NFF85
         tljf8x/DZ506x7lXpWGEgiZboGifrYwyxaR9YNmYeXCnMvn/DAxZbAXce8UEiUFurRTG
         Waxc9TPwkQEKIKTM9fjLTgyDrrtWvzVX8bxB1VUnzBGHTjUwlwQDX2SyyqOT6dQNqyRF
         KKRRnzuzsjuUIcmbvibTARb5NRAavEgMuJHUmbYm7QKZtL4GRQwtO54TJIgWBDRwh5wr
         /5Pg==
X-Gm-Message-State: APjAAAU1X4PIBJO82drSHEEfWw4I9bpAmCc9Dy2JzNtXtQmjHlaaJjVd
        MiiAfJDN2vQpozky0yDkv6s=
X-Google-Smtp-Source: APXvYqxIpUaGYHjBBZkqBxq9C4gI7LzQDwvfUSTeSLhEkS5m4RgcX30JMcEC+W07zub0VrT5fr8jEw==
X-Received: by 2002:a17:90a:7307:: with SMTP id m7mr2194523pjk.75.1580861251789;
        Tue, 04 Feb 2020 16:07:31 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:31 -0800 (PST)
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
Subject: [PATCH v2 04/12] dt-bindings: arm: bcm: Convert Northstar 2 to YAML
Date:   Tue,  4 Feb 2020 15:55:44 -0800
Message-Id: <20200204235552.7466-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Northstar 2 SoC binding document for boards/SoCs to
use YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,ns2.txt  |  9 --------
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
deleted file mode 100644
index 35f056f4a1c3..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
+++ /dev/null
@@ -1,9 +0,0 @@
-Broadcom North Star 2 (NS2) device tree bindings
-------------------------------------------------
-
-Boards with NS2 shall have the following properties:
-
-Required root node property:
-
-NS2 SVK board
-compatible = "brcm,ns2-svk", "brcm,ns2";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
new file mode 100644
index 000000000000..2451704f87f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,ns2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom North Star 2 (NS2) device tree bindings
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
+        - brcm,ns2-svk
+        - brcm,ns2-xmc
+      - const: brcm,ns2
+
+...
-- 
2.19.1

