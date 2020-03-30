Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC38C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB6A20716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E7RfOGIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgC3LTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:19:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgC3LTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fWVXGX/OziKB4qDcBSld4wYjJ05171GId/cI3GmWg3k=; b=E7RfOGIc4QLl2iK/NnCRH9ILsx
        d0GmPXGxtHuhonmHMZ42yvO89G2aLtbjLDvwMdUCyoSmgTC35VUU6A1U2/suReXfelJkEV0v8Po0P
        0jWa5NLWLAYS7fIFPfTU12w/Ezmv9tLYhNzYEgT40jgj0i2KKkqXv8/z85dillHvEFcu0UUjimjAZ
        A8fgatBjgYeVSO15Kh4UrpRS3Yu8qIVFTqA/Ob4RahTh7BpSjMIqauE7qHSkwfavwVC9hE0nrnTuD
        Xgbts7vUU67ci3hYLYIo1pmbWy903QwHJIx5aSXlw03+HEF0ikyEjPk2s0z5rW28PQIPeaP/noQ3Y
        5kO2IK7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIsRT-00024i-HO; Mon, 30 Mar 2020 11:18:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12E7C303C41;
        Mon, 30 Mar 2020 13:18:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F04FD29D04D69; Mon, 30 Mar 2020 13:18:52 +0200 (CEST)
Date:   Mon, 30 Mar 2020 13:18:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, will@kernel.org, dbueso@suse.de,
        juri.lelli@redhat.com, longman@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] locking/percpu-rwsem: fix a task_struct refcount
Message-ID: <20200330111852.GH20696@hirez.programming.kicks-ass.net>
References: <20200327093754.GS20713@hirez.programming.kicks-ass.net>
 <BB30C711-B54C-4D61-8BEE-A55F410C4178@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB30C711-B54C-4D61-8BEE-A55F410C4178@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 06:19:37AM -0400, Qian Cai wrote:
> 
> 
> > On Mar 27, 2020, at 5:37 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > If the trylock fails, someone else got the lock and we remain on the
> > waitqueue. It seems like a very bad idea to put the task while it
> > remains on the waitqueue, no?
> 
> Interesting, I thought this was more straightforward to see,

It is indeed as straight forward as you explain; but when doing 10
things at once, and having just dug through some low-level arch assembly
code for the previous email, even obvious things might sometimes need
a little explaining :/

So please, always try and err on the side of a little verbose when
writing Changelogs, esp. when concerning locking / concurrency, you
really can't be clear enough.

> but I may
> be wrong as always. At the beginning of percpu_rwsem_wake_function()
> it calls get_task_struct(), but if the trylock failed, it will remain
> in the waitqueue. However, it will run percpu_rwsem_wake_function()
> again with get_task_struct() to increase the refcount. Can you
> enlighten me where it will call put_task_struct() in waitqueue or
> elsewhere to balance the refcount in this case?

See, had that explaination been part of the Changelog, my brain would've
probably been able to kick itself in gear and actually spot the problem.

Yes, you're right.

That said, I wonder if we can just move the get_task_struct() call like
below; after all the race we're guarding against is percpu_rwsem_wait()
observing !private, terminating the wait and doing a quick exit() while
percpu_rwsem_wake_function() then does wake_up_process(p) as a
use-after-free.

Hmm?

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a008a1ba21a7..8bbafe3e5203 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -118,14 +118,15 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 				      unsigned int mode, int wake_flags,
 				      void *key)
 {
-	struct task_struct *p = get_task_struct(wq_entry->private);
 	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
 	struct percpu_rw_semaphore *sem = key;
+	struct task_struct *p;
 
 	/* concurrent against percpu_down_write(), can get stolen */
 	if (!__percpu_rwsem_trylock(sem, reader))
 		return 1;
 
+	p = get_task_struct(wq_entry->private);
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
 
