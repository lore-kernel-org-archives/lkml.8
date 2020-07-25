Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6DC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640B9206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGYFMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:12:18 -0400
Received: from out28-4.mail.aliyun.com ([115.124.28.4]:41707 "EHLO
        out28-4.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGYFMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:12:16 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7686685|0.09915053;CH=green;DM=|AD|false|;DS=CONTINUE|ham_regular_dialog|0.0144225-0.00108055-0.984497;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I7G.t3W_1595653922;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I7G.t3W_1595653922)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sat, 25 Jul 2020 13:12:10 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 2/3] dt-bindings: clock: Add tabs to align code.
Date:   Sat, 25 Jul 2020 13:11:35 +0800
Message-Id: <20200725051136.58220-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200725051136.58220-1-zhouyanjie@wanyeetech.com>
References: <20200725051136.58220-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "JZ4780_CLK_LCD0PIXCLK" and the "JZ4780_CLK_LCD1PIXCLK"
in the "jz4780.h" and the new added "JZ4780_CLK_EXCLK_DIV512"
in the previous patch is too long, add tabs to other lines
to align them.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 include/dt-bindings/clock/jz4780-cgu.h | 144 ++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/include/dt-bindings/clock/jz4780-cgu.h b/include/dt-bindings/clock/jz4780-cgu.h
index cb07a0978301..85cf8eb5081b 100644
--- a/include/dt-bindings/clock/jz4780-cgu.h
+++ b/include/dt-bindings/clock/jz4780-cgu.h
@@ -12,80 +12,80 @@
 #ifndef __DT_BINDINGS_CLOCK_JZ4780_CGU_H__
 #define __DT_BINDINGS_CLOCK_JZ4780_CGU_H__
 
-#define JZ4780_CLK_EXCLK	0
-#define JZ4780_CLK_RTCLK	1
-#define JZ4780_CLK_APLL		2
-#define JZ4780_CLK_MPLL		3
-#define JZ4780_CLK_EPLL		4
-#define JZ4780_CLK_VPLL		5
-#define JZ4780_CLK_OTGPHY	6
-#define JZ4780_CLK_SCLKA	7
-#define JZ4780_CLK_CPUMUX	8
-#define JZ4780_CLK_CPU		9
-#define JZ4780_CLK_L2CACHE	10
-#define JZ4780_CLK_AHB0		11
-#define JZ4780_CLK_AHB2PMUX	12
-#define JZ4780_CLK_AHB2		13
-#define JZ4780_CLK_PCLK		14
-#define JZ4780_CLK_DDR		15
-#define JZ4780_CLK_VPU		16
-#define JZ4780_CLK_I2SPLL	17
-#define JZ4780_CLK_I2S		18
+#define JZ4780_CLK_EXCLK		0
+#define JZ4780_CLK_RTCLK		1
+#define JZ4780_CLK_APLL			2
+#define JZ4780_CLK_MPLL			3
+#define JZ4780_CLK_EPLL			4
+#define JZ4780_CLK_VPLL			5
+#define JZ4780_CLK_OTGPHY		6
+#define JZ4780_CLK_SCLKA		7
+#define JZ4780_CLK_CPUMUX		8
+#define JZ4780_CLK_CPU			9
+#define JZ4780_CLK_L2CACHE		10
+#define JZ4780_CLK_AHB0			11
+#define JZ4780_CLK_AHB2PMUX		12
+#define JZ4780_CLK_AHB2			13
+#define JZ4780_CLK_PCLK			14
+#define JZ4780_CLK_DDR			15
+#define JZ4780_CLK_VPU			16
+#define JZ4780_CLK_I2SPLL		17
+#define JZ4780_CLK_I2S			18
 #define JZ4780_CLK_LCD0PIXCLK	19
 #define JZ4780_CLK_LCD1PIXCLK	20
