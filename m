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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC55C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389FE2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCoNrYW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBEAHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:43 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44917 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgBEAHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:40 -0500
Received: by mail-pf1-f173.google.com with SMTP id y5so183515pfb.11;
        Tue, 04 Feb 2020 16:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTWq2v1G39LXXPwE1U1K2JI+unOCnwpw+JLQGuxBSMU=;
        b=sCoNrYW07Awn3/SPOzVkj+hqGwmaXPgkwJiTOIH5c1SmR6LLnqiA7KuLWvcvjL5hKR
         DNG3AypwxWaPBeNtt+0VIQuEsTuKGbSR2SBDappo1y33L92kCqOwWrSMtTAnARCrbKT9
         lxvPqnzLxn3Dzwpv3ttaMU1Y2/EHm+wb3ynvqbHhT/Gfa/dTyPO0MfmtrCKsS+FDPqWN
         02w7BMHVIdcPD5htPgcK8rXQfYz23/CwUaVERAwJIpN5Z1XZY65+mUMz1t3h8FOY1idR
         DpShW4MeWkZkn+DYAIMq8RbOUG8LF6tzk8Ui8KV2XPR1pLGWgB8JsIqmZgejMP0YKblU
         zQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTWq2v1G39LXXPwE1U1K2JI+unOCnwpw+JLQGuxBSMU=;
        b=RG+lZ0Ne9G/k98qISbaCzVttYnCBnUa/aJAJ08HWqITKaJCsSgGnPkuMj/uO7HBDdV
         rkqPgOxJmkx6XssRKb3uvaKZ5oitIL96L/p0t/Xa1x8kMbO2k9S5jcirCqAuz00mhKma
         wPYPnUKFQGukVk65gnhEw8xnlz2b+g2CAq3ZvbbbJwOp4x18j0sixFVw14TGRMjbr7uJ
         tM8VxYk6KNPa2aLcC+DskvW66vZPh1pRug9i7QXPCAcYXlMWSSw8DKSaXkWoFql9Rr5R
         q4wjksF0wwxgFk0oJbLAc+gQUg3o4hXKw8uIt7gI0E0y9u4siFUK7su0rA/r1Osd+W/U
         hdTw==
X-Gm-Message-State: APjAAAV+LIEQrx6X6AIMMZ30naEsKsUdnX7V1iLv0cROusUeOMcI6quI
        Dcc5uYuI1QsnuT6aWkOxSBc=
X-Google-Smtp-Source: APXvYqytGfneOYdyHzaQkzp4Cs3b4hu262Ic3w2t1TgODeStByOKL1tZCTBqMHa6nfShubjhaW5iag==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr33075792pgs.441.1580861258950;
        Tue, 04 Feb 2020 16:07:38 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:38 -0800 (PST)
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
Subject: [PATCH v2 08/12] dt-bindings: arm: bcm: Convert BCM4708 to YAML
Date:   Tue,  4 Feb 2020 15:55:48 -0800
Message-Id: <20200204235552.7466-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.1

