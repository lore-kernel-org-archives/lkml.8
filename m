Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597AFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FF420738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591201792;
	bh=V4v/+8+lWFZ7CMLSbJU7qQu/syYSwbhiswQCZEP0HRw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SkeJZ8ocqhtStXvkSpypLpF7Vz3kk65pmbJVWl2oH7O+7DYbAa96VhDIeSu88L3t2
	 3wOSaLubWUTdISVdVCILVAu2WYs4/h4ApKYSi98WMo+T31cNkM1GVQenMpZou0vmZR
	 5qanb8XGuVlOBpBhnjD2o8L3rsOavttMjPhhmCVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgFCQ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgFCQ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:29:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70CF20659;
        Wed,  3 Jun 2020 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591201789;
        bh=V4v/+8+lWFZ7CMLSbJU7qQu/syYSwbhiswQCZEP0HRw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TSOOj/h7G6v0j9acb9wGJ63VjpgRYjwsIJP6XEeL1QEAka5A0dvCOvM1ND0SHRe4A
         irgsSygznKpoECopGUkXYJv3wcQERN2e1kVfNTX/PsO0uNeHrHt/B2gHKRiVYsDErj
         JcUty3CcVHN7DXSxW83KIMaWgPyRRu0SrksS9qog=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AD32D35209C5; Wed,  3 Jun 2020 09:29:49 -0700 (PDT)
Date:   Wed, 3 Jun 2020 09:29:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Fixup noinstr warnings
Message-ID: <20200603162949.GP29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200602184409.22142-1-elver@google.com>
 <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
 <20200602191936.GE2604@hirez.programming.kicks-ass.net>
 <CANpmjNP3kAZt3kXuABVqJLAJAW0u9-=kzr-QKDLmO6V_S7qXvQ@mail.gmail.com>
 <20200602193853.GF2604@hirez.programming.kicks-ass.net>
 <20200603084818.GB2627@hirez.programming.kicks-ass.net>
 <20200603095932.GM29598@paulmck-ThinkPad-P72>
 <20200603105206.GG2604@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603105206.GG2604@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:52:06PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 03, 2020 at 02:59:32AM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 03, 2020 at 10:48:18AM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 02, 2020 at 09:38:53PM +0200, Peter Zijlstra wrote:
> > > 
> > > > That said; noinstr's __no_sanitize combined with atomic_t might be
> > > > 'interesting', because the regular atomic things have explicit
> > > > annotations in them. That should give validation warnings for the right
> > > > .config, I'll have to go try -- so far I've made sure to never enable
> > > > the *SAN stuff.
> > > 
> > > ---
> > > Subject: rcu: Fixup noinstr warnings
> > > 
> > > A KCSAN build revealed we have explicit annoations through atomic_t
> > > usage, switch to arch_atomic_*() for the respective functions.
> > > 
> > > vmlinux.o: warning: objtool: rcu_nmi_exit()+0x4d: call to __kcsan_check_access() leaves .noinstr.text section
> > > vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> > > vmlinux.o: warning: objtool: rcu_nmi_enter()+0x4f: call to __kcsan_check_access() leaves .noinstr.text section
> > > vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x2a: call to __kcsan_check_access() leaves .noinstr.text section
> > > vmlinux.o: warning: objtool: __rcu_is_watching()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > This one does not apply cleanly onto the -rcu tree's "dev" branch, so
> > I am guessing that it is intended to be carried in -tip with yours and
> > Thomas's patch series.
> 
> Right, I've not played patch tetris yet so see how it should all fit
> together. I also didn't know you feel about loosing the instrumentation
> in these functions.

It would be very good for KCSAN to be able to detect misuse of ->dynticks!

> One option would be do add explicit: instrument_atomic_write() calls
> before instrument_end() / after instrument_begin() in
> the respective callers that have that.

One good thing: The atomic_andnot() goes away in -rcu patches slated
for v5.9.  However, the others remain.

So if today's -next is any guide, this instrument_atomic_write()
would be added (for one example) in the functions that invoke
rcu_dynticks_eqs_enter(), since it is noinstr.  Rather annoying, and
will require careful commenting.  But there are only two such calls and
they are both in the same file and it is very low-level code, so this
should be doable.

I should also add some commentary to the RCU requirements document
say why all of this is happening.

> Anyway, I'll shortly be posting a pile of patches resulting from various
> KCSAN and KASAN builds. The good news is that GCC-KASAN seems to behave
> quite well with Marco's patches, the bad news is that GCC-KASAN is
> retarded wrt inline and needs a bunch of kicks.
> 
> That is, it out-of-lines:
> 
> static inline bool foo(..)
> {
> 	return false;
> }
> 
> just because..

Compilers!!!  :-/

							Thanx, Paul
