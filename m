Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7483C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E6C20828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgCHQd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:33:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:44840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCHQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1AD1AFF7;
        Sun,  8 Mar 2020 16:32:45 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [RFC 02/11] dt-bindings: arm: Add Sunplus SP7021 and Banana Pi BPI-F2S
Date:   Sun,  8 Mar 2020 17:32:20 +0100
Message-Id: <20200308163230.4002-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Wells Lu 呂芳騰 <wells.lu@sunplus.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/arm/sunplus.yaml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus.yaml

diff --git a/Documentation/devicetree/bindings/arm/sunplus.yaml b/Documentation/devicetree/bindings/arm/sunplus.yaml
new file mode 100644
index 000000000000..c88856a00983
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunplus.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/sunplus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus platforms device tree bindings
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      # SP7021 SoC based boards
+      - items:
+          - enum:
+              - bananapi,bpi-f2s # Banana Pi BPI-F2S
+          - const: sunplus,sp7021
+...
-- 
2.16.4

