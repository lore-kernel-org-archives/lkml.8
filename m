Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3175C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA2420578
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595339099;
	bh=pn80ooNmegdYPVjmNjYBuVB2MB7Ot+GlLfpqAmJcj4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ncYfQiVg9iMT6OXQXdGTpdmqw7Jjw2wUexeEEmNa9Cox/N5Kuk3HHb1UYduUc0Dx3
	 fYelYDNfnl/pl3W5SrN4s7tvS+5dzEV18aKn984OWWaLY7dESeHEozzc5YeIuDifxr
	 65pI4W6IkZjMGfnpQCEg8O49P+BKSUviB+77e4eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgGUNo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:44:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38391 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgGUNo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:44:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id a14so6413447wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 06:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pn4rxXnLcED95PLyId2IwjI1AP4bvRug3vOgdxoJ9U0=;
        b=ZpuI0VPhPxoW0pAkJ3nkHHSCDP4y1Ho9895Lf50XrZegXI2XGrrCZXDskEet0aLJMc
         Zp0OR2YXFQASC86FTMpIJbpVw9JmJeXPyI4cLSbKzLOOPRoQTkEXe2bxHZX5tngwLkbX
         heh/gqbop85i1CGRcHE1hw3V4mkUJ6RNlXlcU/nrPQYbiEWxWtvB/kOooQyWTtNdU4C3
         56YjSjhPhIhEe0eBrZT1alGxfZmGoi2uwO0jeA7HP0JGHkyvktroaNLjkqld5shY0jwm
         /xCRkphXTvPbfcnDOP31gGPQauCzsoez30AAsn1KM7iqr9IYnWu300VmXIDuIpchlO7A
         CGMg==
X-Gm-Message-State: AOAM530ozCwLsJGqSVIVRyQliCmxtLyogF8qTyY2/0yZIlgOn28u04Ny
        +KLViYRLNLQN1UA5YiFeQvYymjN3XGt7tipDDKs=
X-Google-Smtp-Source: ABdhPJxN1zGgk55IJDcUQf4RJ3/BJwyYFP1h69KqFOU+E9y5HEgSAvHgDQlWdHSOzy5GoUd4nNVRHAN7vx6xyRYVqrY=
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr973909wrn.60.1595339095514;
 Tue, 21 Jul 2020 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200711124035.6513-1-changbin.du@gmail.com> <20200711124035.6513-4-changbin.du@gmail.com>
 <20200716153630.GD374956@kernel.org> <20200717132650.i32oovllal22b35i@mail.google.com>
 <20200717130124.54e85349@oasis.local.home> <20200717174053.GE712240@kernel.org>
 <20200717135351.5fb1ce95@oasis.local.home> <20200717193455.GD77866@kernel.org>
 <20200717154421.4e3aee99@oasis.local.home>
In-Reply-To: <20200717154421.4e3aee99@oasis.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 21 Jul 2020 22:44:44 +0900
Message-ID: <CAM9d7cirbvj9MTKfU9ga4Mv06facTorYuGaXbLJuZWgNDDrUxw@mail.gmail.com>
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Sat, Jul 18, 2020 at 4:44 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 17 Jul 2020 16:34:55 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Thinking a bit more, I have to ask. Does perf use the kernel when
> getting all the children of an existing task, or is that done only in
> userspace?
>
> That is, is there a perf syscall that says "start tracing this task and
> all its existing children"?
>
> Or is it done by perf user space looking at the /proc filesystem (like
> ps does).

Yep, perf does look up the /proc to get a list of threads in a process.

Thanks
Namhyung


>
> I'm asking because if perf has a syscall to do that, then I probably
> should add a way to do that with ftrace as well. But that's really
> trivial, because all it would take is grabbing the task_list lock and
> iterating over all the children. Getting new children was the
> non-trivial part, which was what I focused on (with the fork options).
>
> If perf does it with proc files, then we don't need to change anything
> as that could still be used with ftrace.
>
> > Changbin, you can take from here :-)
> >
> > And to reiterate, for me the value of 'perf ftrace' is to allow people
> > used to perf to be able to switch to ftrace quickly, just changing:
> >
> >    perf record/top/stat/trace/report/script/etc --pid 1234
> >
> > by:
> >
> >    perf ftrace --pid 1234
> >
> > And have the tracefs ftrace knobs set up to have what is expected in
> > terms of targets to trace as the other perf tools.
> >
> > And not just --pid and --tid, but --cgroup, --cpu, etc.
> >
> > i.e., 'perf ftrace' being _a_ front-end aplication to ftrace.
> >
> > :-)
>
>
> I have no problem with this, and I'm quite excited about it. I would
> like it to use libtracefs, as it looks to be exactly what we are
> working on. And this is now a high priority to get out, and I don't
> expect another year (or two) in doing so ;-)
>
> -- Steve
