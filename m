Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3757CC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087BB24655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583791916;
	bh=IhytbqESjkqEv46s87AyhRaJEI5OmblKW1qPStjbZ3g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=L9NgdLYVL1MS9uLYOV+rmLRMersiA7k0vB0KmCZCkecquCDSlN3a5NrUNgQephpNN
	 YxjifuNH4Nr+PMBSme8ztEwvXkoIj2SXaJfR/h5l4/arXUTvyqCvPp9Td4A8tQmrm8
	 lPO7EnMQPAEkqKqeoxKYQQ58BREkWi5puRG0GM/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCIWLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgCIWLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:11:54 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 952F724654;
        Mon,  9 Mar 2020 22:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583791913;
        bh=IhytbqESjkqEv46s87AyhRaJEI5OmblKW1qPStjbZ3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Rf06Ip2bidwHQ/n0DQiB0x7Mg+Kb4JOtTQPT3/kVgoN9UjHHvZBJ7zjg7OW7p0G7T
         u0XxYdSLwUXXLBA7TZtTWzlUtFWfcj9Mpfm9f2qdQilLVuW9ITwVCE2yUM3AQ6oVIZ
         lOSObtbzh4KaUsSVQgtULjr3ScIfSpUGCNkIramc=
Message-ID: <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
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
Date:   Mon, 09 Mar 2020 18:11:51 -0400
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
> As the problem here is a use-after-free due to a race, one option would
> be to use rcu_free() on the file_lock, and hold rcu_read_lock() around
> test/use.
> 
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
> 

Looks good on a cursory check, and I'm inclined to go with this since
it's less fiddly for people to backport.

One other difference to note -- we are holding the fl_wait lock when
calling lm_notify, but I don't think it will matter to any of the
existing lm_notify functions.

If you want to clean up the changelog and resend that would be great.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

