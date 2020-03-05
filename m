Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63948C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC4F208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AQfv63NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCEJ7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:59:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38248 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCEJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/JtrFN+p8a3QC10s77+QKXamNutI63FbL9mQ/tVqXtE=; b=AQfv63NYpHw2aIOP1taIlPNfSi
        EvrF/Trq9jXMvnhjumleeMn6ICJcj9JMNmlOpjUJqEWdFXkfeD/vadK32d9AIt0f7rmKAc3hJoT+1
        KyYG4XTDPkT9tR6DTyDa07LQcgHB5uXpPOZ4LoqS9IGNHD3owFIeignrZlFTs5AMVEvMLU6aeYvNG
        MO4KYve2jCoVJd2w6dRDaPbKMG+AOXcONTfYNve6dgm+oMgQ2U9VQfmgy0fYPDfl13idVYnRVI03g
        XFLK0R83bqXmElw8rrJMbF97zOzwZ9nzpBPSUGafNWDwMN1hOC1a0CcJsqt9Y0TZsIhQyWkDbG+a1
        XBMc5URg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9nGY-00011M-Sr; Thu, 05 Mar 2020 09:58:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49762303DA3;
        Thu,  5 Mar 2020 10:56:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A95423D4FA17; Thu,  5 Mar 2020 10:58:03 +0100 (CET)
Date:   Thu, 5 Mar 2020 10:58:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, mpe@ellerman.id.au,
        surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
Subject: Re: [PATCH v1 1/1] sched/fair: do not preempt current task if it is
 going to call schedule()
Message-ID: <20200305095803.GW2596@hirez.programming.kicks-ass.net>
References: <20200305081611.29323-1-cl@rock-chips.com>
 <20200305081611.29323-2-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305081611.29323-2-cl@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:16:11PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> when we create a kthread with ktrhead_create_on_cpu(),the child thread
> entry is ktread.c:ktrhead() which will be preempted by the parent after
> call complete(done) while schedule() is not called yet,then the parent
> will call wait_task_inactive(child) but the child is still on the runqueue,
> so the parent will schedule_hrtimeout() for 1 jiffy,it will waste a lot of
> time,especially on startup.
> 
>   parent                             child
> ktrhead_create_on_cpu()
>   wait_fo_completion(&done) -----> ktread.c:ktrhead()
>                              |----- complete(done);--wakeup and preempted by parent
>  kthread_bind() <------------|  |-> schedule();--dequeue here
>   wait_task_inactive(child)     |
>    schedule_hrtimeout(1 jiffy) -|
> 
> So we hope the child just wakeup parent but not preempted by parent, and the
> child is going to call schedule() soon,then the parent will not call
> schedule_hrtimeout(1 jiffy) as the child is already dequeue.
> 
> The same issue for ktrhead_park()&&kthread_parkme().
> This patch can save 120ms on rk312x startup with CONFIG_HZ=300.

> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index b262f47046ca..8a4e4c9cdc22 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -199,8 +199,10 @@ static void __kthread_parkme(struct kthread *self)
>  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>  			break;
>  
> +		set_tsk_going_to_sched(current);
>  		complete(&self->parked);
>  		schedule();
> +		clear_tsk_going_to_sched(current);
>  	}
>  	__set_current_state(TASK_RUNNING);
>  }
> @@ -245,8 +247,10 @@ static int kthread(void *_create)
>  	/* OK, tell user we're spawned, wait for stop or wakeup */
>  	__set_current_state(TASK_UNINTERRUPTIBLE);
>  	create->result = current;
> +	set_tsk_going_to_sched(current);
>  	complete(done);
>  	schedule();
> +	clear_tsk_going_to_sched(current);
>  
>  	ret = -EINTR;
>  	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {

Were you looking for this? I think it does the same without having
fallen from the ugly tree...

diff --git a/kernel/kthread.c b/kernel/kthread.c
index b262f47046ca..62699ff414f4 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -199,8 +199,10 @@ static void __kthread_parkme(struct kthread *self)
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
 
+		preempt_disable()
 		complete(&self->parked);
-		schedule();
+		schedule_preempt_disabled();
+		preempt_enable();
 	}
 	__set_current_state(TASK_RUNNING);
 }
@@ -245,8 +247,10 @@ static int kthread(void *_create)
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result = current;
+	preempt_disable()
 	complete(done);
-	schedule();
+	schedule_preempt_disabled();
+	preempt_enable();
 
 	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
