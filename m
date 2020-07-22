Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD05FC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F47A22B43
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bgbl4hio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbgGVV3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:29:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA0C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:29:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id h17so3181917oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MfkhC03Gc9jUuHWJh3Z9KGKVUr5k40t6D5IVuHnukSY=;
        b=Bgbl4hioE6Lxk+ni+VFgHv+JZXaOi46dj4jneGTg2LbDXDeb410BiCaxc00g7JlziL
         PfzZQFWvlwpLhvCdYW7yhCM2BeGmUHKYhQiNCrSpiix+BJChoBvlLEvBe6LXTtdGTgDc
         cemp03JrIPNs7W6mvR17su+JKU2nKPx2pI9BZKpS0mNwNjoYEaztLDMVdu4jZXSYJT1i
         kj5idv4L50oGDfgBBIqvRv5k2QkUNDG/8Jf5zZ7yzpex5FLYXUgYgoMJuVrAmSPPgwXc
         q6vxhkrD76DTQEQrBtwupWX0O8RHaVYfCPRPRz/QOfbdMuiuRPk9UrrXdJTNJONrIVFw
         5Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MfkhC03Gc9jUuHWJh3Z9KGKVUr5k40t6D5IVuHnukSY=;
        b=dGV3legbXb2DrdFyRm3/zvJl3vdE0GlY50qVBM/ChRxJ7HRuoYLC7BoCg7Xik0+lZM
         g2obR68sA32fk6A/b/TYae2bHs3SmNCbWuUqBb2/yVKzX+g577KyderIhgosMIScmeXJ
         Bht/fbEbG9oVVELIw4vvXamz5TqgFfusFTk4Csx2fSpkUhCdZT26nDtz6k2tFegWTbfJ
         3nXF1nZA/rF04DUXGa3zSu2Cztc//dCQsAULsP+YXYbBViMnPqJ1bz9ECOTLAsgWnTu6
         Vf4B/QRoOwYZaNOg+FVdwykadwHu7BJ7Ewml2T1y+Q09g+f0Q+OWKjlNxsv6udqEW1SM
         ub1A==
X-Gm-Message-State: AOAM530rW8twosCc+Fvn6NDvSfLEUIILlUnw0cdLnnFQYgaWG6nFDMIM
        fy3600shaRg0ZQHWY3XY2tUMFQ==
X-Google-Smtp-Source: ABdhPJwLRa67OJOCfoXDJdByIDklLYqywqdtVbMPH11zT2T7yjjeQPKMkJfj6BzgCQT8ns2C8oTSxQ==
X-Received: by 2002:aca:4e05:: with SMTP id c5mr1303955oib.37.1595453390906;
        Wed, 22 Jul 2020 14:29:50 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q15sm198197ood.11.2020.07.22.14.29.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 22 Jul 2020 14:29:49 -0700 (PDT)
Date:   Wed, 22 Jul 2020 14:29:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com> <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020, Linus Torvalds wrote:
> 
> I do wonder if we should make that PAGE_WAIT_TABLE_SIZE be larger. 256
> entries seems potentially ridiculously small, and aliasing not only
> increases the waitqueue length, it also potentially causes more
> contention on the waitqueue spinlock (which is already likely seeing
> some false sharing on a cacheline basis due to the fairly dense array
> of waitqueue entries: wait_queue_head is intentionally fairly small
> and dense unless you have lots of spinlock debugging options enabled).
> 
> That hashed wait-queue size is an independent issue, though. But it
> might be part of "some loads can get into some really nasty behavior
> in corner cases"

I don't think we've ever suffered from unlock_page() softlockups when
booting, as Michal reports; but we do have a forkbomby test (and a few
others) which occasionally suffer that way, on machines with many cpus.

We run with the three imperfect patches appended below, which together
seemed to improve, but not entirely solve, the situation:

mm,sched: make page_wait_table[] four times bigger
mm,sched: wait_on_page_bit_common() add back to head
mm,sched: __wake_up_common() break only after waking
 kernel/sched/wait.c |    5 ++++-
 mm/filemap.c        |   10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

I've rediffed them to 5.8-rc6, and checked that they build and sustain
a load for a few minutes: so they're not entirely ridiculous on latest
kernels, but certainly not thoroughly retested.

