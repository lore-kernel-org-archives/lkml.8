Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E677CC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13BF2467A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAMVEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:04:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbgAMVEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:04:16 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 263A0206D7;
        Mon, 13 Jan 2020 21:04:15 +0000 (UTC)
Date:   Mon, 13 Jan 2020 16:04:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <peterz@infradead.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] idle: fix spelling mistake "iterrupts" -> "interrupts"
Message-ID: <20200113160413.5afcfbd7@gandalf.local.home>
In-Reply-To: <20200110025604.34373-1-hewenliang4@huawei.com>
References: <20200110025604.34373-1-hewenliang4@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter,

I guess you could just pull this into one of your queues.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Thu, 9 Jan 2020 21:56:04 -0500
Hewenliang <hewenliang4@huawei.com> wrote:

> There is a spelling misake in comments of cpuidle_idle_call. Fix it.
> 
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>
> ---
>  kernel/sched/idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f65ef1e2f204..d29ebe8c63dd 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -158,7 +158,7 @@ static void cpuidle_idle_call(void)
>  	/*
>  	 * Suspend-to-idle ("s2idle") is a system state in which all user space
>  	 * has been frozen, all I/O devices have been suspended and the only
> -	 * activity happens here and in iterrupts (if any).  In that case bypass
> +	 * activity happens here and in interrupts (if any). In that case bypass
>  	 * the cpuidle governor and go stratight for the deepest idle state
>  	 * available.  Possibly also suspend the local tick and the entire
>  	 * timekeeping to prevent timer interrupts from kicking us out of idle

