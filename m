Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA371C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8792253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAUPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgAUPFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:05:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A92F21569;
        Tue, 21 Jan 2020 15:05:22 +0000 (UTC)
Date:   Tue, 21 Jan 2020 10:05:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] tracing: Fixes for v5.5
Message-ID: <20200121100520.13525c74@gandalf.local.home>
In-Reply-To: <20200121094906.421206d7@gandalf.local.home>
References: <20200121094906.421206d7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 09:49:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Linus,
> 
> Various tracing fixes:
> 
>  - Fix a function comparison warning for a xen trace event macro
>  - Fix a double perf_event linking to a trace_uprobe_filter for multiple events
>  - Fix suspicious RCU warnings in trace event code for using
>     list_for_each_entry_rcu() when the "_rcu" portion wasn't needed.
>  - Fix a bug in the histogram code when using the same variable
>  - Fix a NULL pointer dereference when tracefs lockdown enabled and calling
>     trace_set_default_clock()
> 
> 
> Please pull the latest trace-v5.5-rc6 tree, which can be found at:

Hi Linus,

Hold off on pulling this. Peter just notified me there's an issue with
one of the patches.

-- Steve

> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> trace-v5.5-rc6
> 
> Tag SHA1: f920461f2655601c33276a60a2fb39d0b4f24e28
> Head SHA1: bf24daac8f2bd5b8affaec03c2be1d20bcdd6837
> 
> 
> Changbin Du (1):
>       tracing: xen: Ordered comparison of function pointers
> 
> Masami Hiramatsu (2):
>       tracing/uprobe: Fix double perf_event linking on multiprobe uprobe
>       tracing: trigger: Replace unneeded RCU-list traversals
> 
> Masami Ichikawa (1):
>       tracing: Do not set trace clock if tracefs lockdown is in effect
> 
> Steven Rostedt (VMware) (1):
>       tracing: Fix histogram code when expression has same var as value
> 
> ----
>  include/trace/events/xen.h          |   6 +-
>  kernel/trace/trace.c                |   5 ++
>  kernel/trace/trace_events_hist.c    |  63 ++++++++++++++----
>  kernel/trace/trace_events_trigger.c |  20 ++++--
>  kernel/trace/trace_kprobe.c         |   2 +-
>  kernel/trace/trace_probe.c          |   5 +-
>  kernel/trace/trace_probe.h          |   3 +-
>  kernel/trace/trace_uprobe.c         | 124 +++++++++++++++++++++++-------------
>  8 files changed, 163 insertions(+), 65 deletions(-)
> ---------------------------
> diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
>
