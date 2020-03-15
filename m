Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354DFC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0319520663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 13:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584280447;
	bh=3pR9WhpjG6F6KDSnXZjrp4gM40NK9AIbEEQMAF2zaYk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=B7HZ+6872D11qMcV16nmtavX+yYWTgzDfvFId7FnGmjUO2nsQg6kUB6Mk4VKcBEUx
	 Z7pcqOwVE5eF0vj/RRnH18g2kvjZZrZEE92ns4xO8TEXGCzGBjkqclgmslXvtZeClj
	 jXK2+zX9i2lFAjSaS0JubQutQRjySoQAPx98XcOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgCONyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 09:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgCONyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 09:54:05 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA75620637;
        Sun, 15 Mar 2020 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584280444;
        bh=3pR9WhpjG6F6KDSnXZjrp4gM40NK9AIbEEQMAF2zaYk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g84r0oI0gUXESsE/Opdc6bkMR17u5tzCP/m8RZpUI0m+JciIodUakNkd3wSTsu4Uh
         vnPubOY4hZbY4D0OHYSPLOqPIRrKc0dC+JaVhIJ9aY7nGnWAP7Dv3PqOqEHyigCOps
         y0NpFchc266L2L+K5BX7Fe8T9Om+0adzKyse6P54=
Message-ID: <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
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
Date:   Sun, 15 Mar 2020 09:54:02 -0400
In-Reply-To: <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
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
         <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
         <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
         <87v9nattul.fsf@notabene.neil.brown.name>
         <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
         <87o8t2tc9s.fsf@notabene.neil.brown.name>
         <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
         <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
         <877dznu0pk.fsf@notabene.neil.brown.name>
         <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-03-14 at 08:58 -0700, Linus Torvalds wrote:
