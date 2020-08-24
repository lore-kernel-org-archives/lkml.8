Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1862C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856FD206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b30ORC/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHXOOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:14:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65116C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n1MFUZtSNnD68NOJIn4Ii8T2Lxsm8QPQOoQduHaUuow=; b=b30ORC/V2ydNehF8gl2ylP9w7G
        R5+Tgaxjr/f79pUpDvYCFZNUeG4zZUeNcI0hpjLA/DSb+tND0Cvd8gRNvDdRtjbigOkrPdDsznHJq
        rIkIdc6HwyDhjlFlkmtWYYuSj8mGTTnX6DQLrSZIFoOV0m2AY/wD+ijpe2XwrDwhzfKXR6bczxdOU
        f/aCTOEizppqBZs0aS8nlgYBBa9dpSvP6bz/nvuLGfbVbeiWqQ48heLLkwJO2yRJqqPiuRPQO6GkD
        SeSwBTPbeIv5/bcJ0cWYMNqyWO3JxmL2CT9hEeFksuiMHHJFdIo64Qp5fuBsxDXzCbUYNrA1v9gO2
        +Kuirwnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kADF3-0000Md-5b; Mon, 24 Aug 2020 14:14:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCB7D980DF9; Mon, 24 Aug 2020 16:14:29 +0200 (CEST)
Date:   Mon, 24 Aug 2020 16:14:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200824141429.GA3982@worktop.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:02:58PM +0000, Eddy_Wu@trendmicro.com wrote:
> After bisecting, I found this behavior seems to introduce by this
> commit: (5.8-rc1) 0d00449c7a28a1514595630735df383dec606812 x86:
> Replace ist_enter() with nmi_enter() This make kprobe_int3_handler()
> effectively running as NMI context, which pre_handler_kretprobe()
> explicitly checked to prevent recursion.
> 
> (in_nmi() check appears from v3.17)
> f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hit
> in NMI context to avoid deadlock
> 
> To make kretprobe work again with int3 breakpoint, I think we can
> replace the in_nmi() check with in_nmi() == (1 << NMI_SHIFT) at
> kprobe_int3_handler() and skip kretprobe if nested NMI.  Did a quick
> test on 5.9-rc2 and it seems to be working.  I'm not sure if it is the
> best way to do since it may also require change to other architecture
> as well, any thought?

Masami, would it be possible to have a kretprobe specific recursion
count here?

I did the below, but i'm not at all sure that isn't horrible broken. I
can't really find many rp->lock sites and this might break things by
limiting contention.

---

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 9be1bff4f586..0bff314cc800 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -153,6 +153,7 @@ struct kretprobe {
 	size_t data_size;
 	struct hlist_head free_instances;
 	raw_spinlock_t lock;
+	atomic_t recursion;
 };
 
 struct kretprobe_instance {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263c9cb9..27fd096bcb9a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1934,22 +1934,17 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	unsigned long hash, flags = 0;
 	struct kretprobe_instance *ri;
-
-	/*
-	 * To avoid deadlocks, prohibit return probing in NMI contexts,
-	 * just skip the probe and increase the (inexact) 'nmissed'
-	 * statistical counter, so that the user is informed that
-	 * something happened:
-	 */
-	if (unlikely(in_nmi())) {
-		rp->nmissed++;
-		return 0;
-	}
+	unsigned long hash, flags;
+	int rec;
 
 	/* TODO: consider to only swap the RA after the last pre_handler fired */
 	hash = hash_ptr(current, KPROBE_HASH_BITS);
+	rec = atomic_fetch_inc_acquire(&rp->recursion);
+	if (rec) {
+		rp->nmissed++;
+		goto out;
+	}
 	raw_spin_lock_irqsave(&rp->lock, flags);
 	if (!hlist_empty(&rp->free_instances)) {
 		ri = hlist_entry(rp->free_instances.first,
@@ -1964,7 +1959,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 			raw_spin_lock_irqsave(&rp->lock, flags);
 			hlist_add_head(&ri->hlist, &rp->free_instances);
 			raw_spin_unlock_irqrestore(&rp->lock, flags);
-			return 0;
+			goto out;
 		}
 
 		arch_prepare_kretprobe(ri, regs);
@@ -1978,6 +1973,8 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 		rp->nmissed++;
 		raw_spin_unlock_irqrestore(&rp->lock, flags);
 	}
+out:
+	atomic_dec(&rp->recursion);
 	return 0;
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);

