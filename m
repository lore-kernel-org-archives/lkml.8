Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4476FC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BDF2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgBELd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:33:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgBELdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:33:55 -0500
Received: from oasis.local.home (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA2FD2072B;
        Wed,  5 Feb 2020 11:33:53 +0000 (UTC)
Date:   Wed, 5 Feb 2020 06:33:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205063349.4c3df2c0@oasis.local.home>
In-Reply-To: <20200205105113.283672584@goodmis.org>
References: <20200205104929.313040579@goodmis.org>
        <20200205105113.283672584@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul and Joel,

Care to ack this patch (or complain about it ;-) ?

-- Steve


On Wed, 05 Feb 2020 05:49:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Because the function graph tracer can execute in sections where RCU is not
> "watching", the rcu_dereference_sched() for the has needs to be open coded.
> This is fine because the RCU "flavor" of the ftrace hash is protected by
> its own RCU handling (it does its own little synchronization on every CPU
> and does not rely on RCU sched).
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 022def96d307..8c52f5de9384 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -975,6 +975,11 @@ static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
>  
>  	preempt_disable_notrace();
>  
> +	/*
> +	 * Have to open code "rcu_dereference_sched()" because the
> +	 * function graph tracer can be called when RCU is not
> +	 * "watching".
> +	 */
>  	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
>  
>  	if (ftrace_hash_empty(hash)) {
> @@ -1022,6 +1027,11 @@ static inline int ftrace_graph_notrace_addr(unsigned long addr)
>  
>  	preempt_disable_notrace();
>  
> +	/*
> +	 * Have to open code "rcu_dereference_sched()" because the
> +	 * function graph tracer can be called when RCU is not
> +	 * "watching".
> +	 */
>  	notrace_hash = rcu_dereference_protected(ftrace_graph_notrace_hash,
>  						 !preemptible());
>  

