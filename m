Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B93CC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA124673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583791099;
	bh=j8JudUjaVqpyhM2J1RL+ojN6W74AclALW8V/PLr7bGk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=TJ6t8ftYDRf9hgCCGFbFaVRUVPvbIZxHsz6e5tg7KHUmegrOLm/C9QXNj1q9MNL3K
	 M36ilI9NCToBYpFFUv4YPRcE148zlkuVE2sQJIKPKttcjaCqy4y1nxgg3NxrNvI9xt
	 QbYq57OkGsg5Kbm6ZpbiI07I2Z4dVK9MFXgfDAoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCIV6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgCIV6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:58:17 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1D712253D;
        Mon,  9 Mar 2020 21:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583791096;
        bh=j8JudUjaVqpyhM2J1RL+ojN6W74AclALW8V/PLr7bGk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tLh3awgHjrkugCZkLXtjvhHPQZ7Z29Nzqc5+wDUvympdq1RLdXxSfkyObzPqzxk+h
         YbBC3PaxxbYJKceo0IZL4U0nxvhOFvu/JGQkocy3NLMNkRq5qtYcCdjz6GH4L17skB
         9mYzNmBC7o4sbTA22dHhx/jVZb8UW/FsgrKCVGuw=
Message-ID: <926c589a579e28a349c84c9fca9fa5d5eadc6203.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        yangerkun <yangerkun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 09 Mar 2020 17:58:14 -0400
In-Reply-To: <87blp5urwq.fsf@notabene.neil.brown.name>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 08:42 +1100, NeilBrown wrote:
> On Mon, Mar 09 2020, Jeff Layton wrote:
> 
> > On Mon, 2020-03-09 at 13:22 -0400, Jeff Layton wrote:
> > > On Mon, 2020-03-09 at 08:52 -0700, Linus Torvalds wrote:
> > > > On Mon, Mar 9, 2020 at 7:36 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > On Sun, 2020-03-08 at 22:03 +0800, kernel test robot wrote:
> > > > > > FYI, we noticed a -96.6% regression of will-it-scale.per_process_ops due to commit:
> > > > > 
> > > > > This is not completely unexpected as we're banging on the global
> > > > > blocked_lock_lock now for every unlock. This test just thrashes file
> > > > > locks and unlocks without doing anything in between, so the workload
> > > > > looks pretty artificial [1].
> > > > > 
> > > > > It would be nice to avoid the global lock in this codepath, but it
> > > > > doesn't look simple to do. I'll keep thinking about it, but for now I'm
> > > > > inclined to ignore this result unless we see a problem in more realistic
> > > > > workloads.
> > > > 
> > > > That is a _huge_ regression, though.
> > > > 
> > > > What about something like the attached? Wouldn't that work? And make
> > > > the code actually match the old comment about wow "fl_blocker" being
> > > > NULL being special.
> > > > 
> > > > The old code seemed to not know about things like memory ordering either.
> > > > 
> > > > Patch is entirely untested, but aims to have that "smp_store_release()
> > > > means I'm done and not going to touch it any more", making that
> > > > smp_load_acquire() test hopefully be valid as per the comment..
> > > 
> > > Yeah, something along those lines maybe. I don't think we can use
> > > fl_blocker that way though, as the wait_event_interruptible is waiting
> > > on it to go to NULL, and the wake_up happens before fl_blocker is
> > > cleared.
> > > 
> > > Maybe we need to mix in some sort of FL_BLOCK_ACTIVE flag and use that
> > > instead of testing for !fl_blocker to see whether we can avoid the
> > > blocked_lock_lock?
> > >   
> > 
> > How about something like this instead? (untested other than for
> > compilation)
> > 
> > Basically, this just switches the waiters over to wait for
> > fl_blocked_member to go empty. That still happens before the wakeup, so
> > it should be ok to wait on that.
> > 
> > I think we can also eliminate the lockless list_empty check in
> > locks_delete_block, as the fl_blocker check should be sufficient now.
> > -- 
> > Jeff Layton <jlayton@kernel.org>
> > From c179d779c9b72838ed9996a65d686d86679d1639 Mon Sep 17 00:00:00 2001
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Date: Mon, 9 Mar 2020 14:35:43 -0400
> > Subject: [PATCH] locks: reinstate locks_delete_lock optimization
> > 
> > ...by using smp_load_acquire and smp_store_release to close the race
> > window.
> > 
> > [ jlayton: wait on the fl_blocked_requests list to go empty instead of
> > 	   the fl_blocker pointer to clear. Remove the list_empty check
> > 	   from locks_delete_lock shortcut. ]
> 
> Why do you think it is OK to remove that list_empty check?  I don't
> think it is.  There might be locked requests that need to be woken up.
> 

Temporary braino. We definitely cannot remove that check.

> As the problem here is a use-after-free due to a race, one option would
> be to use rcu_free() on the file_lock, and hold rcu_read_lock() around
> test/use.
> 

