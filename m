Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EC920823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgEVPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:36:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:44824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730180AbgEVPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:36:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66393B203;
        Fri, 22 May 2020 15:36:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 48B6F1E1270; Fri, 22 May 2020 17:36:15 +0200 (CEST)
Date:   Fri, 22 May 2020 17:36:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Martijn Coenen <maco@android.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: Writeback bug causing writeback stalls
Message-ID: <20200522153615.GF14199@quack2.suse.cz>
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz>
 <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-05-20 17:23:30, Martijn Coenen wrote:
> [ dropped android-storage-core@google.com from CC: since that list
> can't receive emails from outside google.com - sorry about that ]
> 
> Hi Jan,
> 
> On Fri, May 22, 2020 at 4:41 PM Jan Kara <jack@suse.cz> wrote:
> > > The easiest way to fix this, I think, is to call requeue_inode() at the end of
> > > writeback_single_inode(), much like it is called from writeback_sb_inodes().
> > > However, requeue_inode() has the following ominous warning:
> > >
> > > /*
> > >  * Find proper writeback list for the inode depending on its current state and
> > >  * possibly also change of its state while we were doing writeback.  Here we
> > >  * handle things such as livelock prevention or fairness of writeback among
> > >  * inodes. This function can be called only by flusher thread - noone else
> > >  * processes all inodes in writeback lists and requeueing inodes behind flusher
> > >  * thread's back can have unexpected consequences.
> > >  */
> > >
> > > Obviously this is very critical code both from a correctness and a performance
> > > point of view, so I wanted to run this by the maintainers and folks who have
> > > contributed to this code first.
> >
> > Sadly, the fix won't be so easy. The main problem with calling
> > requeue_inode() from writeback_single_inode() is that if there's parallel
> > sync(2) call, inode->i_io_list is used to track all inodes that need writing
> > before sync(2) can complete. So requeueing inodes in parallel while sync(2)
> > runs can result in breaking data integrity guarantees of it.
> 
> Ah, makes sense.
> 
> > But I agree
> > we need to find some mechanism to safely move inode to appropriate dirty
> > list reasonably quickly.
> >
> > Probably I'd add an inode state flag telling that inode is queued for
> > writeback by flush worker and we won't touch dirty lists in that case,
> > otherwise we are safe to update current writeback list as needed. I'll work
> > on fixing this as when I was reading the code I've noticed there are other
> > quirks in the code as well. Thanks for the report!
> 
> Thanks! While looking at the code I also saw some other paths that
> appeared to be racy, though I haven't worked them out in detail to
> confirm that - the locking around the inode and writeback lists is
> tricky. What's the best way to follow up on those? Happy to post them
> to this same thread after I spend a bit more time looking at the code.

Sure, if you are aware some some other problems, just write them to this
thread. FWIW stuff that I've found so far:

1) __I_DIRTY_TIME_EXPIRED setting in move_expired_inodes() can get lost as
there are other places doing RMW modifications of inode->i_state.

2) sync(2) is prone to livelocks as when we queue inodes from b_dirty_time
list, we don't take dirtied_when into account (and that's the only thing
that makes sure aggressive dirtier cannot livelock sync).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
