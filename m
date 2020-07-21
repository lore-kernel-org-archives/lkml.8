Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC724C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864BC20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXD/TMXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGUPlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGUPlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:41:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961CCC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aoTWOICeCHjv2x6ZecgmXxbVbqew19GvuC18N4BkUac=; b=GXD/TMXxizDadIqcRfKzXiH1E+
        858bLZPoVOBvxT0DmiNiP5od9BJKGUVGUI2NFQsEnkY1i+SGLdzug+xD7eUsRtKy01L67KeB9yfvn
        ZcsDiW/uYsGp5MWR+d5WAOGnm+ZDFh1Rk1iCOijbY4iWrXCFkztypMX4VCnLR7oyDTgxxTEFqcMaN
        rQZBpEZkKBSSMXBgCmEbTruRyVWnRaTy806mpxLvJFCKhhx+kf/vhBf0ESiuVxK3z8T0zqGfMcw69
        28/gaRrD1nwTf5pQdrGPAYBprZcJ8ihpspomRfFOixnhpoAaGDS+HPF5ZPPjJe7E7i3+ulJmW/Y7l
        YsRGawbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxuOC-00065f-Ac; Tue, 21 Jul 2020 15:41:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A384E301AC6;
        Tue, 21 Jul 2020 17:41:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8ECE720107F33; Tue, 21 Jul 2020 17:41:06 +0200 (CEST)
Date:   Tue, 21 Jul 2020 17:41:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net, axboe@kernel.dk,
        keescook@chromium.org, torvalds@linux-foundation.org,
        jannh@google.com, will@kernel.org, hch@lst.de, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v3] mm: Fix kthread_use_mm() vs TLB invalidate
Message-ID: <20200721154106.GE10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


For SMP systems using IPI based TLB invalidation, looking at
current->active_mm is entirely reasonable. This then presents the
following race condition:


  CPU0			CPU1

  flush_tlb_mm(mm)	use_mm(mm)
    <send-IPI>
			  tsk->active_mm = mm;
			  <IPI>
			    if (tsk->active_mm == mm)
			      // flush TLBs
			  </IPI>
			  switch_mm(old_mm,mm,tsk);


Where it is possible the IPI flushed the TLBs for @old_mm, not @mm,
because the IPI lands before we actually switched.

Avoid this by disabling IRQs across changing ->active_mm and
switch_mm().

[ There are all sorts of reasons this might be harmless for various
architecture specific reasons, but best not leave the door open at
all. ]

Cc: stable@kernel.org
Reported-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

Sorry, I dropped the ball on this and only found it because I was
looking at the whole membarrier things vs use_mm().


 kernel/kthread.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1d9e2fdfd67a..7221dcbffef3 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1241,13 +1241,15 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(tsk->mm);
 
 	task_lock(tsk);
+	local_irq_disable();
 	active_mm = tsk->active_mm;
 	if (active_mm != mm) {
 		mmgrab(mm);
 		tsk->active_mm = mm;
 	}
 	tsk->mm = mm;
-	switch_mm(active_mm, mm, tsk);
+	switch_mm_irqs_off(active_mm, mm, tsk);
+	local_irq_enable();
 	task_unlock(tsk);
 #ifdef finish_arch_post_lock_switch
 	finish_arch_post_lock_switch();
@@ -1276,9 +1278,11 @@ void kthread_unuse_mm(struct mm_struct *mm)
 
 	task_lock(tsk);
 	sync_mm_rss(mm);
+	local_irq_disable();
 	tsk->mm = NULL;
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
+	local_irq_enable();
 	task_unlock(tsk);
 }
 EXPORT_SYMBOL_GPL(kthread_unuse_mm);
