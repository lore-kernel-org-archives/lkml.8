Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13549C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70A7206DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgGFQAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:00:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgGFQA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:00:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659CB1FB;
        Mon,  6 Jul 2020 09:00:28 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A61A23F68F;
        Mon,  6 Jul 2020 09:00:25 -0700 (PDT)
Date:   Mon, 6 Jul 2020 17:00:23 +0100
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
Message-ID: <20200706160023.GB10992@arm.com>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702072301.GA15963@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:23:02AM +0100, Will Deacon wrote:
> On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> > On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
> > > When building with LTO, there is an increased risk of the compiler
> > > converting an address dependency headed by a READ_ONCE() invocation
> > > into a control dependency and consequently allowing for harmful
> > > reordering by the CPU.
> > > 
> > > Ensure that such transformations are harmless by overriding the generic
> > > READ_ONCE() definition with one that provides acquire semantics when
> > > building with LTO.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
> > >  arch/arm64/kernel/vdso/Makefile   |  2 +-
> > >  arch/arm64/kernel/vdso32/Makefile |  2 +-
> > >  3 files changed, 65 insertions(+), 2 deletions(-)
> > >  create mode 100644 arch/arm64/include/asm/rwonce.h
> > > 
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
> > 
> > Don't we have a generic option for LTO that's not specific to Clang.
> 
> /me looks at the LTO series some more
> 
> Oh yeah, there's CONFIG_LTO which is selected by CONFIG_LTO_CLANG, which is
> the non-typoed version of the above. I can switch this to CONFIG_LTO.
> 
> > Also, can you illustrate code that can only be unsafe with Clang LTO?
> 
> I don't have a concrete example, but it's an ongoing concern over on the LTO
> thread [1], so I cooked this to show one way we could deal with it. The main
> concern is that the whole-program optimisations enabled by LTO may allow the
> compiler to enumerate possible values for a pointer at link time and replace
> an address dependency between two loads with a control dependency instead,
> defeating the dependency ordering within the CPU.

Why can't that happen without LTO?

> We likely won't realise if/when this goes wrong, other than impossible to
> debug, subtle breakage that crops up seemingly randomly. Ideally, we'd be
> able to detect this sort of thing happening at build time, and perhaps
> even prevent it with compiler options or annotations, but none of that is
> close to being available and I'm keen to progress the LTO patches in the
> meantime because they are a requirement for CFI.

My concern was not so much why LTO makes things dangerous, as why !LTO
makes things safe...

Cheers
---Dave
