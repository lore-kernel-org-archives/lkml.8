Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E982C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9A6215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583774551;
	bh=1cu4d+oO7XWpJIvbZCH3HtArOArgUHyZxzWlPouuQ1Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=SgsKJxv8hbhN6i8YSLfuH+4Qli+0tKfZbKDc3g+95lG/WL4Syj46pGKa1JLzivvXm
	 szxi2MHvq1MW7NMwRPuGeUSCKePwpdcEx3hqn+JyO7X/Om761NUHnAX8PScUYPD8WY
	 scjnm4+3PRlGS9iNSTseV5MnD2eFdL95e3HxoFGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCIRWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCIRWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:22:30 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE55208C3;
        Mon,  9 Mar 2020 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583774550;
        bh=1cu4d+oO7XWpJIvbZCH3HtArOArgUHyZxzWlPouuQ1Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=saf4rYJy6tRsbQfoEujMGfmyBgkiMEgICumgmP5NzqCJGbXcXHXn+CJPp4Wio+lvR
         KpOaAlBhlhUgq+nNioXedK640RclUAE2whsPldklde+E+6i0p5sEF8fOQ39LK95QX0
         oRXxcYUTLz6qH+OiNSPi4I7AzjIe6AJDmTEDz/8E=
Message-ID: <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        yangerkun <yangerkun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Neil Brown <neilb@suse.de>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 09 Mar 2020 13:22:28 -0400
In-Reply-To: <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
References: <20200308140314.GQ5972@shao2-debian>
         <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
         <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 08:52 -0700, Linus Torvalds wrote:
> On Mon, Mar 9, 2020 at 7:36 AM Jeff Layton <jlayton@kernel.org> wrote:
> > On Sun, 2020-03-08 at 22:03 +0800, kernel test robot wrote:
> > > FYI, we noticed a -96.6% regression of will-it-scale.per_process_ops due to commit:
> > 
> > This is not completely unexpected as we're banging on the global
> > blocked_lock_lock now for every unlock. This test just thrashes file
> > locks and unlocks without doing anything in between, so the workload
> > looks pretty artificial [1].
> > 
> > It would be nice to avoid the global lock in this codepath, but it
> > doesn't look simple to do. I'll keep thinking about it, but for now I'm
> > inclined to ignore this result unless we see a problem in more realistic
> > workloads.
> 
> That is a _huge_ regression, though.
> 
> What about something like the attached? Wouldn't that work? And make
> the code actually match the old comment about wow "fl_blocker" being
> NULL being special.
> 
> The old code seemed to not know about things like memory ordering either.
> 
> Patch is entirely untested, but aims to have that "smp_store_release()
> means I'm done and not going to touch it any more", making that
> smp_load_acquire() test hopefully be valid as per the comment..

Yeah, something along those lines maybe. I don't think we can use
fl_blocker that way though, as the wait_event_interruptible is waiting
on it to go to NULL, and the wake_up happens before fl_blocker is
cleared.

Maybe we need to mix in some sort of FL_BLOCK_ACTIVE flag and use that
instead of testing for !fl_blocker to see whether we can avoid the
blocked_lock_lock?
  
-- 
Jeff Layton <jlayton@kernel.org>