Yeah, I was considering this too, but Linus' approach seemed simpler.

> Another option is to use a different lock.  The fl_wait contains a
> spinlock, and we have wake_up_locked() which is provided for exactly
> these sorts of situations where the wake_up call can race with a thread
> waking up.
> 
> So my compile-tested-only proposal is below.
> I can probably a proper change-log entry if you think the patch is a
> good way to go.
> 
> NeilBrown
> 
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 426b55d333d5..8aa04d5ac8b3 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -735,11 +735,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
>  
>  		waiter = list_first_entry(&blocker->fl_blocked_requests,
>  					  struct file_lock, fl_blocked_member);
> +		spin_lock(&waiter->fl_wait.lock);
>  		__locks_delete_block(waiter);
>  		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
>  			waiter->fl_lmops->lm_notify(waiter);
>  		else
> -			wake_up(&waiter->fl_wait);
> +			wake_up_locked(&waiter->fl_wait);
> +		spin_unlock(&waiter->fl_wait.lock);
>  	}
>  }
>  
> @@ -753,6 +755,31 @@ int locks_delete_block(struct file_lock *waiter)
>  {
>  	int status = -ENOENT;
>  
> +	/*
> +	 * If fl_blocker is NULL, it won't be set again as this thread
> +	 * "owns" the lock and is the only one that might try to claim
> +	 * the lock.  So it is safe to test fl_blocker locklessly.
> +	 * Also if fl_blocker is NULL, this waiter is not listed on
> +	 * fl_blocked_requests for some lock, so no other request can
> +	 * be added to the list of fl_blocked_requests for this
> +	 * request.  So if fl_blocker is NULL, it is safe to
> +	 * locklessly check if fl_blocked_requests is empty.  If both
> +	 * of these checks succeed, there is no need to take the lock.
> +	 * However, some other thread might have only *just* set
> +	 * fl_blocker to NULL and it about to send a wakeup on
> +	 * fl_wait, so we mustn't return too soon or we might free waiter
> +	 * before that wakeup can be sent.  So take the fl_wait.lock
> +	 * to serialize with the wakeup in __locks_wake_up_blocks().
> +	 */
> +	if (waiter->fl_blocker == NULL) {
> +		spin_lock(&waiter->fl_wait.lock);
> +		if (waiter->fl_blocker == NULL &&
> +		    list_empty(&waiter->fl_blocked_requests)) {
> +			spin_unlock(&waiter->fl_wait.lock);
> +			return status;
> +		}
> +		spin_unlock(&waiter->fl_wait.lock);
> +	}
>  	spin_lock(&blocked_lock_lock);
>  	if (waiter->fl_blocker)
>  		status = 0;

Yeah, this is simpler for me to prove to myself that it's correct, and I
like that it touches less code, tbh. I'll give it a try here in a bit
and see if it also fixes up the perf regression.

FWIW, here's the variant of Linus' patch I've been testing. It seems to
fix the performance regression too.

--------------8<---------------

[PATCH] locks: reinstate locks_delete_lock optimization

There is measurable performance impact in some synthetic tests in commit
6d390e4b5d48 (locks: fix a potential use-after-free problem when wakeup
a waiter).  Fix the race condition instead by clearing the fl_blocker
pointer after the wakeup and by using smp_load_acquire and
smp_store_release to handle the access.

This means that we can no longer use the clearing of fl_blocker clearing
as the wait condition, so switch over to checking whether the
fl_blocked_member list is empty.

[ jlayton: wait on the fl_blocked_requests list to go empty instead of
	   the fl_blocker pointer to clear. ]

Cc: yangerkun <yangerkun@huawei.com>
Fixes: 6d390e4b5d48 (locks: fix a potential use-after-free problem when wakeup a waiter)
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cifs/file.c |  3 ++-
 fs/locks.c     | 43 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 7 deletions(-)

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
index 426b55d333d5..e78d37c73df5 100644
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
 
@@ -753,11 +758,32 @@ int locks_delete_block(struct file_lock *waiter)
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
+	 */
+	if (!smp_load_acquire(&waiter->fl_blocker) &&
+	    list_empty(&waiter->fl_blocked_requests))
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
@@ -1350,7 +1376,8 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = posix_lock_inode(inode, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+					list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -1435,7 +1462,8 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 		error = posix_lock_inode(inode, &fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl.fl_wait, !fl.fl_blocker);
+		error = wait_event_interruptible(fl.fl_wait,
+					list_empty(&fl.fl_blocked_member));
 		if (!error) {
 			/*
 			 * If we've been sleeping someone might have
@@ -1638,7 +1666,8 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 
 	locks_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-						!new_fl->fl_blocker, break_time);
+					list_empty(&new_fl->fl_blocked_member),
+					break_time);
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -2122,7 +2151,8 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = flock_lock_inode(inode, fl);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
+		error = wait_event_interruptible(fl->fl_wait,
+				list_empty(&fl->fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -2399,7 +2429,8 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
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


