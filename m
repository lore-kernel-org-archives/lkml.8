Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1644C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895F72074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgGQToZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgGQToZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:44:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A7F20684;
        Fri, 17 Jul 2020 19:44:23 +0000 (UTC)
Date:   Fri, 17 Jul 2020 15:44:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200717154421.4e3aee99@oasis.local.home>
In-Reply-To: <20200717193455.GD77866@kernel.org>
References: <20200711124035.6513-1-changbin.du@gmail.com>
        <20200711124035.6513-4-changbin.du@gmail.com>
        <20200716153630.GD374956@kernel.org>
        <20200717132650.i32oovllal22b35i@mail.google.com>
        <20200717130124.54e85349@oasis.local.home>
        <20200717174053.GE712240@kernel.org>
        <20200717135351.5fb1ce95@oasis.local.home>
        <20200717193455.GD77866@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 16:34:55 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

Thinking a bit more, I have to ask. Does perf use the kernel when
getting all the children of an existing task, or is that done only in
userspace?

That is, is there a perf syscall that says "start tracing this task and
all its existing children"?

Or is it done by perf user space looking at the /proc filesystem (like
ps does).

I'm asking because if perf has a syscall to do that, then I probably
should add a way to do that with ftrace as well. But that's really
trivial, because all it would take is grabbing the task_list lock and
iterating over all the children. Getting new children was the
non-trivial part, which was what I focused on (with the fork options).

If perf does it with proc files, then we don't need to change anything
as that could still be used with ftrace.

> Changbin, you can take from here :-)
> 
> And to reiterate, for me the value of 'perf ftrace' is to allow people
> used to perf to be able to switch to ftrace quickly, just changing:
> 
>    perf record/top/stat/trace/report/script/etc --pid 1234
> 
> by:
> 
>    perf ftrace --pid 1234
> 
> And have the tracefs ftrace knobs set up to have what is expected in
> terms of targets to trace as the other perf tools.
> 
> And not just --pid and --tid, but --cgroup, --cpu, etc.
> 
> i.e., 'perf ftrace' being _a_ front-end aplication to ftrace.
> 
> :-)


I have no problem with this, and I'm quite excited about it. I would
like it to use libtracefs, as it looks to be exactly what we are
working on. And this is now a high priority to get out, and I don't
expect another year (or two) in doing so ;-)

-- Steve
