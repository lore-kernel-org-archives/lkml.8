Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F58C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0BB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583861279;
	bh=etd2RAuoX9TSRMZgA+S2nVEr4Gkcu8K2bN8hk5b+bds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=us3bu5cacJFkbXBLbtZ6ApC4yDELHsNI0t4dsiETdY6UrmsJnvkN18dfVMhAmw4U6
	 CKCS4ifD09WS0SzC0AhB1yS+/KPIWZ1l80MiFOWgQeJ268cIglRSS/qNIy2GP7dJwB
	 q4pakfz2M8AV7/WNbX+6exqJYSnEEKfjBERtB33U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCJR16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJR15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:27:57 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7C221927;
        Tue, 10 Mar 2020 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583861277;
        bh=etd2RAuoX9TSRMZgA+S2nVEr4Gkcu8K2bN8hk5b+bds=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZB5x0FuQ2gdj5DJFXUT11LRtHSdD5LSaeDVhUIMIfctSJJnhJ04uiQTDWES41uE9V
         Is+Jz9XXOND4txKG0HKSdJFfemSyaOV1bXRW+1L2w2dB4PKCRD0FIRA/wXTHwqqNI7
         N5XXZ3w3sxJ1vtr+LacNmLljqb/my3VcSt46r2y8=
Message-ID: <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     yangerkun <yangerkun@huawei.com>, NeilBrown <neilb@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue, 10 Mar 2020 13:27:55 -0400
In-Reply-To: <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
         <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
         <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
         <87blp5urwq.fsf@notabene.neil.brown.name>
         <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
         <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
         <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-10 at 08:52 -0400, Jeff Layton wrote:

[snip]

> On Tue, 2020-03-10 at 11:24 +0800, yangerkun wrote:
> > > 
> > Something others. I think there is no need to call locks_delete_block 
> > for all case in function like flock_lock_inode_wait. What we should do 
> > as the patch '16306a61d3b7 ("fs/locks: always delete_block after 
> > waiting.")' describes is that we need call locks_delete_block not only 
> > for error equal to -ERESTARTSYS(please point out if I am wrong). And 
> > this patch may fix the regression too since simple lock that success or 
> > unlock will not try to acquire blocked_lock_lock.
> > 
> > 
> 
> Nice! This looks like it would work too, and it's a simpler fix.
> 
> I'd be inclined to add a WARN_ON_ONCE(fl->fl_blocker) after the if
> statements to make sure we never exit with one still queued. Also, I
> think we can do a similar optimization in __break_lease.
> 
> There are some other callers of locks_delete_block:
> 
> cifs_posix_lock_set: already only calls it in these cases
> 
> nlmsvc_unlink_block: I think we need to call this in most cases, and
> they're not going to be high-performance codepaths in general
> 
> nfsd4 callback handling: Several calls here, most need to always be
> called. find_blocked_lock could be reworked to take the
> blocked_lock_lock only once (I'll do that in a separate patch).
> 
> How about something like this (
> 
> ----------------------8<---------------------
> 
> From: yangerkun <yangerkun@huawei.com>
> 
> [PATCH] filelock: fix regression in unlock performance
> 
> '6d390e4b5d48 ("locks: fix a potential use-after-free problem when
> wakeup a waiter")' introduces a regression since we will acquire
> blocked_lock_lock every time locks_delete_block is called.
> 
> In many cases we can just avoid calling locks_delete_block at all,
> when we know that the wait was awoken by the condition becoming true.
> Change several callers of locks_delete_block to only call it when
> waking up due to signal or other error condition.
> 
> [ jlayton: add similar optimization to __break_lease, reword changelog,
> 	   add WARN_ON_ONCE calls ]
> 
> Fixes: 16306a61d3b7 ("fs/locks: always delete_block after waiting.")
> Fixes: 6d390e4b5d48 ("locks: fix a potential use-after-free problem when wakeup a waiter")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/locks.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 426b55d333d5..b88a5b11c464 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1354,7 +1354,10 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
>  		if (error)
>  			break;
>  	}
> -	locks_delete_block(fl);
> +	if (error)
> +		locks_delete_block(fl);
> +	WARN_ON_ONCE(fl->fl_blocker);
> +
>  	return error;
>  }
>  
> @@ -1447,7 +1450,9 @@ int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
>  
>  		break;
>  	}
> -	locks_delete_block(&fl);
> +	if (error)
> +		locks_delete_block(&fl);
> +	WARN_ON_ONCE(fl.fl_blocker);
>  
>  	return error;
>  }
> @@ -1638,23 +1643,28 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  
>  	locks_dispose_list(&dispose);
>  	error = wait_event_interruptible_timeout(new_fl->fl_wait,
> -						!new_fl->fl_blocker, break_time);
> +						 !new_fl->fl_blocker,
> +						 break_time);
>  
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
>  	trace_break_lease_unblock(inode, new_fl);
> -	locks_delete_block(new_fl);
>  	if (error >= 0) {
>  		/*
>  		 * Wait for the next conflicting lease that has not been
>  		 * broken yet
>  		 */
> -		if (error == 0)
> +		if (error == 0) {
> +			locks_delete_block(new_fl);
>  			time_out_leases(inode, &dispose);
> +		}
>  		if (any_leases_conflict(inode, new_fl))
>  			goto restart;
>  		error = 0;
> +	} else {
> +		locks_delete_block(new_fl);
>  	}
> +	WARN_ON_ONCE(fl->fl_blocker);
>  out:
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read(&file_rwsem);
> @@ -2126,7 +2136,10 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
>  		if (error)
>  			break;
>  	}
> -	locks_delete_block(fl);
> +	if (error)
> +		locks_delete_block(fl);
> +	WARN_ON_ONCE(fl->fl_blocker);
> +
>  	return error;
>  }
>  
> @@ -2403,7 +2416,9 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
>  		if (error)
>  			break;
>  	}
> -	locks_delete_block(fl);
> +	if (error)
> +		locks_delete_block(fl);
> +	WARN_ON_ONCE(fl->fl_blocker);
>  
>  	return error;
>  }

I've gone ahead and added the above patch to linux-next. Linus, Neil,
are you ok with this one? I think this is probably the simplest
approach.

Assuming so and that this tests out OK, I'll a PR in a few days, after
it has had a bit of soak time in next.

Thanks for the effort everyone! 
-- 
Jeff Layton <jlayton@kernel.org>

