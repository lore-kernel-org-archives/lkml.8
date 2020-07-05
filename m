Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B08C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A652075B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="Ku1PsicO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGEToS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:44:18 -0400
Received: from gateway20.websitewelcome.com ([192.185.59.4]:43863 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbgGEToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:44:18 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 494E0400CECE4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 12:58:50 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id sAB5juxxGQyTQsAB5jwR1Z; Sun, 05 Jul 2020 14:19:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GfLOfM3WHzU0BIyRJD4iTtlteWnSzQZLlEmD9Xo7d20=; b=Ku1PsicOgEi8DGG1AT5hHZFSw9
        QC4omYSyirQB4EK2wh3yntLwCqWpXgnLtWqhWcp8CTyFbhy1rYWtUMbbAlVDkG/lmSSMhYP7MEMUQ
        +HtJTSazIFQl9ZhBUMSwNhmZqu+ShGoP5JDjEexdingJiiYhc644el6LR2vcV9jxUS4NIrjX9GUdR
        XXse7TN2lDIMN8ad5LaHyl7BYjaz2bmR35udA8JRXZdMptJTDanX3n6qYIVmAVN5qmUUFXpauYHGC
        f1ZTaBNTY8GC97KaTNgzovFFoBfGlDCzFCFj05oCWKWuxi4WVyjB60kXPxFb4wn3WLpQxeAeMdHyJ
        qk/hKFZg==;
Received: from [189.59.31.158] (port=33088 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1jsAB5-004Abs-6n; Sun, 05 Jul 2020 16:19:51 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1] arm64: dts: actions: Fix smp Bringing up secondary CPUs
Date:   Sun,  5 Jul 2020 16:19:44 -0300
Message-Id: <20200705191944.404933-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 189.59.31.158
X-Source-L: No
X-Exim-ID: 1jsAB5-004Abs-6n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [189.59.31.158]:33088
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the enable-method to fix the failed to boot errors:

[    0.040330] smp: Bringing up secondary CPUs ...
[    0.040683] psci: failed to boot CPU1 (-22)
[    0.040691] CPU1: failed to boot: -22
[    0.041062] psci: failed to boot CPU2 (-22)
[    0.041071] CPU2: failed to boot: -22
[    0.041408] psci: failed to boot CPU3 (-22)
[    0.041417] CPU3: failed to boot: -22
[    0.041443] smp: Brought up 1 node, 1 CPU
[    0.041451] SMP: Total of 1 processors activated.

Tested on Caninos Labrador v3 based on Actions Semi S700.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++--------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 2006ad5424fa..b28dbbcad27b 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -14,37 +14,50 @@ / {
 	#size-cells = <2>;

 	cpus {
-		#address-cells = <2>;
+		#address-cells = <1>;
 		#size-cells = <0>;
-
+
 		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
+			reg = <0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
 		};

 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
-			reg = <0x0 0x1>;
-			enable-method = "psci";
+			reg = <0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
 		};

 		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
-			reg = <0x0 0x2>;
-			enable-method = "psci";
+			reg = <0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
 		};

 		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
-			reg = <0x0 0x3>;
-			enable-method = "psci";
+			reg = <0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x1f000020>;
+			next-level-cache = <&L2>;
 		};
 	};
+
+	L2: l2-cache {
+		compatible = "cache";
+		cache-level = <2>;
+	};

 	reserved-memory {
 		#address-cells = <2>;
--
2.27.0

