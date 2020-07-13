Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074EB206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgGMCNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:13:24 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:60760 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgGMCNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:13:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4102802|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00696024-0.000355632-0.992684;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.I0sGW3h_1594606394;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I0sGW3h_1594606394)
          by smtp.aliyun-inc.com(10.147.42.253);
          Mon, 13 Jul 2020 10:13:20 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     tiny.windzz@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH v3 11/16] dt-bindings: irq: sun7i-nmi: fix dt-binding for a80 nmi
Date:   Mon, 13 Jul 2020 10:13:09 +0800
Message-Id: <20200713021309.31885-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no one use "allwinner,sun9i-a80-sc-nmi". The A80 uses
"allwinner,sun9i-a80-nmi".

Let's fix it.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 .../bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index cf09055..aab74a8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -29,7 +29,7 @@ properties:
       - items:
         - const: allwinner,sun8i-a83t-r-intc
         - const: allwinner,sun6i-a31-r-intc
-      - const: allwinner,sun9i-a80-sc-nmi
+      - const: allwinner,sun9i-a80-nmi
       - items:
         - const: allwinner,sun50i-a64-r-intc
         - const: allwinner,sun6i-a31-r-intc
-- 
1.9.1

