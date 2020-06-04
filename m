Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD20C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E412053B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WVJqusIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgFDRkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:40:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:55228 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730208AbgFDRj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:39:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 19668C007F;
        Thu,  4 Jun 2020 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591292394; bh=vr/az6MfiBirfILNrjnYt+VLOecopVaBBPoxvJZYCes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVJqusIyEi1kg1CoaLRikleQKxsxAZAUtMQpn2N6GLvCIj2q2d5lUSDvl6f8lBGYp
         SUNrgUGAYkH4HIwBxr7NJ3qafYQUXGILsd/l1MJ9qmlZeZtZkie5v7wyBYrxYV1hWU
         /1+QUg9HVoCceSLcdXx+T2g16YvhdzPwmPrHZwqn1GcdxtM0BiHnPPBGaGjGPkYAT1
         e3q8rmel3U5w3J7ZZYW9GFhfP1uUEaItfw+ynVqziKwSkUcJR/hPdtg7KiK/Zic3QI
         IlkrXk3lnOzznvuNunFYBsE+li3BkssSAHbtbr0huH81gNXtcvgEs3/mZ3My7yNbzF
         NdybOtcXMJqBA==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.225.49.234])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6D5B9A006D;
        Thu,  4 Jun 2020 17:39:50 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 4/4] ARC: [plat-hsdk*] document HSDK-4xD board/SoC bindings
Date:   Thu,  4 Jun 2020 20:39:27 +0300
Message-Id: <20200604173927.23127-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
References: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for HSDK-4xD board/SoC bindings. While I'm at it
convert HSDK board/SoC bindings to DT schema format using
json-schema.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../devicetree/bindings/arc/hsdk.txt          |  7 -----
 .../devicetree/bindings/arc/hsdk.yaml         | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arc/hsdk.txt
 create mode 100644 Documentation/devicetree/bindings/arc/hsdk.yaml

diff --git a/Documentation/devicetree/bindings/arc/hsdk.txt b/Documentation/devicetree/bindings/arc/hsdk.txt
deleted file mode 100644
index be50654bbf61..000000000000
--- a/Documentation/devicetree/bindings/arc/hsdk.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-Synopsys DesignWare ARC HS Development Kit Device Tree Bindings
----------------------------------------------------------------------------
-
-ARC HSDK Board with quad-core ARC HS38x4 in silicon.
-
-Required root node properties:
-    - compatible = "snps,hsdk";
diff --git a/Documentation/devicetree/bindings/arc/hsdk.yaml b/Documentation/devicetree/bindings/arc/hsdk.yaml
new file mode 100644
index 000000000000..3a269423b3d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arc/hsdk.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arc/hsdk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare ARC HS Development Kits device tree bindings.
+
+maintainers:
+  - Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: ARC HS Development Kit based on quad core ARC HS38
+          processor in silicon
+        items:
+          - const: snps,hsdk
+      - description: ARC HS4x/HS4xD Development Kit based on quad core
+          ARC HS48/HS47D processor in silicon
+        items:
+          - const: snps,hsdk-4xd
+
+...
-- 
2.21.3

