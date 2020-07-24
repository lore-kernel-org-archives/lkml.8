Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E517C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6AE206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGXHKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:10:21 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:52512 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgGXHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:10:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3986539|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0129791-0.000774184-0.986247;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I6po0ZJ_1595574611;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I6po0ZJ_1595574611)
          by smtp.aliyun-inc.com(10.147.44.145);
          Fri, 24 Jul 2020 15:10:16 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 06/16] dt-bindings: nvmem: SID: add binding for A100's SID controller
Date:   Fri, 24 Jul 2020 15:09:35 +0800
Message-Id: <c884058c7395d514308f87e76f506b74894fed28.1595572867.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1595572867.git.frank@allwinnertech.com>
References: <cover.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a binding for A100's SID controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../nvmem/allwinner,sun4i-a10-sid.yaml        | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index daf1321d76ad..6687ab720304 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -15,14 +15,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - allwinner,sun4i-a10-sid
-      - allwinner,sun7i-a20-sid
-      - allwinner,sun8i-a83t-sid
-      - allwinner,sun8i-h3-sid
-      - allwinner,sun50i-a64-sid
-      - allwinner,sun50i-h5-sid
-      - allwinner,sun50i-h6-sid
+    oneOf:
+      - const: allwinner,sun4i-a10-sid
+      - const: allwinner,sun7i-a20-sid
+      - const: allwinner,sun8i-a83t-sid
+      - const: allwinner,sun8i-h3-sid
+      - const: allwinner,sun50i-a64-sid
+      - items:
+          - const: allwinner,sun50i-a100-sid
+          - const: allwinner,sun50i-a64-sid
+      - const: allwinner,sun50i-h5-sid
+      - const: allwinner,sun50i-h6-sid
 
   reg:
     maxItems: 1
-- 
2.24.0

