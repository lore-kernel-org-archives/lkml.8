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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369F7C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9D62080D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEhWlT5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgBBVTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36411 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgBBVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so6701332pgc.3;
        Sun, 02 Feb 2020 13:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HqoXW19IU0tQeOfSlgHN6Hx1A42Q+7w83EjyBN0djk=;
        b=eEhWlT5Tj1M2M79+KdTJ/ZkY6iDqP5hJIiDhZzqXAinj/L9KkQFU688Jn1PUyGQyxm
         Bkcfp7cQtiCnwvl8tQb4rTDddT04CX3zLjxiELDRPj2y2+7UpfZvx94L7TW2xomnsHdg
         GR7dyUrYAQewHqrCfO4G9UYTku56Ph3gmI86U7UcZerbjMXh64rOWVmYHz9tM3jSZP0E
         97/fqoNzIsZtAvdawFdF5wzj5PiIonAkoZl9HRWHlBPjzg7roba95nbyYgKXeIXxryQ8
         K3NzqxKbud90r2k7ktWW381bCYOSnBMFrPrSkIl28wDuNEKO9EG/YAxRtVKjSSv8uyXa
         cfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+HqoXW19IU0tQeOfSlgHN6Hx1A42Q+7w83EjyBN0djk=;
        b=JeGGRshvuRm1rd/FVPjJtYiejZBTPGpqjQgfkNTs+vvF2A6EJkGHF9+V9yAkZyoZM6
         JwgU5MQ3ydn5sw4tIPVo4H2pdBc8wxkz1NWcE3wOdh9ODu7+rPUJpJKodQdycHRDIump
         estj8Q3kkryHG2qPutB5vrxnVy7WthaM9JQU8j2BFuCvYJllFGubcIUJ2GmER9HyRGgw
         46ThSgKqa3pmYpJhxVnJOPMaFVKkZtL4lzP6XmJP/O9tROXGiZ9AP93FVCFAkM0B1tvD
         bdRCnanQehPMaeT1IY3IaW+JO2tOAmGNbiiukg4eWEnngt7wFrHb0ptkKMVal/guYE08
         ySmQ==
X-Gm-Message-State: APjAAAWHmynUv1vfocMB74L0wJjhkCbprCs11hK4xXo1h5eGOL/n/R5h
        POMHupeXAmQpyslQJ+4R99VettXM
X-Google-Smtp-Source: APXvYqxwXr+UYh03Rgin6a5IfM55L+wGSkmtED3oBRwGNCdutIY5WGWTI2Zkb5r4Ms+8sZuujzi9Wg==
X-Received: by 2002:a63:6441:: with SMTP id y62mr13441735pgb.86.1580678344356;
        Sun, 02 Feb 2020 13:19:04 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:03 -0800 (PST)
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
Subject: [PATCH 04/12] dt-bindings: arm: bcm: Convert Northstar 2 to YAML
Date:   Sun,  2 Feb 2020 13:18:19 -0800
Message-Id: <20200202211827.27682-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Northstar 2 SoC binding document for boards/SoCs to
use YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,ns2.txt  |  9 -------
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml | 25 +++++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)
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
index 000000000000..2fb9b16408f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
@@ -0,0 +1,25 @@
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
+    oneOf:
+      - description: Northstar2 based boards
+        items:
+          - enum:
+              - brcm,ns2-svk
+              - brcm,ns2-xmc
+          - const: brcm,ns2
+
+...
-- 
2.17.1

