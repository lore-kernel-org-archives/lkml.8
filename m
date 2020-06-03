Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8071AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E6C20825
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H+Nek6rC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgFCKwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFCKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:52:34 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13B9C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 03:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gDAYBsNhd3MhHyd9Nfu4JI7C94w3l3VoucL+udwtlmg=; b=H+Nek6rCCT+THMCi0vc3MVZHoC
        8UCON2zctiamF5TCDl3c+R16MbhjaAUVCCJGwC5ExdBBQTQYbbXB8jXHmCDAqofB/nyHCxhlFNkD8
        g2wXDR0YOTE+V3rFCEz+r20nWVB4ZwK7ikQ2KsX57Y3NKthQ47eEBQY73GDn1orY5XSDz3mvjgT99
        PgBY3LhXVXssIlS6GjKzlq4z0gLlI/O0dtGOcJxWTOnM2WHW3FHN+N1oS7JSVwNEPh105amNA+3J4
        BAmPHRGN84+9iqUFk7muhGbz7R+CETmJHb0YdFE8Dv4Hffsg+Kq4q2guYoRq5spdwmThs0DTthHep
        vsURGVqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgR0C-00053H-VC; Wed, 03 Jun 2020 10:52:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50A6F30008D;
        Wed,  3 Jun 2020 12:52:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E28A20598375; Wed,  3 Jun 2020 12:52:06 +0200 (CEST)
Date:   Wed, 3 Jun 2020 12:52:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200603105206.GG2604@hirez.programming.kicks-ass.net>
References: <20200602184409.22142-1-elver@google.com>
 <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
 <20200602191936.GE2604@hirez.programming.kicks-ass.net>
 <CANpmjNP3kAZt3kXuABVqJLAJAW0u9-=kzr-QKDLmO6V_S7qXvQ@mail.gmail.com>
 <20200602193853.GF2604@hirez.programming.kicks-ass.net>
 <20200603084818.GB2627@hirez.programming.kicks-ass.net>
 <20200603095932.GM29598@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603095932.GM29598@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 02:59:32AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 03, 2020 at 10:48:18AM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 02, 2020 at 09:38:53PM +0200, Peter Zijlstra wrote:
> > 
> > > That said; noinstr's __no_sanitize combined with atomic_t might be
> > > 'interesting', because the regular atomic things have explicit
> > > annotations in them. That should give validation warnings for the right
> > > .config, I'll have to go try -- so far I've made sure to never enable
> > > the *SAN stuff.
> > 
> > ---
> > Subject: rcu: Fixup noinstr warnings
> > 
> > A KCSAN build revealed we have explicit annoations through atomic_t
> > usage, switch to arch_atomic_*() for the respective functions.
> > 
> > vmlinux.o: warning: objtool: rcu_nmi_exit()+0x4d: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: rcu_nmi_enter()+0x4f: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x2a: call to __kcsan_check_access() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: __rcu_is_watching()+0x25: call to __kcsan_check_access() leaves .noinstr.text section
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> This one does not apply cleanly onto the -rcu tree's "dev" branch, so
> I am guessing that it is intended to be carried in -tip with yours and
> Thomas's patch series.

Right, I've not played patch tetris yet so see how it should all fit
together. I also didn't know you feel about loosing the instrumentation
in these functions.

One option would be do add explicit: instrument_atomic_write() calls
before instrument_end() / after instrument_begin() in
the respective callers that have that.

Anyway, I'll shortly be posting a pile of patches resulting from various
KCSAN and KASAN builds. The good news is that GCC-KASAN seems to behave
quite well with Marco's patches, the bad news is that GCC-KASAN is
retarded wrt inline and needs a bunch of kicks.

That is, it out-of-lines:

static inline bool foo(..)
{
	return false;
}

just because..
