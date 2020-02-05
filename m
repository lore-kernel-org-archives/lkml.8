Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF32C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817C8217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fW9VMren"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBEWGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:06:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35017 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBEWGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:06:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1446762plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0mz8ghzRtlNXRAOessj5ksQCBU4mJW2G9mtxFkaYRDQ=;
        b=fW9VMrenQz9iTmdfdoDMzHKyP8mMhtw2mck9e3ViEKVPBnj6IerWyXo1moiBRnAAij
         bYQkpq6s+48whH++3i/ihUrN6f8hlH54AuBmvHzVdZYO2Yb0LSt8n8yflOTaRVOXY627
         nME6stNH4hW4UJZTcKRuCz/7m7b3BZQtkARrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0mz8ghzRtlNXRAOessj5ksQCBU4mJW2G9mtxFkaYRDQ=;
        b=XG55LFvUs6x0iyPPcyG9VDt63I2zDVgt8GO/NYswtzsLDbQFihZxIG/IBjP30/tJm0
         rpp0JmOKhbNKVlfkliaKW/Gtsg5lZLrPvM2tdFw5xR2ebSaQFI0CuuQWUKTL/eNqPb+S
         7O+PRNg80kLFXdJ7j8+tvZ4v1Evpjk1sbq6W/xljCesUqY6jXtxJn1s0XuuyuvXqVL+u
         XC8oFnVsqikxTcjQii5xQlkwuf7KuvwEI5Z0N3APNWnIpimyz6RiH9FGNamRaYhAvYF+
         wx1oUs0xH88ftM3lNLZ2qi3uHHqRlQ8JJZWr+G3q0sSOhHlJrBV6Tx7ccZmaGU4aigoj
         kKzA==
X-Gm-Message-State: APjAAAVtjWPlmd8jwQ5fOOAINb0UuvLH6x675qTd+yJvjW1embj6lSh2
        qodp2YwfxDUXQ8HKiLAjd4g1SQ==
X-Google-Smtp-Source: APXvYqwPxwRuDtRVckccB99BVAAZnpynaXqtYDYcBqdZyf9yCOvN/yE8DvmTukAFZ2dnb8mjozDU4A==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr143755pll.236.1580940361372;
        Wed, 05 Feb 2020 14:06:01 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 23sm494645pfh.28.2020.02.05.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:06:01 -0800 (PST)
Date:   Wed, 5 Feb 2020 17:06:00 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200205220600.GM142103@google.com>
References: <20200201072703.17330-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201072703.17330-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 12:57:04PM +0530, Amol Grover wrote:
> Fix following instances of sparse error
> kernel/trace/ftrace.c:5664:29: error: incompatible types in comparison
> kernel/trace/ftrace.c:5785:21: error: incompatible types in comparison
> kernel/trace/ftrace.c:5864:36: error: incompatible types in comparison
> kernel/trace/ftrace.c:5866:25: error: incompatible types in comparison
> 
> Use rcu_dereference_protected to access the __rcu annotated pointer.
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  kernel/trace/trace.h  | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 9bf1f2cd515e..959ded08dc13 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5596,7 +5596,7 @@ static const struct file_operations ftrace_notrace_fops = {
>  
>  static DEFINE_MUTEX(graph_lock);
>  
> -struct ftrace_hash *ftrace_graph_hash = EMPTY_HASH;
> +struct ftrace_hash __rcu *ftrace_graph_hash = EMPTY_HASH;
>  struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
>  
>  enum graph_filter_type {
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 63bf60f79398..97dad3326020 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -950,22 +950,25 @@ extern void __trace_graph_return(struct trace_array *tr,
>  				 unsigned long flags, int pc);
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> -extern struct ftrace_hash *ftrace_graph_hash;
> +extern struct ftrace_hash __rcu *ftrace_graph_hash;
>  extern struct ftrace_hash *ftrace_graph_notrace_hash;
>  
>  static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
>  {
>  	unsigned long addr = trace->func;
>  	int ret = 0;
> +	struct ftrace_hash *hash;
>  
>  	preempt_disable_notrace();
>  
> -	if (ftrace_hash_empty(ftrace_graph_hash)) {
> +	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

BTW I think set_ftrace_early_graph() should use rcu_assign_pointer() so that
the early writes to the hash are release-barrier'ed before the global pointer
is updated. I will send a patch for that.

thanks,

 - Joel


> +
> +	if (ftrace_hash_empty(hash)) {
>  		ret = 1;
>  		goto out;
>  	}
>  
> -	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
> +	if (ftrace_lookup_ip(hash, addr)) {
>  
>  		/*
>  		 * This needs to be cleared on the return functions
> -- 
> 2.24.1
> 
