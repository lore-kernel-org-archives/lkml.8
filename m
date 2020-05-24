Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60249C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4942C20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbgEXPsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:48:13 -0400
Received: from out28-217.mail.aliyun.com ([115.124.28.217]:34317 "EHLO
        out28-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgEXPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:48:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3040102|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00952081-0.000370523-0.990109;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HcyTzUM_1590335272;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HcyTzUM_1590335272)
          by smtp.aliyun-inc.com(10.147.44.118);
          Sun, 24 May 2020 23:48:02 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v9 3/6] dt-bindings: clock: Add X1830 bindings.
Date:   Sun, 24 May 2020 23:47:26 +0800
Message-Id: <20200524154729.30958-5-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200524154729.30958-1-zhouyanjie@wanyeetech.com>
References: <20200524154729.30958-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock bindings for the X1830 Soc from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
    to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
    the old mailbox is in an unstable state.
    
    v2->v3:
    Adjust order from [3/5] in v2 to [4/5] in v3.
    
    v3->v4:
    Adjust order from [4/5] in v3 to [3/4] in v4.
    
    v4->v5:
    Rebase on top of kernel 5.6-rc1.
    
    v5->v6:
    Add missing part of X1830's CGU.
    
    v6->v7:
    No change.
    
    v7->v8:
    Rebase on top of linux-next.
    
    v8->v9:
    No change.

 .../devicetree/bindings/clock/ingenic,cgu.yaml     |  2 +
 include/dt-bindings/clock/x1830-cgu.h              | 54 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
index 0281cd1d7e1b..a952d5811823 100644
--- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
+++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
@@ -25,6 +25,7 @@ select:
           - ingenic,jz4770-cgu
           - ingenic,jz4780-cgu
           - ingenic,x1000-cgu
+          - ingenic,x1830-cgu
   required:
     - compatible
 
@@ -51,6 +52,7 @@ properties:
         - ingenic,jz4770-cgu
         - ingenic,jz4780-cgu
         - ingenic,x1000-cgu
+        - ingenic,x1830-cgu
       - const: simple-mfd
     minItems: 1
 
diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/x1830-cgu.h
new file mode 100644
index 000000000000..2e709222777d
--- /dev/null
+++ b/include/dt-bindings/clock/x1830-cgu.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,x1830-cgu DT binding.
+ *
+ * They are roughly ordered as:
+ *   - external clocks
+ *   - PLLs
+ *   - muxes/dividers in the order they appear in the x1830 programmers manual
+ *   - gates in order of their bit in the CLKGR* registers
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_X1830_CGU_H__
+#define __DT_BINDINGS_CLOCK_X1830_CGU_H__
+
+#define X1830_CLK_EXCLK			0
+#define X1830_CLK_RTCLK			1
+#define X1830_CLK_APLL			2
+#define X1830_CLK_MPLL			3
+#define X1830_CLK_EPLL			4
+#define X1830_CLK_VPLL			5
+#define X1830_CLK_OTGPHY		6
+#define X1830_CLK_SCLKA			7
+#define X1830_CLK_CPUMUX		8
+#define X1830_CLK_CPU			9
+#define X1830_CLK_L2CACHE		10
+#define X1830_CLK_AHB0			11
+#define X1830_CLK_AHB2PMUX		12
+#define X1830_CLK_AHB2			13
+#define X1830_CLK_PCLK			14
+#define X1830_CLK_DDR			15
+#define X1830_CLK_MAC			16
+#define X1830_CLK_LCD			17
+#define X1830_CLK_MSCMUX		18
+#define X1830_CLK_MSC0			19
+#define X1830_CLK_MSC1			20
+#define X1830_CLK_SSIPLL		21
+#define X1830_CLK_SSIPLL_DIV2	22
+#define X1830_CLK_SSIMUX		23
+#define X1830_CLK_EMC			24
+#define X1830_CLK_EFUSE			25
+#define X1830_CLK_OTG			26
+#define X1830_CLK_SSI0			27
+#define X1830_CLK_SMB0			28
+#define X1830_CLK_SMB1			29
+#define X1830_CLK_SMB2			30
+#define X1830_CLK_UART0			31
+#define X1830_CLK_UART1			32
+#define X1830_CLK_SSI1			33
+#define X1830_CLK_SFC			34
+#define X1830_CLK_PDMA			35
+#define X1830_CLK_DTRNG			36
+#define X1830_CLK_OST			37
+
+#endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
-- 
2.11.0

