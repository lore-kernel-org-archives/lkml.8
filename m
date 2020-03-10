Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1AC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9D32071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846952;
	bh=DMKnhKNpJqvPpWyAutFRc5hbUqWncOMjTqysHYlqR4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=ovEktoiZ0H/g6xQoq9HYXsIhD3vFaEvrtZR/odziICv+Q3FBjQXAJEqb13+Mrh1Xd
	 DJxjuUE4nL1Sai4Svz1qFDskL1co+0NkMpPh0F2LM+CzJBrnidEWGgRE2nOQy//MNN
	 j/+t66f7SQ6LiPYxMTzvLBtzIb0WqapNjAtOfM1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgCJN3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgCJMwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:52:13 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DDB2469C;
        Tue, 10 Mar 2020 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844731;
        bh=DMKnhKNpJqvPpWyAutFRc5hbUqWncOMjTqysHYlqR4c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yPg/KtaUzYqOnCj4GlZR0Jp/npMhjrJfdRW3FQR9PPaQa/c1T1zyKbOqwwtwQ8X2d
         Ot8adYzu2aWhi5P0rzxdtGATzJihmGA/gAHlLweJHZs4a+Plm2WAbXur4oE6i/lpG8
         svaseBzX3HEk3fd0qNPLUweVU+NJs5ceWbJs4tHg=
