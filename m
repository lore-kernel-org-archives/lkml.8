Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704EC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgGaTdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:33:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgGaTdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:33:52 -0400
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1k1amr-0002Ir-Mm
        for linux-kernel@vger.kernel.org; Fri, 31 Jul 2020 19:33:49 +0000
Received: by mail-oo1-f72.google.com with SMTP id v21so12624642ooq.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 12:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UfcxnqQXz45WSHJuykuGHWzN2VIv6JtmJCEatnLzos=;
        b=rgUljsswn0Ow/eFo8GbqLpXq+M4AteQQCCfQITHsnGZcUdsChVMSnnsVaPh35uWxVK
         CpbgnYAgjVgb0PkxymD1xDo1DfXqi/SHf8pYCEDgk9jiLY1uV+Myw80F8ocL0FoiX+Bf
         qImm2YskLrao2fcWQIBM41jB7wGLP5oPNU34LPCD5uwvVPPNuQYbPxt3627bZKODVNjS
         ow2PVKdNGans1lm4Q1ihdV2kysWqovEsvb+aTZ5YI0aa6nUE2rgWVJzyek81361TQBht
         YiSHaXKy2xQ5aLxLXDSRJgAMOplCPthXcj9A1ZLINlV/aKfJwKxxgChHaayjhuGJtaSy
         yZPw==
X-Gm-Message-State: AOAM532oD/ALTFfpctHj8kJkF2qL9MwBuDf2v1xwEcl4UQHJxXGIhToe
        hk/hKH81H2yPV4DhaCNo5UHO+kNacEuPVprBAbd1QDbsaQI7pTYIJSPiulCbDvSdq9EatGTf6js
        0KDu1+iOVTyovG8TEFNP8fsDiyAwhegjpBpcxpfWmHQ==
X-Received: by 2002:aca:1904:: with SMTP id l4mr128084oii.67.1596224028603;
        Fri, 31 Jul 2020 12:33:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6SVnCUx4j4tWOYOHp5bXL/UEbqVmdXAz2oYJ378BGhoFK8umq6n3SCpPF/jUvjUew6ye1Ww==
X-Received: by 2002:aca:1904:: with SMTP id l4mr128070oii.67.1596224028188;
        Fri, 31 Jul 2020 12:33:48 -0700 (PDT)
Received: from xps13.dannf (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id p143sm1665093oop.14.2020.07.31.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 12:33:47 -0700 (PDT)
Date:   Fri, 31 Jul 2020 13:33:45 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian May <ian.may@canonical.com>
Subject: Re: [for-next][PATCH 09/18] tracing: Move pipe reference to trace
 array instead of current_tracer
Message-ID: <20200731193345.GA54749@xps13.dannf>
References: <20200702215812.428188663@goodmis.org>
 <20200702215832.784471709@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702215832.784471709@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:58:21PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If a process has the trace_pipe open on a trace_array, the current tracer
> for that trace array should not be changed. This was original enforced by a
> global lock, but when instances were introduced, it was moved to the
> current_trace. But this structure is shared by all instances, and a
> trace_pipe is for a single instance. There's no reason that a process that
> has trace_pipe open on one instance should prevent another instance from
> changing its current tracer. Move the reference counter to the trace_array
> instead.
> 
> This is marked as "Fixes" but is more of a clean up than a true fix.
> Backport if you want, but its not critical.

Thanks Steven! In case it helps backport consideration, I wanted to
note that this addresses an issue we've seen with users trying to
change current_tracer when they happen to have rasdaemon
installed. rasdaemon uses the trace_pipe interface at runtime, which
therefore blocks changing the current tracer. But of course, unless
you know about rasdaemon internals, it isn't exactly an obvious
failure mode.

  -dann

> Fixes: cf6ab6d9143b1 ("tracing: Add ref count to tracer for when they are being read by pipe")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 12 ++++++------
>  kernel/trace/trace.h |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8241d1448d70..64c5b8146cca 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5891,7 +5891,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  	}
>  
>  	/* If trace pipe files are being read, we can't change the tracer */
> -	if (tr->current_trace->ref) {
> +	if (tr->trace_ref) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -6107,7 +6107,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
>  
>  	nonseekable_open(inode, filp);
>  
> -	tr->current_trace->ref++;
> +	tr->trace_ref++;
>  out:
>  	mutex_unlock(&trace_types_lock);
>  	return ret;
> @@ -6126,7 +6126,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
>  
>  	mutex_lock(&trace_types_lock);
>  
> -	tr->current_trace->ref--;
> +	tr->trace_ref--;
>  
>  	if (iter->trace->pipe_close)
>  		iter->trace->pipe_close(iter);
> @@ -7428,7 +7428,7 @@ static int tracing_buffers_open(struct inode *inode, struct file *filp)
>  
>  	filp->private_data = info;
>  
> -	tr->current_trace->ref++;
> +	tr->trace_ref++;
>  
>  	mutex_unlock(&trace_types_lock);
>  
> @@ -7529,7 +7529,7 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
>  
>  	mutex_lock(&trace_types_lock);
>  
> -	iter->tr->current_trace->ref--;
> +	iter->tr->trace_ref--;
>  
>  	__trace_array_put(iter->tr);
>  
> @@ -8737,7 +8737,7 @@ static int __remove_instance(struct trace_array *tr)
>  	int i;
>  
>  	/* Reference counter for a newly created trace array = 1. */
> -	if (tr->ref > 1 || (tr->current_trace && tr->current_trace->ref))
> +	if (tr->ref > 1 || (tr->current_trace && tr->trace_ref))
>  		return -EBUSY;
>  
>  	list_del(&tr->list);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 13db4000af3f..f21607f87189 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -356,6 +356,7 @@ struct trace_array {
>  	struct trace_event_file *trace_marker_file;
>  	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
>  	int			ref;
> +	int			trace_ref;
>  #ifdef CONFIG_FUNCTION_TRACER
>  	struct ftrace_ops	*ops;
>  	struct trace_pid_list	__rcu *function_pids;
> @@ -547,7 +548,6 @@ struct tracer {
>  	struct tracer		*next;
>  	struct tracer_flags	*flags;
>  	int			enabled;
> -	int			ref;
>  	bool			print_max;
>  	bool			allow_instances;
>  #ifdef CONFIG_TRACER_MAX_TRACE
