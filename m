Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB397C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE71622B43
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgHTQxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbgHTQxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:53:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C3D2072D;
        Thu, 20 Aug 2020 16:53:40 +0000 (UTC)
Date:   Thu, 20 Aug 2020 12:53:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rjw@rjwysocki.net, joel@joelfernandes.org,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
Message-ID: <20200820125337.01440a50@oasis.local.home>
In-Reply-To: <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
References: <20200820073031.886217423@infradead.org>
        <20200820103643.1b9abe88@oasis.local.home>
        <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 16:58:21 +0200
peterz@infradead.org wrote:

> @@ -91,11 +91,11 @@ void __cpuidle default_idle_call(void)
>  	if (current_clr_polling_and_test()) {
>  		local_irq_enable();
>  	} else {
> -		rcu_idle_enter();
>  		stop_critical_timings();
> +		rcu_idle_enter();
>  		arch_cpu_idle();
> -		start_critical_timings();
>  		rcu_idle_exit();
> +		start_critical_timings();
>  	}
>  }
>  

tip/master didn't have the above function and instead I had this:

@@ -93,11 +93,11 @@ void __cpuidle default_idle_call(void)
        } else {
 
                trace_cpu_idle(1, smp_processor_id());
-               rcu_idle_enter();
                stop_critical_timings();
+               rcu_idle_enter();
                arch_cpu_idle();
-               start_critical_timings();
                rcu_idle_exit();
+               start_critical_timings();
                trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
        }
 }

But it booted to completion without warning with this patch applied.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

For the entire series, with this update.

-- Steve
