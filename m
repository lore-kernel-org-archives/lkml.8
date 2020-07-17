Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA7BC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1673220737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGQRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:00:33 -0400
Received: from out28-194.mail.aliyun.com ([115.124.28.194]:34142 "EHLO
        out28-194.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgGQRA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:00:26 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07492061|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.093307-0.000478175-0.906215;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10422;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I3U5VZp_1595005212;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I3U5VZp_1595005212)
          by smtp.aliyun-inc.com(10.147.41.121);
          Sat, 18 Jul 2020 01:00:23 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tsbogend@alpha.franken.de,
        robh+dt@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tglx@linutronix.de,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
Subject: [PATCH v7 5/5] MIPS: X1830: Use SYSOST instead of TCU to provide clocksource.
Date:   Sat, 18 Jul 2020 00:59:47 +0800
Message-Id: <20200717165947.56158-6-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200717165947.56158-1-zhouyanjie@wanyeetech.com>
References: <20200717165947.56158-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this series of patches, X1830 used TCU to provide
clocksource and clockevent, but because the timer of TCU
is only 16 bits, so the timing length is only 16 bits. In
actual use, it is easy to cause some problems such as data
loss during data transmission. The SYSOST driver is provided
in this series of patches, which can provide 32bit timing
length, so use SYSOST instead of TCU to provide clocksource
and clockevent to solve the aforementioned problems.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v7:
    New patch.

 arch/mips/boot/dts/ingenic/cu1830-neo.dts |  9 +++------
 arch/mips/boot/dts/ingenic/x1830.dtsi     | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/cu1830-neo.dts b/arch/mips/boot/dts/ingenic/cu1830-neo.dts
index 640f96c00d63..ac4c9fbf8bca 100644
--- a/arch/mips/boot/dts/ingenic/cu1830-neo.dts
+++ b/arch/mips/boot/dts/ingenic/cu1830-neo.dts
@@ -3,7 +3,7 @@
 
 #include "x1830.dtsi"
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/ingenic,tcu.h>
+#include <dt-bindings/clock/ingenic,sysost.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -43,13 +43,10 @@
 	clock-frequency = <24000000>;
 };
 
-&tcu {
+&ost {
 	/* 1500 kHz for the system timer and clocksource */
-	assigned-clocks = <&tcu TCU_CLK_TIMER0>, <&tcu TCU_CLK_TIMER2>;
+	assigned-clocks = <&ost OST_CLK_PERCPU_TIMER>, <&ost OST_CLK_GLOBAL_TIMER>;
 	assigned-clock-rates = <1500000>, <1500000>;
-
-	/* Use channel #0 for the system timer channel #2 for the clocksource */
-	ingenic,pwm-channels-mask = <0xfa>;
 };
 
 &uart1 {
diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
index eb1214481a33..99eac297ee34 100644
--- a/arch/mips/boot/dts/ingenic/x1830.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
@@ -47,6 +47,22 @@
 		clock-names = "ext", "rtc";
 	};
 
+	ost: timer@12000000 {
+		compatible = "ingenic,x1830-ost", "ingenic,x1000-ost";
+		reg = <0x12000000 0x1000>;
+
+		#clock-cells = <1>;
+
+		clocks = <&cgu X1830_CLK_OST>;
+		clock-names = "ost";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <4>;
+	};
+
 	tcu: timer@10002000 {
 		compatible = "ingenic,x1830-tcu", "ingenic,x1000-tcu", "simple-mfd";
 		reg = <0x10002000 0x1000>;
-- 
2.11.0

