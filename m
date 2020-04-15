Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38562C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1231220732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586990544;
	bh=x/Cmj27L/W6Nu9Y3NvSBUefO3zm74duKAtTuZeqBSm8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=e+zoZGD1ilgpof1buLUcJNMji1uZRvWREExoTqYeT5sDUofqtU2Gxvuquvim/pEnO
	 tOJgbPImDAjN3J7BEZ8HBI32zLM8Sn7fTw/6X5fKiBfEZCC4SF/XHJT7mxpd2MdHCT
	 35vutpgTpDhFzY4t/JZ2N+iNz5xHOSFt4KVGhtqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbgDOWmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgDOWmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:42:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D9020732;
        Wed, 15 Apr 2020 22:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586990534;
        bh=x/Cmj27L/W6Nu9Y3NvSBUefO3zm74duKAtTuZeqBSm8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n2O6Urzf8bmzJ6u6HmLQ7SpahouIWf9PmMaYlIaa3KBdVery/4IwL7Lo6hqjuqWQQ
         f0gTIsStuzrUnr84dfyS8nKyKXzn5sct4wkLob8ByLZoBK6kY/vkTkjBWaDkXefUey
         NxkzcDSTfWkz5zH4b/jbQ2ejWiL9ZTY5hfWPFFPI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 092E93522AD1; Wed, 15 Apr 2020 15:42:14 -0700 (PDT)
Date:   Wed, 15 Apr 2020 15:42:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
Message-ID: <20200415224213.GA26058@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200406133543.GB19865@paulmck-ThinkPad-P72>
 <67156109-7D79-45B7-8C09-E98D25069928@lca.pw>
 <20200406195146.GI19865@paulmck-ThinkPad-P72>
 <3B06DA7F-DCAF-4566-B72A-F088A8F0B8A9@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B06DA7F-DCAF-4566-B72A-F088A8F0B8A9@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 04:33:27PM -0400, Qian Cai wrote:
> 
> 
> > On Apr 6, 2020, at 3:51 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Mon, Apr 06, 2020 at 09:45:44AM -0400, Qian Cai wrote:
> >> 
> >> 
> >>> On Apr 6, 2020, at 9:35 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> It goes back in in seven days, after -rc1 is released.  The fact that
> >>> it was there last week was a mistake on my part, and I did eventually
> >>> get my hand slapped for it.  ;-)
> >>> 
> >>> In the meantime, if it would help, I could group the KCSAN commits
> >>> on top of those in -tip to allow you to get them with one "git pull"
> >>> command.
> >> 
> >> Testing Linux-next for a week without that commit with KCSAN is a torture, so please do that if that is not much work. Otherwise, I could manually cherry-pick the commit myself after fixing all the offsets.
> > 
> > Just to confirm, you are interested in this -rcu commit, correct?
> > 
> > 2402d0eae589 ("kcsan: Add option for verbose reporting")
> > 
> > This one and the following are directly on top of the KCSAN stack
> > that is in -tip and thus -next:
> > 
> > 48b1fc1 kcsan: Add option to allow watcher interruptions
> > 2402d0e kcsan: Add option for verbose reporting
> > 44656d3 kcsan: Add current->state to implicitly atomic accesses
> > e7b3410 kcsan: Fix a typo in a comment
> > e7325b7 kcsan: Update Documentation/dev-tools/kcsan.rst
> > 1443b8c kcsan: Update API documentation in kcsan-checks.h
> > 
> > These are on top of this -tip commit:
> > 
> > f5d2313bd3c5 ("kcsan, trace: Make KCSAN compatible with tracing")
> > 
> > You can pull them in via the kcsan-dev.2020.03.25a branch if you wish.
> 
> Great! That should be enough food for me to survive for this week.

And I just put it back.  Please accept my apologies for the delay, but
the branching process fought a bit harder than usual.  I probably missed
today's -next, but hopefully tomorrow!

							Thanx, Paul
