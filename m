Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422B42075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbgE1O4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403786AbgE1O4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:56:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BAC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:56:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeJx4-0002Q5-Ub; Thu, 28 May 2020 16:56:11 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 75C61FF834;
        Thu, 28 May 2020 16:56:10 +0200 (CEST)
Message-Id: <20200528145522.715816477@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 28 May 2020 16:53:16 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 1/5] x86/idt: Mark init only functions __init
References: <20200528145315.727724091@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 8175cfbbbfcb ("x86/idt: Remove update_intr_gate()") set_intr_gate()
and idt_setup_from_table() are only called from __init functions. Mark them
as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/idt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -217,7 +217,7 @@ static inline void idt_init_desc(gate_de
 #endif
 }
 
-static void
+static __init void
 idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sys)
 {
 	gate_desc desc;
@@ -230,7 +230,7 @@ idt_setup_from_table(gate_desc *idt, con
 	}
 }
 
-static void set_intr_gate(unsigned int n, const void *addr)
+static __init void set_intr_gate(unsigned int n, const void *addr)
 {
 	struct idt_data data;
 

