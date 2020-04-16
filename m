Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8F5C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2467E214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505948AbgDPPfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437135AbgDPPfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:35:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6A921927;
        Thu, 16 Apr 2020 15:35:04 +0000 (UTC)
Date:   Thu, 16 Apr 2020 11:35:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cpuacct: Fix charge cpuacct.usage_sys
 incorrently.
Message-ID: <20200416113502.53b33a1c@gandalf.local.home>
In-Reply-To: <20200416141833.50663-1-songmuchun@bytedance.com>
References: <20200416141833.50663-1-songmuchun@bytedance.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 22:18:33 +0800
Muchun Song <songmuchun@bytedance.com> wrote:

> The user_mode(task_pt_regs(tsk)) always return true for
> user thread, and false for kernel thread. So it means that
> the cpuacct.usage_sys is the time that kernel thread uses
> not the time that thread uses in the kernel mode. We can
> use get_irq_regs() instead of task_pt_regs() to fix it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/sched/cpuacct.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 6448b0438ffb2..edfc62554648e 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -5,6 +5,7 @@
>   * Based on the work by Paul Menage (menage@google.com) and Balbir Singh
>   * (balbir@in.ibm.com).
>   */
> +#include <asm/irq_regs.h>
>  #include "sched.h"
>  
>  /* Time spent by the tasks of the CPU accounting group executing in ... */
> @@ -339,7 +340,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  {
>  	struct cpuacct *ca;
>  	int index = CPUACCT_STAT_SYSTEM;
> -	struct pt_regs *regs = task_pt_regs(tsk);
> +	struct pt_regs *regs = get_irq_regs();

But get_irq_regs() is only available from interrupt context. This will be
NULL most the time, whereas the original way will have regs existing for
the task.

>  
>  	if (regs && user_mode(regs))
>  		index = CPUACCT_STAT_USER;

To show this, I applied your patch then did the following:

 # echo 'p:cpuacct cpuacct_charge+0x36 regs=%ax' > /sys/kernel/tracing/kprobe_events

Where I found that the test of 'regs' is %rax at offset 0x36.

 # trace-cmd start -p function -l cpuacct_charge -e kprobes
 # trace-cmd show
# tracer: function
#
# entries-in-buffer/entries-written: 70664/70664   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           <...>-1720  [002] d..2   306.430302: cpuacct_charge <-update_curr
           <...>-1720  [002] d..3   306.430306: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
           <...>-1720  [002] dN.2   306.430321: cpuacct_charge <-update_curr
           <...>-1720  [002] dN.3   306.430322: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
           <...>-1720  [002] d..2   306.430355: cpuacct_charge <-update_curr
           <...>-1720  [002] d..3   306.430357: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
            bash-1652  [006] d.h2   306.430799: cpuacct_charge <-update_curr
            bash-1652  [006] d.h3   306.430802: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0xffffaf34012abdd8
           <...>-199   [005] d.h2   306.430806: cpuacct_charge <-update_curr
           <...>-199   [005] d.h3   306.430809: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0xffffaf3400347c38
           <...>-16    [001] d..2   306.430873: cpuacct_charge <-update_curr
           <...>-16    [001] d..3   306.430875: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
           <...>-199   [005] d..2   306.430936: cpuacct_charge <-update_curr
           <...>-199   [005] d..3   306.430937: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
            bash-1652  [006] d..2   306.430944: cpuacct_charge <-update_curr
            bash-1652  [006] d..3   306.430946: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
            sshd-1649  [000] d..2   306.430990: cpuacct_charge <-update_curr
            sshd-1649  [000] d..3   306.430992: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
     rcu_preempt-10    [006] d..2   306.432844: cpuacct_charge <-update_curr
     rcu_preempt-10    [006] d..3   306.432846: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
     rcu_preempt-10    [006] d..2   306.436848: cpuacct_charge <-update_curr
     rcu_preempt-10    [006] d..3   306.436850: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
     rcu_preempt-10    [006] d..2   306.440868: cpuacct_charge <-update_curr
     rcu_preempt-10    [006] d..3   306.440871: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
     rcu_preempt-10    [006] d..2   306.444867: cpuacct_charge <-update_curr
     rcu_preempt-10    [006] d..3   306.444870: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
     kworker/2:1-127   [002] d..2   306.446925: cpuacct_charge <-update_curr
     kworker/2:1-127   [002] d..3   306.446928: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
     rcu_preempt-10    [006] d..2   306.448868: cpuacct_charge <-update_curr
     rcu_preempt-10    [006] d..3   306.448870: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0
     rcu_preempt-10    [006] d..2   306.452869: cpuacct_charge <-update_curr
     rcu_preempt-10    [006] d..3   306.452872: cpuacct: (cpuacct_charge+0x36/0x1f0) regs=0x0

The only times regs has content is from the the interrupt handler (seen as
the 'h' in the status portion of the trace.

-- Steve
