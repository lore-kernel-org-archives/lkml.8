Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A15C54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECB120820
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589218431;
	bh=Ld6u2nKxuEazMixoxWTsfhtvmt3aD0PMzwYEqn6CJss=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bQUVt+mMWdDdU9iF758UN0UR3nO0r2B2AfJCDrfIQT1w8bZB+MI5uJd4k339UfD3v
	 R8tr9mBSdMBDoe23+YxxCqZb6wKzqof6uEu5DxaUVgmh1UEvsS9TedBJTuFEMQcF5w
	 ESwBXCwNkCq5kNxq8ZH/kc+QG2wKqAQPsRQhBhfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgEKRdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730215AbgEKRdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:33:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88FF720720;
        Mon, 11 May 2020 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589218428;
        bh=Ld6u2nKxuEazMixoxWTsfhtvmt3aD0PMzwYEqn6CJss=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mG73zVbtKXMszUw6bgydX3SAhe6duep6quJlk89CI/+Xm4uui6ulk3x0p1k9hh/XK
         xINIg8UyDwXkmNTjQ/P3XK6FHDXZ2Fm1rPUgDKJem0n7GDRW4o58WQOlTn98smyWe/
         m7D4uoPSjMcawu4bN0Sih6wI1ebqXc56D6SMHzJE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6AE44352271C; Mon, 11 May 2020 10:33:48 -0700 (PDT)
Date:   Mon, 11 May 2020 10:33:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, vpillai@digitalocean.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
Message-ID: <20200511173348.GX2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 04:21:02PM +0900, Akira Yokosawa wrote:
> On Sat, 9 May 2020 12:43:30 +0900, Akira Yokosawa wrote:
> > Hi Joel,
> > 
> > Sorry for the late response but I've noticed some glitches.
> >  
> > On Sun, 22 Mar 2020 21:57:32 -0400, Joel Fernandes (Google) wrote:
> >> Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
> >> directory.
> > 
> > MP+onceassign+derefonce.litmus is called out in
> > tools/memory-model/Documentation/recipes.txt as a representative example
> > of RCU related litmus test.
> > 
> > So I think it should be kept under tools/memory-model/litmus-tests.
> > 
> > Further RCU-related litmus tests can be added under Documentation/litmus-tests/.
> > 
> > IIUC, this change is not picked up by tip tree yet. So we have time to respin
> > the series targeting v5.9.
> > 
> >>
> >> More RCU-related litmus tests would be added here.
> >>
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>
> >> ---
> >> Cc: vpillai@digitalocean.com
> >>
> >>  Documentation/litmus-tests/README                        | 9 +++++++++
> > 
> > Please note that later patches to add atomic litmus tests under
> > Documentation/litmus-tests/ by Boqun put README as
> > Documentation/litums-tests/atomic/README.
> > 
> > This patch's location of RCU's README as Documentation/litmus-tests/README
> > looks asymmetric to me.
> > 
> > I'm OK with either merging atomic's README with the top-level one or
> > moving RCU's README to under Documentation/litmus-tests/rcu.
> > 
> > Joel, Boqum, can you sort out the location of README?
> 
> So something like this?
> 
> Patch 1/3 is an independent typo fix in recipes.txt.
> Patch 2/3 reverts the MP+onceassign+derefonce relocation.
> Patch 3/3 merges atomic's README into the top-level one.
> 
> This is relative to -rcu's lkmm branch.
> 
> Thoughts?

Looks plausible to me, and thank you for reviewing this.

Joel, thoughts?

							Thanx, Paul

>         Thanks, Akira
> --
> Akira Yokosawa (3):
>   tools/memory-model: Fix reference to litmus test in recipes.txt
>   Revert "Documentation: LKMM: Move MP+onceassign+derefonce to new
>     litmus-tests/rcu/"
>   Documentation/litmus-tests: Merge atomic's README into top-level one
> 
>  Documentation/litmus-tests/README             | 22 ++++++++++++++++---
>  Documentation/litmus-tests/atomic/README      | 16 --------------
>  tools/memory-model/Documentation/recipes.txt  |  2 +-
>  .../MP+onceassign+derefonce.litmus            |  0
>  tools/memory-model/litmus-tests/README        |  3 +++
>  5 files changed, 23 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/litmus-tests/atomic/README
>  rename {Documentation/litmus-tests/rcu => tools/memory-model/litmus-tests}/MP+onceassign+derefonce.litmus (100%)
> 
> -- 
> 2.17.1
> 
> 
