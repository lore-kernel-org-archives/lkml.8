Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3B2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E2B208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbgE0R7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:59:48 -0400
Received: from out28-121.mail.aliyun.com ([115.124.28.121]:42434 "EHLO
        out28-121.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391778AbgE0R7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:59:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2216236|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0106189-0.000383161-0.988998;FP=18363760306740780531|2|1|7|0|-1|-1|-1;HT=e02c03268;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.HeTcPrZ_1590602337;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HeTcPrZ_1590602337)
          by smtp.aliyun-inc.com(10.147.43.95);
          Thu, 28 May 2020 01:59:20 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v12 4/7] dt-bindings: clock: Add X1830 clock bindings.
Date:   Thu, 28 May 2020 01:56:32 +0800
Message-Id: <20200527175635.5558-5-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200527175635.5558-1-zhouyanjie@wanyeetech.com>
References: <20200527175635.5558-1-zhouyanjie@wanyeetech.com>
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
    v11:
    New patch, split from [3/6] in v10.
    
    v11->v12:
    No change.

 include/dt-bindings/clock/x1830-cgu.h | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 include/dt-bindings/clock/x1830-cgu.h

diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/x1830-cgu.h
new file mode 100644
index 000000000000..801e1d09c881
--- /dev/null
+++ b/include/dt-bindings/clock/x1830-cgu.h
@@ -0,0 +1,55 @@
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
+#define X1830_CLK_TCU			36
+#define X1830_CLK_DTRNG			37
+#define X1830_CLK_OST			38
+
+#endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
-- 
2.11.0

