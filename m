Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B81C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C812C20DD4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGHI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:27:19 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:40435 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbgGHI1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:27:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3919662|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.05864-0.00417621-0.937184;FP=16269809178823979455|2|1|16|0|-1|-1|-1;HT=e02c03268;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I-BX2cf_1594196829;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I-BX2cf_1594196829)
          by smtp.aliyun-inc.com(10.147.40.2);
          Wed, 08 Jul 2020 16:27:14 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        icenowy@aosc.io, clabbe@baylibre.com, megous@megous.com,
        frank@allwinnertech.com, georgii.staroselskii@emlid.com,
        tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: [PATCH v3 15/16] dt-bindings: arm: sunxi: Add Allwinner A100 Perf1 Board bindings
Date:   Wed,  8 Jul 2020 16:27:19 +0800
Message-Id: <20200708082719.5644-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Allwinner A100 Perf1 Board.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index abf2d97..8cdc677 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -16,6 +16,11 @@ properties:
   compatible:
     oneOf:
 
+      - description: Allwinner A100 Perf1 Board
+        items:
+          - const: allwinner,a100-perf1
+          - const: allwinner,sun50i-a100
+
       - description: Allwinner A23 Evaluation Board
         items:
           - const: allwinner,sun8i-a23-evb
-- 
1.9.1

