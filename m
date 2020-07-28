Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A0B20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgG1JJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:09:36 -0400
Received: from foss.arm.com ([217.140.110.172]:59026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgG1JJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:09:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D78930E;
        Tue, 28 Jul 2020 02:09:35 -0700 (PDT)
Received: from [10.37.12.33] (unknown [10.37.12.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FFE13F66E;
        Tue, 28 Jul 2020 02:09:33 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
To:     vincent.donnefort@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7131ec02-39ae-fe8a-e3d6-171a6e6c8103@arm.com>
Date:   Tue, 28 Jul 2020 10:09:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 7/27/20 11:59 AM, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Introducing two macro helpers u64_32read() and u64_32read_set_copy() to
> factorize the u64 vminruntime and last_update_time read on a 32-bits
> architecture. Those new helpers encapsulate smp_rmb() and smp_wmb()
> synchronization and therefore, have a small penalty in set_task_rq_fair()
> and init_cfs_rq().
> 
> The choice of using a macro over an inline function is driven by the
> conditional u64 variable copy declarations.
> 
>    #ifndef CONFIG_64BIT
>       u64 [vminruntime|last_update_time]_copy;
>    #endif
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 

I've run it on 32-bit ARM big.LITTLE platform (odroid xu3) with
the CONFIG_FAIR_GROUP_SCHED and CONFIG_CGROUP_SCHED.

I haven't observed any issues while running hackbench or booting
the kernel, the performance of affected function
set_task_rq_fair() is the same.

Function profile results after hackbench test:
--------w/ Vincent's patch + performance cpufreq gov------------
root@odroid:/sys/kernel/debug/tracing# cat trace_stat/function?
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      4068    3753.185 us     0.922 
us        1.239 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      4492    4180.133 us     0.930 
us        2.318 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      4208    3991.386 us     0.948 
us        13.552 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      4753    4432.231 us     0.932 
us        5.875 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      7980    5037.096 us     0.631 
us        1.690 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      8143    5078.515 us     0.623 
us        2.930 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      9721    6477.904 us     0.666 
us        2.425 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      7743    4896.002 us     0.632 
us        1.188 us


-----------w/o Vincent patch, performance cpufreq gov------------
root@odroid:/sys/kernel/debug/tracing# cat trace_stat/function?
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      6525    5830.450 us     0.893 
us        3.213 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      6646    6069.444 us     0.913 
us        9.651 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      5988    5646.133 us     0.942 
us        7.685 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      5883    5390.103 us     0.916 
us        29.283 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      3844    2561.186 us     0.666 
us        0.933 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      5515    3491.011 us     0.633 
us        9.845 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      6947    4808.522 us     0.692 
us        5.822 us
   Function                               Hit    Time            Avg 
         s^2
   --------                               ---    ----            --- 
         ---
   set_task_rq_fair                      4530    2810.000 us     0.620 
us        0.554 us


Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
