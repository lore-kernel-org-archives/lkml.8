Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD94C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840B520838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ssVhzTyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgBCQdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:33:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34196 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbgBCQdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:33:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so8108692pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kygvN3JdMT5rx78cW75jLEUMNI3vcBU3dBQx9CHHh28=;
        b=ssVhzTyIIEma75A48rf94bLZxvLV2Ygj35UJQ0/ElMy5zReCrcJWlvCCuAVwB8VEEM
         llqIZ5iH0KbSY++6FbAuS7zmU1K48lVteIrWwROBafWrJk86DC6f6DsiYbQ+WcCZwq8u
         HnYB7uYVt+WC3ZQNE/fe5Uzj89sjepMDJavCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kygvN3JdMT5rx78cW75jLEUMNI3vcBU3dBQx9CHHh28=;
        b=eJ32wGGc0cDzheWwpELZe0bh8/VIicQ2pFpqURHTulW7nWOduDVVw0bYBZTkkJ1clW
         B/K4TPbRvy2gSWWge7XSlz+qlSf9e2otv9uJCZF/D8bbUT/RFkcXNeTsERLA0Z6dyhLN
         B10YnH9u7W6GXSnaJ6ZL5oN8rEnDD/DUAfvWbb7o5o0MeGJWbqQ4Lc1i67HG5Ik+tFL9
         29tFgG8qSYs+yZGWrsbuI99gd2Vq6jJ3ubjqyekMER9pQJ0L1Bnjdc5vaslEdVKQe5Bb
         l5kgI5KZIxcunJWluNjtARROMPqE7WwiSaSALIFsqucfuV1cLofzIBdXhCDCAy2FN7ki
         3ZZw==
X-Gm-Message-State: APjAAAX66+tgfOEZvOE7CgWGCCXmu1zwDtR/O2WTShpTI8vK+3z7b1Dr
        UDNThn/BtzfjsVCcTJQlpFWa0g==
X-Google-Smtp-Source: APXvYqwiD0ofx+MWpoFTDHUC7QLzEfQhhRkJS46LskXJIT7/Zw6mHw+5kbzS177wESnxUfXWKuKlmg==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr25792754pfr.24.1580747582875;
        Mon, 03 Feb 2020 08:33:02 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 11sm22034985pfz.25.2020.02.03.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 08:33:02 -0800 (PST)
Date:   Mon, 3 Feb 2020 11:33:01 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Message-ID: <20200203163301.GB85781@google.com>
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

I think you can use rcu_dereference_sched() here? That way no need to pass
!preemptible.

A preempt-disabled section is an RCU "sched flavor" section. Flavors are
consolidated in the backend, but in the front end the dereference API still
do have flavors.

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
