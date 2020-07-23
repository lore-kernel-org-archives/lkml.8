Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC0C4361B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E7822D02
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgGWGN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:13:58 -0400
Received: from out28-98.mail.aliyun.com ([115.124.28.98]:55206 "EHLO
        out28-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgGWGNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:13:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6997842|0.7739751;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_regular_dialog|0.0117991-0.00267069-0.98553;FP=16928395198620438954|2|2|8|0|-1|-1|-1;HT=e02c03293;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I6H78tB_1595484804;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I6H78tB_1595484804)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 23 Jul 2020 14:13:52 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v5 1/4] dt-bindings: USB: Add bindings for new Ingenic SoCs.
Date:   Thu, 23 Jul 2020 14:12:58 +0800
Message-Id: <20200723061301.82583-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200723061301.82583-1-zhouyanjie@wanyeetech.com>
References: <20200723061301.82583-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB PHY bindings for the JZ4780 SoC, the X1000 SoC and
the X1830 SoC from Ingenic.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    Add bindings for the JZ4780 SoC.
    
    v2->v3:
    No change.
    
    v3->v4:
    No change.
    
    v4->v5:
    No change.

 Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml b/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
index a81b0b1a2226..2d61166ea5cf 100644
--- a/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
+++ b/Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
@@ -4,10 +4,11 @@
 $id: http://devicetree.org/schemas/usb/ingenic,jz4770-phy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ingenic JZ4770 USB PHY devicetree bindings
+title: Ingenic SoCs USB PHY devicetree bindings
 
 maintainers:
   - Paul Cercueil <paul@crapouillou.net>
+  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
 
 properties:
   $nodename:
@@ -16,6 +17,9 @@ properties:
   compatible:
     enum:
       - ingenic,jz4770-phy
+      - ingenic,jz4780-phy
+      - ingenic,x1000-phy
+      - ingenic,x1830-phy
 
   reg:
     maxItems: 1
-- 
2.11.0

