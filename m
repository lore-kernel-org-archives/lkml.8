Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA13C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F89A20774
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCVIVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:21:49 -0400
Received: from out28-218.mail.aliyun.com ([115.124.28.218]:40205 "EHLO
        out28-218.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:21:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2437828|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.0154397-0.00035353-0.984207;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16384;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.H3MM99h_1584865287;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.H3MM99h_1584865287)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sun, 22 Mar 2020 16:21:40 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v6 5/6] dt-bindings: clock: Add and reorder ABI for X1000.
Date:   Sun, 22 Mar 2020 16:21:01 +0800
Message-Id: <1584865262-25297-7-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1584865262-25297-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.The SSI clock of X1000 not like JZ4770 and JZ4780, they are not
  directly derived from the output of SSIPLL, but from the clock
  obtained by dividing the frequency by 2. "X1000_CLK_SSIPLL_DIV2"
  is added for this purpose, it must between "X1000_CLK_SSIPLL"
  and "X1000_CLK_SSIMUX", otherwise an error will occurs when
  initializing the clock. These ABIs are only used for X1000, and
  I'm sure that no other devicetree out there is using these ABIs,
  so we should be able to reorder them.
2.Clocks of LCD, OTG, EMC, EFUSE, OST are also added.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v5:
    New patch.

 include/dt-bindings/clock/x1000-cgu.h | 62 +++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/x1000-cgu.h
index bbaebaf..ef6ff63 100644
--- a/include/dt-bindings/clock/x1000-cgu.h
+++ b/include/dt-bindings/clock/x1000-cgu.h
@@ -12,33 +12,39 @@
 #ifndef __DT_BINDINGS_CLOCK_X1000_CGU_H__
 #define __DT_BINDINGS_CLOCK_X1000_CGU_H__
 
-#define X1000_CLK_EXCLK		0
-#define X1000_CLK_RTCLK		1
-#define X1000_CLK_APLL		2
-#define X1000_CLK_MPLL		3
-#define X1000_CLK_SCLKA		4
-#define X1000_CLK_CPUMUX	5
-#define X1000_CLK_CPU		6
-#define X1000_CLK_L2CACHE	7
-#define X1000_CLK_AHB0		8
-#define X1000_CLK_AHB2PMUX	9
-#define X1000_CLK_AHB2		10
-#define X1000_CLK_PCLK		11
-#define X1000_CLK_DDR		12
-#define X1000_CLK_MAC		13
-#define X1000_CLK_MSCMUX	14
-#define X1000_CLK_MSC0		15
-#define X1000_CLK_MSC1		16
-#define X1000_CLK_SSIPLL	17
-#define X1000_CLK_SSIMUX	18
-#define X1000_CLK_SFC		19
-#define X1000_CLK_I2C0		20
-#define X1000_CLK_I2C1		21
-#define X1000_CLK_I2C2		22
-#define X1000_CLK_UART0		23
-#define X1000_CLK_UART1		24
-#define X1000_CLK_UART2		25
-#define X1000_CLK_SSI		26
-#define X1000_CLK_PDMA		27
+#define X1000_CLK_EXCLK			0
+#define X1000_CLK_RTCLK			1
+#define X1000_CLK_APLL			2
+#define X1000_CLK_MPLL			3
+#define X1000_CLK_SCLKA			4
+#define X1000_CLK_CPUMUX		5
+#define X1000_CLK_CPU			6
+#define X1000_CLK_L2CACHE		7
+#define X1000_CLK_AHB0			8
+#define X1000_CLK_AHB2PMUX		9
+#define X1000_CLK_AHB2			10
+#define X1000_CLK_PCLK			11
+#define X1000_CLK_DDR			12
+#define X1000_CLK_MAC			13
+#define X1000_CLK_LCD			14
+#define X1000_CLK_MSCMUX		15
+#define X1000_CLK_MSC0			16
+#define X1000_CLK_MSC1			17
+#define X1000_CLK_OTG			18
+#define X1000_CLK_SSIPLL		19
+#define X1000_CLK_SSIPLL_DIV2	20
+#define X1000_CLK_SSIMUX		21
+#define X1000_CLK_EMC			22
+#define X1000_CLK_EFUSE			23
+#define X1000_CLK_SFC			24
+#define X1000_CLK_I2C0			25
+#define X1000_CLK_I2C1			26
+#define X1000_CLK_I2C2			27
+#define X1000_CLK_UART0			28
+#define X1000_CLK_UART1			29
+#define X1000_CLK_UART2			30
+#define X1000_CLK_SSI			31
+#define X1000_CLK_OST			32
+#define X1000_CLK_PDMA			33
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
-- 
2.7.4

