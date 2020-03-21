Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28549C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 02:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0732072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 02:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhhGA9UW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgCUCY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 22:24:56 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41046 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCUCYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 22:24:55 -0400
Received: by mail-yb1-f193.google.com with SMTP id d5so3559984ybs.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sWKQj4Uyupgpe20upDE1CDsAGcVde2eq3FfcxBSqtw=;
        b=hhhGA9UWT/3U3ety3Si0Pz+2VxrteiTL1w2fW4bALSSesaU013GbJx65VYFnvA9xJi
         PHkjaaMIK1gC+VuQmx5FfVzqBzHHafuApDFLj/NgqQB+EoNfoNIzUgxtIkO1Mg1mloJ2
         D/prA/1Ki/1Rb2avhc0bglsFnNcxG3gyjTL19zKhKI1/QZ8+Lqt6LoCMRNj4lhDXsSiC
         V72m7zm3JPzTDQ8cdjCEHc3Dac7+ANXd0DVY10LnduPwCBMiq7A6XWBA5DIn9ikouIdA
         jiKsmCS3x81Y8qJhMF2qdqc0zhxLcOZqh7IjVEorKM9fMXARKBDU1KGmMfiCmSJJzyDF
         eu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sWKQj4Uyupgpe20upDE1CDsAGcVde2eq3FfcxBSqtw=;
        b=D0tvyjcyZ5AP1amyMwXsvIQvXveXf7IBnQFaFaCj29tIl7y/iM0djApfJ+0Yuw66LI
         cFej2kK6tqfhjmDefMlm9xvGq21joGpN2tY9v+Jr13JCIY3FWYJA/CzxF0EY88WDocvw
         v+ELfx1I+6gQ+FmWIhpWVP2gEFwrrAEtu9ePefRJt7lmmL6B9mK2qcAeimslMwbaQe9Q
         XApc05Nl7WF5pu8AcolZLjhAKhJIDWtGAlLF8iX4lwlhhgkEuvZJBMyWFl3Rw+WAZihy
         6Vj070DIghuCIlJcxHxRAX9kzUqm3RrAZ2FVguxjpVZQ3OlrujqqfvFRntxmArYymGkQ
         j27g==
X-Gm-Message-State: ANhLgQ2HIUxk88Wjzgel67mPbsDrt5SPKdUPzJz2erTqiuRsH3MGKaZ4
        kDM3aCByVQkBD1e1BNe6FoLx/+EXdfFxfyHgU6Y6yA==
X-Google-Smtp-Source: ADFU+vvpQCpgtKO5Wxl1XzXEkIWs1WgNh8zCu/SCP6QXwgMX5OdlFp1qeFH3leT5seMN72TsRh1BZFIidMBUuBQIMgA=
X-Received: by 2002:a25:9787:: with SMTP id i7mr17042865ybo.383.1584757492441;
 Fri, 20 Mar 2020 19:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200312105637.GA8960@mwanda> <20200313122725.GZ12561@hirez.programming.kicks-ass.net>
In-Reply-To: <20200313122725.GZ12561@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 20 Mar 2020 19:24:41 -0700
Message-ID: <CAP-5=fU060AZxi6gC7Z4exUqy8VBT08AuE1AZV6F2qDmTKLPwg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Fix reversed NULL check in perf_event_groups_less()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 5:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 12, 2020 at 01:56:37PM +0300, Dan Carpenter wrote:
> > This NULL check is reversed so it leads to a Smatch warning and
> > presumably a NULL dereference.
> >
> >     kernel/events/core.c:1598 perf_event_groups_less()
> >     error: we previously assumed 'right->cgrp->css.cgroup' could be null
> >       (see line 1590)
> >
> > Fixes: 95ed6c707f26 ("perf/cgroup: Order events in RB tree by cgroup id")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  kernel/events/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 6a47c3e54fe9..607c04ec7cfa 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1587,7 +1587,7 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
> >                        */
> >                       return true;
> >               }
> > -             if (!right->cgrp || right->cgrp->css.cgroup) {
> > +             if (!right->cgrp || !right->cgrp->css.cgroup) {
> >                       /*
> >                        * Right has no cgroup but left does, no cgroups come
> >                        * first.
>
> Thanks!

Also much thanks!

Ian
