Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE4C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642E92074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YbaBX3cY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ApFG0ptU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgIDNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbgIDNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:16:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D49FC061246;
        Fri,  4 Sep 2020 06:16:14 -0700 (PDT)
Date:   Fri, 04 Sep 2020 13:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599225368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPu0sU99hlyF20wIihiuG8PsbfdGW9Hy+3ot0Fh5A0g=;
        b=YbaBX3cYoPO27fW5maB6m9RDQIITAgaY5iktQ85muUnM4fG9Yz/BPUX+3w/l/ARthSNMex
        uwoBwNwy3wjTcf2XWrDNFgCtNL1OlM7kMS2F/4f0nEsnK+T99BsumGW+0xAyFKI8FpVkok
        7YWt3uw62tlR4xt01FRRRUywXpky7kSNUM1oghQcfWRpW7NFzhaGIyw/WqCBLZ+c9L/jnR
        jPQWrTWixKpP0y3Nt7zlTn4t/7Trjccg6wgAVVYz3gxMVnz/YAcKZmu+S9sOJr7KYEebtR
        3f/mDtochAlDkR/0RVzYXHIANtm0ST2h+qYcXYl7U6730pgx7iY8Om/HANPr+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599225368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPu0sU99hlyF20wIihiuG8PsbfdGW9Hy+3ot0Fh5A0g=;
        b=ApFG0ptUPcDopRVfSnEFCUSqDel2nNK+RCt0LTdRv8gVUT8jnfmV19OvDwvdPCCGSvTvbn
        kok2a08CXRGsPQBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/debug: Remove aout_dump_debugregs()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902133201.233022474@infradead.org>
References: <20200902133201.233022474@infradead.org>
MIME-Version: 1.0
Message-ID: <159922536764.20229.11233205099095161537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     b84d42b6c6ac6a60519286e72b69f2dbf08dfb70
Gitweb:        https://git.kernel.org/tip/b84d42b6c6ac6a60519286e72b69f2dbf08dfb70
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Sep 2020 15:25:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Sep 2020 15:12:55 +02:00

x86/debug: Remove aout_dump_debugregs()

Unused remnants for the bit-bucket.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200902133201.233022474@infradead.org

---
 arch/x86/include/asm/debugreg.h |  2 +--
 arch/x86/kernel/hw_breakpoint.c | 36 +--------------------------------
 2 files changed, 38 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index e89558a..cfdf307 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -90,8 +90,6 @@ static __always_inline bool hw_breakpoint_active(void)
 	return __this_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;
 }
 
-extern void aout_dump_debugregs(struct user *dump);
-
 extern void hw_breakpoint_restore(void);
 
 static __always_inline unsigned long local_db_save(void)
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b98ff62..ca9de59 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -442,42 +442,6 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
 }
 
 /*
- * Dump the debug register contents to the user.
- * We can't dump our per cpu values because it
- * may contain cpu wide breakpoint, something that
- * doesn't belong to the current task.
- *
- * TODO: include non-ptrace user breakpoints (perf)
- */
-void aout_dump_debugregs(struct user *dump)
-{
-	int i;
-	int dr7 = 0;
-	struct perf_event *bp;
-	struct arch_hw_breakpoint *info;
-	struct thread_struct *thread = &current->thread;
-
-	for (i = 0; i < HBP_NUM; i++) {
-		bp = thread->ptrace_bps[i];
-
-		if (bp && !bp->attr.disabled) {
-			dump->u_debugreg[i] = bp->attr.bp_addr;
-			info = counter_arch_bp(bp);
-			dr7 |= encode_dr7(i, info->len, info->type);
-		} else {
-			dump->u_debugreg[i] = 0;
-		}
-	}
-
-	dump->u_debugreg[4] = 0;
-	dump->u_debugreg[5] = 0;
-	dump->u_debugreg[6] = current->thread.debugreg6;
-
-	dump->u_debugreg[7] = dr7;
-}
-EXPORT_SYMBOL_GPL(aout_dump_debugregs);
-
-/*
  * Release the user breakpoints used by ptrace
  */
 void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
