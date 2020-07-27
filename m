Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDDC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AE921744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgG0Pm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbgG0Pm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:42:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF03B206E7;
        Mon, 27 Jul 2020 15:42:55 +0000 (UTC)
Date:   Mon, 27 Jul 2020 11:42:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] ftrace: fix ftrace_trace_task return value
Message-ID: <20200727114254.3086b8b9@oasis.local.home>
In-Reply-To: <20200725005048.1790-1-josef@toxicpanda.com>
References: <20200725005048.1790-1-josef@toxicpanda.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 20:50:48 -0400
Josef Bacik <josef@toxicpanda.com> wrote:

> I was attempting to use pid filtering with function_graph, but it wasn't
> allowing anything to make it through.  Turns out ftrace_trace_task
> returns false if ftrace_ignore_pid is not-empty, which isn't correct
> anymore.  We're now setting it to FTRACE_PID_IGNORE if we need to ignore
> that pid, otherwise it's set to the pid (which is weird considering the
> name) or to FTRACE_PID_TRACE.  Fix the check to check for !=
> FTRACE_PID_IGNORE.  With this we can now use function_graph with pid
> filtering.
> 

I just ran into this myself! And was about to go look at why function
graph pid filtering wasn't working. Thanks for the patch! I'll start
testing it this week.

-- Steve


> Fixes: 717e3f5ebc82 ("ftrace: Make function trace pid filtering a bit more exact")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  kernel/trace/ftrace.c | 3 ---
>  kernel/trace/trace.h  | 7 ++++++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1903b80db6eb..7d879fae3777 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -139,9 +139,6 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
>  #endif
>  }
>  
> -#define FTRACE_PID_IGNORE	-1
> -#define FTRACE_PID_TRACE	-2
> -
>  static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
>  			    struct ftrace_ops *op, struct pt_regs *regs)
>  {
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 13db4000af3f..1531ec565cb5 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1103,6 +1103,10 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
>  extern struct list_head ftrace_pids;
>  
>  #ifdef CONFIG_FUNCTION_TRACER
> +
> +#define FTRACE_PID_IGNORE	-1
> +#define FTRACE_PID_TRACE	-2
> +
>  struct ftrace_func_command {
>  	struct list_head	list;
>  	char			*name;
> @@ -1114,7 +1118,8 @@ struct ftrace_func_command {
>  extern bool ftrace_filter_param __initdata;
>  static inline int ftrace_trace_task(struct trace_array *tr)
>  {
> -	return !this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid);
> +	return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=
> +		FTRACE_PID_IGNORE;
>  }
>  extern int ftrace_is_dead(void);
>  int ftrace_create_function_files(struct trace_array *tr,

