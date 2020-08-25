Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432AFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DAD20767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OcgqyJD1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iIMn4E5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHYXmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgHYXk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:40:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37692C061574;
        Tue, 25 Aug 2020 16:40:57 -0700 (PDT)
Date:   Tue, 25 Aug 2020 23:40:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NdM4NvSUS7lOtb6c85JGMBX+05vF3M/i484C2Si/TQ=;
        b=OcgqyJD1ZQaVDKszKKbCXYXFbOkjzQgdJ1UIbzy0qC8kuoMYeNQgnNcgZtVzfZadbW2m1i
        eVt+6oz9C74P1ktYKFBNbAr6i/KGRc9KqPkXoMbTq0KExHlikijmuKTUwmaIL7A4/zCNEH
        ClePzhuPT0iogsaTIpA3j6CisGdDVKh+AyPoQW3kJ3BNZ5nNvRJZjBaqel40qrrjWp0RoY
        qgMCog7dq69nE95vST3N8eNg7UoD5EPzJtc11djBtU7DmhadRW32W4EcT8XGx9zsA3FVjV
        DeGPv9fD9JP4boXOEdSwDXHm70T3yug4MtodJZ7vRqWSkvDdjqG/6xwls7JahQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NdM4NvSUS7lOtb6c85JGMBX+05vF3M/i484C2Si/TQ=;
        b=iIMn4E5rxBB8IlHH6bvDsHPgl9hv8Pyia/SDCHrKPngTiAarZpYjwCnpX33INUjXP4oWgz
        OLR+QXUu6skoWKAw==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] arm64: dts: k3-am65: ti-sci-inta/intr: Update to
 latest bindings
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Suman Anna <s-anna@ti.com>,
        Marc Zyngier <maz@kernel.org>, Nishanth Menon <nm@ti.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-13-lokeshvutla@ti.com>
References: <20200806074826.24607-13-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839885455.389.17024823141000526435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     fef845122f6c3c92178e4e4a1f85cce84dca06fe
Gitweb:        https://git.kernel.org/tip/fef845122f6c3c92178e4e4a1f85cce84dca06fe
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:25 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:01:19 +01:00

arm64: dts: k3-am65: ti-sci-inta/intr: Update to latest bindings

Update the INTA and INTR dt nodes to the latest DT bindings.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20200806074826.24607-13-lokeshvutla@ti.com
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 24 +++++++---------
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      |  8 ++---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |  4 +--
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  1 +-
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 9edfae5..996a82f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -417,10 +417,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <56>;
-		ti,sci-rm-range-girq = <0x1>;
+		ti,sci-dev-id = <100>;
+		ti,interrupt-ranges = <0 392 32>;
 	};
 
 	main_navss {
@@ -438,10 +438,11 @@
 			ti,intr-trigger-type = <4>;
 			interrupt-controller;
 			interrupt-parent = <&gic500>;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <1>;
 			ti,sci = <&dmsc>;
-			ti,sci-dst-id = <56>;
-			ti,sci-rm-range-girq = <0x0>, <0x2>;
+			ti,sci-dev-id = <182>;
+			ti,interrupt-ranges = <0 64 64>,
+					      <64 448 64>;
 		};
 
 		inta_main_udmass: interrupt-controller@33d00000 {
@@ -452,8 +453,7 @@
 			msi-controller;
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <179>;
-			ti,sci-rm-range-vint = <0x0>;
-			ti,sci-rm-range-global-event = <0x1>;
+			ti,interrupt-ranges = <0 0 256>;
 		};
 
 		secure_proxy_main: mailbox@32c00000 {
@@ -622,7 +622,7 @@
 			reg-names = "cpts";
 			clocks = <&main_cpts_mux>;
 			clock-names = "cpts";
-			interrupts-extended = <&intr_main_navss 163 0>;
+			interrupts-extended = <&intr_main_navss 391>;
 			interrupt-names = "cpts";
 			ti,cpts-periodic-outputs = <6>;
 			ti,cpts-ext-ts-inputs = <8>;
@@ -645,8 +645,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&intr_main_gpio>;
-		interrupts = <57 256>, <57 257>, <57 258>, <57 259>, <57 260>,
-				<57 261>;
+		interrupts = <192>, <193>, <194>, <195>, <196>, <197>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <96>;
@@ -661,8 +660,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&intr_main_gpio>;
-		interrupts = <58 256>, <58 257>, <58 258>, <58 259>, <58 260>,
-				<58 261>;
+		interrupts = <200>, <201>, <202>, <203>, <204>, <205>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <90>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 5f55b9e..a1ffe88 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -74,10 +74,10 @@
 		ti,intr-trigger-type = <1>;
 		interrupt-controller;
 		interrupt-parent = <&gic500>;
-		#interrupt-cells = <2>;
+		#interrupt-cells = <1>;
 		ti,sci = <&dmsc>;
-		ti,sci-dst-id = <56>;
-		ti,sci-rm-range-girq = <0x4>;
+		ti,sci-dev-id = <156>;
+		ti,interrupt-ranges = <0 712 16>;
 	};
 
 	wkup_gpio0: wkup_gpio0@42110000 {
@@ -86,7 +86,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-parent = <&intr_wkup_gpio>;
-		interrupts = <59 128>, <59 129>, <59 130>, <59 131>;
+		interrupts = <60>, <61>, <62>, <63>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,ngpio = <56>;
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 611e662..b8a8a0f 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -384,7 +384,7 @@
 };
 
 &mailbox0_cluster0 {
-	interrupts = <164 0>;
+	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 		ti,mbox-tx = <1 0 0>;
@@ -393,7 +393,7 @@
 };
 
 &mailbox0_cluster1 {
-	interrupts = <165 0>;
+	interrupts = <432>;
 
 	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 		ti,mbox-tx = <1 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index e00cf2a..c4a48e8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -105,7 +105,6 @@
 		ti,sci = <&dmsc>;
 		ti,sci-dev-id = <137>;
 		ti,interrupt-ranges = <16 960 16>;
-		ti,sci-rm-range-girq = <0x5>;
 	};
 
 	wkup_gpio0: gpio@42110000 {
