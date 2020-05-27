Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B088C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EB1208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590558048;
	bh=/QPL55vHd1xjxjBT/Uf3J8qX56iae8hMRSaZmdMGMHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iyF1LrKce4K7gMn0yCB6FYHio8xh7f8EXGmTcVyq/WM80dutJuw69Uo8sBCL/iSj4
	 wVtcK3CQyG6aslZCfLcUL503DiQi+oW0yKLecV5MLhThgyLZM21pilvMUZc5b1iLp1
	 ppLjA9vusl2IW6Vw7r74WnWibsu8Uf/XJLvewMpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgE0Fkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE0Fkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:40:47 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831752078C;
        Wed, 27 May 2020 05:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590558046;
        bh=/QPL55vHd1xjxjBT/Uf3J8qX56iae8hMRSaZmdMGMHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jJHUdC2jptOx9PjcZDb0uXa6K81hZTALfO3HtrIL270sqOW2wBtBUSEQ4We8iopzG
         uDKuZpELSx1QI4u/HBha07wPs7zNw0tlpmiQF2DcFsHz2Bcn4m0l2wrfPOWO6bI4R6
         FnEIJVEtiLm9U78DeZBGHTF1j5oYXKm739QmZm8w=
Date:   Wed, 27 May 2020 14:40:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-Id: <20200527144040.3f12026f31b20b2011fbbcee@kernel.org>
In-Reply-To: <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
        <20200526213913.GG2483@worktop.programming.kicks-ass.net>
        <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 21:46:29 +0000
Song Liu <songliubraving@fb.com> wrote:

> 
> 
> > On May 26, 2020, at 2:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, May 26, 2020 at 02:28:26PM -0700, Song Liu wrote:
> >> It is useful to trace functions in kernel/event/core.c. Allow ftrace for
> >> them by removing $(CC_FLAGS_FTRACE) from Makefile.
> > 
> > Did you try using the ftrace event with perf with this on?
> 
> I have tried a few things, like 
> 
>   perf stat -e probe:perf_read -I 1000
>   perf record -e probe:__x64_sys_perf_event_open -aR
> 
> They all work fine. 

Did you try using perf with function-tracer or function-graph tracer?
If you just want to trace those functions with kprobes, you can 
build your kernel with CONFIG_KPROBE_EVENTS_ON_NOTRACE=y, which allows
you to probe perf_read etc.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
