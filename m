Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A71C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3E220679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbgCPShf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:37:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbgCPShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:37:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDua6-00CwUo-Nf; Mon, 16 Mar 2020 18:35:18 +0000
Date:   Mon, 16 Mar 2020 18:35:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ling Ma <ling.ma.program@gmail.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, "ling.ma" <ling.ml@antfin.com>
Subject: Re: [RFC PATCH] locks:Remove spinlock in unshare_files
Message-ID: <20200316183518.GZ23230@ZenIV.linux.org.uk>
References: <20200313031017.71090-1-ling.ma.program@gmail.com>
 <CAOGi=dNniSgkUtJPfaYLAbR+_8DMFdU59mx7hf8Otj_VjDF_dQ@mail.gmail.com>
 <20200316133916.GD12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316133916.GD12561@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:39:16PM +0100, Peter Zijlstra wrote:

> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 60a1295..fe54600 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -3041,9 +3041,7 @@ int unshare_files(struct files_struct **displaced)
> > >                 return error;
> > >         }
> > >         *displaced = task->files;
> > > -       task_lock(task);
> > > -       task->files = copy;
> > > -       task_unlock(task);
> > > +       WRITE_ONCE(task->files, copy);
> > >         return 0;
> > >  }
> 
> AFAICT this is completely and utterly buggered.
> 
> IFF task->files was lockless, like say RCU, then you'd still need
> smp_store_release(). But if we look at fs/file.c then everything uses
> task_lock() and removing it like the above is actively broken.

The problem is not fs/file.c; it's the code that does (read-only)
access to *other* threads' ->files.  procfs, SAK, some cgroup
shite (pardon the redundancy)...  All of those rely upon task_lock.

FWIW, having just grepped around, I'm worried about the crap io_uring
is pulling off - interplay with unshare(2) could be unpleasant.

In any case - task_lock in the code that assigns to ->files (and it's
not just unshare_files()) serves to protect the 3rd-party readers
(including get_files_struct()) from having the fucker taken apart
under them.  It's not just freeing the thing - it's the entire
close_files().

And no, we do *NOT* want to convert everything to get_files_struct() +
being clever in it.  I would rather have get_files_struct() taken
out and shot, TBH - the only real reason it hadn't been killed years
ago is the loop in proc_readfd_common()...

I'd prefer to have 3rd-party readers indicate their interest
in a way that would be distinguishable from normal references,
with close_files() waiting until all of those are gone.  One way
to do that would be
	* secondary counter in files_struct
	* rcu-delayed freeing of actual structure (not a problem)
	* rcu_read_lock in 3rd-party readers (among other things
it means that proc_readfd_common() would need to be rearchitected
a bit)
	* close_files() starting with subtraction of large constant
from the secondary counter and then spinning until it gets to
-<large constant>
	* 3rd-party readers (under rcu_read_lock()) fetching task->files,
bumping the secondary counter unless it's negative, doing their thing,
then decrementing the counter.
