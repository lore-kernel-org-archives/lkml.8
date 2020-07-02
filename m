Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD33B2068F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593701745;
	bh=nbXe6nJCNrMku6QIpQkPDTVx3nVSr/HZ3tO6LrfZY8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z4DVRj/whRPT9AhSnI6xoxlE7J23KA//XeiiIUGdDm5ZFQzAupOoqZ64XL+j8yGtN
	 ZdBe7WPHodC58OmZo9Qf3nmweey6ZF8P6pGe4/hA5YlMS2s44zTVDZcaRmzZAnskIl
	 09aIu+QJrw7o85lFLj0wZTp+UqZM07+yr8r8M0a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgGBOzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgGBOzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:55:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1105F2075D;
        Thu,  2 Jul 2020 14:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593701741;
        bh=nbXe6nJCNrMku6QIpQkPDTVx3nVSr/HZ3tO6LrfZY8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcEiNPxuhlEyLh2HMXcrpBV1EC5XLsFjtMKSlRSdePnrAVWjczQYEysgptdOEIbNb
         QjfUU6jDXo4nj7OwF7ffPzJvSQ1L4KMCNuYjhVu7foez1h5841jqZdO+/Wfss7iN0Y
         tyFLYFMHbSNeYbjpimnr2GDt6pYflThH5++ITr0w=
Date:   Thu, 2 Jul 2020 15:55:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH 04/18] alpha: Override READ_ONCE() with barriered
 implementation
Message-ID: <20200702145532.GB16999@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-5-will@kernel.org>
 <CAJWu+oqs-d0oDswB2Owyh-4Zo4WXAqKhKU0L=1HEwEfQbc1izw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqs-d0oDswB2Owyh-4Zo4WXAqKhKU0L=1HEwEfQbc1izw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Thu, Jul 02, 2020 at 10:43:55AM -0400, Joel Fernandes wrote:
> On Tue, Jun 30, 2020 at 1:38 PM Will Deacon <will@kernel.org> wrote:
> > diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
> > index 92ec486a4f9e..2ecd068d91d1 100644
> > --- a/arch/alpha/include/asm/barrier.h
> > +++ b/arch/alpha/include/asm/barrier.h
> > - * For example, the following code would force ordering (the initial
> > - * value of "a" is zero, "b" is one, and "p" is "&a"):
> > - *
> > - * <programlisting>
> > - *     CPU 0                           CPU 1
> > - *
> > - *     b = 2;
> > - *     memory_barrier();
> > - *     p = &b;                         q = p;
> > - *                                     read_barrier_depends();
> > - *                                     d = *q;
> > - * </programlisting>
> > - *
> > - * because the read of "*q" depends on the read of "p" and these
> > - * two reads are separated by a read_barrier_depends().  However,
> > - * the following code, with the same initial values for "a" and "b":
> > - *
> 
> Would it be Ok to keep this example in the kernel sources? I think it
> serves as good documentation and highlights the issue in the Alpha
> architecture well.

I'd _really_ like to remove it, as I think it only serves to confuse people
on a topic that is confusing enough already. Paul's perfbook [1] already has
plenty of information about this, so I don't think we need to repeat that
here. I could add a citation, perhaps?

> > - * <programlisting>
> > - *     CPU 0                           CPU 1
> > - *
> > - *     a = 2;
> > - *     memory_barrier();
> > - *     b = 3;                          y = b;
> > - *                                     read_barrier_depends();
> > - *                                     x = a;
> > - * </programlisting>
> > - *
> > - * does not enforce ordering, since there is no data dependency between
> > - * the read of "a" and the read of "b".  Therefore, on some CPUs, such
> > - * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
> > - * in cases like this where there are no data dependencies.
> > - */
> > -#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
> > +#define __smp_load_acquire(p)                                          \
> > +({                                                                     \
> > +       __unqual_scalar_typeof(*p) ___p1 =                              \
> > +               (*(volatile typeof(___p1) *)(p));                       \
> > +       compiletime_assert_atomic_type(*p);                             \
> > +       ___p1;                                                          \
> > +})
> 
> I had the same question as Mark about the need for a memory barrier
> here, otherwise alpha will again break right? Looking forward to the
> future fix you mentioned.

Yeah, sorry about that. It went missing somehow during the rebase, it seems.

> BTW,  do you know any architecture where speculative execution of
> address-dependent loads can cause similar misorderings? That would be
> pretty insane though. In Alpha's case it is not speculation but rather
> the split local cache design as the docs mention.   The reason I ask
> is it is pretty amusing that control-dependent loads do have such
> misordering issues due to speculative branch execution and I wondered
> what other games the CPUs are playing. FWIW I ran into [1] which talks
> about analogy between memory dependence and control dependence.

I think you're asking about value prediction, and the implications it would
have on address-dependent loads where the address can itself be predicted.
I'm not aware of an CPUs where that is observable architecturally.

arm64 has some load instructions that do not honour address dependencies,
but I believe that's mainly to enable alternative cache designs for things
like non-temporal and large vector loads.

Will

[1] https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html
