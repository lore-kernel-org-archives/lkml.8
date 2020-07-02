Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F58B20884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593683323;
	bh=8To++DcBmhQUuz2eqkOVWHaWbqWUTZ6jhRKebFqKYqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B+yWn40pUqcH0Rt8ETK4phWz/lu0axqT3IHgan98FpfxBqbbVfxvMVWlwldGzkZZs
	 Mf+wzjTzT308IlyAsSV0WvK9LLgxAC55OBdCDuNL9IuQpn3YUhxBgOBx5tLNCtTzZt
	 FoE/3Qazsb3kGos1hOaU9jTapY+HJHAtBEorKlvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGBJsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgGBJsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:48:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E995020874;
        Thu,  2 Jul 2020 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593683320;
        bh=8To++DcBmhQUuz2eqkOVWHaWbqWUTZ6jhRKebFqKYqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvvSqoKuX6EoQp3iR1pOFMS1VuWVSn9bXK/IVDhTQ1Bb8G4k5KaaptoPD6grev0aX
         fNdI68lGWQGkuhsT0oBuiB3hXEx9ZLANBXAgOTDc+ixQmjHmi9pG8qTts8l/Xw1PHx
         R1JOSfYU0SMNZ/OPMRKZNPdqf1Ztg/D9u+MRtgqw=
Date:   Thu, 2 Jul 2020 10:48:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered
 implementation
Message-ID: <20200702094833.GA16248@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-5-will@kernel.org>
 <20200702093239.GA15391@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702093239.GA15391@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:32:39AM +0100, Mark Rutland wrote:
> On Tue, Jun 30, 2020 at 06:37:20PM +0100, Will Deacon wrote:
> > -#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> > +#define __smp_load_acquire(p)						\
> > +({									\
> > +	__unqual_scalar_typeof(*p) ___p1 =				\
> > +		(*(volatile typeof(___p1) *)(p));			\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	___p1;								\
> > +})
> 
> Sorry if I'm being thick, but doesn't this need a barrier after the
> volatile access to provide the acquire semantic?
> 
> IIUC prior to this commit alpha would have used the asm-generic
> __smp_load_acquire, i.e.
> 
> | #ifndef __smp_load_acquire
> | #define __smp_load_acquire(p)                                           \
> | ({                                                                      \
> |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
> |         compiletime_assert_atomic_type(*p);                             \
> |         __smp_mb();                                                     \
> |         (typeof(*p))___p1;                                              \
> | })
> | #endif
> 
> ... where the __smp_mb() would be alpha's mb() from earlier in the patch
> context, i.e.
> 
> | #define mb() __asm__ __volatile__("mb": : :"memory")
> 
> ... so don't we need similar before returning ___p1 above in
> __smp_load_acquire() (and also matching the old read_barrier_depends())?
> 
> [...]
> 
> > +#include <asm/barrier.h>
> > +
> > +/*
> > + * Alpha is apparently daft enough to reorder address-dependent loads
> > + * on some CPU implementations. Knock some common sense into it with
> > + * a memory barrier in READ_ONCE().
> > + */
> > +#define __READ_ONCE(x)	__smp_load_acquire(&(x))
> 
> As above, I don't see a memory barrier implied here, so this doesn't
> look quite right.

You're right, and Peter spotted the same thing off-list. I've reworked
locally so that the mb() ends up in __READ_ONCE() and __smp_load_acquire()
calles __READ_ONCE() instead of the other way round (which made more
sense before the rework in the merge window).

Will
