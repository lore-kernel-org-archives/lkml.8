Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC245C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904A82075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbgG0Sqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732095AbgG0Spw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:45:52 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB38E2075A;
        Mon, 27 Jul 2020 18:45:51 +0000 (UTC)
Date:   Mon, 27 Jul 2020 14:45:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] tracing: add flag to control different traces
Message-ID: <20200727144550.7aa40c61@oasis.local.home>
In-Reply-To: <20200726025931.30510-3-tingwei@codeaurora.org>
References: <20200726025931.30510-1-tingwei@codeaurora.org>
        <20200726025931.30510-3-tingwei@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 10:59:27 +0800
Tingwei Zhang <tingwei@codeaurora.org> wrote:


> diff --git a/include/linux/trace.h b/include/linux/trace.h
> index 7fd86d3c691f..d2fdf9be84b5 100644
> --- a/include/linux/trace.h
> +++ b/include/linux/trace.h
> @@ -3,6 +3,9 @@
>  #define _LINUX_TRACE_H
>  
>  #ifdef CONFIG_TRACING
> +
> +#define TRACE_EXPORT_FUNCTION	BIT_ULL(0)

All the flags variables below are defined as "int". Why the BIT_ULL()?
BIT(0) should work just fine. The ULL makes one think these flags will
be used for unsigned long variables, which it is not.

-- Steve


> +

>  struct trace_export {
>  	struct trace_export __rcu	*next;
>  	void (*write)(struct trace_export *, const void *, unsigned int);
> +	int flags;
>  };
>  
>  int register_ftrace_export(struct trace_export *export);
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bb62269724d5..8f1e66831e9e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2747,33 +2747,37 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
>  
>  static void
>  trace_process_export(struct trace_export *export,
> -	       struct ring_buffer_event *event)
> +	       struct ring_buffer_event *event, int flag)
>  {
>  	struct trace_entry *entry;
>  	unsigned int size = 0;
>  
> -	entry = ring_buffer_event_data(event);
> -	size = ring_buffer_event_length(event);
> -	export->write(export, entry, size);
> +	if (export->flags & flag) {
> +		entry = ring_buffer_event_data(event);
> +		size = ring_buffer_event_length(event);
> +		export->write(export, entry, size);
> +	}
>  }
