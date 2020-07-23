Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB8AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9012A206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcywJcgW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPyAZSzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgGWTJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgGWTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:48 -0400
Date:   Thu, 23 Jul 2020 19:09:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uyibh09fRIvhTZEslxtKva5uwEaRdPpSGaETrJl/6PA=;
        b=vcywJcgWB45NV484NvQPuJoY6yYHZmQOh1OSYRlzvT8tTOZ7OgplWuXO7kTqujvSITfSJw
        8AvcprE5Hu49CKlKtZLTuhTmOpY7Jm1SGI31wK7JsnGRjeDKEhweYnx/OMa0Zc0GJZwUf2
        3KC7x7O1HTm/fw8fJc22eoGEU9bJJ9LcZ7X5p2HWo7TQfuoPr1+vMPiAOqFchf9sGx8qDG
        lx4y/z/G5pnjxNF2jhXf0l7Pm8+QPHAQOgNy3L3QrdZ5Tx+i92h8Rsl+sKuBdtRe3L+zq7
        U0RpwuyfDWSki+dHZN+mggR385HcAeig76pzwrkUtliN8FrjYFR8I7aFqcJ2+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uyibh09fRIvhTZEslxtKva5uwEaRdPpSGaETrJl/6PA=;
        b=VPyAZSzOGZ5HESTfGZd4fNOMt/KL3FkFJcFd2FEb0cyD87Q000gSZ4V/+oGrsJh75RFZ8k
        bfHCVPQPLhNAFCDw==
From:   "tip-bot2 for Alexandre Belloni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ARM: dts: at91: sama5d2: add TCB GCLK
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710230813.1005150-4-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <159553138590.4006.3759668982230902432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     44f6fa431bbd087083fca437d0348edd4b09e3c2
Gitweb:        https://git.kernel.org/tip/44f6fa431bbd087083fca437d0348edd4b09e3c2
Author:        Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate:    Sat, 11 Jul 2020 01:08:07 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 11 Jul 2020 18:57:03 +02:00

ARM: dts: at91: sama5d2: add TCB GCLK

The sama5d2 tcbs take an extra input clock, their gclk.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-4-alexandre.belloni@bootlin.com
---
 arch/arm/boot/dts/sama5d2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index ab550d6..996143e 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -499,23 +499,23 @@
 			};
 
 			tcb0: timer@f800c000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_GCK 35>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			tcb1: timer@f8010000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf8010000 0x100>;
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&pmc PMC_TYPE_GCK 36>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			hsmc: hsmc@f8014000 {
