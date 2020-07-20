Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD1C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A6720773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260521;
	bh=CPfkp2QBSP3gKifkBSkUyRSWEi+JHbUnJ+ZB0izj7DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yOYPSBV/k7On3XYnMvRrCEw1I91EbRjPzaYA50ndFy4RyWg2tMvCSbpSPn+JkIqRi
	 pVby09juj99C6PAFbbNWrakdhf/Cam7ts+ROzIPu1/2wU+iWRkh6FRJul6pXUeHnJk
	 YPVUFaif2zOxxj/VPjQrfRzKGRlhW39gZejljoKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgGTPzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731641AbgGTPzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:55:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0960B22BEF;
        Mon, 20 Jul 2020 15:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260508;
        bh=CPfkp2QBSP3gKifkBSkUyRSWEi+JHbUnJ+ZB0izj7DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5D8vvsdPtuyNYv8qE1jt1t3R9hwgKBR8Ede9nALJ4GZh3UC88Nws0YRzwzNNeorI
         I6F07W869uTS3luWta0bx2aHQA6vGJ8h5e5sxVfXxpGZN+kyk/pEq36G0rCjq/iKmZ
         /FYTeONkLgSEhZ5hG4MefWUaAVfzMFvXZKz/EBg0=
Date:   Mon, 20 Jul 2020 16:55:02 +0100
From:   Will Deacon <will@kernel.org>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [PATCH v3 02/19] compiler.h: Split {READ,WRITE}_ONCE definitions
 out into rwonce.h
Message-ID: <20200720155501.GA12064@willie-the-truck>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-3-will@kernel.org>
 <20200713122322.GD72639@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713122322.GD72639@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 08:23:22PM +0800, boqun.feng@gmail.com wrote:
> On Fri, Jul 10, 2020 at 05:51:46PM +0100, Will Deacon wrote:
> > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> > new file mode 100644
> > index 000000000000..92cc2f223cb3
> > --- /dev/null
> > +++ b/include/asm-generic/rwonce.h
> > @@ -0,0 +1,91 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Prevent the compiler from merging or refetching reads or writes. The
> > + * compiler is also forbidden from reordering successive instances of
> > + * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
> > + * particular ordering. One way to make the compiler aware of ordering is to
> > + * put the two invocations of READ_ONCE or WRITE_ONCE in different C
> > + * statements.
> > + *
> > + * These two macros will also work on aggregate data types like structs or
> > + * unions.
> > + *
> > + * Their two major use cases are: (1) Mediating communication between
> > + * process-level code and irq/NMI handlers, all running on the same CPU,
> > + * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
> > + * mutilate accesses that either do not require ordering or that interact
> > + * with an explicit memory barrier or atomic instruction that provides the
> > + * required ordering.
> > + */
> > +#ifndef __ASM_GENERIC_RWONCE_H
> > +#define __ASM_GENERIC_RWONCE_H
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <linux/compiler_types.h>
> > +#include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +
> > +#include <asm/barrier.h>
> > +
> > +/*
> > + * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> > + * atomicity or dependency ordering guarantees. Note that this may result
> > + * in tears!
> > + */
> > +#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
> > +
> > +#define __READ_ONCE_SCALAR(x)						\
> > +({									\
> > +	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
> > +	smp_read_barrier_depends();					\
> > +	(typeof(x))__x;							\
> > +})
> > +
> > +#define READ_ONCE(x)							\
> > +({									\
> > +	compiletime_assert_rwonce_type(x);				\
> 
> Does it make sense if we also move the definition of this compile time
> assertion into rwonce.h too?

Yes, that looks straightforward enough. Thanks for the suggestion!

I'll also try to get this lot into -next this week.

Will
