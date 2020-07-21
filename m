Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1BAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1278C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tuWETmIT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwumFlYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgGUHPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:15:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35572 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgGUHPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:15:16 -0400
Date:   Tue, 21 Jul 2020 09:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595315712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiErJQ3/pvdDczbHfP7geDKER1phc+abHIAv/TX3dPo=;
        b=tuWETmITBNcudRlx7rC5BIgTv+Fx4FzTDnt8NCBKzevVpaDPowcv+/5er4R84GVMcUf+Pc
        i3sVaD3xsRlNaEvCkwlx9lr/w7GREynhrlsbw8HaJP5itSyiU89M2r2s9hVslcNOMhPycO
        gl00axSsKy6DI9d1+hW0M1uomRHW188gCmZLDuMcB5/7s5Unx8/J1MuyavhQGGr2GdfQ27
        7G9BF0UyAZe1d9PTs08qY1x8ggVwFe5yyLM59JTnifE1QY5g1lM0Z3dAMuJXI/lIVK5+8d
        y5r9ItPVTgMy91lXVlXlI9q3njQqrg+COL3l5dnRNhX3mN2uIKlhbxNlIUO6bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595315712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiErJQ3/pvdDczbHfP7geDKER1phc+abHIAv/TX3dPo=;
        b=ZwumFlYaLZltOUD/a6CEqLjmblCs/2U42ruGzV/qYbNKuA7pCxl7oCJbVaboxQpvtl71WK
        mKzhLC9TkKaED9DA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/24] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200721071510.GA1175122@debian-buster-darwi.lab.linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-2-a.darwish@linutronix.de>
 <20200720214400.5ec6a028@oasis.local.home>
 <20200720215115.4c5276db@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720215115.4c5276db@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:51:15PM -0400, Steven Rostedt wrote:
> On Mon, 20 Jul 2020 21:44:00 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > - * This is not as cache friendly as brlock. Also, this may not work well
> > > - * for data that contains pointers, because any writer could
> > > - * invalidate a pointer that a reader was following.
> > > + * See Documentation/locking/seqlock.rst
> >
> > I absolutely hate it when I see this.
> >
> > I much rather have the documentation next to the code. Because
> > honestly, I trust that comments next to the code will get updated if
> > the code changes much more likely than comments buried in the
> > Documentation directory.
> >
> > It's also more likely that I wont even bother looking at the doc
> > (because I wont trust it to be up to date) and just read the code and
> > try to figure it out. Or look at how others have used it.
>
> Never mind,
>
> I see that kerneldoc is added in patch 5, which helps.
>

Even looking at the current patch #1 *in isolation*, no relevant
comments were removed from seqlock.h at all. They were just moved closer
to the seqcount_t and seqlock_t structure definitions.

The original comments were horrible. They intermingled seqcount_t and
seqlock_t descriptions in a *very* ambiguous, sometimes even in the same
sentence. It was misleading, as the usage constrains for each data type
(especially on the write side) are vastly different.

Even the new KCSAN comment, which was freshly merged this release cycle,
got tainted by such already-existing incoherence. It kept talking about
the "seqlock interface" while it actually meant the seqcount_t
interface.  Then at the end, it realized the semantical ambiguity and
noted how the "seqlock interface" does *not* cover seqlock_t.

Moreover, this seqcount_t/seqlock_t documentation intermingling led to
the critical usage constraint of disabling preemption before entering a
seqcount_t write side critical section never getting explicitly
mentioned. This has (naturally) led to a considerable number of buggy
call sites, and the fixes are now merged.

I've tried to fix the problem at the roots, and basically identified
three major problems:

  1. The seqcount_t/seqlock_t intermingling is confusing everyone. That
     is, both of call-site developers *and* core kernel engineers.

  2. The big picture of seqlock.h was never expressed in a sufficient
     detail.

  3. The usage constraints for the exported seqlock.h APIs were never
     explicitly mentioned.. leading to buggy call sites.

To fix #1, I've changed the all of the existing seqlock.h comments to
explicitly mention either "seqcount_t" or "seqlock_t". Then, divided the
the top seqlock.h comment into a seqcount_t part and a seqlock_t one.
Afterwards, the whole seqlock.h header file code was grouped into
"sections", as seen in patch #4.

To fix #2, Documentation/locking/seqlock.rst was introduced and boldly
referenced at the header-file top comment.

To fix #3, kernel-doc was added for all of the seqlock.h exported APIs.

@Peter, kindly note that all of the above *is exactly why* I've resisted
hiding the new seqcount_LOCKTYPE_t APIs introduced by this patch series
inside generative macros. All the parts that will be referenced by
call-site developers are kept both explicit and kernel-doc commented.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
