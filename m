Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E712DC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63AF2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588788154;
	bh=z92+mQf7UCpY5n67Uv6gibVlbx0OePllFMQQ+ADBjAs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=I7a1EPBlMy8cexIMpoAY77BRwktruwwD4Ag320HH8SbuOCGG6UdZEXzGq2nlAbuRp
	 8JeKd3E8ZwwtV7uvGxNmlxv431/fvFYbUNmn5EQChWZT8/2aSgQQklP86JuzogZI9B
	 axGG9VkcqxWp4GFx9dqgtwaPtapQuMeyI/yxvTZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgEFSCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgEFSCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:02:33 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13FF20753;
        Wed,  6 May 2020 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588788152;
        bh=z92+mQf7UCpY5n67Uv6gibVlbx0OePllFMQQ+ADBjAs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vvPXHot6utJAOBEWMZwD3stj37CKE8NYtkDGePF2p5nCueY8btewNWSfB4NJwjMGO
         C0Sa+xsxR2SQLwgvoGpm5wNZsPf34KxIKH715zS7enj7aYbmnnuFb7TV1z4qoFm/7x
         89qOrLSnJQpiXy3L9jf6vUhzYCm56dFuSIC8Qg4w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BB102352306C; Wed,  6 May 2020 11:02:32 -0700 (PDT)
Date:   Wed, 6 May 2020 11:02:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please can I have a stable KCSAN branch for 5.8?
Message-ID: <20200506180232.GB2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200506132816.GJ8043@willie-the-truck>
 <20200506143616.GY2869@paulmck-ThinkPad-P72>
 <20200506144141.GA12919@willie-the-truck>
 <CANpmjNP3ge49sXJZS-KaL5bpEq0rmc4CqepjGRbtbCVwm7rwpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP3ge49sXJZS-KaL5bpEq0rmc4CqepjGRbtbCVwm7rwpw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:26:56PM +0200, Marco Elver wrote:
> On Wed, 6 May 2020 at 16:41, Will Deacon <will@kernel.org> wrote:
> >
> > Hi Paul,
> >
> > Cheers for the quick reply!
> >
> > On Wed, May 06, 2020 at 07:36:16AM -0700, Paul E. McKenney wrote:
> > > On Wed, May 06, 2020 at 02:28:17PM +0100, Will Deacon wrote:
> > > > I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
> > > > so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
> > > > missing some bits:
> > > >
> > > >   * An update to checkpatch.pl to warn about missing comments for
> > > >     data_race():
> > > >
> > > >     https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com
> > >
> > > For some reason, I thought this was going up some other tree, but I do
> > > not see it in -next.  So unless I hear otherwise, I will pull it into
> > > the v5.8 kcsan branch.
> >
> > Brill, thanks.
> >
> > > >   * I'm unable to apply these two patches from Marco that are needed for
> > > >     my READ_ONCE() work:
> > > >
> > > >     https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/
> > > >
> > > >     I think these depend on stuff that has been queued by Paul, and appears
> > > >     in linux-next, but to be honest with you I'm quite confused about what
> > > >     is queued for 5.8 and what isn't.
> > >
> > > This one is queued, but I currently have it in the v5.9 pile (but
> > > tentatively for v5.8).  Unless Marco tells me otherwise, I will move it
> > > to the v5.8 branch, which will be part of my pull request next week.
> >
> > Great, then this would all show up on tip/locking/kscan, right?
> >
> > > > What's the best base for me to use?
> > >
> > > The -next tree has the latter, but not yet the former.
> >
> > That probably means -next is good enough for me to cook a new version of my
> > series, and then I can make a proper branch next week.
> >
> > > Hopefully we can get this straightened out, and please accept my apologies
> > > for the hassle!
> >
> > No need to apologise, I just couldn't figure out what was what and decided
> > it was easier to ask the experts ;)
> 
> Just confirming that I don't see any issues with the plan -- the
> patches that Will needs are good to go into the v5.8 branch.

OK, I have updated -rcu's kcsan and kcsan-dev branches.  Could you please
double-check, given that pull-request time is quite soon?

							Thanx, Paul
