Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C5BC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E11E20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgGUQhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgGUQhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:37:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C878B207DD;
        Tue, 21 Jul 2020 16:37:34 +0000 (UTC)
Date:   Tue, 21 Jul 2020 12:37:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tracing: add trace_export support for event trace
Message-ID: <20200721123733.1a87568a@oasis.local.home>
In-Reply-To: <20200720022117.9375-3-tingwei@codeaurora.org>
References: <20200720022117.9375-1-tingwei@codeaurora.org>
        <20200720022117.9375-3-tingwei@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 10:21:15 +0800
Tingwei Zhang <tingwei@codeaurora.org> wrote:

> Only function traces can be exported to other destinations currently.
> This patch exports event trace as well.
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---
>  kernel/trace/trace.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bb62269724d5..aef6330836e2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2697,17 +2697,6 @@ int tracepoint_printk_sysctl(struct ctl_table *table, int write,
>  	return ret;
>  }
>  
> -void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
> -{
> -	if (static_key_false(&tracepoint_printk_key.key))
> -		output_printk(fbuffer);
> -
> -	event_trigger_unlock_commit_regs(fbuffer->trace_file, fbuffer->buffer,
> -				    fbuffer->event, fbuffer->entry,
> -				    fbuffer->flags, fbuffer->pc, fbuffer->regs);
> -}
> -EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
> -

Please move the ftrace_exports routines up, instead of moving the
trace_event_buffer_commit() down. As it fits better where it is (next
to the other buffer_commit code).

-- Steve


>  /*
>   * Skip 3:
>   *
> @@ -2868,6 +2857,19 @@ int unregister_ftrace_export(struct
> trace_export *export) }
>  EXPORT_SYMBOL_GPL(unregister_ftrace_export);
>  
> +void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
> +{
> +	if (static_key_false(&tracepoint_printk_key.key))
> +		output_printk(fbuffer);
> +
> +	if (static_branch_unlikely(&ftrace_exports_enabled))
> +		ftrace_exports(fbuffer->event);
> +	event_trigger_unlock_commit_regs(fbuffer->trace_file,
> fbuffer->buffer,
> +				    fbuffer->event, fbuffer->entry,
> +				    fbuffer->flags, fbuffer->pc,
> fbuffer->regs); +}
> +EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
> +
>  void
>  trace_function(struct trace_array *tr,
>  	       unsigned long ip, unsigned long parent_ip, unsigned
> long flags,

