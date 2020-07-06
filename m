Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB624C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20E320722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594053297;
	bh=KGB5xCGGGIp9bGUY4wuMOuO+TBUq2UB1oRA8b9IjLnw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Uw+e6dE07q4KysTd8RvbJCa8FCHeX8jC5EreVd97sWpQbGt7lbJxIlY7zTQfFiCOz
	 YWNs/oVJTI/o6rYHG5GXu/AhPbfJUYeBYOIjoxJ4TWyNfRJAPulEy20wL7s6sOODDh
	 Q/M5taL0H7veVTQrtblVy7QYFCQqEBDigZdeH/JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgGFQe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbgGFQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:34:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7345420702;
        Mon,  6 Jul 2020 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594053295;
        bh=KGB5xCGGGIp9bGUY4wuMOuO+TBUq2UB1oRA8b9IjLnw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CHLWFWDo8o64Xe0c2/fzvbWFaEMk6o22PbdfvrK7GELHs/X5AtEKtnN0BphATdwFR
         bSR78oZCcfnO+2bi4GnxLfEsTymAInrr8QncUPTgymdjH15TLfzhyj1g5NyiQAHmsh
         iJCvy6z1juiNZ95VKkAJqYjJOckCwB9Y2v97+7CI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 592A13521502; Mon,  6 Jul 2020 09:34:55 -0700 (PDT)
Date:   Mon, 6 Jul 2020 09:34:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Turner <mattst88@gmail.com>, kernel-team@android.com,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200706163455.GV9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706160023.GB10992@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:00:23PM +0100, Dave Martin wrote:
> On Thu, Jul 02, 2020 at 08:23:02AM +0100, Will Deacon wrote:
> > On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> > > On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
> > > > When building with LTO, there is an increased risk of the compiler
> > > > converting an address dependency headed by a READ_ONCE() invocation
> > > > into a control dependency and consequently allowing for harmful
> > > > reordering by the CPU.
> > > > 
> > > > Ensure that such transformations are harmless by overriding the generic
> > > > READ_ONCE() definition with one that provides acquire semantics when
> > > > building with LTO.
> > > > 
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > ---
> > > >  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
> > > >  arch/arm64/kernel/vdso/Makefile   |  2 +-
> > > >  arch/arm64/kernel/vdso32/Makefile |  2 +-
> > > >  3 files changed, 65 insertions(+), 2 deletions(-)
> > > >  create mode 100644 arch/arm64/include/asm/rwonce.h
> > > > 
> > > > diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> > > > new file mode 100644
> > > > index 000000000000..515e360b01a1
> > > > --- /dev/null
> > > > +++ b/arch/arm64/include/asm/rwonce.h
> > > > @@ -0,0 +1,63 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Copyright (C) 2020 Google LLC.
> > > > + */
> > > > +#ifndef __ASM_RWONCE_H
> > > > +#define __ASM_RWONCE_H
> > > > +
> > > > +#ifdef CONFIG_CLANG_LTO
> > > 
> > > Don't we have a generic option for LTO that's not specific to Clang.
> > 
> > /me looks at the LTO series some more
> > 
> > Oh yeah, there's CONFIG_LTO which is selected by CONFIG_LTO_CLANG, which is
> > the non-typoed version of the above. I can switch this to CONFIG_LTO.
> > 
> > > Also, can you illustrate code that can only be unsafe with Clang LTO?
> > 
> > I don't have a concrete example, but it's an ongoing concern over on the LTO
> > thread [1], so I cooked this to show one way we could deal with it. The main
> > concern is that the whole-program optimisations enabled by LTO may allow the
> > compiler to enumerate possible values for a pointer at link time and replace
> > an address dependency between two loads with a control dependency instead,
> > defeating the dependency ordering within the CPU.
> 
> Why can't that happen without LTO?

Because without LTO, the compiler cannot see all the pointers all at
the same time due to their being in different translation units.

But yes, if the compiler could see all the pointer values and further
-know- that it was seeing all the pointer values, these optimizations
could happen even without LTO.  But it is quite easy to make sure that
the compiler thinks that there are additional pointer values that it
does not know about.

> > We likely won't realise if/when this goes wrong, other than impossible to
> > debug, subtle breakage that crops up seemingly randomly. Ideally, we'd be
> > able to detect this sort of thing happening at build time, and perhaps
> > even prevent it with compiler options or annotations, but none of that is
> > close to being available and I'm keen to progress the LTO patches in the
> > meantime because they are a requirement for CFI.
> 
> My concern was not so much why LTO makes things dangerous, as why !LTO
> makes things safe...

Because ignorant compilers are safe compilers!  ;-)

							Thanx, Paul
