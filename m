Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696C72087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgDVMv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgDVMv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:51:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5BD20787;
        Wed, 22 Apr 2020 12:51:56 +0000 (UTC)
Date:   Wed, 22 Apr 2020 08:51:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, wim@linux-watchdog.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 16/23] sched,watchdog: Convert to sched_set_fifo()
Message-ID: <20200422085155.7549ca94@gandalf.local.home>
In-Reply-To: <20200422112832.165197058@infradead.org>
References: <20200422112719.826676174@infradead.org>
        <20200422112832.165197058@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 13:27:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively changes prio from 99 to 50.

Hmm, this being a watchdog, and looking at commit 38a1222ae4f364d
("watchdog: core: make sure the watchdog worker always works")

I wonder if we should add a sched_set_high(), or have some other kind of
watchdog handler that is guaranteed to trigger.

-- Steve


> 
> Cc: wim@linux-watchdog.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/watchdog/watchdog_dev.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -1144,14 +1144,13 @@ void watchdog_dev_unregister(struct watc
>  int __init watchdog_dev_init(void)
>  {
>  	int err;
> -	struct sched_param param = {.sched_priority = MAX_RT_PRIO - 1,};
>  
>  	watchdog_kworker = kthread_create_worker(0, "watchdogd");
>  	if (IS_ERR(watchdog_kworker)) {
>  		pr_err("Failed to create watchdog kworker\n");
>  		return PTR_ERR(watchdog_kworker);
>  	}
> -	sched_setscheduler(watchdog_kworker->task, SCHED_FIFO, &param);
> +	sched_set_fifo(watchdog_kworker->task);
>  
>  	err = class_register(&watchdog_class);
>  	if (err < 0) {
> 

