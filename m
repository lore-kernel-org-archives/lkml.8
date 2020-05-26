Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7711AC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADBE20723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgEZOm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:42:59 -0400
Received: from out28-219.mail.aliyun.com ([115.124.28.219]:46382 "EHLO
        out28-219.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgEZOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:42:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1907401|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0106147-0.000420229-0.988965;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.Hdvl59T_1590504067;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Hdvl59T_1590504067)
          by smtp.aliyun-inc.com(10.147.41.143);
          Tue, 26 May 2020 22:42:41 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v10 5/6] dt-bindings: clock: Add and reorder ABI for X1000.
Date:   Tue, 26 May 2020 22:40:43 +0800
Message-Id: <20200526144044.71413-7-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200526144044.71413-1-zhouyanjie@wanyeetech.com>
References: <20200526144044.71413-1-zhouyanjie@wanyeetech.com>
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
2.Clocks of LCD, OTG, EMC, EFUSE, OST, TCU are also added.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v5:
    New patch.
    
    v5->v6:
    Add missing part of X1000's CGU.
    
    v6->v7:
    No change.
    
    v7->v8:
    No change.
    
    v8->v9:
    No change.
    
    v9->v10:
    No change.

 include/dt-bindings/clock/x1000-cgu.h | 64 ++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/x1000-cgu.h
index bbaebaf7adb9..0367c8c02e16 100644
--- a/include/dt-bindings/clock/x1000-cgu.h
+++ b/include/dt-bindings/clock/x1000-cgu.h
@@ -12,33 +12,41 @@
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
+#define X1000_CLK_OTGPHY		4
+#define X1000_CLK_SCLKA			5
+#define X1000_CLK_CPUMUX		6
+#define X1000_CLK_CPU			7
+#define X1000_CLK_L2CACHE		8
+#define X1000_CLK_AHB0			9
+#define X1000_CLK_AHB2PMUX		10
+#define X1000_CLK_AHB2			11
+#define X1000_CLK_PCLK			12
+#define X1000_CLK_DDR			13
+#define X1000_CLK_MAC			14
+#define X1000_CLK_LCD			15
+#define X1000_CLK_MSCMUX		16
+#define X1000_CLK_MSC0			17
+#define X1000_CLK_MSC1			18
+#define X1000_CLK_OTG			19
+#define X1000_CLK_SSIPLL		20
+#define X1000_CLK_SSIPLL_DIV2	21
+#define X1000_CLK_SSIMUX		22
+#define X1000_CLK_EMC			23
+#define X1000_CLK_EFUSE			24
+#define X1000_CLK_SFC			25
+#define X1000_CLK_I2C0			26
+#define X1000_CLK_I2C1			27
+#define X1000_CLK_I2C2			28
+#define X1000_CLK_UART0			29
+#define X1000_CLK_UART1			30
+#define X1000_CLK_UART2			31
+#define X1000_CLK_TCU			32
+#define X1000_CLK_SSI			33
+#define X1000_CLK_OST			34
+#define X1000_CLK_PDMA			35
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
-- 
2.11.0

