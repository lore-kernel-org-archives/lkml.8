Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF17C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F9520DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgEVOlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:41:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:41890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgEVOlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:41:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9FE2B1B6;
        Fri, 22 May 2020 14:41:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 89DC71E126B; Fri, 22 May 2020 16:41:00 +0200 (CEST)
Date:   Fri, 22 May 2020 16:41:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Martijn Coenen <maco@android.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        android-storage-core@google.com, kernel-team@android.com
Subject: Re: Writeback bug causing writeback stalls
Message-ID: <20200522144100.GE14199@quack2.suse.cz>
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri 22-05-20 11:57:42, Martijn Coenen wrote:
<snip>

> So, the sequence of events is something like this. Let's assume the inode is
> already on b_dirty_time for valid reasons. Then:
> 
> CPU1                                          CPU2
> fuse_flush()
>   write_inode_now()
>     writeback_single_inode()
>       sets I_SYNC
>         __writeback_single_inode()
>           writes back data
>           clears inode dirty flags
>           unlocks inode
>           calls mark_inode_dirty_sync()
>             sets I_DIRTY_SYNC, but doesn't
>             update wb list because I_SYNC is
>             still set
>                                               write() // somebody else writes
>                                               mark_inode_dirty(I_DIRTY_PAGES)
>                                               sets I_DIRTY_PAGES on i_state
>                                               doesn't update wb list,
>                                               because I_SYNC set
>       locks inode again
>       sees inode is still dirty,
>       doesn't touch WB list
>       clears I_SYNC
> 
> So now we have an inode on b_dirty_time with I_DIRTY_PAGES | I_DIRTY_SYNC set,
> and subsequent calls to mark_inode_dirty() with either I_DIRTY_PAGES or
> I_DIRTY_SYNC will do nothing to change that. The flusher won't touch
> the inode either,
> because it's not on a b_dirty or b_io list.

Thanks for the detailed analysis and explanation! I agree that what you
describe is a bug in the writeback code.

> The easiest way to fix this, I think, is to call requeue_inode() at the end of
> writeback_single_inode(), much like it is called from writeback_sb_inodes().
> However, requeue_inode() has the following ominous warning:
> 
> /*
>  * Find proper writeback list for the inode depending on its current state and
>  * possibly also change of its state while we were doing writeback.  Here we
>  * handle things such as livelock prevention or fairness of writeback among
>  * inodes. This function can be called only by flusher thread - noone else
>  * processes all inodes in writeback lists and requeueing inodes behind flusher
>  * thread's back can have unexpected consequences.
>  */
> 
> Obviously this is very critical code both from a correctness and a performance
> point of view, so I wanted to run this by the maintainers and folks who have
> contributed to this code first.

Sadly, the fix won't be so easy. The main problem with calling
requeue_inode() from writeback_single_inode() is that if there's parallel
sync(2) call, inode->i_io_list is used to track all inodes that need writing
before sync(2) can complete. So requeueing inodes in parallel while sync(2)
runs can result in breaking data integrity guarantees of it. But I agree
we need to find some mechanism to safely move inode to appropriate dirty
list reasonably quickly.

Probably I'd add an inode state flag telling that inode is queued for
writeback by flush worker and we won't touch dirty lists in that case,
otherwise we are safe to update current writeback list as needed. I'll work
on fixing this as when I was reading the code I've noticed there are other
quirks in the code as well. Thanks for the report!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
