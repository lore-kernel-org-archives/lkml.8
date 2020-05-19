Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA11520826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgESUBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgEST65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:58:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AEFC08C5C0;
        Tue, 19 May 2020 12:58:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8O8-0000Ax-6V; Tue, 19 May 2020 21:58:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B32591C0852;
        Tue, 19 May 2020 21:58:44 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:44 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idt: Remove update_intr_gate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158991832459.17951.14798835986906194460.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     8175cfbbbfcba992ed0dd5868d83733c4f38bbb9
Gitweb:        https://git.kernel.org/tip/8175cfbbbfcba992ed0dd5868d83733c4f38bbb9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 May 2020 17:39:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 16:03:49 +02:00

x86/idt: Remove update_intr_gate()

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/desc.h | 1 -
 arch/x86/kernel/idt.c       | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 68a99d2..085a2dd 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -386,7 +386,6 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 	desc->limit1 = (limit >> 16) & 0xf;
 }
 
-void update_intr_gate(unsigned int n, const void *addr);
 void alloc_intr_gate(unsigned int n, const void *addr);
 
 extern unsigned long system_vectors[];
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 36fef90..95609ee 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -360,14 +360,6 @@ void idt_invalidate(void *addr)
 	load_idt(&idt);
 }
 
-/* This goes away once ASYNC_PF is sanitized */
-void __init update_intr_gate(unsigned int n, const void *addr)
-{
-	if (WARN_ON_ONCE(!test_bit(n, system_vectors)))
-		return;
-	set_intr_gate(n, addr);
-}
-
 void __init alloc_intr_gate(unsigned int n, const void *addr)
 {
 	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
