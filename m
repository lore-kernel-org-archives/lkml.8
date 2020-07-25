Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E3DC433F2
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96699206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGYFMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:12:15 -0400
Received: from out28-51.mail.aliyun.com ([115.124.28.51]:49239 "EHLO
        out28-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgGYFMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:12:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1552631|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0239945-0.00119476-0.974811;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I7G.t3W_1595653922;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I7G.t3W_1595653922)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sat, 25 Jul 2020 13:12:09 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 1/3] dt-bindings: clock: Add RTC related clocks for Ingenic SoCs.
Date:   Sat, 25 Jul 2020 13:11:34 +0800
Message-Id: <20200725051136.58220-2-zhouyanjie@wanyeetech.com>
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

Add RTC related clocks bindings for the JZ4780 SoC, the X1000 SoC,
and the X1830 SoC from Ingenic.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 include/dt-bindings/clock/jz4780-cgu.h | 2 ++
 include/dt-bindings/clock/x1000-cgu.h  | 2 ++
 include/dt-bindings/clock/x1830-cgu.h  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/jz4780-cgu.h b/include/dt-bindings/clock/jz4780-cgu.h
index 1859ce53ee38..cb07a0978301 100644
--- a/include/dt-bindings/clock/jz4780-cgu.h
+++ b/include/dt-bindings/clock/jz4780-cgu.h
@@ -85,5 +85,7 @@
 #define JZ4780_CLK_DES		70
 #define JZ4780_CLK_X2D		71
 #define JZ4780_CLK_CORE1	72
+#define JZ4780_CLK_EXCLK_DIV512	73
+#define JZ4780_CLK_RTC		74
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4780_CGU_H__ */
diff --git a/include/dt-bindings/clock/x1000-cgu.h b/include/dt-bindings/clock/x1000-cgu.h
index 0367c8c02e16..f187e0719fd3 100644
--- a/include/dt-bindings/clock/x1000-cgu.h
+++ b/include/dt-bindings/clock/x1000-cgu.h
@@ -48,5 +48,7 @@
 #define X1000_CLK_SSI			33
 #define X1000_CLK_OST			34
 #define X1000_CLK_PDMA			35
+#define X1000_CLK_EXCLK_DIV512	36
+#define X1000_CLK_RTC			37
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
diff --git a/include/dt-bindings/clock/x1830-cgu.h b/include/dt-bindings/clock/x1830-cgu.h
index 801e1d09c881..88455376a950 100644
--- a/include/dt-bindings/clock/x1830-cgu.h
+++ b/include/dt-bindings/clock/x1830-cgu.h
@@ -51,5 +51,7 @@
 #define X1830_CLK_TCU			36
 #define X1830_CLK_DTRNG			37
 #define X1830_CLK_OST			38
+#define X1830_CLK_EXCLK_DIV512	39
+#define X1830_CLK_RTC			40
 
 #endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
-- 
2.11.0

