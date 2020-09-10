Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5FDC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4965C20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4qSHDnZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BirEK82J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIJT3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42846C061350;
        Thu, 10 Sep 2020 08:08:29 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6+IFj5KsRwEgGxJPZulh3HA62DooTbJIv60Z+9sE10=;
        b=m4qSHDnZcxNODEKHI7R7I0n8RVi7blwJ2zeUg3y2wWzvD16qluHu2Vm2nu0htWUIfqsN19
        N3OlV+FuGAXOxfOl6ZEMkQFVQT9cMixcWmZTv0Hii/WXCm6PkRl6SYhGzRnVwbdG9+Y3Qv
        Q94oVCmU5W/bp0GkfBtB4U0zTg85kZgSZwfBiG6CMiFuu5rHnzqn5itAi8FpxVkSY4HqtF
        kIH28Wt5TXFLr5jwGkXLuGLDv3gi/w5MDkFp3Ry+WWlTXUtNFuH3Vc0MyGxvZGVhIvPMQI
        vxsheCwiy/0wZrNNLDkALHjhsrIo5F8xQLns9CY7vYalRfBsWShpucmII2Ongg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6+IFj5KsRwEgGxJPZulh3HA62DooTbJIv60Z+9sE10=;
        b=BirEK82JlKkzGqHVY8zlyFWNLAkEzIUmAPLA5eCyiyj6b/XltzeEwVTwRLVmwY4pCrri/Y
        e2xv/lwZzia0UiCg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/tsc: Use seqcount_latch_t
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827114044.11173-7-a.darwish@linutronix.de>
References: <20200827114044.11173-7-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050696.20229.10208989556997350425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a1f1066133d85d5f42217cc72a2490bb7aa889c5
Gitweb:        https://git.kernel.org/tip/a1f1066133d85d5f42217cc72a2490bb7aa889c5
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:29 +02:00

x86/tsc: Use seqcount_latch_t

Latch sequence counters have unique read and write APIs, and thus
seqcount_latch_t was recently introduced at seqlock.h.

Use that new data type instead of plain seqcount_t. This adds the
necessary type-safety and ensures that only latching-safe seqcount APIs
are to be used.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
[peterz: unwreck cyc2ns_read_begin()]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200827114044.11173-7-a.darwish@linutronix.de
---
 arch/x86/kernel/tsc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 49d9250..f70dffc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -54,7 +54,7 @@ struct clocksource *art_related_clocksource;
 
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
-	seqcount_t	   seq;		/* 32 + 4    = 36 */
+	seqcount_latch_t   seq;		/* 32 + 4    = 36 */
 
 }; /* fits one cacheline */
 
@@ -73,14 +73,14 @@ __always_inline void cyc2ns_read_begin(struct cyc2ns_data *data)
 	preempt_disable_notrace();
 
 	do {
-		seq = this_cpu_read(cyc2ns.seq.sequence);
+		seq = this_cpu_read(cyc2ns.seq.seqcount.sequence);
 		idx = seq & 1;
 
 		data->cyc2ns_offset = this_cpu_read(cyc2ns.data[idx].cyc2ns_offset);
 		data->cyc2ns_mul    = this_cpu_read(cyc2ns.data[idx].cyc2ns_mul);
 		data->cyc2ns_shift  = this_cpu_read(cyc2ns.data[idx].cyc2ns_shift);
 
-	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.sequence)));
+	} while (unlikely(seq != this_cpu_read(cyc2ns.seq.seqcount.sequence)));
 }
 
 __always_inline void cyc2ns_read_end(void)
@@ -186,7 +186,7 @@ static void __init cyc2ns_init_boot_cpu(void)
 {
 	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
 
-	seqcount_init(&c2n->seq);
+	seqcount_latch_init(&c2n->seq);
 	__set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
 }
 
@@ -203,7 +203,7 @@ static void __init cyc2ns_init_secondary_cpus(void)
 
 	for_each_possible_cpu(cpu) {
 		if (cpu != this_cpu) {
-			seqcount_init(&c2n->seq);
+			seqcount_latch_init(&c2n->seq);
 			c2n = per_cpu_ptr(&cyc2ns, cpu);
 			c2n->data[0] = data[0];
 			c2n->data[1] = data[1];
