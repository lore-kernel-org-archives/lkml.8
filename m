Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355C1C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B132082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BfgtY2l3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBEV6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:58:04 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52031 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgBEV6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:58:02 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so1551848pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZiszdRhEoXDklowAhrMMrF/LCE5Ul6eKPbb4HvqS4w=;
        b=BfgtY2l3umi7jAcYAQkg0xPmgX1OhRn09atiKDbbeZ66YUiA39WaRMI0IYWXIR78lH
         camocExRGLndJzc7CcnzUHTuiZsTZGalRcwYsKd161M1EvmA9q3xNSK01OzMDVRNYtOl
         TX4dEOq/PIsoUdTqRGSWus5SFSKGc+Pir9A0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZiszdRhEoXDklowAhrMMrF/LCE5Ul6eKPbb4HvqS4w=;
        b=MsDsZelhQOcARljErtulWZBPkoXY5XaeJZ1Lge7eRca2lKL30dq5Vz0mVCbbO45KNY
         fG2yd56O2VLerODYI+LSW/BixlyAElG4gtHOrf9tlI5h6S7xG0mrrA+c2Obdy22eNLPv
         dSD7VvaaiAuZqxTWP+0205bIAAAL8NQ6+k2FLQ/G+6mbEd9xhopHiihimJUAYJBJDCsE
         5niUIlBVYAbQPKGybMwCEHhEKwYJnUODySd6WeCxjR4fK1KLHajEHHJR1q/j5HSFxa7i
         w/7ddtbMJ3tnjh4oURj5YtEY9yBL3tz7FvgGr9hSBllZ3HK3S0G4xLDy+Eo0SlO/4NNR
         3PpQ==
X-Gm-Message-State: APjAAAUdUtuKZ7xxa8cIAWIT19ngDczePylJy01K7erFyUTCC5N44Tnm
        X4uOlzHyG7qDUOaAUB0npQXHZw==
X-Google-Smtp-Source: APXvYqw6aPnw9wiX99xKRjaXoLALCuAIA38bb2qb5PqIt39eb/sDjSo3NuwC4AtV73voA3Z/K7bpVw==
X-Received: by 2002:a17:902:bf49:: with SMTP id u9mr64670pls.199.1580939881455;
        Wed, 05 Feb 2020 13:58:01 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d2sm717301pjv.18.2020.02.05.13.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 13:58:00 -0800 (PST)
Date:   Wed, 5 Feb 2020 16:57:59 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Amol Grover <frextrite@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: Re: [PATCH] ftrace: Protect ftrace_graph_hash with ftrace_sync
Message-ID: <20200205215759.GK142103@google.com>
References: <20200205094156.717b36c9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205094156.717b36c9@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 09:41:56AM -0500, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As function_graph tracer can run when RCU is not "watching", it can not be
> protected by synchronize_rcu() it requires running a task on each CPU before
> it can be freed. Calling schedule_on_each_cpu(ftrace_sync) needs to be used.
> 
> Link: https://lore.kernel.org/r/20200205131110.GT2935@paulmck-ThinkPad-P72
> 
> Cc: stable@vger.kernel.org
> Fixes: b9b0c831bed26 ("ftrace: Convert graph filter to use hash tables")
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
>  kernel/trace/ftrace.c | 11 +++++++++--
>  kernel/trace/trace.h  |  2 ++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 481ede3eac13..3f7ee102868a 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5867,8 +5867,15 @@ ftrace_graph_release(struct inode *inode, struct file *file)
>  
>  		mutex_unlock(&graph_lock);
>  
> -		/* Wait till all users are no longer using the old hash */
> -		synchronize_rcu();
> +		/*
> +		 * We need to do a hard force of sched synchronization.
> +		 * This is because we use preempt_disable() to do RCU, but
> +		 * the function tracers can be called where RCU is not watching
> +		 * (like before user_exit()). We can not rely on the RCU
> +		 * infrastructure to do the synchronization, thus we must do it
> +		 * ourselves.
> +		 */
> +		schedule_on_each_cpu(ftrace_sync);
>  
>  		free_ftrace_hash(old_hash);
>  	}
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 8c52f5de9384..3c75d29bd861 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -979,6 +979,7 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
>  	 * Have to open code "rcu_dereference_sched()" because the
>  	 * function graph tracer can be called when RCU is not
>  	 * "watching".
> +	 * Protected with schedule_on_each_cpu(ftrace_sync)
>  	 */
>  	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
>  
> @@ -1031,6 +1032,7 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
>  	 * Have to open code "rcu_dereference_sched()" because the
>  	 * function graph tracer can be called when RCU is not
>  	 * "watching".
> +	 * Protected with schedule_on_each_cpu(ftrace_sync)
>  	 */
>  	notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
>  						 !preemptible());
> -- 
> 2.20.1
> 
