Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A7AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A067E20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ilhlIq/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgIBQbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:31:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F0FC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=88Vj/Wc6X7MjJr1tlbjOd/wr3LMbx0W4hoJRs4r17rM=; b=ilhlIq/kZOPPyT38R6jlJ7rJ3A
        9iuCnGJB3LsiAD0hDpw2cCUGEpnk2w8wt23fdNfudswwFqdpqmTfPHwfXlsp05bkbt/qi/ebjkaFK
        qD3XkFlC/QpqWLp33qU4i2p2JENJ0uho3yrtLxH8MwAdUWGlSBSR5uGk4fsP56pkZvaPLumz8mjAK
        vyAxHdj22u3OGEi+Ejiogy3rUJAM6hmlClk3IesBu5k/ESFga2c/LeRb7rKlfAwH/IJ8jl8HueSZg
        ttmVpFQehAS8FgrXkiik9ti1X6SU3tixeT0yPXO825g88za5Q8+TSj2iPf2TneTVEgKerRm6I6blq
        sPKPn4ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDVfJ-0006xj-I9; Wed, 02 Sep 2020 16:31:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BBAF3011C6;
        Wed,  2 Sep 2020 18:31:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 639EE2B98F973; Wed,  2 Sep 2020 18:31:15 +0200 (CEST)
Date:   Wed, 2 Sep 2020 18:31:15 +0200
From:   peterz@infradead.org
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH 01/13] x86/entry: Fix AC assertion
Message-ID: <20200902163115.GM1362448@hirez.programming.kicks-ass.net>
References: <20200902132549.496605622@infradead.org>
 <20200902133200.666781610@infradead.org>
 <CAMzpN2i9C5Sj-M0b9Y7VtOphDJs2Z9NPux9Dg347PSeNBaXRMQ@mail.gmail.com>
 <c6915915-1c94-70cf-453d-861a4ca2da4c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6915915-1c94-70cf-453d-861a4ca2da4c@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:24:27PM +0200, Jürgen Groß wrote:
> On 02.09.20 17:58, Brian Gerst wrote:
> > On Wed, Sep 2, 2020 at 9:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
> > > improve user entry sanity checks") unconditionally triggers on my IVB
> > > machine because it does not support SMAP.
> > > 
> > > For !SMAP hardware we patch out CLAC/STAC instructions and thus if
> > > userspace sets AC, we'll still have it set after entry.
> > > 
> > > Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Acked-by: Andy Lutomirski <luto@kernel.org>
> > > ---
> > >   arch/x86/include/asm/entry-common.h |   11 +++++++++--
> > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > --- a/arch/x86/include/asm/entry-common.h
> > > +++ b/arch/x86/include/asm/entry-common.h
> > > @@ -18,8 +18,16 @@ static __always_inline void arch_check_u
> > >                   * state, not the interrupt state as imagined by Xen.
> > >                   */
> > >                  unsigned long flags = native_save_fl();
> > > -               WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> > > -                                     X86_EFLAGS_NT));
> > > +               unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
> > > +
> > > +               /*
> > > +                * For !SMAP hardware we patch out CLAC on entry.
> > > +                */
> > > +               if (boot_cpu_has(X86_FEATURE_SMAP) ||
> > > +                   (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
> > > +                       mask |= X86_EFLAGS_AC;
> > 
> > Is the explicit Xen check necessary?  IIRC the Xen hypervisor will
> > filter out the SMAP bit in the cpuid pvop.
> 
> Right, and this test will nevertheless result in setting AC in the mask.
> IIRC this was the main objective here.

Correct, this asserts that 64bit Xen-PV will never have AC set; it had
better not have it set since it runs in ring 3.
