Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FFC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E9220728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NIdJIKWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgDXJ6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:58:45 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:41783 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgDXJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:58:44 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id Rv6NjEO4DlKa1Rv6QjMqRq; Fri, 24 Apr 2020 11:58:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1587722323; bh=k6dsvmXgOpFSBh1dJIhsVbphBki+pzKk7qpeRVznUZE=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=NIdJIKWmFy07aFXiA658Jzz6vr/e23IiUo05wvwN8VZFwshJoOJPtHqapSP6lxZf9
         ciF5PZn3fbvbAaU7fugKWxtX4Zj7GdpIr3aRS4QmopR3UaAY89pC0K9C/YLLg4Z2Ma
         nW9BdQe7sZ8aAW+gEjp64UkmLIlTq9saH6e6SPwEe0E7jR9lxeCZG8I3G/JlpHPvwI
         PaZl2FlqBEsmW9i+skvH2yyWwLat9aLJy7Fhyj8m0PfdL3TSMKG416sH4cesInAm+D
         IYe/7DdL2xVcaCxSE/iKip2ne55mXIdLtB0bvGD50AbXH1WK4w7ixM/bqSahWtuOsp
         d+thyBPCzZYzw==
Subject: Re: [PATCH 09/23] sched,ivtv: Convert to sched_set_fifo*()
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        awalls@md.metrocast.net
References: <20200422112719.826676174@infradead.org>
 <20200422112831.752048390@infradead.org>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <b78b07d3-afda-8080-4647-c1592d935943@xs4all.nl>
Date:   Fri, 24 Apr 2020 11:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422112831.752048390@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLH6cCu7ls7JMylCQb7UHQdwqril0bd5dMMlpIrPgFO4qanlgNpFOWnmIi8Ch1OdRthjkvTi/Oqr98edA6dQTfUJLWyzDYRttj7iIdsMXV7oHuXFMYKz
 7fV9mCwzshA8v5vhRh2FwxhEZCWJClQa+nQ576BmX50WI7s2rwchyLHUEwHh8EBnMO949eN0vPXYFqpFQoGyUxkOv+MvrgSONfq3HtVR2BHfW0wOpCm54M9F
 OjRULg+BaKaylflUM7RgsbaDUSF7u9f6y4zzW8wyc/KWicBcQXjIPcmEQRt8mN6Ra6XCeJiSfKjpPrI6nadqqrAPWbIrAgQuoyE5w5SJarFxiZUAEdu5GrJy
 9DXrl/2i0vJBDYdzzvZQdiec2lmig459ZAUaNQPmTilKEwMBCrrEBwKIoz4UmGvCMN1ilYl48MT1Q63ua/QBjilXqpWKjbvfT1mJWn7oMvjNyGwWZu17GpqZ
 zCAa+utf/9BkzmWVUyBpMgZSG0lBaTUXG0IzZwOY+6ZSJISxkkzdm/tsMsbedBLjMuP2+3mqYk8u3xsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 13:27, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively changes from 99 to 50.
> 
> Cc: hverkuil@xs4all.nl
> Cc: awalls@md.metrocast.net
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

I didn't see any difference in behavior when I changed the prio from 99 to 50,
so it doesn't seem to be a harmful change :-)

Regards,

	Hans

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
> 

