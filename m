Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1407DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFAF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FecCuCrx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4NI4hV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHYXlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgHYXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:40:58 -0400
Date:   Tue, 25 Aug 2020 23:40:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mg6uD54oUXcalqsEJ/9AfyBGBcDpMCCeV2GXlDzObSs=;
        b=FecCuCrxqkxEvVCoAcQWkVrW9gkMiDgH6XPzoAVR0gYhinASACScbNeFPZfcp6RcBYpXYX
        +XYJy08Dal8cQpRImq6jUp/r+4LwZyeH/ry+ywccYmSoL0T/N41dIYxcNpPAM/Nqud9WWi
        GESRGPkJAi3Nw4DVwlnGZ9iHxA5Z78hWrppqt9tvNgzOcI6CEo5AqYv63riKkW7AzYtDok
        goK6nhQjIbBo+sgU9zcwWcx38LEQ1yNqCdf+DF3JH4pgC2b/7ijrsGGdLMdCkTc+kTp1Q0
        gL2KrtUiUzpqAL6nt0JrmCBXKnxT2ukQTkd5GUSmdTvfDGtXW8MSogot4vOHzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mg6uD54oUXcalqsEJ/9AfyBGBcDpMCCeV2GXlDzObSs=;
        b=w4NI4hV4tdnwm7BFXrv8xSxp462Z3URs5ye86m3gyQRiXKqx/VQOo6eaH4ppNMVQ1/ykV/
        4R7Qjy4pPxff1BCg==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] arm64: dts: k3-j721e: ti-sci-inta/intr: Update to
 latest bindings
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        Nishanth Menon <nm@ti.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-12-lokeshvutla@ti.com>
References: <20200806074826.24607-12-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839885523.389.18287924007853963556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8d523f096da53598c271b5b69fcacb48779884a3
Gitweb:        https://git.kernel.org/tip/8d523f096da53598c271b5b69fcacb48779884a3
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:24 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:01:19 +01:00

arm64: dts: k3-j721e: ti-sci-inta/intr: Update to latest bindings

Update the INTA and INTR dt nodes to the latest DT bindings.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20200806074826.24607-12-lokeshvutla@ti.com
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 10 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 43 +++++-----
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       | 11 +--
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8bc1e6e..e8fc01d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -287,7 +287,7 @@
 };
 
 &mailbox0_cluster0 {
-	interrupts = <214 0>;
+	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -301,7 +301,7 @@
 };
 
 &mailbox0_cluster1 {
-	interrupts = <215 0>;
+	interrupts = <432>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -315,7 +315,7 @@
 };
 
 &mailbox0_cluster2 {
-	interrupts = <216 0>;
+	interrupts = <428>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 0>;
@@ -329,7 +329,7 @@
 };
 
 &mailbox0_cluster3 {
-	interrupts = <217 0>;
+	interrupts = <424>;
 
 	mbox_c66_0: mbox-c66-0 {
 		ti,mbox-rx = <0 0 0>;
@@ -343,7 +343,7 @@
 };
 
 &mailbox0_cluster4 {
-	interrupts = <218 0>;
+	interrupts = <420>;
 
 	mbox_c71_0: mbox-c71-0 {
 		ti,mbox-rx = <0 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index d140602..12ceea9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -80,10 +80,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <14>;
-		ti,sci-rm-range-girq = <0x1>;
+		ti,sci-dev-id = <131>;
+		ti,interrupt-ranges = <8 392 56>;
 	};
 
 	main_navss {
@@ -101,10 +101,12 @@
 			ti,intr-trigger-type = <4>;
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <1>;
 			ti,sci = <&dmsc>;
-			ti,sci-dst-id = <14>;
-			ti,sci-rm-range-girq = <0>, <2>;
+			ti,sci-dev-id = <213>;
+			ti,interrupt-ranges = <0 64 64>,
+					      <64 448 64>,
+					      <128 672 64>;
 		};
 
 		main_udmass_inta: interrupt-controller@33d00000 {
@@ -115,8 +117,7 @@
 			msi-controller;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <209>;
-			ti,sci-rm-range-vint = <0xa>;
-			ti,sci-rm-range-global-event = <0xd>;
+			ti,interrupt-ranges = <0 0 256>;
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
@@ -296,7 +297,7 @@
 			reg-names = "cpts";
 			clocks = <&k3_clks 201 1>;
 			clock-names = "cpts";
-			interrupts-extended = <&main_navss_intr 201 0>;
+			interrupts-extended = <&main_navss_intr 391>;
 			interrupt-names = "cpts";
 			ti,cpts-periodic-outputs = <6>;
 			ti,cpts-ext-ts-inputs = <8>;
@@ -688,8 +689,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <105 0>, <105 1>, <105 2>, <105 3>,
-			     <105 4>, <105 5>, <105 6>, <105 7>;
+		interrupts = <256>, <257>, <258>, <259>,
+			     <260>, <261>, <262>, <263>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -705,7 +706,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <106 0>, <106 1>, <106 2>;
+		interrupts = <288>, <289>, <290>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
@@ -721,8 +722,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <107 0>, <107 1>, <107 2>, <107 3>,
-			     <107 4>, <107 5>, <107 6>, <107 7>;
+		interrupts = <264>, <265>, <266>, <267>,
+			     <268>, <269>, <270>, <271>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -738,7 +739,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <108 0>, <108 1>, <108 2>;
+		interrupts = <292>, <293>, <294>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
@@ -754,8 +755,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <109 0>, <109 1>, <109 2>, <109 3>,
-			     <109 4>, <109 5>, <109 6>, <109 7>;
+		interrupts = <272>, <273>, <274>, <275>,
+			     <276>, <277>, <278>, <279>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -771,7 +772,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <110 0>, <110 1>, <110 2>;
+		interrupts = <296>, <297>, <298>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
@@ -787,8 +788,8 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <111 0>, <111 1>, <111 2>, <111 3>,
-			     <111 4>, <111 5>, <111 6>, <111 7>;
+		interrupts = <280>, <281>, <282>, <283>,
+			     <284>, <285>, <286>, <287>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <128>;
@@ -804,7 +805,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&main_gpio_intr>;
-		interrupts = <112 0>, <112 1>, <112 2>;
+		interrupts = <300>, <301>, <302>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <36>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 30a735b..e00cf2a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -101,9 +101,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <14>;
+		ti,sci-dev-id = <137>;
+		ti,interrupt-ranges = <16 960 16>;
 		ti,sci-rm-range-girq = <0x5>;
 	};
 
@@ -113,8 +114,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&wkup_gpio_intr>;
-		interrupts = <113 0>, <113 1>, <113 2>,
-			     <113 3>, <113 4>, <113 5>;
+		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <84>;
@@ -130,8 +130,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&wkup_gpio_intr>;
-		interrupts = <114 0>, <114 1>, <114 2>,
-			     <114 3>, <114 4>, <114 5>;
+		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <84>;
