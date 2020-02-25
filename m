Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23809C35DEA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46A62176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 01:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHhKFEev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBYBuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:50:20 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37635 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYBuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 20:50:20 -0500
Received: by mail-qv1-f66.google.com with SMTP id ci20so3703437qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 17:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=658+MST6tRLPpeSgmfQnL9jvRO2fL056h095yosRw9k=;
        b=sHhKFEevj+QRdk9OGUJHHHzCoP9/juukTB80Etwxnnci+MUyhhBdHYuwU8/0Nxh7tJ
         16yONm0GtU6JkStXRdQLZi1aYoEkKZ5d3mdJd2LhL7yoOm4Plpi6KN7GEBXzQ0dv0PDc
         OS9Zq1GnczNJhHpcOPrjZ0ZD0n1JuX2IfzahhJUCPUnwFnKX1fuUH9+X0KqrNkkQE73D
         7EGdo6JCQ7gSZ8n9iMH908JQMkKZAeRuwo8EwUSGXOKiYu7wFYObHtfijSMObyh3pSbY
         xiqPWUazXwH3GcuAiDtqt9YhLn1CbCKJ8vwTMloG7REI956s2VTFaXGpaTEm9bcQXCwd
         RToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=658+MST6tRLPpeSgmfQnL9jvRO2fL056h095yosRw9k=;
        b=WNFerRzt/7ynx3pDXOBeRG/PhjoxSMFrzyFWcJlEEokiuUwFeqS8fgq6D7fzcLX8WV
         jbySYD2ynUQ2rZOVzd6rd3wpFr6fyKuTDVCP6Cjc4b9NO8jOZZqTpJOaABxwDnXReVcE
         9QGkHg4DVU3Dr46SuoEBalioET9avD/s6UVpEM1Ho369gdedbQxZvdqNjdgLk1YkuSD9
         18I/FLa9i/dsrZ73t6Ys5aJivVdyFs93g3MbnBCNP0RZroOG0FuIcgxMp7tM1kLz11pe
         kiRdE2AMktPD1e888ekP/5ig+mHwG6CmgOw3r1AvZbwPVSM3SBdVawcpmv3h37JvMcVT
         BDKQ==
X-Gm-Message-State: APjAAAXXXZ/M4Hfh+7vKimYRD4o26PNfRnUlHpxY6mxD4SHQuxyd0g37
        mQmjfBwfYhuzErPTXPC142b4CaFFt5KZbrhiQAxEPA==
X-Google-Smtp-Source: APXvYqyU1bEoiWQ++12wo9LNv5vQ3PXb1Q+3VdJ86d0Dplyj19+BGuWRmXdcdPAim6V57ZV5/iSI6TGn8trP0RzSrQ0=
X-Received: by 2002:ad4:486f:: with SMTP id u15mr33166366qvy.235.1582595419053;
 Mon, 24 Feb 2020 17:50:19 -0800 (PST)
MIME-Version: 1.0
References: <CABk29NvMS87uGnFRWoN3Ce0t+UQ--qnjRmQCPJCCEcSASs25uQ@mail.gmail.com>
 <20191219001418.234372-1-joshdon@google.com> <CAKfTPtDBuzVUZmqZo2MZNDrrnX=iMEN=pq6pid0NJ7PRzGjKjw@mail.gmail.com>
In-Reply-To: <CAKfTPtDBuzVUZmqZo2MZNDrrnX=iMEN=pq6pid0NJ7PRzGjKjw@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 24 Feb 2020 17:50:08 -0800
Message-ID: <CABk29NtG32iuBRdTMqz9P=FynpMH=RzLaMpF+h07TwTCCQ7iEQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bumping in case this fell through the cracks of the patch queue

On Thu, Dec 26, 2019 at 7:05 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Thu, 19 Dec 2019 at 01:14, Josh Don <joshdon@google.com> wrote:
> >
> > From: Venkatesh Pallipadi <venki@google.com>
> >
> > Setting the skip buddy up the hierarchy effectively means that a thread
> > calling yield will also end up skipping the other tasks in its hierarchy
> > as well. However, a yielding thread shouldn't end up causing this
> > behavior on behalf of its entire hierarchy.
> >
> > For typical uses of yield, setting the skip buddy up the hierarchy is
> > counter-productive, as that results in CPU being yielded to a task in
> > some other cgroup.
> >
> > So, limit the skip effect only to the task requesting it.
> >
> > Co-developed-by: Josh Don <joshdon@google.com>
> > Signed-off-by: Josh Don <joshdon@google.com>
>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> > ---
> > v2: Only clear skip buddy on the current cfs_rq
> >
> > v3: Modify comment describing the justification for this change.
> >
> >  kernel/sched/fair.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 08a233e97a01..0056b57d52cb 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4051,13 +4051,10 @@ static void __clear_buddies_next(struct sched_entity *se)
> >
> >  static void __clear_buddies_skip(struct sched_entity *se)
> >  {
> > -       for_each_sched_entity(se) {
> > -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > -               if (cfs_rq->skip != se)
> > -                       break;
> > +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >
> > +       if (cfs_rq->skip == se)
> >                 cfs_rq->skip = NULL;
> > -       }
> >  }
> >
> >  static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > @@ -6552,8 +6549,12 @@ static void set_next_buddy(struct sched_entity *se)
> >
> >  static void set_skip_buddy(struct sched_entity *se)
> >  {
> > -       for_each_sched_entity(se)
> > -               cfs_rq_of(se)->skip = se;
> > +       /*
> > +        * Only set the skip buddy for the task requesting it. Setting the skip
> > +        * buddy up the hierarchy would result in skipping all other tasks in
> > +        * the hierarchy as well.
> > +        */
> > +       cfs_rq_of(se)->skip = se;
> >  }
> >
> >  /*
> > --
> > 2.24.1.735.g03f4e72817-goog
> >
