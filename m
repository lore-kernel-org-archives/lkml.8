Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C27206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594064562;
	bh=gq8OONsZv2DL9Wl2RlB9KVkvm70QuCx2mh8QqqjtMbI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=h7WrGSLdia49UzWHq6ZwAoqvVSZBBmdzjyZaOg0NbCBrFriB0CVo2TP/BIVWbt0Zy
	 YyayVAMq8V+9GFfYGIVH7J1WdxnxsDJi+gp6UUqrkFN+RoAy1zS5x7qSKnSmbenoSo
	 9WpfHAoaKM/yDdojFIixSrKmnPzXbKsc04eWpO08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGFTml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgGFTmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:42:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E08120675;
        Mon,  6 Jul 2020 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594064557;
        bh=gq8OONsZv2DL9Wl2RlB9KVkvm70QuCx2mh8QqqjtMbI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lh3vxVKBCu2a1xT47mTYziII5iB0/8GAkDAt71DAfoKVDSx6FVqCJSq59QVsEGSnP
         Q60Pvq90qvfChKmNKQJkCuTpUGESomfnWfhOoPesvmXeSdfBqBsiWX1GemxQCisw41
         x0SD+lBBhKrCWfQ4CGoMu0RtilR1klMo8qmHvImM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 181CE3522637; Mon,  6 Jul 2020 12:42:37 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:42:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Turner <mattst88@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Kees Cook <keescook@chromium.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200706194237.GF9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
 <20200706183542.GB23766@willie-the-truck>
 <CANpmjNP9pb4_2S8sf+Ty2ZqtMxWSrBEosDx2wuL2OQnA9YFt9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP9pb4_2S8sf+Ty2ZqtMxWSrBEosDx2wuL2OQnA9YFt9A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:23:26PM +0200, Marco Elver wrote:
> On Mon, 6 Jul 2020 at 20:35, Will Deacon <will@kernel.org> wrote:
> > On Mon, Jul 06, 2020 at 05:00:23PM +0100, Dave Martin wrote:
> > > On Thu, Jul 02, 2020 at 08:23:02AM +0100, Will Deacon wrote:
> > > > On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> > > > > Also, can you illustrate code that can only be unsafe with Clang LTO?
> > > >
> > > > I don't have a concrete example, but it's an ongoing concern over on the LTO
> > > > thread [1], so I cooked this to show one way we could deal with it. The main
> > > > concern is that the whole-program optimisations enabled by LTO may allow the
> > > > compiler to enumerate possible values for a pointer at link time and replace
> > > > an address dependency between two loads with a control dependency instead,
> > > > defeating the dependency ordering within the CPU.
> > >
> > > Why can't that happen without LTO?
> >
> > It could, but I'd argue that it's considerably less likely because there
> > is less information available to the compiler to perform these sorts of
> > optimisations. It also doesn't appear to be happening in practice.
> >
> > The current state of affairs is that, if/when we catch the compiler
> > performing harmful optimistations, we look for a way to disable them.
> > However, there are good reasons to enable LTO, so this is one way to
> > do that without having to worry about the potential impact on dependency
> > ordering.
> 
> If it's of any help, I'll see if we can implement that warning in LLVM
> if data dependencies somehow disappear (although I don't have any
> cycles to pursue right now myself). Until then, short of manual
> inspection or encountering a bug in the wild, there is no proof any of
> this happens or doesn't happen.
> 
> Also, as some anecdotal evidence it's extremely unlikely, even with
> LTO: looking at the passes that LLVM runs, there are a number of
> passes that seem to want to eliminate basic blocks, thereby getting
> rid of branches. Intuitively, it makes sense, because branches are
> expensive on most architectures (for GPU targets, I think it tries
> even harder to get rid of branches). If we extend our reasoning and
> assumptions of LTO's aggressiveness in that direction, we might
> actually end up with fewer branches. That might be beneficial for the
> data dependencies we worry about (but not so much for control
> dependencies we want to keep). Still, no point in speculating (no pun
> intended) until we have hard data what actually happens. :-)

Anything along these lines would be very welcome!!!

							Thanx, Paul
