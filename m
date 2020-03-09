Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604520828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCIIVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:21:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbgCIIVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:21:14 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E35596FD0CB43560891F;
        Mon,  9 Mar 2020 16:20:26 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.80) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Mar 2020
 16:20:24 +0800
Subject: Re: [PATCH] timer_list: avoid other cpu soft lockup when printing
 timer list
To:     Stephen Boyd <sboyd@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1582170152-69418-1-git-send-email-yangyingliang@huawei.com>
 <158224928306.184098.11550548610262156729@swboyd.mtv.corp.google.com>
CC:     <tglx@linutronix.de>, <john.stultz@linaro.org>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5E65FC47.8070102@huawei.com>
Date:   Mon, 9 Mar 2020 16:20:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <158224928306.184098.11550548610262156729@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.205.80]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the late reply.

On 2020/2/21 9:41, Stephen Boyd wrote:
> Quoting Yang Yingliang (2020-02-19 19:42:32)
>> If system has many cpus (e.g. 128), it will spend a lot of time to
>> print message to the console when execute echo q > /proc/sysrq-trigger.
>>
>> When /proc/sys/kernel/numa_balancing is enabled, if the migration threads
>> are woke up, the migration thread that on print mesasage cpu can't run
>> until the print finish, another migration thread may trigger soft lockup.
>>
>> PID: 619    TASK: ffffa02fdd8bec80  CPU: 121  COMMAND: "migration/121"
>>    #0 [ffff00000a103b10] __crash_kexec at ffff0000081bf200
>>    #1 [ffff00000a103ca0] panic at ffff0000080ec93c
>>    #2 [ffff00000a103d80] watchdog_timer_fn at ffff0000081f8a14
>>    #3 [ffff00000a103e00] __run_hrtimer at ffff00000819701c
>>    #4 [ffff00000a103e40] __hrtimer_run_queues at ffff000008197420
>>    #5 [ffff00000a103ea0] hrtimer_interrupt at ffff00000819831c
>>    #6 [ffff00000a103f10] arch_timer_dying_cpu at ffff000008b53144
>>    #7 [ffff00000a103f30] handle_percpu_devid_irq at ffff000008174e34
>>    #8 [ffff00000a103f70] generic_handle_irq at ffff00000816c5e8
>>    #9 [ffff00000a103f90] __handle_domain_irq at ffff00000816d1f4
>>   #10 [ffff00000a103fd0] gic_handle_irq at ffff000008081860
>>   --- <IRQ stack> ---
>>   #11 [ffff00000d6e3d50] el1_irq at ffff0000080834c8
>>   #12 [ffff00000d6e3d60] multi_cpu_stop at ffff0000081d9964
>>   #13 [ffff00000d6e3db0] cpu_stopper_thread at ffff0000081d9cfc
>>   #14 [ffff00000d6e3e10] smpboot_thread_fn at ffff00000811e0a8
>>   #15 [ffff00000d6e3e70] kthread at ffff000008118988
>>
>> To avoid this soft lockup, add touch_all_softlockup_watchdogs()
>> in sysrq_timer_list_show()
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   kernel/time/timer_list.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
>> index acb326f..4cb0e6f 100644
>> --- a/kernel/time/timer_list.c
>> +++ b/kernel/time/timer_list.c
>> @@ -289,13 +289,17 @@ void sysrq_timer_list_show(void)
>>   
>>          timer_list_header(NULL, now);
>>   
>> -       for_each_online_cpu(cpu)
>> +       for_each_online_cpu(cpu) {
>> +               touch_all_softlockup_watchdogs();
> Usage of touch_all_softlockup_watchdogs() deserves a comment. Otherwise
> the reader is left to git archaeology to understand why watchdogs are
> being touched. Of course, we failed at that with commit 010704276865
> ("sysrq: Reset the watchdog timers while displaying high-resolution
> timers") which looks awfully similar to this.
OK, I will add a comment later.
>
>>                  print_cpu(NULL, cpu, now);
>> +       }
>>   
>>   #ifdef CONFIG_GENERIC_CLOCKEVENTS
>>          timer_list_show_tickdevices_header(NULL);
>> -       for_each_online_cpu(cpu)
>> +       for_each_online_cpu(cpu) {
>> +               touch_all_softlockup_watchdogs();
>>                  print_tickdevice(NULL, tick_get_device(cpu), cpu);
> print_tickdevice() already has touch_nmi_watchdog() which eventually
> touches the softlockup watchdog. Is the problem that it isn't enough to
> do that when the migration thread is also running?
No, it's not enough.
The soft lockup occurs on other cpu, so other cpu's soft watchdog need 
to be touched.

>
>> +       }
>>   #endif
>>          return;
> .
>


