Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E4CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6510022B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxfZMucz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgHDTY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHDTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:24:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFAFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 12:24:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so39464420qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzsHuz3jz2KjqjbdXSlm4QZoLu4U8KSe5A09SXjkgoM=;
        b=pxfZMuczjhW/F8JFU7DtDbRoeILs3IStkDcNky/fJGelBVVhrK6RDX/i8xekFGTQLM
         8aEGWH690sudIfYarn+0BOFjl6eO96prLV0OppiwlmxGDHdIenQFHdXAFK+jYYTsyg40
         PuRh4BRc2RoJ5uMYVGBfIsW1RoJwmcZG3S1GNjK6uAIZUE1XXSXubWOHeNZFFHnWWNM7
         REcZ5peEYawXrcYglST5UMJ82do8tM7DN8/BhW7fw1HXzqBb6u7bOGvZ7hNK4D70/hdX
         qu8POu2iJ04zAxE8f/TJDfjm/St+52WnUHaPeUpqhGKaTGWcMJvf35VKUVVGm9PskSal
         9hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzsHuz3jz2KjqjbdXSlm4QZoLu4U8KSe5A09SXjkgoM=;
        b=C7xGAlOHgEeh2veD6lv/7V83Dlg7+XYjqAfQJZF/ksU8gTocYYNsHPrPTdMcR/BJ6M
         uKfyLjPntcUMFUB4y5KuGlLie1Jua31rcGQLkBi6pXb13e/2SSl6AvvELR3lw9jpg1pE
         TOIaiMXWjzn64CnYY1otLDoFnTCc17UemFpV/7GM5HxXsWx8GArQbukAsrIV0epvM6aw
         vsqiHf/OelBeu2oWBiaXXumhBAxNQ4xpCB2DRhjU/ykEyqktvo/Je594tU4BTPgkHUiY
         ymddd5zeYVe8v1yQkjSgjNvPECweHkexkezXvNPe/EMtObrlefrIXFi3C9LUShCwSOZD
         8M3w==
X-Gm-Message-State: AOAM532+abmOfc4vR2y3tyMNzrbfsmruXy/FMwz/PNqtKtGV9YTEX7pe
        ToTCQGQ2q++QVygdzuit2wwxT6gVv/LpeHj5f5eJjQ==
X-Google-Smtp-Source: ABdhPJwXWvCIO8Y8R/+lIlTuLCsmrpuS6BKzpZJHHVUHLJbb4ZaN2z9pD5qQ8Cogh5sEA6/8nK1FaweDpNFgdH55DN4=
X-Received: by 2002:a05:620a:15e8:: with SMTP id p8mr22024185qkm.182.1596569094262;
 Tue, 04 Aug 2020 12:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200804000614.4176212-1-joshdon@google.com> <20200804105619.GE2657@hirez.programming.kicks-ass.net>
In-Reply-To: <20200804105619.GE2657@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 4 Aug 2020 12:24:43 -0700
Message-ID: <CABk29NuN4n9bzi9YzBf7=6HyXn1uTTTiFE3NiVRQ0AOYfiADhA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: ignore cache hotness for SMT migration
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 3:56 AM <peterz@infradead.org> wrote:
>
> On Mon, Aug 03, 2020 at 05:06:14PM -0700, Josh Don wrote:
> > SMT siblings share caches, so cache hotness should be irrelevant for
> > cross-sibling migration.
> >
> > Proposed-by: Venkatesh Pallipadi <venki@google.com>
> > Signed-off-by: Josh Don <joshdon@google.com>
> > ---
> >  kernel/sched/fair.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2ba8f230feb9..5b203b55bcb2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7402,6 +7402,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
> >       if (unlikely(task_has_idle_policy(p)))
> >               return 0;
> >
> > +     if ((env->sd->flags & cpu_smt_flags()) == cpu_smt_flags())
> > +             return 0;
>
> I think that wants to be:
>
>         if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>

Agreed

> Also, perhaps stick a comment on top with the rationale for this.
>
> > +
> >       /*
> >        * Buddy candidates are cache hot:
> >        */
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >
