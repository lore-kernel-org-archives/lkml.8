Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D1FC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6751222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583878066;
	bh=DHAN0I29DwoZWN2Wh3iFT+l4WD2xdxIe3omBWt1StEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=jGn3SV4B9IU6L1PWWtTS+/nsmzqD/oeZMuuc5YCcBIgg8/v3ZOx3pB7d4fTDQzYbZ
	 MSecQ3Mq9RBUwScAOOeexBkA1SYhyV+mnkQ/kE9ULRsKnIASoWTCitIFIVmdE3W5n5
	 +r3EWXpA3YwxR+I1+JaZFLcjeTN/Tkm8VNcCvwnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgCJWHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgCJWHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:07:45 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A97208E4;
        Tue, 10 Mar 2020 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583878064;
        bh=DHAN0I29DwoZWN2Wh3iFT+l4WD2xdxIe3omBWt1StEY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YoJuo5ROOds6vuSyTs8LNVz977cmPul0DuRXUS8pdyBbgJ24BMedhZfWEKZCSx2J+
         +OL+gkt7Qh9P6FOrO2ZKnYxkbeKhpvc8t6JNc6TXO1zrOi9gKv/dUyqccnYLWbhmc7
         KVM2aE2pMO+6epG9zL6VU2ofDpVqQe/3t80b9sII=
Message-ID: <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        NeilBrown <neilb@suse.de>
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 10 Mar 2020 18:07:42 -0400
In-Reply-To: <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
         <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
         <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
         <878sk7vs8q.fsf@notabene.neil.brown.name>
         <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
         <875zfbvrbm.fsf@notabene.neil.brown.name>
         <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 14:47 -0700, Linus Torvalds wrote:
> On Tue, Mar 10, 2020 at 2:22 PM NeilBrown <neilb@suse.de> wrote:
> > A compiler barrier() is probably justified.  Memory barriers delay reads
> > and expedite writes so they cannot be needed.
> 
> That's not at all guaranteed. Weakly ordered memory things can
> actually have odd orderings, and not just "writes delayed, reads done
> early". Reads may be delayed too by cache misses, and memory barriers
> can thus expedite reads as well (by forcing the missing read to happen
> before later non-missing ones).
> 
> So don't assume that a memory barrier would only delay reads and
> expedite writes. Quite the reverse: assume that there is no ordering
> at all unless you impose one with a memory barrier (*).
> 
>              Linus
> 
> (*) it's a bit more complex than that, in that we do assume that
> control dependencies end up gating writes, for example, but those
> kinds of implicit ordering things should *not* be what you depend on
> in the code unless you're doing some seriously subtle memory ordering
> work and comment on it extensively.

Good point. I too prefer code that's understandable by mere mortals.

Given that, and the fact that Neil pointed out that yangerkun's latest
patch would reintroduce the original race, I'm leaning back toward the
patch Neil sent yesterday. It relies solely on spinlocks, and so doesn't
have the subtle memory-ordering requirements of the others.

I did some cursory testing with it and it seems to fix the performance
regression. If you guys are OK with this patch, and Neil can send an
updated changelog, I'll get it into -next and we can get this sorted
out.

Thanks,

-------------------8<-------------------

[PATCH] locks: reintroduce locks_delete_block shortcut
---
 fs/locks.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..8aa04d5ac8b3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -735,11 +735,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 
 		waiter = list_first_entry(&blocker->fl_blocked_requests,
 					  struct file_lock, fl_blocked_member);
+		spin_lock(&waiter->fl_wait.lock);
 		__locks_delete_block(waiter);
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
-			wake_up(&waiter->fl_wait);
+			wake_up_locked(&waiter->fl_wait);
+		spin_unlock(&waiter->fl_wait.lock);
 	}
 }
 
@@ -753,6 +755,31 @@ int locks_delete_block(struct file_lock *waiter)
 {
 	int status = -ENOENT;
 
+	/*
+	 * If fl_blocker is NULL, it won't be set again as this thread
+	 * "owns" the lock and is the only one that might try to claim
+	 * the lock.  So it is safe to test fl_blocker locklessly.
+	 * Also if fl_blocker is NULL, this waiter is not listed on
+	 * fl_blocked_requests for some lock, so no other request can
+	 * be added to the list of fl_blocked_requests for this
+	 * request.  So if fl_blocker is NULL, it is safe to
+	 * locklessly check if fl_blocked_requests is empty.  If both
+	 * of these checks succeed, there is no need to take the lock.
+	 * However, some other thread might have only *just* set
+	 * fl_blocker to NULL and it about to send a wakeup on
+	 * fl_wait, so we mustn't return too soon or we might free waiter
+	 * before that wakeup can be sent.  So take the fl_wait.lock
+	 * to serialize with the wakeup in __locks_wake_up_blocks().
+	 */
+	if (waiter->fl_blocker == NULL) {
+		spin_lock(&waiter->fl_wait.lock);
+		if (waiter->fl_blocker == NULL &&
+		    list_empty(&waiter->fl_blocked_requests)) {
+			spin_unlock(&waiter->fl_wait.lock);
+			return status;
+		}
+		spin_unlock(&waiter->fl_wait.lock);
+	}
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status = 0;
-- 
2.24.1


