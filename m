Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE47C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DCC20857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgDVMxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgDVMxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:53:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E87720776;
        Wed, 22 Apr 2020 12:53:47 +0000 (UTC)
Date:   Wed, 22 Apr 2020 08:53:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, hverkuil@xs4all.nl,
        awalls@md.metrocast.net
Subject: Re: [PATCH 09/23] sched,ivtv: Convert to sched_set_fifo*()
Message-ID: <20200422085345.48b50508@gandalf.local.home>
In-Reply-To: <20200422112831.752048390@infradead.org>
References: <20200422112719.826676174@infradead.org>
        <20200422112831.752048390@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 13:27:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively changes from 99 to 50.

I wonder for the 99 users, we should have a sched_set_high() that would set
the task to something like 75.

That is, above default 50?


-- Steve


> 
> Cc: hverkuil@xs4all.nl
> Cc: awalls@md.metrocast.net
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/media/pci/ivtv/ivtv-driver.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/drivers/media/pci/ivtv/ivtv-driver.c
> +++ b/drivers/media/pci/ivtv/ivtv-driver.c
> @@ -737,8 +737,6 @@ static void ivtv_process_options(struct
>   */
>  static int ivtv_init_struct1(struct ivtv *itv)
>  {
> -	struct sched_param param = { .sched_priority = 99 };
> -
>  	itv->base_addr = pci_resource_start(itv->pdev, 0);
>  	itv->enc_mbox.max_mbox = 2; /* the encoder has 3 mailboxes (0-2) */
>  	itv->dec_mbox.max_mbox = 1; /* the decoder has 2 mailboxes (0-1) */
> @@ -758,7 +756,7 @@ static int ivtv_init_struct1(struct ivtv
>  		return -1;
>  	}
>  	/* must use the FIFO scheduler as it is realtime sensitive */
> -	sched_setscheduler(itv->irq_worker_task, SCHED_FIFO, &param);
> +	sched_set_fifo(itv->irq_worker_task);
>  
>  	kthread_init_work(&itv->irq_work, ivtv_irq_work_handler);
>  
> 