Message-ID: <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     yangerkun <yangerkun@huawei.com>, NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 10 Mar 2020 08:52:09 -0400
In-Reply-To: <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 11:24 +0800, yangerkun wrote:
> On 2020/3/10 6:11, Jeff Layton wrote:
> > On Tue, 2020-03-10 at 08:42 +1100, NeilBrown wrote:
> > > On Mon, Mar 09 2020, Jeff Layton wrote:
> > > 
> > > > On Mon, 2020-03-09 at 13:22 -0400, Jeff Layton wrote:
> > > > > On Mon, 2020-03-09 at 08:52 -0700, Linus Torvalds wrote:
> > > > > > On Mon, Mar 9, 2020 at 7:36 AM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > > On Sun, 2020-03-08 at 22:03 +0800, kernel test robot wrote:
> > > > > > > > FYI, we noticed a -96.6% regression of will-it-scale.per_process_ops due to commit:
> > > > > > > 
> > > > > > > This is not completely unexpected as we're banging on the global
> > > > > > > blocked_lock_lock now for every unlock. This test just thrashes file
> > > > > > > locks and unlocks without doing anything in between, so the workload
> > > > > > > looks pretty artificial [1].
> > > > > > > 
> > > > > > > It would be nice to avoid the global lock in this codepath, but it
> > > > > > > doesn't look simple to do. I'll keep thinking about it, but for now I'm
> > > > > > > inclined to ignore this result unless we see a problem in more realistic
> > > > > > > workloads.
> > > > > > 
> > > > > > That is a _huge_ regression, though.
> > > > > > 
> > > > > > What about something like the attached? Wouldn't that work? And make
> > > > > > the code actually match the old comment about wow "fl_blocker" being
> > > > > > NULL being special.
> > > > > > 
> > > > > > The old code seemed to not know about things like memory ordering either.
> > > > > > 
> > > > > > Patch is entirely untested, but aims to have that "smp_store_release()
> > > > > > means I'm done and not going to touch it any more", making that
> > > > > > smp_load_acquire() test hopefully be valid as per the comment..
> > > > > 
> > > > > Yeah, something along those lines maybe. I don't think we can use
> > > > > fl_blocker that way though, as the wait_event_interruptible is waiting
> > > > > on it to go to NULL, and the wake_up happens before fl_blocker is
> > > > > cleared.
> > > > > 
> > > > > Maybe we need to mix in some sort of FL_BLOCK_ACTIVE flag and use that
> > > > > instead of testing for !fl_blocker to see whether we can avoid the
> > > > > blocked_lock_lock?
> > > > >    
> > > > 
> > > > How about something like this instead? (untested other than for
> > > > compilation)
> > > > 
> > > > Basically, this just switches the waiters over to wait for
> > > > fl_blocked_member to go empty. That still happens before the wakeup, so
> > > > it should be ok to wait on that.
> > > > 
> > > > I think we can also eliminate the lockless list_empty check in
> > > > locks_delete_block, as the fl_blocker check should be sufficient now.
> > > > -- 
> > > > Jeff Layton <jlayton@kernel.org>
> > > >  From c179d779c9b72838ed9996a65d686d86679d1639 Mon Sep 17 00:00:00 2001
> > > > From: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Date: Mon, 9 Mar 2020 14:35:43 -0400
> > > > Subject: [PATCH] locks: reinstate locks_delete_lock optimization
> > > > 
> > > > ...by using smp_load_acquire and smp_store_release to close the race
> > > > window.
> > > > 
> > > > [ jlayton: wait on the fl_blocked_requests list to go empty instead of
> > > > 	   the fl_blocker pointer to clear. Remove the list_empty check
> > > > 	   from locks_delete_lock shortcut. ]
> > > 
> > > Why do you think it is OK to remove that list_empty check?  I don't
> > > think it is.  There might be locked requests that need to be woken up.
> > > 
> > > As the problem here is a use-after-free due to a race, one option would
> > > be to use rcu_free() on the file_lock, and hold rcu_read_lock() around
> > > test/use.
> > > 
> > > Another option is to use a different lock.  The fl_wait contains a
> > > spinlock, and we have wake_up_locked() which is provided for exactly
> > > these sorts of situations where the wake_up call can race with a thread
> > > waking up.
> > > 
> > > So my compile-tested-only proposal is below.
> > > I can probably a proper change-log entry if you think the patch is a
> > > good way to go.
> > > 
> > > NeilBrown
> > > 
> > > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 426b55d333d5..8aa04d5ac8b3 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -735,11 +735,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
> > >   
> > >   		waiter = list_first_entry(&blocker->fl_blocked_requests,
> > >   					  struct file_lock, fl_blocked_member);
> > > +		spin_lock(&waiter->fl_wait.lock);
> > >   		__locks_delete_block(waiter);
> > >   		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
> > >   			waiter->fl_lmops->lm_notify(waiter);
> > >   		else
> > > -			wake_up(&waiter->fl_wait);
> > > +			wake_up_locked(&waiter->fl_wait);
> > > +		spin_unlock(&waiter->fl_wait.lock);
> > >   	}
> > >   }
> > >   
> > > @@ -753,6 +755,31 @@ int locks_delete_block(struct file_lock *waiter)
> > >   {
> > >   	int status = -ENOENT;
> > >   
> > > +	/*
> > > +	 * If fl_blocker is NULL, it won't be set again as this thread
> > > +	 * "owns" the lock and is the only one that might try to claim
> > > +	 * the lock.  So it is safe to test fl_blocker locklessly.
> > > +	 * Also if fl_blocker is NULL, this waiter is not listed on
> > > +	 * fl_blocked_requests for some lock, so no other request can
> > > +	 * be added to the list of fl_blocked_requests for this
> > > +	 * request.  So if fl_blocker is NULL, it is safe to
> > > +	 * locklessly check if fl_blocked_requests is empty.  If both
> > > +	 * of these checks succeed, there is no need to take the lock.
> > > +	 * However, some other thread might have only *just* set
> > > +	 * fl_blocker to NULL and it about to send a wakeup on
> > > +	 * fl_wait, so we mustn't return too soon or we might free waiter
> > > +	 * before that wakeup can be sent.  So take the fl_wait.lock
> > > +	 * to serialize with the wakeup in __locks_wake_up_blocks().
> > > +	 */
> > > +	if (waiter->fl_blocker == NULL) {
> > > +		spin_lock(&waiter->fl_wait.lock);
> > > +		if (waiter->fl_blocker == NULL &&
> > > +		    list_empty(&waiter->fl_blocked_requests)) {
> > > +			spin_unlock(&waiter->fl_wait.lock);
> > > +			return status;
> > > +		}
> > > +		spin_unlock(&waiter->fl_wait.lock);
> > > +	}
> > >   	spin_lock(&blocked_lock_lock);
> > >   	if (waiter->fl_blocker)
> > >   		status = 0;
> > > 
> > 
> > Looks good on a cursory check, and I'm inclined to go with this since
> > it's less fiddly for people to backport.
> > 
> > One other difference to note -- we are holding the fl_wait lock when
> > calling lm_notify, but I don't think it will matter to any of the
> > existing lm_notify functions.
> > 
> > If you want to clean up the changelog and resend that would be great.
> > 
> > Thanks,
> > 
> Something others. I think there is no need to call locks_delete_block 
> for all case in function like flock_lock_inode_wait. What we should do 
> as the patch '16306a61d3b7 ("fs/locks: always delete_block after 
> waiting.")' describes is that we need call locks_delete_block not only 
> for error equal to -ERESTARTSYS(please point out if I am wrong). And 
> this patch may fix the regression too since simple lock that success or 
> unlock will not try to acquire blocked_lock_lock.
> 
> 

Nice! This looks like it would work too, and it's a simpler fix.

I'd be inclined to add a WARN_ON_ONCE(fl->fl_blocker) after the if
statements to make sure we never exit with one still queued. Also, I
think we can do a similar optimization in __break_lease.

There are some other callers of locks_delete_block:

cifs_posix_lock_set: already only calls it in these cases

nlmsvc_unlink_block: I think we need to call this in most cases, and
they're not going to be high-performance codepaths in general

nfsd4 callback handling: Several calls here, most need to always be
called. find_blocked_lock could be reworked to take the
blocked_lock_lock only once (I'll do that in a separate patch).

How about something like this (

----------------------8<---------------------

From: yangerkun <yangerkun@huawei.com>

[PATCH] filelock: fix regression in unlock performance

'6d390e4b5d48 ("locks: fix a potential use-after-free problem when
wakeup a waiter")' introduces a regression since we will acquire
blocked_lock_lock every time locks_delete_block is called.

In many cases we can just avoid calling locks_delete_block at all,
when we know that the wait was awoken by the condition becoming true.
Change several callers of locks_delete_block to only call it when
waking up due to signal or other error condition.

[ jlayton: add similar optimization to __break_lease, reword changelog,
	   add WARN_ON_ONCE calls ]

Fixes: 16306a61d3b7 ("fs/locks: always delete_block after waiting.")
Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wakeup a waiter")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 426b55d333d5..b88a5b11c464 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1354,7 +1354,10 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		if (error)
 			break;
 	}
-	locks_delete_block(fl);
+	if (error)
+		locks_delete_block(fl);
+	WARN_ON_ONCE(fl->fl_blocker);
+
 	return error;
 }
 
@@ -1447,7 +1450,9 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
 
 		break;
 	}
