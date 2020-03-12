Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C81C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C651E206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584016283;
	bh=kzA7pUXBMBrP6Y9bca0MhoL8R7zCc167GLEKQNdzmV8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=dT8x6Ix4O67QFTWJ3jpeq84qKZlfPl0BlTyexXgPW6DvwIhPZm+xnrky1Z1eAjLlb
	 f24TUbCjtVzJr49gfcxAXfmlF1aUr9/5yG3cK69GtL3D9a8Arrd8DmQ78FBmEz9U/v
	 6QEBQTJa+M7BOIdotDKy8cG6RQhQcwtj3DSYfMas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCLMbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLMbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:31:22 -0400
Received: from vulkan (unknown [170.249.165.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 567B8206B1;
        Thu, 12 Mar 2020 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584016281;
        bh=kzA7pUXBMBrP6Y9bca0MhoL8R7zCc167GLEKQNdzmV8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gLDISDiIc0qlRd+xKdxrxDnyZomYXWd3D1bs9Q9ymU1hIpyp5NVrcSITWr9wnuTWe
         2OgdjyVAwxG0WOSeX2hgyp74uAUl0Sv6+IVf98NdjRO7iD38IT1nqgAkOlqJ0wSxiX
         +GNDl8Jruf+lp3YHGSo5o3iR+aXpTAgXHXSd6wvk=
Message-ID: <5e5a109f2a8f64324c114f4f55b7cb7c21a8d8da.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 12 Mar 2020 07:31:18 -0500
In-Reply-To: <87o8t2tc9s.fsf@notabene.neil.brown.name>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 15:42 +1100, NeilBrown wrote:
> On Wed, Mar 11 2020, Linus Torvalds wrote:
> 
> > On Wed, Mar 11, 2020 at 3:22 PM NeilBrown <neilb@suse.de> wrote:
> > > We can combine the two ideas - move the list_del_init() later, and still
> > > protect it with the wq locks.  This avoids holding the lock across the
> > > callback, but provides clear atomicity guarantees.
> > 
> > Ugfh. Honestly, this is disgusting.
> > 
> > Now you re-take the same lock in immediate succession for the
> > non-callback case.  It's just hidden.
> > 
> > And it's not like the list_del_init() _needs_ the lock (it's not
> > currently called with the lock held).
> > 
> > So that "hold the lock over list_del_init()" seems to be horrendously
> > bogus. It's only done as a serialization thing for that optimistic
> > case.
> > 
> > And that optimistic case doesn't even *want* that kind of
> > serialization. It really just wants a "I'm done" flag.
> > 
> > So no. Don't do this. It's mis-using the lock in several ways.
> > 
> >              Linus
> 
> It seems that test_and_set_bit_lock() is the preferred way to handle
> flags when memory ordering is important, and I can't see how to use that
> well with an "I'm done" flag.  I can make it look OK with a "I'm
> detaching" flag.  Maybe this is better.
> 
> NeilBrown
> 
> From f46db25f328ddf37ca9fbd390c6eb5f50c4bd2e6 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Wed, 11 Mar 2020 07:39:04 +1100
> Subject: [PATCH] locks: restore locks_delete_lock optimization
> 
> A recent patch (see Fixes: below) removed an optimization which is
> important as it avoids taking a lock in a common case.
> 
> The comment justifying the optimisation was correct as far as it went,
> in that if the tests succeeded, then the values would remain stable and
> the test result will remain valid even without a lock.
> 
> However after the test succeeds the lock can be freed while some other
> thread might have only just set ->blocker to NULL (thus allowing the
> test to succeed) but has not yet called wake_up() on the wq in the lock.
> If the wake_up happens after the lock is freed, a use-after-free error occurs.
> 
> This patch restores the optimization and adds a flag to ensure this
> use-after-free is avoid.  The use happens only when the flag is set, and
> the free doesn't happen until the flag has been cleared, or we have
> taken blocked_lock_lock.
> 
> Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wakeup a waiter")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/locks.c         | 44 ++++++++++++++++++++++++++++++++++++++------
>  include/linux/fs.h |  3 ++-
>  2 files changed, 40 insertions(+), 7 deletions(-)
> 

Just a note that I'm traveling at the moment, and won't be able do much
other than comment on this for a few days.

> diff --git a/fs/locks.c b/fs/locks.c
> index 426b55d333d5..334473004c6c 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -283,7 +283,7 @@ locks_dump_ctx_list(struct list_head *list, char *list_type)
>  	struct file_lock *fl;
>  
>  	list_for_each_entry(fl, list, fl_list) {
> -		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
> +		pr_warn("%s: fl_owner=%p fl_flags=0x%lx fl_type=0x%x fl_pid=%u\n", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
>  	}
>  }
>  
> @@ -314,7 +314,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
>  	list_for_each_entry(fl, list, fl_list)
>  		if (fl->fl_file == filp)
>  			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
> -				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
> +				" fl_owner=%p fl_flags=0x%lx fl_type=0x%x fl_pid=%u\n",
>  				list_type, MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino,
>  				fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
> @@ -736,10 +736,13 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
>  		waiter = list_first_entry(&blocker->fl_blocked_requests,
>  					  struct file_lock, fl_blocked_member);
>  		__locks_delete_block(waiter);
> -		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
> -			waiter->fl_lmops->lm_notify(waiter);
> -		else
> -			wake_up(&waiter->fl_wait);
> +		if (!test_and_set_bit_lock(FL_DELETING, &waiter->fl_flags)) {
> +			if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
> +				waiter->fl_lmops->lm_notify(waiter);
> +			else
> +				wake_up(&waiter->fl_wait);
> +			clear_bit_unlock(FL_DELETING, &waiter->fl_flags);
> +		}

I *think* this is probably safe.

AIUI, when you use atomic bitops on a flag word like this, you should
use them for all modifications to ensure that your changes don't get
clobbered by another task racing in to do a read/modify/write cycle on
the same word.

I haven't gone over all of the places where fl_flags is changed, but I
don't see any at first glance that do it on a blocked request.

>  	}
>  }
>  
> @@ -753,11 +756,40 @@ int locks_delete_block(struct file_lock *waiter)
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
> +	 *
> +	 * We perform these checks only if we can set FL_DELETING.
> +	 * This ensure that we don't race with __locks_wake_up_blocks()
> +	 * in a way which leads it to call wake_up() *after* we return
> +	 * and the file_lock is freed.
> +	 */
> +	if (!test_and_set_bit_lock(FL_DELETING, &waiter->fl_flags)) {
> +		if (waiter->fl_blocker == NULL &&
> +		    list_empty(&waiter->fl_blocked_requests)) {
> +			/* Already fully unlinked */
> +			clear_bit_unlock(FL_DELETING, &waiter->fl_flags);
> +			return status;
> +		}
> +	}
> +
>  	spin_lock(&blocked_lock_lock);
>  	if (waiter->fl_blocker)
>  		status = 0;
>  	__locks_wake_up_blocks(waiter);
>  	__locks_delete_block(waiter);
> +	/* This flag might not be set and it is largely irrelevant
> +	 * now, but it seem cleaner to clear it.
> +	 */
> +	clear_bit(FL_DELETING, &waiter->fl_flags);
>  	spin_unlock(&blocked_lock_lock);
>  	return status;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..4db514f29bca 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1012,6 +1012,7 @@ static inline struct file *get_file(struct file *f)
>  #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
>  #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
>  #define FL_LAYOUT	2048	/* outstanding pNFS layout */
> +#define FL_DELETING	32768	/* lock is being disconnected */

nit: Why the big gap?

>  
>  #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
>  
> @@ -1087,7 +1088,7 @@ struct file_lock {
>  						 * ->fl_blocker->fl_blocked_requests
>  						 */
>  	fl_owner_t fl_owner;
> -	unsigned int fl_flags;
> +	unsigned long fl_flags;

This will break kABI, so backporting this to enterprise distro kernels
won't be trivial. Not a showstopper, but it might be nice to avoid that
if we can.

While it's not quite as efficient, we could just do the FL_DELETING
manipulation under the flc->flc_lock. That's per-inode, so it should be
safe to do it that way.

>  	unsigned char fl_type;
>  	unsigned int fl_pid;
>  	int fl_link_cpu;		/* what cpu's list is this on? */

