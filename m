Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BCFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07FF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsHA1THP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHRUCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgHRUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:02:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2637EC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:02:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a79so10490623pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYlwdkpiQ5r4IlzlVf3XVoN723S4ZkSGimNU1q1QEv0=;
        b=gsHA1THPb/jhzoRgTkhXbdFHQ3FHcjNQAPRUKS/MaQ4nboOSjfI9LbBjaXtjZdJzFL
         xlU2vWhoF8kgNISJazpoRzdaNGsgfPQg6Yjx65HbYR6Dmsd+ecCk7IPaipIiP67qLAfG
         XqeuVNWJkBCPr560f2sHEsnsUr6Pnd31OHyqSr2YBv+2AwDT+YybLF+1XD/osm4kYdq5
         KPVzmFMbUTZRQQDYLlzb4ywSBxkA+pPUDQrlGCytu8P2i21obLr6h/WxVyuXgCz7vURN
         rWPj87bg7bZkOWcVWbydJwVRtxY2WH2J6t6OsY3IkiMa2OJXvYtjVjUnaYfsnG09tWuB
         xChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYlwdkpiQ5r4IlzlVf3XVoN723S4ZkSGimNU1q1QEv0=;
        b=phJbsFb6eTYhwXco+AxsZ8R3Thz/2LuvRcI/TbaktV6dZwr45BCc104jnA35xhoJ3B
         RopwVLQE2y1bKYnYxWMR4u3kfm7ou60+pelctVT++DKDuPGFLz1BEPMsr+8vj6SsOhYo
         +cbWOb5F7OCdKmwtuoLZocwcsYn8cleCLPafdS/kC1YL0wjDT8c2DJ7mlbDBOUYxFMmp
         4S794nkBTvkEmtRDx/rD+X1TBmSZd91JYX1HtClSfV41cVn7dK4NywJzWa93kI/QaZGm
         ndpD0K5uJ3mz0+MgwcUzAuw6QxtvHChnp9YljmHxZnUCPg8lr0foN1bd03qcZ4NWnpI3
         v7nQ==
X-Gm-Message-State: AOAM5333P7ZSC19k5esUiONNtJhgnfwdxdWVFI5pRXsq5eC9kG4vGHkK
        mM2vi6KBRQz9rryIwOgHWcXBXHICuLfKJA83jzpFRQ==
X-Google-Smtp-Source: ABdhPJwfqmwz26YvV5y8i9SDr0VzzXGBkJz5qDVA2luzchYK4nn1cMyK5iIBc1WsDebp1ooAdQP/9XHci5s0euykYko=
X-Received: by 2002:aa7:96e5:: with SMTP id i5mr13565872pfq.108.1597780957364;
 Tue, 18 Aug 2020 13:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200818170337.805624-1-alex.dewar90@gmail.com>
 <CAKwvOdk2fynn=-FGUniYLG+hCOkEFppRnAaTYe8DW=YRrT-siQ@mail.gmail.com> <20200818195746.scpjm3dlg7cfst53@medion>
In-Reply-To: <20200818195746.scpjm3dlg7cfst53@medion>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 13:02:26 -0700
Message-ID: <CAKwvOdn=32A4QumC_-Y8fJ29fqUPzPK0H_7-dn6rcsAT+O1xOw@mail.gmail.com>
Subject: Re: [PATCH] sched/cputime: Mark function as __maybe_unused
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:57 PM Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> On Tue, Aug 18, 2020 at 11:13:10AM -0700, Nick Desaulniers wrote:
> > On Tue, Aug 18, 2020 at 10:04 AM Alex Dewar <alex.dewar90@gmail.com> wrote:
> > >
> > > Depending on config options, account_other_time() may not be called
> > > anywhere. Add __maybe_unused flag to fix clang warning.
> >
> > Just curious, would moving this definition to be within an existing
> > preprocessor guard for a particular config also fix the issue? If so,
> > prefer that. If not, __maybe_unused is the way to go.
>
> I don't think that'd work here: it's used within an "#ifdef
> CONFIG_IRQ_TIME_ACCOUNTING" block and a separate "#ifdef
> CONFIG_VIRT_CPU_ACCOUNTING_GEN" one. We could do:
>         #if defined(CONFIG_IRQ_TIME_ACCOUNTING) ||
>             defined(CONFIG_VIRT_CPU_ACCOUNTING)
>                 ...
> ... but that might be a bit ugly.

Yeah, ok, in that case it's fine.  One issue with __maybe_unused is
that this function will stick around forever if all call sites get
removed.  But when the preprocessor checks start getting hairy,
__maybe_unused is maybe simpler.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> >
> > >
> > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > > ---
> > >  kernel/sched/cputime.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > > index 5a55d2300452..43ede0d6661c 100644
> > > --- a/kernel/sched/cputime.c
> > > +++ b/kernel/sched/cputime.c
> > > @@ -252,7 +252,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
> > >  /*
> > >   * Account how much elapsed time was spent in steal, irq, or softirq time.
> > >   */
> > > -static inline u64 account_other_time(u64 max)
> > > +static inline u64 __maybe_unused account_other_time(u64 max)
> > >  {
> > >         u64 accounted;
> > >
> > > --
> > > 2.28.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200818170337.805624-1-alex.dewar90%40gmail.com.
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
