Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C420884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593674591;
	bh=Re61RwD/CyQqWBiQskwnaPfGr1o4kLsu1CWsfLls+hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bC/8WfTBTYksU0+wuHpAbG+pJnEoNrqkBuHd91t8AY1HzsFQwFgva9LSoYY6YM7fT
	 DfBjln6RSvzErRIR9az/KwyTfZnF+OKdCrDRQH25HSQG4lJfos05fbdcDjOUtW19E3
	 FTGrpZ4btl3YDphdbEqxlrmo+FRf8gP3Ipj6ELH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgGBHXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgGBHXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:23:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3D42073E;
        Thu,  2 Jul 2020 07:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593674588;
        bh=Re61RwD/CyQqWBiQskwnaPfGr1o4kLsu1CWsfLls+hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuS2Mmhm+7c/+nST2Wi4JbOT82ZSobqK5KFCdbVqQXwCGLZBy7/LpmgMb7Pq85t1G
         a6m6BrCh5id96wu1KUG0opwCahVKpnhDfkXuSg9AMslVdZ1XMgtrIMFp1PT5EHGsL9
         n0XlU4lEskbMa3Pt2IwRkzphNfPJu+6WmVYkG9DQ=
Date:   Thu, 2 Jul 2020 08:23:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave P Martin <dave.martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
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
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200702072301.GA15963@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 06:07:25PM +0100, Dave P Martin wrote:
> On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
> > When building with LTO, there is an increased risk of the compiler
> > converting an address dependency headed by a READ_ONCE() invocation
> > into a control dependency and consequently allowing for harmful
> > reordering by the CPU.
> > 
> > Ensure that such transformations are harmless by overriding the generic
> > READ_ONCE() definition with one that provides acquire semantics when
> > building with LTO.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/vdso/Makefile   |  2 +-
> >  arch/arm64/kernel/vdso32/Makefile |  2 +-
> >  3 files changed, 65 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/rwonce.h
> > 
> > diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> > new file mode 100644
> > index 000000000000..515e360b01a1
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/rwonce.h
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +#ifndef __ASM_RWONCE_H
> > +#define __ASM_RWONCE_H
> > +
> > +#ifdef CONFIG_CLANG_LTO
> 
> Don't we have a generic option for LTO that's not specific to Clang.

/me looks at the LTO series some more

Oh yeah, there's CONFIG_LTO which is selected by CONFIG_LTO_CLANG, which is
the non-typoed version of the above. I can switch this to CONFIG_LTO.

> Also, can you illustrate code that can only be unsafe with Clang LTO?

I don't have a concrete example, but it's an ongoing concern over on the LTO
thread [1], so I cooked this to show one way we could deal with it. The main
concern is that the whole-program optimisations enabled by LTO may allow the
compiler to enumerate possible values for a pointer at link time and replace
an address dependency between two loads with a control dependency instead,
defeating the dependency ordering within the CPU.

We likely won't realise if/when this goes wrong, other than impossible to
debug, subtle breakage that crops up seemingly randomly. Ideally, we'd be
able to detect this sort of thing happening at build time, and perhaps
even prevent it with compiler options or annotations, but none of that is
close to being available and I'm keen to progress the LTO patches in the
meantime because they are a requirement for CFI.

Will

[1] https://lore.kernel.org/r/20200624203200.78870-1-samitolvanen@google.com
