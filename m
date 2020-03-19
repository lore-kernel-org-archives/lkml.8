Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B53C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A928207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584625312;
	bh=OTiOI9NpVgAuHMhA+pe29888F5J5ckdUeAQZInkekaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PYubo36noLTmbnH0QOUkNXwAkjeU8ISxJbZOm21soBYssfeF9HrjVG2QeyuDlap0u
	 4bAuXiSDaDiyoIzoA/IHsagndC3xYhwEhm0a/avWirJhvTJy8HGUWLWpI23g4Jb+77
	 OG7J/yu1jpGQr0b41qgWIRBucyDSQXDlVqj8+H/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCSNlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgCSNlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:41:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B5320663;
        Thu, 19 Mar 2020 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584625309;
        bh=OTiOI9NpVgAuHMhA+pe29888F5J5ckdUeAQZInkekaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUdGwNLlsVxO3xUB6XATLkNW2L4CKFDFFZ2NuC5jY47TDNKO0AwzaBoO63/wIa70d
         HGaxGGV+hnyezyBixqb0ro9Rrvm5D+dKmAgAHbtBA0AVy/kR1/pZ+KVh7nGSDbdwKM
         jf73+Ey2WwxJRUHRj8rOh3i7cyGgufOBMxn3kipg=
Date:   Thu, 19 Mar 2020 22:41:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [RFC][PATCH 01/11] tracing: Save off entry when peeking at next
 entry
Message-Id: <20200319224144.cc16357a3476506fd64ad448@kernel.org>
In-Reply-To: <20200317213415.722539921@goodmis.org>
References: <20200317213222.421100128@goodmis.org>
        <20200317213415.722539921@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 17 Mar 2020 17:32:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> In order to have the iterator read the buffer even when it's still updating,
> it requires that the ring buffer iterator saves each event in a separate
> location outside the ring buffer such that its use is immutable.
> 
> There's one use case that saves off the event returned from the ring buffer
> interator and calls it again to look at the next event, before going back to
> use the first event. As the ring buffer iterator will only have a single
> copy, this use case will no longer be supported.
> 
> Instead, have the one use case create its own buffer to store the first
> event when looking at the next event. This way, when looking at the first
> event again, it wont be corrupted by the second read.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/trace_events.h |  2 ++
>  kernel/trace/trace.c         | 27 ++++++++++++++++++++++++++-
>  kernel/trace/trace_output.c  | 15 ++++++---------
>  3 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 6c7a10a6d71e..5c6943354049 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -85,6 +85,8 @@ struct trace_iterator {
>  	struct mutex		mutex;
>  	struct ring_buffer_iter	**buffer_iter;
>  	unsigned long		iter_flags;
> +	void			*temp;	/* temp holder */
> +	unsigned int		temp_size;
>  
>  	/* trace_seq for __print_flags() and __print_symbolic() etc. */
>  	struct trace_seq	tmp_seq;
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6b11e4e2150c..52425aaf26c2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3466,7 +3466,31 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
>  struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
>  					  int *ent_cpu, u64 *ent_ts)
>  {
> -	return __find_next_entry(iter, ent_cpu, NULL, ent_ts);
> +	/* __find_next_entry will reset ent_size */
> +	int ent_size = iter->ent_size;
> +	struct trace_entry *entry;
> +
> +	/*
> +	 * The __find_next_entry() may update iter->ent, making
> +	 * the current iter->ent pointing to stale data.
> +	 * Need to copy it over.
> +	 */

Is this comment correct? I can not find the code which update
iter->ent in __find_next_entry() and peek_next_entry().
Maybe writer updates the "*iter->ent"?

> +	if (iter->ent && iter->ent != iter->temp) {
> +		if (!iter->temp || iter->temp_size < iter->ent_size) {
> +			kfree(iter->temp);
> +			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);

This can be alloc/free several times on one iteration. Should we
be so careful about memory consumption for this small piece?

Since the reader will not run in parallel (or very rare case),
iter->temp can allocate the max entry size at the beginning.

Thank you,

> +			if (!iter->temp)
> +				return NULL;
> +		}
> +		memcpy(iter->temp, iter->ent, iter->ent_size);
> +		iter->temp_size = iter->ent_size;
> +		iter->ent = iter->temp;
> +	}
> +	entry = __find_next_entry(iter, ent_cpu, NULL, ent_ts);
> +	/* Put back the original ent_size */
> +	iter->ent_size = ent_size;
> +
> +	return entry;
>  }
>  
>  /* Find the next real entry, and increment the iterator to the next entry */
> @@ -4344,6 +4368,7 @@ static int tracing_release(struct inode *inode, struct file *file)
>  
>  	mutex_destroy(&iter->mutex);
>  	free_cpumask_var(iter->started);
> +	kfree(iter->temp);
>  	kfree(iter->trace);
>  	kfree(iter->buffer_iter);
>  	seq_release_private(inode, file);
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index e25a7da79c6b..9a121e147102 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -617,22 +617,19 @@ int trace_print_context(struct trace_iterator *iter)
>  
>  int trace_print_lat_context(struct trace_iterator *iter)
>  {
> +	struct trace_entry *entry, *next_entry;
>  	struct trace_array *tr = iter->tr;
> -	/* trace_find_next_entry will reset ent_size */
> -	int ent_size = iter->ent_size;
>  	struct trace_seq *s = &iter->seq;
> -	u64 next_ts;
> -	struct trace_entry *entry = iter->ent,
> -			   *next_entry = trace_find_next_entry(iter, NULL,
> -							       &next_ts);
>  	unsigned long verbose = (tr->trace_flags & TRACE_ITER_VERBOSE);
> +	u64 next_ts;
>  
> -	/* Restore the original ent_size */
> -	iter->ent_size = ent_size;
> -
> +	next_entry = trace_find_next_entry(iter, NULL, &next_ts);
>  	if (!next_entry)
>  		next_ts = iter->ts;
>  
> +	/* trace_find_next_entry() may change iter->ent */
> +	entry = iter->ent;
> +
>  	if (verbose) {
>  		char comm[TASK_COMM_LEN];
>  
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
