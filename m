Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8864C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34842098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDVQpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:45:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVQpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:45:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1813B1FB;
        Wed, 22 Apr 2020 09:45:40 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 146903F6CF;
        Wed, 22 Apr 2020 09:45:37 -0700 (PDT)
Subject: Re: [PATCH 04/23] sched,acpi_pad: Convert to sched_set_fifo*()
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, rafael.j.wysocki@intel.com
References: <20200422112719.826676174@infradead.org>
 <20200422112831.455977635@infradead.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c620bb30-eeee-336b-f8d6-a98e903a48e2@arm.com>
Date:   Wed, 22 Apr 2020 18:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422112831.455977635@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 13:27, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> In this case, use fifo_low, because it only cares about being above
> SCHED_NORMAL. Effectively no change in behaviour.
> 
> XXX: this driver is still complete crap; why isn't it using proper
> idle injection or at the very least play_idle() ?
> 
> Cc: rafael.j.wysocki@intel.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/acpi/acpi_pad.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -136,12 +136,11 @@ static unsigned int idle_pct = 5; /* per
>  static unsigned int round_robin_time = 1; /* second */
>  static int power_saving_thread(void *data)
>  {
> -	struct sched_param param = {.sched_priority = 1};
>  	int do_sleep;
>  	unsigned int tsk_index = (unsigned long)data;
>  	u64 last_jiffies = 0;
>  
> -	sched_setscheduler(current, SCHED_RR, &param);

I was wondering what happened to the SCHED_RR cases but as I can see now
they are handled here and in the next patch.

> +	sched_set_fifo_low(current);
>  
>  	while (!kthread_should_stop()) {
>  		unsigned long expire_time;
> 
> 
