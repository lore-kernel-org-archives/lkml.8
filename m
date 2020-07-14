Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9846FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CDD221ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGNG7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:59:37 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:52951 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbgGNG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:59:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7789875|0.5314721;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_regular_dialog|0.0554704-0.000987751-0.943542;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.I1TXvIO_1594709967;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I1TXvIO_1594709967)
          by smtp.aliyun-inc.com(10.147.44.145);
          Tue, 14 Jul 2020 14:59:32 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Yangtao Li <frank@allwinnertech.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/16] dt-bindings: clk: sunxi-ccu: add compatible string for A100 CCU and R-CCU
Date:   Tue, 14 Jul 2020 14:59:20 +0800
Message-Id: <ca521ce2603649ad530acd8a562c639479c81e80.1594708864.git.frank@allwinnertech.com>
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

This patch adds binding to a100's ccu clock and r-ccu clock.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
index 4d382128b711..3b45344ed758 100644
--- a/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml
@@ -36,6 +36,8 @@ properties:
       - allwinner,sun9i-a80-ccu
       - allwinner,sun50i-a64-ccu
       - allwinner,sun50i-a64-r-ccu
+      - allwinner,sun50i-a100-ccu
+      - allwinner,sun50i-a100-r-ccu
       - allwinner,sun50i-h5-ccu
       - allwinner,sun50i-h6-ccu
       - allwinner,sun50i-h6-r-ccu
@@ -78,6 +80,7 @@ if:
         - allwinner,sun8i-a83t-r-ccu
         - allwinner,sun8i-h3-r-ccu
         - allwinner,sun50i-a64-r-ccu
+        - allwinner,sun50i-a100-r-ccu
         - allwinner,sun50i-h6-r-ccu
 
 then:
@@ -94,7 +97,9 @@ else:
   if:
     properties:
       compatible:
-        const: allwinner,sun50i-h6-ccu
+        enum:
+          - allwinner,sun50i-a100-ccu
+          - allwinner,sun50i-h6-ccu
 
   then:
     properties:
-- 
2.24.0

