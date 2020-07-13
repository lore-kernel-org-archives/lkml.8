Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C3C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5F6205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgGMOcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:32:47 -0400
Received: from out28-194.mail.aliyun.com ([115.124.28.194]:41371 "EHLO
        out28-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgGMOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:32:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6848288|0.7660741;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.00906375-0.0040207-0.986916;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10422;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.I19VHhZ_1594650754;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I19VHhZ_1594650754)
          by smtp.aliyun-inc.com(10.147.41.158);
          Mon, 13 Jul 2020 22:32:42 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     balbi@kernel.org, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v2 1/3] dt-bindings: USB: Add bindings for new Ingenic SoCs.
Date:   Mon, 13 Jul 2020 22:32:09 +0800
Message-Id: <20200713143212.126399-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713143212.126399-1-zhouyanjie@wanyeetech.com>
References: <20200713143212.126399-1-zhouyanjie@wanyeetech.com>
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