-	locks_delete_block(&fl);
+	if (error)
+		locks_delete_block(&fl);
+	WARN_ON_ONCE(fl.fl_blocker);
 
 	return error;
 }
@@ -1638,23 +1643,28 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 
 	locks_dispose_list(&dispose);
 	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-						!new_fl->fl_blocker, break_time);
+						 !new_fl->fl_blocker,
+						 break_time);
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	trace_break_lease_unblock(inode, new_fl);
-	locks_delete_block(new_fl);
 	if (error >= 0) {
 		/*
 		 * Wait for the next conflicting lease that has not been
 		 * broken yet
 		 */
-		if (error == 0)
+		if (error == 0) {
+			locks_delete_block(new_fl);
 			time_out_leases(inode, &dispose);
+		}
 		if (any_leases_conflict(inode, new_fl))
 			goto restart;
 		error = 0;
+	} else {
+		locks_delete_block(new_fl);
 	}
+	WARN_ON_ONCE(fl->fl_blocker);
 out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
@@ -2126,7 +2136,10 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		if (error)
 			break;
 	}
-	locks_delete_block(fl);
+	if (error)
+		locks_delete_block(fl);
+	WARN_ON_ONCE(fl->fl_blocker);
+
 	return error;
 }
 
@@ -2403,7 +2416,9 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		if (error)
 			break;
 	}
-	locks_delete_block(fl);
+	if (error)
+		locks_delete_block(fl);
+	WARN_ON_ONCE(fl->fl_blocker);
 
 	return error;
 }
-- 
2.24.1


