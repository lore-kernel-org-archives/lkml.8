Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64664C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFCB207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgFRR5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbgFRR5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:57:41 -0400
Received: from home.goodmis.org (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2F020734;
        Thu, 18 Jun 2020 17:57:40 +0000 (UTC)
Date:   Thu, 18 Jun 2020 13:57:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200618175733.GA26895@home.goodmis.org>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
 <20200609212509.GA239889@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609212509.GA239889@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:25:09PM -0700, Guenter Roeck wrote:
> > 
> > Still occurring on Linus' tree.  This needs to be fixed.  (And not by removing
> > support for randstruct; that's not a "fix"...)
> > 
> 
> How about the hack below ?

My test suite failed due to this bug (on my allmodconfig test).

Your hack appears to fix it. I've applied it to my "fixes" patches applied to
my test suite before building my kernels.

Thanks!

-- Steve


> 
> Guenter
> 
> ---
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c5d96e3e7fff..df1cbb04f9b3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -629,6 +629,15 @@ struct wake_q_node {
>  	struct wake_q_node *next;
>  };
>  
> +/*
> + * Hack around assumption that wake_entry_type follows wake_entry even with
> + * CONFIG_GCC_PLUGIN_RANDSTRUCT=y.
> + */
> +struct _wake_entry {
> +	struct llist_node	wake_entry;
> +	unsigned int		wake_entry_type;
> +};
> +
>  struct task_struct {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/*
> @@ -653,8 +662,9 @@ struct task_struct {
>  	unsigned int			ptrace;
>  
>  #ifdef CONFIG_SMP
> -	struct llist_node		wake_entry;
> -	unsigned int			wake_entry_type;
> +	struct _wake_entry		_we;
> +#define wake_entry		_we.wake_entry
> +#define wake_entry_type		_we.wake_entry_type
>  	int				on_cpu;
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */
