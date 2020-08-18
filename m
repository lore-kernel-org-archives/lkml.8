Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484D120709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHRUUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgHRUUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:20:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614D1206B5;
        Tue, 18 Aug 2020 20:20:31 +0000 (UTC)
Date:   Tue, 18 Aug 2020 16:20:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] sched/cputime: Mark function as __maybe_unused
Message-ID: <20200818162029.1692fc82@oasis.local.home>
In-Reply-To: <CAKwvOdn=32A4QumC_-Y8fJ29fqUPzPK0H_7-dn6rcsAT+O1xOw@mail.gmail.com>
References: <20200818170337.805624-1-alex.dewar90@gmail.com>
        <CAKwvOdk2fynn=-FGUniYLG+hCOkEFppRnAaTYe8DW=YRrT-siQ@mail.gmail.com>
        <20200818195746.scpjm3dlg7cfst53@medion>
        <CAKwvOdn=32A4QumC_-Y8fJ29fqUPzPK0H_7-dn6rcsAT+O1xOw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 13:02:26 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Tue, Aug 18, 2020 at 12:57 PM Alex Dewar <alex.dewar90@gmail.com> wrote:
> >
> > On Tue, Aug 18, 2020 at 11:13:10AM -0700, Nick Desaulniers wrote:  
> > > On Tue, Aug 18, 2020 at 10:04 AM Alex Dewar <alex.dewar90@gmail.com> wrote:  
> > > >
> > > > Depending on config options, account_other_time() may not be called
> > > > anywhere. Add __maybe_unused flag to fix clang warning.  
> > >
> > > Just curious, would moving this definition to be within an existing
> > > preprocessor guard for a particular config also fix the issue? If so,
> > > prefer that. If not, __maybe_unused is the way to go.  
> >
> > I don't think that'd work here: it's used within an "#ifdef
> > CONFIG_IRQ_TIME_ACCOUNTING" block and a separate "#ifdef
> > CONFIG_VIRT_CPU_ACCOUNTING_GEN" one. We could do:
> >         #if defined(CONFIG_IRQ_TIME_ACCOUNTING) ||
> >             defined(CONFIG_VIRT_CPU_ACCOUNTING)
> >                 ...
> > ... but that might be a bit ugly.  
> 
> Yeah, ok, in that case it's fine.  One issue with __maybe_unused is
> that this function will stick around forever if all call sites get
> removed.  But when the preprocessor checks start getting hairy,
> __maybe_unused is maybe simpler.

For the reasons you state above, I'm almost thinking ugly may be better. :-/

But there's other places that have the "maybe_unused" in the scheduler
code for basically the same reasons, thus I guess it's OK.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> >  
> > >  
> > > >
> > > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > > > ---
> > > >  kernel/sched/cputime.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > > > index 5a55d2300452..43ede0d6661c 100644
> > > > --- a/kernel/sched/cputime.c
> > > > +++ b/kernel/sched/cputime.c
> > > > @@ -252,7 +252,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
> > > >  /*
> > > >   * Account how much elapsed time was spent in steal, irq, or softirq time.
> > > >   */
> > > > -static inline u64 account_other_time(u64 max)
> > > > +static inline u64 __maybe_unused account_other_time(u64 max)
> > > >  {
> > > >         u64 accounted;
> > > >
> > > > --
> > > > 2.28.0
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200818170337.805624-1-alex.dewar90%40gmail.com.  
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers  
> 
> 
> 