> On Fri, Mar 13, 2020 at 7:31 PM NeilBrown <neilb@suse.de> wrote:
> > The idea of list_del_init_release() and list_empty_acquire() is growing
> > on me though.  See below.
> 
> This does look like a promising approach.
> 
> However:
> 
> > +       if (waiter->fl_blocker == NULL &&
> > +           list_empty(&waiter->fl_blocked_requests) &&
> > +           list_empty_acquire(&waiter->fl_blocked_member))
> > +               return status;
> 
> This does not seem sensible to me.
> 
> The thing is, the whole point about "acquire" semantics is that it
> should happen _first_ - because a load-with-acquire only orders things
> _after_ it.
> 
> So testing some other non-locked state before testing the load-acquire
> state makes little sense: it means that the other tests you do are
> fundamentally unordered and nonsensical in an unlocked model.
> 
> So _if_ those other tests matter (do they?), then they should be after
> the acquire test (because they test things that on the writer side are
> set before the "store-release"). Otherwise you're testing random
> state.
> 
> And if they don't matter, then they shouldn't exist at all.
> 
> IOW, if you depend on ordering, then the _only_ ordering that exists is:
> 
>  - writer side: writes done _before_ the smp_store_release() are visible
> 
>  - to the reader side done _after_ the smp_load_acquire()
> 
> and absolutely no other ordering exists or makes sense to test for.
> 
> That limited ordering guarantee is why a store-release -> load-acquire
> is fundamentally cheaper than any other serialization.
> 
> So the optimistic "I don't need to do anything" case should start ouf with
> 
>         if (list_empty_acquire(&waiter->fl_blocked_member)) {
> 
> and go from there. Does it actually need to do anything else at all?
> But if it does need to check the other fields, they should be checked
> after that acquire.
> 
> Also, it worries me that the comment talks about "if fl_blocker is
> NULL". But it realy now is that fl_blocked_member list being empty
> that is the real serialization test, adn that's the one that the
> comment should primarily talk about.
> 

Good point. The list manipulation and setting of fl_blocker are always
done in conjunction, so I don't see why we'd need to check but one
condition there (whichever gets the explicit acquire/release semantics).

The fl_blocker pointer seems like the clearest way to indicate that to
me, but if using list_empty makes sense for other reasons, I'm fine with
that.

This is what I have so far (leaving Linus as author since he did the
original patch):

------------8<-------------

From 1493f539e09dfcd5e0862209c6f7f292a2f2d228 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2020 14:35:43 -0400
Subject: [PATCH] locks: reinstate locks_delete_block optimization

There is measurable performance impact in some synthetic tests due to
commit 6d390e4b5d48 (locks: fix a potential use-after-free problem when
wakeup a waiter). Fix the race condition instead by clearing the
fl_blocker pointer after the wake_up, using explicit acquire/release
semantics.

With this change, we can just check for fl_blocker to clear as an
indicator that the block is already deleted, and eliminate the
list_empty check that was in the old optimization.

This does mean that we can no longer use the clearing of fl_blocker as
the wait condition, so switch the waiters over to checking whether the
fl_blocked_member list_head is empty.

Cc: yangerkun <yangerkun@huawei.com>
Cc: NeilBrown <neilb@suse.de>
Fixes: 6d390e4b5d48 (locks: fix a potential use-after-free problem when wakeup a waiter)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cifs/file.c |  3 ++-
 fs/locks.c     | 38 ++++++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 3b942ecdd4be..8f9d849a0012 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1169,7 +1169,8 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	rc = posix_lock_file(file, flock, NULL);
 	up_write(&cinode->lock_sem);
 	if (rc == FILE_LOCK_DEFERRED) {
-		rc = wait_event_interruptible(flock->fl_wait, !flock->fl_blocker);
+		rc = wait_event_interruptible(flock->fl_wait,
+					list_empty(&flock->fl_blocked_member));
 		if (!rc)
 			goto try_again;
 		locks_delete_block(flock);
diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..652a09ab02d7 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -725,7 +725,6 @@ static void __locks_delete_block(struct file_lock *waiter)
 {
 	locks_delete_global_blocked(waiter);
 	list_del_init(&waiter->fl_blocked_member);
-	waiter->fl_blocker = NULL;
 }
 
 static void __locks_wake_up_blocks(struct file_lock *blocker)
@@ -740,6 +739,12 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
 			wake_up(&waiter->fl_wait);
+
+		/*
+		 * Tell the world we're done with it - see comment at
+		 * top of locks_delete_block().
+		 */
+		smp_store_release(&waiter->fl_blocker, NULL);
 	}
 }
 
@@ -753,11 +758,27 @@ int locks_delete_block(struct file_lock *waiter)
 {
 	int status = -ENOENT;
 
+	/*
+	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
+	 * the lock and is the only one that might try to claim the lock.
+	 * Because fl_blocker is explicitly set last during a delete, it's
+	 * safe to locklessly test to see if it's NULL and avoid doing
+	 * anything further if it is.
+	 */
+	if (!smp_load_acquire(&waiter->fl_blocker))
+		return status;
+
 	spin_lock(&blocked_lock_lock);
 	if (waiter->fl_blocker)
 		status = 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
+
+	/*
+	 * Tell the world we're done with it - see comment at top
+	 * of this function
+	 */
+	smp_store_release(&waiter->fl_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
@@ -1350,7 +1371,8 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = posix_lock_inode(inode, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -1435,7 +1457,8 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 		error = posix_lock_inode(inode, &fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl.fl_wait, !fl.fl_blocker);
+		error = wait_event_interruptible(fl.fl_wait,
+					list_empty(&fl.fl_blocked_member));
 		if (!error) {
 			/*
 			 * If we've been sleeping someone might have
@@ -1638,7 +1661,8 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 
 	locks_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-						!new_fl->fl_blocker, break_time);
+					list_empty(&new_fl->fl_blocked_member),
+					break_time);
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -2122,7 +2146,8 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = flock_lock_inode(inode, fl);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+				list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -2399,7 +2424,8 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		error = vfs_lock_file(filp, cmd, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
-- 
2.24.1


