Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4EDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D232070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593688723;
	bh=h84qaL3tEGgL2zFfFCmV5wFzP3FSpcWjx8fMB+KEr/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tkdVN8gzgmEIUKcdo1+j4UxJV4naW25UhX89zls3q7rE5NxRskpr1WQpzAwNIJpsI
	 F41PTanXn/b8KWKytaz+XBZzI5m5pUUzl8G+Tp3Vg8ziu5cKf2U4FpaQTZxgop2rB7
	 8VBJ29LP6Qa48uCx1AFylbJELoMjJkcjO6ZajaP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgGBLSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgGBLSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:18:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F432070C;
        Thu,  2 Jul 2020 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593688719;
        bh=h84qaL3tEGgL2zFfFCmV5wFzP3FSpcWjx8fMB+KEr/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEOri34UXEVBKgcj4rLGB/bJmudCDMyJL+tLvCgKpyoj8RzaK4APPbgu5RGOTP3p5
         5oXOCWMbf39NFuDmH+wlYd4Dc7VUwtHetvygZjh2VEHqUUXg8xiVgAGsUh4qOeP1r9
         KRGIfHHvKVj65yixb+M3JOkgh2dE76YFoeN4R2m4=
Date:   Thu, 2 Jul 2020 12:18:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered
 implementation
Message-ID: <20200702111832.GC16418@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-5-will@kernel.org>
 <20200702093239.GA15391@C02TD0UTHF1T.local>
 <20200702094833.GA16248@willie-the-truck>
 <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a07G1dLC+RUBDkzDbCRCP_gwZAaVK+k1UxvXT+7Kj=o+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:08:41PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 2, 2020 at 11:48 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Jul 02, 2020 at 10:32:39AM +0100, Mark Rutland wrote:
> > > On Tue, Jun 30, 2020 at 06:37:20PM +0100, Will Deacon wrote:
> > > > -#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> > > > +#define __smp_load_acquire(p)                                              \
> > > > +({                                                                 \
> > > > +   __unqual_scalar_typeof(*p) ___p1 =                              \
> > > > +           (*(volatile typeof(___p1) *)(p));                       \
> > > > +   compiletime_assert_atomic_type(*p);                             \
> > > > +   ___p1;                                                          \
> > > > +})
> > >
> > > Sorry if I'm being thick, but doesn't this need a barrier after the
> > > volatile access to provide the acquire semantic?
> > >
> > > IIUC prior to this commit alpha would have used the asm-generic
> > > __smp_load_acquire, i.e.
> > >
> > > | #ifndef __smp_load_acquire
> > > | #define __smp_load_acquire(p)                                           \
> > > | ({                                                                      \
> > > |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
> > > |         compiletime_assert_atomic_type(*p);                             \
> > > |         __smp_mb();                                                     \
> > > |         (typeof(*p))___p1;                                              \
> > > | })
> > > | #endif
> 
> I also have a question that I didn't dare ask when the same
> code came up before (I guess it's also what's in the kernel today):
> 
> With the cast to 'typeof(*p)' at the end, doesn't that mean we
> lose the effect of __unqual_scalar_typeof() again, so any "volatile"
> pointer passed into __READ_ONCE_SCALAR() or
> __smp_load_acquire() still leads to a volatile load of the original
> variable, plus another volatile access to ___p1 after
> spilling it to the stack as a non-volatile variable?

Not sure I follow you here, but I can confirm that what you're worried
about doesn't happen for the usual case of a pointer-to-volatile scalar.

For example, ignoring dependency ordering:

unsigned long foo(volatile unsigned long *p)
{
	return smp_load_acquire(p) + 1;
}

Ends up looking like:

	unsigned long ___p1 = *(const volatile unsigned long *)p;
	smp_mb();
	(volatile unsigned long)___p1;

My understanding is that casting a non-pointer type to volatile doesn't
do anything, so we're good.

On the other hand, you can still cause the stack reload if you use volatile
pointers to volatile:

volatile unsigned long *bar(volatile unsigned long * volatile *ptr)
{
	return READ_ONCE(*ptr);
}

but this is pretty weird code, I think.

Will
