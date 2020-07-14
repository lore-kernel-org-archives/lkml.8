Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EC3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E62B221E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGNHSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:18:11 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54985 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725952AbgGNHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:18:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3518181|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0120182-0.00230646-0.985675;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16384;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I1U6uky_1594711082;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I1U6uky_1594711082)
          by smtp.aliyun-inc.com(10.147.42.241);
          Tue, 14 Jul 2020 15:18:06 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tiny.windzz@gmail.com,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 12/16] dt-bindings: irq: sun7i-nmi: Add binding for A100's NMI controller
Date:   Tue, 14 Jul 2020 15:17:54 +0800
Message-Id: <9f05facf3a37611e604b01934fa71dfd507c9c13.1594708864.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1594708863.git.frank@allwinnertech.com>
References: <cover.1594708863.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Add a binding for A100's nmi controller.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index d8fe2d9a307b..8acca0ae3129 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -33,6 +33,9 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-r-intc
           - const: allwinner,sun6i-a31-r-intc
+      - items:
+          - const: allwinner,sun50i-a100-nmi
+          - const: allwinner,sun9i-a80-nmi
       - items:
           - const: allwinner,sun50i-h6-r-intc
           - const: allwinner,sun6i-a31-r-intc
-- 
2.24.0

