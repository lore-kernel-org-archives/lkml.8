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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B9C3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD34206D3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2qx4E2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgBBVTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:20 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:55619 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgBBVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:11 -0500
Received: by mail-pj1-f51.google.com with SMTP id d5so5385535pjz.5;
        Sun, 02 Feb 2020 13:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lzwVHc1k/dY+x845Gy9RdQHoQfS2nfs3A+KYo1foc+0=;
        b=H2qx4E2Nhhp/BK97BF1fSINkDJ/idHIamceUiP6CjL6p57LV7ch1P3F1LBIno+/V7C
         JCGivnzqrNKP8ZuMgrYAwPZ+g656v7GkQb1aTxvaeN7Q3paP1QYJDximmditdTZlBGg6
         O+ysRhTLoLXbRm72LcVzhRpCJb1E/XxDI6jfePpFplSwJnqD2AWxXanuNWFGWkCSCFjX
         7gh6iUcIEutC9wVbOuZZwV3DtyZVkLVBAP+RphWo9XibaOjKaBhnatufScJOlmHto115
         d6g4IUOfrz7sgJDN9L6/nanBoqYiGEz8ofAzQfyfDikuAnIJK8l9J9pW8wYLGArisZCq
         Muog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lzwVHc1k/dY+x845Gy9RdQHoQfS2nfs3A+KYo1foc+0=;
        b=owYPBkNDrXy8cdmzhMRDnCVpPVEtCic36AdI0iG1GZtF2wVzCBYrA013G80OHjw70I
         vPMpVV1ywBwM4XlyXsGOguGh7tA4MxGch5PhnHHl9MD8yIDCLY+MAMuUdJqBDCVyFvYl
         ORsHi/uAFnv8JR5VfiOlG2A+buk7Lo/uJtmuNdtwDlzBfOM+WVmJMN0D+vPLiCkAmqaO
         8krPAYt/DN/ZnKUVbhvz0Prny0QKuroBtAfoTjrVQCL23VAWjT70secPAk74MoolYnUG
         z6myMG3TBSky+GtSfvt5gyEQ7INX6vPfEHttgh2uJ3VPQkO28qnCAxaf6DHi3ZdZ4gnW
         yw0g==
X-Gm-Message-State: APjAAAVaDNtchBKRcXvPLh0WTnBD/3Is58ZWpK/4BC6y5nYlSTZ0JXvE
        HOf4Z7/bqP/8j/8aWg9XsRaSvK1Z
X-Google-Smtp-Source: APXvYqwpg4xdPeG2V0xlCQCQTflLB4Gel0Sq5vaGv2Q+wOl7EIu98sLT2K4/HtfyYhyrZVMx7mAlUA==
X-Received: by 2002:a17:90a:2545:: with SMTP id j63mr26212455pje.128.1580678350712;
        Sun, 02 Feb 2020 13:19:10 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:10 -0800 (PST)
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
Subject: [PATCH 08/12] dt-bindings: arm: bcm: Convert BCM4708 to YAML
Date:   Sun,  2 Feb 2020 13:18:23 -0800
Message-Id: <20200202211827.27682-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom BCM4708 SoC family binding document for boards/SoCs
to use YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,bcm4708.txt         | 15 ----
 .../bindings/arm/bcm/brcm,bcm4708.yaml        | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
deleted file mode 100644
index 8608a776caa7..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Broadcom BCM4708 device tree bindings
--------------------------------------------
-
-Boards with the BCM4708 SoC shall have the following properties:
-
-Required root node property:
-
-bcm4708
-compatible = "brcm,bcm4708";
-
-bcm4709
-compatible = "brcm,bcm4709";
-
-bcm53012
-compatible = "brcm,bcm53012";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
new file mode 100644
index 000000000000..d48313c7ae45
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,bcm4708.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4708 device tree bindings
+
+description:
+  Broadcom BCM4708/47081/4709/47094/53012 Wi-Fi/network SoCs based
+  on the iProc architecture (Northstar).
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+  - Hauke Mehrtens <hauke@hauke-m.de>
+  - Rafal Milecki <zajec5@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BCM4708 based boards
+        items:
+          - enum:
+              - asus,rt-ac56u
+              - asus,rt-ac68u
+              - buffalo,wzr-1750dhp
+              - linksys,ea6300-v1
+              - linksys,ea6500-v2
+              - luxul,xap-1510v1
+              - luxul,xwc-1000
+              - netgear,r6250v1
+              - netgear,r6300v2
+              - smartrg,sr400ac
+              - brcm,bcm94708
+          - const: brcm,bcm4708
+
+      - description: BCM47081 based boards
+        items:
+          - enum:
+              - asus,rt-n18u
+              - buffalo,wzr-600dhp2
+              - buffalo,wzr-900dhp
+              - luxul,xap-1410v1
+              - luxul,xwr-1200v1
+              - tplink,archer-c5-v2
+          - const: brcm,bcm47081
+          - const: brcm,bcm4708
+
+      - description: BCM4709 based boards
+        items:
+          - enum:
+              - asus,rt-ac87u
+              - buffalo,wxr-1900dhp
+              - linksys,ea9200
+              - netgear,r7000
+              - netgear,r8000
+              - tplink,archer-c9-v1
+              - brcm,bcm94709
+          - const: brcm,bcm4709
+          - const: brcm,bcm4708
+
+      - description: BCM47094 based boards
+        items:
+          - enum:
+              - dlink,dir-885l
+              - linksys,panamera
+              - luxul,abr-4500-v1
+              - luxul,xap-1610-v1
+              - luxul,xbr-4500-v1
+              - luxul,xwc-2000-v1
+              - luxul,xwr-3100v1
+              - luxul,xwr-3150-v1
+              - netgear,r8500
+              - phicomm,k3
+          - const: brcm,bcm47094
+          - const: brcm,bcm4708
+
+      - description: BCM53012 based boards
+        items:
+          - enum:
+              - brcm,bcm953012er
+              - brcm,bcm953012hr
+              - brcm,bcm953012k
+          - const: brcm,brcm53012
+          - const: brcm,bcm4708
+...
-- 
2.17.1

