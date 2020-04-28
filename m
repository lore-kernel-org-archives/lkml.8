Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86064206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgD1Opp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgD1Opp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:45:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85F1206B9;
        Tue, 28 Apr 2020 14:45:44 +0000 (UTC)
Date:   Tue, 28 Apr 2020 10:45:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
Message-ID: <20200428104543.3926eaaf@gandalf.local.home>
In-Reply-To: <20200428104409.0995ceb0@gandalf.local.home>
References: <20200424223630.224895-1-joel@joelfernandes.org>
        <5EA80319.7080005@cn.fujitsu.com>
        <20200428104409.0995ceb0@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 10:44:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 28 Apr 2020 18:19:05 +0800
> Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> 
> > Hi Joel,
> > 
> > Thanks for your quick fix.
> > 
> > Unfortunately, it fixes my original panic but introduces other
> > issues(two wanings and one panic) on my arm64 vm, as below:
> >  
> 
> Does the following on top of Joel's patch fix it?
> 
> -- Steve
> 
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> index 1c28ca20e30b..6d9131ae7e8c 100644
> --- a/kernel/trace/preemptirq_delay_test.c
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -113,15 +113,27 @@ static int preemptirq_delay_run(void *data)
>  
>  	for (i = 0; i < s; i++)
>  		(testfuncs[i])(i);
> +
> +	while (!kthread_should_stop()) {
> +		schedule();
> +		set_current_state(TASK_INTERRUPTIBLE);
> +	}
> +
> +	__set_current_state(TASK_RUNNING);
> +
>  	return 0;
>  }
>  


The below isn't needed, as the return does check IS_ERR().

-- Steve

>  static struct task_struct *preemptirq_start_test(void)
>  {
> +	struct task_struct *task;
>  	char task_name[50];
>  
>  	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
> -	return kthread_run(preemptirq_delay_run, NULL, task_name);
> +	task = kthread_run(preemptirq_delay_run, NULL, task_name);
> +	if (IS_ERR(task))
> +		return NULL;
> +	return task;
>  }
>  
>  
>  

