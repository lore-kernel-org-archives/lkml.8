Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E365C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042A72082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588865534;
	bh=N4GrJ9YX80OAEZM/hWltOvL4lJILT88lZn6Mre7anRE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=S45++wzIhkkaWeCSZSRF83ee+5XoKjJxwhC/cjVDS8o2Lub5bw+QuHGQJIg9KGJ5i
	 Zy9Acbkw6bArMKRHChsgUne5M+Y+qXpf6+MT/glSHcGh9QoXZT3e/g/t4XnB9W5xX7
	 f2qYuUgg7Hae2A77AP9LoMjh8I7pS5zINLZFGOK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgEGPcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgEGPcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:32:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2219B207DD;
        Thu,  7 May 2020 15:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588865532;
        bh=N4GrJ9YX80OAEZM/hWltOvL4lJILT88lZn6Mre7anRE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ShPKmuGr9Ge6yjH2LGTLNkErUqmHhTUIUPoR1fEDdPr9ap0syIjlcYf5VvxBYsr5i
         +elDlnpto0/zWJZvFys//sBuUkdPX3lydIbW78IAlLwNDPRy8yqhf0wMT5VjSrqmJs
         UH/aicaaZxs52/uh9rXlg8Y8gvjvHcEWpOa61fis=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05726352319D; Thu,  7 May 2020 08:32:12 -0700 (PDT)
Date:   Thu, 7 May 2020 08:32:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please can I have a stable KCSAN branch for 5.8?
Message-ID: <20200507153211.GL2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200506132816.GJ8043@willie-the-truck>
 <20200506143616.GY2869@paulmck-ThinkPad-P72>
 <20200506144141.GA12919@willie-the-truck>
 <CANpmjNP3ge49sXJZS-KaL5bpEq0rmc4CqepjGRbtbCVwm7rwpw@mail.gmail.com>
 <20200506180232.GB2869@paulmck-ThinkPad-P72>
 <CANpmjNP1v8wORd_nfQb7hVH2EY5P565uJYsRFt0dXi4KZvQ46A@mail.gmail.com>
 <20200506193713.GG2869@paulmck-ThinkPad-P72>
 <20200506214727.GA27039@paulmck-ThinkPad-P72>
 <CANpmjNObCdQ-QnawW+gz5aAwM7AVSgRe4yptyavyQGG20bp5-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNObCdQ-QnawW+gz5aAwM7AVSgRe4yptyavyQGG20bp5-Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:34:55AM +0200, Marco Elver wrote:
> On Wed, 6 May 2020 at 23:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, May 06, 2020 at 12:37:13PM -0700, Paul E. McKenney wrote:
> > > On Wed, May 06, 2020 at 09:11:23PM +0200, Marco Elver wrote:
> > > > On Wed, 6 May 2020 at 20:02, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Wed, May 06, 2020 at 05:26:56PM +0200, Marco Elver wrote:
> > > > > > On Wed, 6 May 2020 at 16:41, Will Deacon <will@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi Paul,
> > > > > > >
> > > > > > > Cheers for the quick reply!
> > > > > > >
> > > > > > > On Wed, May 06, 2020 at 07:36:16AM -0700, Paul E. McKenney wrote:
> > > > > > > > On Wed, May 06, 2020 at 02:28:17PM +0100, Will Deacon wrote:
> > > > > > > > > I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
> > > > > > > > > so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
> > > > > > > > > missing some bits:
> > > > > > > > >
> > > > > > > > >   * An update to checkpatch.pl to warn about missing comments for
> > > > > > > > >     data_race():
> > > > > > > > >
> > > > > > > > >     https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com
> > > > > > > >
> > > > > > > > For some reason, I thought this was going up some other tree, but I do
> > > > > > > > not see it in -next.  So unless I hear otherwise, I will pull it into
> > > > > > > > the v5.8 kcsan branch.
> > > > > > >
> > > > > > > Brill, thanks.
> > > > > > >
> > > > > > > > >   * I'm unable to apply these two patches from Marco that are needed for
> > > > > > > > >     my READ_ONCE() work:
> > > > > > > > >
> > > > > > > > >     https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/
> > > > > > > > >
> > > > > > > > >     I think these depend on stuff that has been queued by Paul, and appears
> > > > > > > > >     in linux-next, but to be honest with you I'm quite confused about what
> > > > > > > > >     is queued for 5.8 and what isn't.
> > > > > > > >
> > > > > > > > This one is queued, but I currently have it in the v5.9 pile (but
> > > > > > > > tentatively for v5.8).  Unless Marco tells me otherwise, I will move it
> > > > > > > > to the v5.8 branch, which will be part of my pull request next week.
> > > > > > >
> > > > > > > Great, then this would all show up on tip/locking/kscan, right?
> > > > > > >
> > > > > > > > > What's the best base for me to use?
> > > > > > > >
> > > > > > > > The -next tree has the latter, but not yet the former.
> > > > > > >
> > > > > > > That probably means -next is good enough for me to cook a new version of my
> > > > > > > series, and then I can make a proper branch next week.
> > > > > > >
> > > > > > > > Hopefully we can get this straightened out, and please accept my apologies
> > > > > > > > for the hassle!
> > > > > > >
> > > > > > > No need to apologise, I just couldn't figure out what was what and decided
> > > > > > > it was easier to ask the experts ;)
> > > > > >
> > > > > > Just confirming that I don't see any issues with the plan -- the
> > > > > > patches that Will needs are good to go into the v5.8 branch.
> > > > >
> > > > > OK, I have updated -rcu's kcsan and kcsan-dev branches.  Could you please
> > > > > double-check, given that pull-request time is quite soon?
> > > >
> > > > I believe "objtool, kcsan: Add kcsan_disable_current() and
> > > > kcsan_enable_current_nowarn()" is missing, which should go after
> > > > "kcsan: Add __kcsan_{enable,disable}_current() variants".
> > >
> > > Thank you for checking!  I will move that one also.
> >
> > And it is moved.  FYI, I will likely be sending my KCSAN pull request
> > late tomorrow (Thursday) Pacific Time, a few days earlier than normal.
> 
> Looks good, thank you!

And it did pass overnight testing, so looking good!  Next step is a
quick test without KCSAN enabled.

							Thanx, Paul
