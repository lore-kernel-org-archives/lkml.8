Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A246206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGGKKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:10:24 -0400
Received: from foss.arm.com ([217.140.110.172]:36564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgGGKKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:10:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87A21C0A;
        Tue,  7 Jul 2020 03:10:22 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4C603F71E;
        Tue,  7 Jul 2020 03:10:19 -0700 (PDT)
Date:   Tue, 7 Jul 2020 11:10:17 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200707101015.GH10992@arm.com>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200706160820.GC10992@arm.com>
 <20200706183510.GA23766@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706183510.GA23766@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 07:35:11PM +0100, Will Deacon wrote:
> On Mon, Jul 06, 2020 at 05:08:20PM +0100, Dave Martin wrote:
> > On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
> > > diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> > > new file mode 100644
> > > index 000000000000..515e360b01a1
> > > --- /dev/null
> > > +++ b/arch/arm64/include/asm/rwonce.h
> > > @@ -0,0 +1,63 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2020 Google LLC.
> > > + */
> > > +#ifndef __ASM_RWONCE_H
> > > +#define __ASM_RWONCE_H
> > > +
> > > +#ifdef CONFIG_CLANG_LTO
> > > +
> > > +#include <linux/compiler_types.h>
> > > +#include <asm/alternative-macros.h>
> > > +
> > > +#ifndef BUILD_VDSO
> > > +
> > > +#ifdef CONFIG_AS_HAS_LDAPR
> > > +#define __LOAD_RCPC(sfx, regs...)					\
> > > +	ALTERNATIVE(							\
> > > +		"ldar"	#sfx "\t" #regs,				\
> > 
> > ^ Should this be here?  It seems that READ_ONCE() will actually read
> > twice... even if that doesn't actually conflict with the required
> > semantics of READ_ONCE(), it looks odd.
> 
> It's patched at runtime, so it's either LDAR or LDAPR.

Agh ignore me, I somehow failed to sport the ALTERNATIVE().

For my understanding -- my background here is a bit shaky -- the LDAPR
gives us load-to-load order even if there is just a control dependency?

If so (possibly dumb question): why can't we just turn this on
unconditionally?  Is there a significant performance impact?

I'm still confused (or ignorant) though.  If both loads are READ_ONCE()
then switching to LDAPR presumably helps, but otherwise, once the
compiler has reduced the address dependency to a control dependency
can't it then go one step further and reverse the order of the loads?
LDAPR wouldn't rescue us from that.

Or does the "memory" clobber in READ_ONCE() fix that for all important
cases?  I can't see this mattering for local variables (where it
definitely won't work), but I wonder whether static variables might not
count as "memory" in some situations.

Discounting ridiculous things like static register variables, I think
the only way for a static variable not to count as memory would be if
there are no writes to it that are reachable from any translation unit
entry point (possibly after dead code removal).  If so, maybe that's
enough.

> > Making a direct link between LTO and the memory model also seems highly
> > spurious (as discussed in the other subthread) so can we have a comment
> > explaining the reasoning?
> 
> Sure, although like I say, this is more about helping to progress that
> conversation.

That's fair enough, but when there is a consensus it would be good to
see it documented in the code _especially_ if we know that the fix won't
address all instances of the problem and in any case works partly by
accident.  That doesn't mean it's not a good practical compromise, but
it could be very confusing to unpick later on.

Cheers
---Dave