-#define JZ4780_CLK_MSCMUX	21
-#define JZ4780_CLK_MSC0		22
-#define JZ4780_CLK_MSC1		23
-#define JZ4780_CLK_MSC2		24
-#define JZ4780_CLK_UHC		25
-#define JZ4780_CLK_SSIPLL	26
-#define JZ4780_CLK_SSI		27
-#define JZ4780_CLK_CIMMCLK	28
-#define JZ4780_CLK_PCMPLL	29
-#define JZ4780_CLK_PCM		30
-#define JZ4780_CLK_GPU		31
-#define JZ4780_CLK_HDMI		32
-#define JZ4780_CLK_BCH		33
-#define JZ4780_CLK_NEMC		34
-#define JZ4780_CLK_OTG0		35
-#define JZ4780_CLK_SSI0		36
-#define JZ4780_CLK_SMB0		37
-#define JZ4780_CLK_SMB1		38
-#define JZ4780_CLK_SCC		39
-#define JZ4780_CLK_AIC		40
-#define JZ4780_CLK_TSSI0	41
-#define JZ4780_CLK_OWI		42
-#define JZ4780_CLK_KBC		43
-#define JZ4780_CLK_SADC		44
-#define JZ4780_CLK_UART0	45
-#define JZ4780_CLK_UART1	46
-#define JZ4780_CLK_UART2	47
-#define JZ4780_CLK_UART3	48
-#define JZ4780_CLK_SSI1		49
-#define JZ4780_CLK_SSI2		50
-#define JZ4780_CLK_PDMA		51
-#define JZ4780_CLK_GPS		52
-#define JZ4780_CLK_MAC		53
-#define JZ4780_CLK_SMB2		54
-#define JZ4780_CLK_CIM		55
-#define JZ4780_CLK_LCD		56
-#define JZ4780_CLK_TVE		57
-#define JZ4780_CLK_IPU		58
-#define JZ4780_CLK_DDR0		59
-#define JZ4780_CLK_DDR1		60
-#define JZ4780_CLK_SMB3		61
-#define JZ4780_CLK_TSSI1	62
-#define JZ4780_CLK_COMPRESS	63
-#define JZ4780_CLK_AIC1		64
-#define JZ4780_CLK_GPVLC	65
-#define JZ4780_CLK_OTG1		66
-#define JZ4780_CLK_UART4	67
-#define JZ4780_CLK_AHBMON	68
-#define JZ4780_CLK_SMB4		69
-#define JZ4780_CLK_DES		70
-#define JZ4780_CLK_X2D		71
-#define JZ4780_CLK_CORE1	72
+#define JZ4780_CLK_MSCMUX		21
+#define JZ4780_CLK_MSC0			22
+#define JZ4780_CLK_MSC1			23
+#define JZ4780_CLK_MSC2			24
+#define JZ4780_CLK_UHC			25
+#define JZ4780_CLK_SSIPLL		26
+#define JZ4780_CLK_SSI			27
+#define JZ4780_CLK_CIMMCLK		28
+#define JZ4780_CLK_PCMPLL		29
+#define JZ4780_CLK_PCM			30
+#define JZ4780_CLK_GPU			31
+#define JZ4780_CLK_HDMI			32
+#define JZ4780_CLK_BCH			33
+#define JZ4780_CLK_NEMC			34
+#define JZ4780_CLK_OTG0			35
+#define JZ4780_CLK_SSI0			36
+#define JZ4780_CLK_SMB0			37
+#define JZ4780_CLK_SMB1			38
+#define JZ4780_CLK_SCC			39
+#define JZ4780_CLK_AIC			40
+#define JZ4780_CLK_TSSI0		41
+#define JZ4780_CLK_OWI			42
+#define JZ4780_CLK_KBC			43
+#define JZ4780_CLK_SADC			44
+#define JZ4780_CLK_UART0		45
+#define JZ4780_CLK_UART1		46
+#define JZ4780_CLK_UART2		47
+#define JZ4780_CLK_UART3		48
+#define JZ4780_CLK_SSI1			49
+#define JZ4780_CLK_SSI2			50
+#define JZ4780_CLK_PDMA			51
+#define JZ4780_CLK_GPS			52
+#define JZ4780_CLK_MAC			53
+#define JZ4780_CLK_SMB2			54
+#define JZ4780_CLK_CIM			55
+#define JZ4780_CLK_LCD			56
+#define JZ4780_CLK_TVE			57
+#define JZ4780_CLK_IPU			58
+#define JZ4780_CLK_DDR0			59
+#define JZ4780_CLK_DDR1			60
+#define JZ4780_CLK_SMB3			61
+#define JZ4780_CLK_TSSI1		62
+#define JZ4780_CLK_COMPRESS		63
+#define JZ4780_CLK_AIC1			64
+#define JZ4780_CLK_GPVLC		65
+#define JZ4780_CLK_OTG1			66
+#define JZ4780_CLK_UART4		67
+#define JZ4780_CLK_AHBMON		68
+#define JZ4780_CLK_SMB4			69
+#define JZ4780_CLK_DES			70
+#define JZ4780_CLK_X2D			71
+#define JZ4780_CLK_CORE1		72
 #define JZ4780_CLK_EXCLK_DIV512	73
-#define JZ4780_CLK_RTC		74
+#define JZ4780_CLK_RTC			74
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4780_CGU_H__ */
-- 
2.11.0

