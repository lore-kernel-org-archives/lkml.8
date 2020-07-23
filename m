Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09FFC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA3720737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bv3y+IGx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H6qNc0Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgGWTJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60516 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgGWTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:48 -0400
Date:   Thu, 23 Jul 2020 19:09:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqtfCSA/19p5Hfit8iDitGESKsfMClKnPPmwKmrbJ1g=;
        b=bv3y+IGxsL7C6A9nqeHYoAjVWfLF2KQNyvTTuKs8DW8N5kGb3adCAKwPaFY85vv2QrDuDr
        GZUw41UOpSgBdIj5y9MtqNTEGzuGu+/BXPZD2ztaIbSbMTo9E2KMBlcm3+klycgmC2D5XW
        U5MaTb1hVPvFPSe8eIVJzfFJeeZz6L82oELRXqIsRHVcWLsNjzGAYsrULyYzehzKxoEWkX
        yxf7tGQ39qPS/vwhSAWyLt6/6o+buajSAxw7SaFqEwIsAgWQg/Vmcnrlc2zWnxakUwB+rz
        4LYVwDy6pPB2KGIhJpie8C+zkjXuckmMTPw8EUDGuw9YAV4W0ADR9xfntWcILg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqtfCSA/19p5Hfit8iDitGESKsfMClKnPPmwKmrbJ1g=;
        b=H6qNc0PkZC+nvxcSoMg7wnJ9tOlL/t59JgYFe0bjhGvpGWVTSoCp1lUQ4PWhoQstyMH07i
        CVRBsxG796nV1OAQ==
From:   "tip-bot2 for Alexandre Belloni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: microchip: atmel,at91rm9200-tcb: add
 sama5d2 compatible
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200710230813.1005150-3-alexandre.belloni@bootlin.com>
References: <20200710230813.1005150-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Message-ID: <159553138655.4006.3056030778427952417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d777960e8f7268f82806451065f84ea3b05a3ea3
Gitweb:        https://git.kernel.org/tip/d777960e8f7268f82806451065f84ea3b05a3ea3
Author:        Alexandre Belloni <alexandre.belloni@bootlin.com>
AuthorDate:    Sat, 11 Jul 2020 01:08:06 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 11 Jul 2020 18:57:03 +02:00

dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible

The sama5d2 TC block TIMER_CLOCK1 is different from the at91sam9x5 one.
Instead of being MCK / 2, it is the TCB GCLK.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-3-alexandre.belloni@bootlin.com
---
 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 9d680e0..d226fd7 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - atmel,at91rm9200-tcb
           - atmel,at91sam9x5-tcb
+          - atmel,sama5d2-tcb
       - const: simple-mfd
       - const: syscon
 
@@ -36,15 +37,6 @@ properties:
     description:
       List of clock names. Always includes t0_clk and slow clk. Also includes
       t1_clk and t2_clk if a clock per channel is available.
-    oneOf:
-      - items:
-        - const: t0_clk
-        - const: slow_clk
-      - items:
-        - const: t0_clk
-        - const: t1_clk
-        - const: t2_clk
-        - const: slow_clk
     minItems: 2
     maxItems: 4
 
@@ -75,6 +67,38 @@ patternProperties:
       - compatible
       - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,sama5d2-tcb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: t0_clk
+            - const: gclk
+            - const: slow_clk
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 4
+        clock-names:
+          oneOf:
+            - items:
+              - const: t0_clk
+              - const: slow_clk
+            - items:
+              - const: t0_clk
+              - const: t1_clk
+              - const: t2_clk
+              - const: slow_clk
+
 required:
   - compatible
   - reg