I'm rather desperate to stay out of the discussion here, given how far
behind I am on responding to other threads; and may not be able to
defend them beyond what I said in the original commit messages.
But seeing this thread, thought I'd better put them up for your eyes.

(And, no, I don't think I have a Copyright on changing an 8 to a 10:
you've probably gone further already; just included for completeness.)

Hugh

[PATCH] mm,sched: make page_wait_table[] four times bigger

Current page_wait_table[] size is 256 entries: bump that up to 1024
to reduce latency from frequent page hash collisions.  No science in
choosing fourfold: just "a little bigger".

Signed-off-by: Hugh Dickins <hughd@google.com>

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -968,7 +968,7 @@ EXPORT_SYMBOL(__page_cache_alloc);
  * at a cost of "thundering herd" phenomena during rare hash
  * collisions.
  */
-#define PAGE_WAIT_TABLE_BITS 8
+#define PAGE_WAIT_TABLE_BITS 10
 #define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
 static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline_aligned;
 
 
[PATCH] mm,sched: wait_on_page_bit_common() add back to head

wait_on_page_bit_common() always adds to tail of wait queue.  That is
of course right when adding an entry for the first time; but when woken,
and bit found already set, so adding back again?  Looks unfair: it would
get placed after recent arrivals, and in danger of indefinite starvation.

Instead, add back to head on repeat passes: not quite right either, but
if that happens again and again, the ordering will be reversed each time,
so it should work out reasonably fair.

Signed-off-by: Hugh Dickins <hughd@google.com>

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1109,6 +1109,7 @@ static inline int wait_on_page_bit_commo
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool bit_is_set;
+	bool first_time = true;
 	bool thrashing = false;
 	bool delayacct = false;
 	unsigned long pflags;
@@ -1134,7 +1135,12 @@ static inline int wait_on_page_bit_commo
 		spin_lock_irq(&q->lock);
 
 		if (likely(list_empty(&wait->entry))) {
-			__add_wait_queue_entry_tail(q, wait);
+			if (first_time) {
+				__add_wait_queue_entry_tail(q, wait);
+				first_time = false;
+			} else {
+				__add_wait_queue(q, wait);
+			}
 			SetPageWaiters(page);
 		}
 

[PATCH] mm,sched: __wake_up_common() break only after waking

4.14 commit 2554db916586 ("sched/wait: Break up long wake list walk")
added WQ_FLAG_BOOKMARK early breakout from __wake_up_common(): it lets
the waker drop and retake the irq-safe wait queue lock every 64 entries.
It was introduced to handle an Intel customer issue with long page wait
queues, but it also applies to all paths using __wake_up_common_lock().

It would probably be more useful to our non-preemptible kernel if it
could do a cond_resched() along with its cpu_relax(); but although
most unlock_page() calls would be fine with that, some would not -
page_endio(), for example; and it would be a big job to sort them,
and not clear that doing some not others would really help anyway.

A patch that I've been running with, that does help somewhat to reduce
those unlock_page() softlockups, is this weakening of 2554db916586:
don't break out until at least one wakeup has been issued for the page.

In the worst case (waking a page at the very end of a hash queue shared
with many waiters on another page), this would simply revert to the old
behavior, where there was no WQ_FLAG_BOOKMARK early breakout at all.

Whilst it did not set out to change behavior for __wake_up_common_lock()
users, review suggests that this change is probably good for them too.

Signed-off-by: Hugh Dickins <hughd@google.com>

--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -68,6 +68,7 @@ static int __wake_up_common(struct wait_
 			wait_queue_entry_t *bookmark)
 {
 	wait_queue_entry_t *curr, *next;
+	int woken = 0;
 	int cnt = 0;
 
 	lockdep_assert_held(&wq_head->lock);
@@ -95,8 +96,10 @@ static int __wake_up_common(struct wait_
 			break;
 		if (ret && (flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
 			break;
+		if (ret)
+			woken++;
 
-		if (bookmark && (++cnt > WAITQUEUE_WALK_BREAK_CNT) &&
+		if (bookmark && (++cnt > WAITQUEUE_WALK_BREAK_CNT) && woken &&
 				(&next->entry != &wq_head->head)) {
 			bookmark->flags = WQ_FLAG_BOOKMARK;
 			list_add_tail(&bookmark->entry, &next->entry);

