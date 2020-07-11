Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC4C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD15520657
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jy3s1SGw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c24nWxiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGKKKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgGKKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:09:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C8CC08C5DD;
        Sat, 11 Jul 2020 03:09:57 -0700 (PDT)
Date:   Sat, 11 Jul 2020 10:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594462194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+hXXEWDvNMyPF2USbvAt1i5T00JHIqg7Qsoq70MMcI=;
        b=Jy3s1SGwPvcyvutBydD55gBGnFRp1zaswiV4hw9qFmNvRWb3plNRnM+OsyLFbS/beWfP+D
        NWa1n6DOOXYzArNzScjLGRSmLw6qAeWpn51hGsx0zsy/ovSQhyybsi5FPY5VT3BIsBdlOk
        PCkiQTNFdwMegFQJ87Dyh3J/kv1g8knREPPoDdb4KZPE3SzX1nLFeyVfpIpqU2CJ0mEDxh
        KeLTBj9u8mzgb038A54BqvPR+eX+iUM028tq6Jlm5rzmRo5cPvYuJYwYQoNA6E2R5NJ0TY
        LZ3XtqEDoJOB5c9IJwP5H6UoVmfBQivBBA12eb3FdaIBfNs9jGDZAXjg12WBCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594462194;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+hXXEWDvNMyPF2USbvAt1i5T00JHIqg7Qsoq70MMcI=;
        b=c24nWxiVcqPDBuPljlIRzPP6IwEX2HFfX0csZWKs1+B9vABCITTPVi99jxvuw7a6sw9NQo
        T0NKv+8ku5gbT6Cg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] arm: Break cyclic percpu include
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200623083721.454517573@infradead.org>
References: <20200623083721.454517573@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219427.4006.4005355405552922553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a6342915881a687b07847b7c57628de07a256525
Gitweb:        https://git.kernel.org/tip/a6342915881a687b07847b7c57628de07a256525
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Jun 2020 17:21:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:02 +02:00

arm: Break cyclic percpu include

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200623083721.454517573@infradead.org
---
 arch/arm/include/asm/percpu.h      | 2 ++
 arch/arm/include/asm/thread_info.h | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index f44f448..e2fcb3c 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+register unsigned long current_stack_pointer asm ("sp");
+
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 3609a69..536b6b9 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -76,11 +76,6 @@ struct thread_info {
 }
 
 /*
- * how to get the current stack pointer in C
- */
-register unsigned long current_stack_pointer asm ("sp");
-
-/*
  * how to get the thread information struct from C
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
