Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B481FC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929802075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p52kyfBZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3fsNbhrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGKKKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgGKKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:09:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6DC08C5DD;
        Sat, 11 Jul 2020 03:09:58 -0700 (PDT)
Date:   Sat, 11 Jul 2020 10:09:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594462196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqU8VwYSibpYg3tWi+UGqKlAPhy4X+KgTLQHOPME3cw=;
        b=p52kyfBZfmkDP1LukvzMwGr6qnEETnaUUCPJqABW2d388SjuQYhWynqGpygCtQldq7hMk3
        ogAYNzeq8Ht8xOLjGEeNLkJG6wUovuwF4C1QZyDoO6JrK/wvnbf7YrLB3N8gDmFgCeY/z4
        Tivi+XMVd/UkIVc71oTG53cqOqEkmJzUDsf88p1h6lImzdkvJ5fXFoZc7nfdwmygmoHgkR
        n159QZ8uU7eFl4IFVYZPc+unyxXOA+RGenCykkZSILhvMVC1T/Xc7tmDGym4vdZpsaCRkF
        LV/gjTjxf5F19t4R8QwyTQOKVc/sxJZHuDKj1hXtOBdZDydnGARZyaAeAszpNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594462196;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqU8VwYSibpYg3tWi+UGqKlAPhy4X+KgTLQHOPME3cw=;
        b=3fsNbhrBnvJ2Yf8RPxsgbwwzVSPRR+ME6lB1YokZeH5RFosI3KF/QZGDXQNIno9grj4TMa
        WdLioNfdiC4jgGBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sparc64: Fix asm/percpu.h build error
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200623083721.277992771@infradead.org>
References: <20200623083721.277992771@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219606.4006.16923768828083285770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     48017e5481ce85ba52c4cff082cad5f021c4b413
Gitweb:        https://git.kernel.org/tip/48017e5481ce85ba52c4cff082cad5f021c4b413
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 22:40:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:01 +02:00

sparc64: Fix asm/percpu.h build error

In order to break a header dependency between lockdep and task_struct,
I need per-cpu stuff from lockdep.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Link: https://lkml.kernel.org/r/20200623083721.277992771@infradead.org
---
 arch/sparc/include/asm/percpu_64.h  | 2 ++
 arch/sparc/include/asm/trap_block.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/percpu_64.h b/arch/sparc/include/asm/percpu_64.h
index 32ef6f0..a8786a4 100644
--- a/arch/sparc/include/asm/percpu_64.h
+++ b/arch/sparc/include/asm/percpu_64.h
@@ -4,7 +4,9 @@
 
 #include <linux/compiler.h>
 
+#ifndef BUILD_VDSO
 register unsigned long __local_per_cpu_offset asm("g5");
+#endif
 
 #ifdef CONFIG_SMP
 
diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 0f6d0c4..ace0d48 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_TRAP_BLOCK_H
 #define _SPARC_TRAP_BLOCK_H
 
+#include <linux/threads.h>
+
 #include <asm/hypervisor.h>
 #include <asm/asi.h>
 
