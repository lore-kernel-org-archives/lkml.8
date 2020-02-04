Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576D7C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9BA2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgBDH0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:26:12 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46840 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgBDH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:26:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tp78NT9_1580801078;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Tp78NT9_1580801078)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Feb 2020 15:24:39 +0800
Subject: Re: [PATCH RESEND] mm: fix tick_sched timer blocked by
 pgdat_resize_lock
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200110082510.172517-2-shile.zhang@linux.alibaba.com>
 <20200110093053.34777-1-shile.zhang@linux.alibaba.com>
 <1ee6088c-9e72-8824-3a9a-fc099d196faf@virtuozzo.com>
 <c7ac0338-78a6-2ae3-465c-2d6371d96a72@linux.alibaba.com>
 <9420eab3-5e5e-150f-53c9-6cd40bacf859@virtuozzo.com>
 <ba242ee6-22be-3047-5a88-e6b39e1509ef@linux.alibaba.com>
 <e87a04fa-c96b-c15e-126e-46f1cc2885d1@virtuozzo.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <39eb8ac4-bdb2-bdf2-9189-2d088edb43c1@linux.alibaba.com>
Date:   Tue, 4 Feb 2020 15:24:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e87a04fa-c96b-c15e-126e-46f1cc2885d1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

Sorry for ping, could you please also help to check this issue?
Any comments from you is welcome!

Thanks!


On 2020/1/15 17:45, Kirill Tkhai wrote:
> On 14.01.2020 11:54, Shile Zhang wrote:
>>
>> On 2020/1/13 16:11, Kirill Tkhai wrote:
>>> On 13.01.2020 03:54, Shile Zhang wrote:
>>>> On 2020/1/10 19:42, Kirill Tkhai wrote:
>>>>> On 10.01.2020 12:30, Shile Zhang wrote:
>>>>>> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdat_resize_lock'
>>>>>> will be called inside 'pgdatinit' kthread to initialise the deferred
>>>>>> pages with local interrupts disabled. Which is introduced by
>>>>>> commit 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred
>>>>>> pages").
>>>>>>
>>>>>> But 'pgdatinit' kthread is possible be pined on the boot CPU (CPU#0 by
>>>>>> default), especially in small system with NRCPUS <= 2. In this case, the
>>>>>> interrupts are disabled on boot CPU during memory initialising, which
>>>>>> caused the tick_sched timer be blocked, leading to wall clock stuck.
>>>>>>
>>>>>> Fixes: commit 3a2d7fa8a3d5 ("mm: disable interrupts while initializing
>>>>>> deferred pages")
>>>>>>
>>>>>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>>>>>> ---
>>>>>>     include/linux/memory_hotplug.h | 16 ++++++++++++++--
>>>>>>     1 file changed, 14 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>>>>>> index ba0dca6aac6e..be69a6dc4fee 100644
>>>>>> --- a/include/linux/memory_hotplug.h
>>>>>> +++ b/include/linux/memory_hotplug.h
>>>>>> @@ -6,6 +6,8 @@
>>>>>>     #include <linux/spinlock.h>
>>>>>>     #include <linux/notifier.h>
>>>>>>     #include <linux/bug.h>
>>>>>> +#include <linux/sched.h>
>>>>>> +#include <linux/smp.h>
>>>>>>       struct page;
>>>>>>     struct zone;
>>>>>> @@ -282,12 +284,22 @@ static inline bool movable_node_is_enabled(void)
>>>>>>     static inline
>>>>>>     void pgdat_resize_lock(struct pglist_data *pgdat, unsigned long *flags)
>>>>>>     {
>>>>>> -    spin_lock_irqsave(&pgdat->node_size_lock, *flags);
>>>>>> +    /*
>>>>>> +     * Disable local interrupts on boot CPU will stop the tick_sched
>>>>>> +     * timer, which will block jiffies(wall clock) update.
>>>>>> +     */
>>>>>> +    if (current->cpu != get_boot_cpu_id())
>>>>>> +        spin_lock_irqsave(&pgdat->node_size_lock, *flags);
>>>>>> +    else
>>>>>> +        spin_lock(&pgdat->node_size_lock);
>>>>>>     }
>>>>>>     static inline
>>>>>>     void pgdat_resize_unlock(struct pglist_data *pgdat, unsigned long *flags)
>>>>>>     {
>>>>>> -    spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
>>>>>> +    if (current->cpu != get_boot_cpu_id())
>>>>>> +        spin_unlock_irqrestore(&pgdat->node_size_lock, *flags);
>>>>>> +    else
>>>>>> +        spin_unlock(&pgdat->node_size_lock);
>>>>>>     }
>>>>>>     static inline
>>>>>>     void pgdat_resize_init(struct pglist_data *pgdat)
>>>>> 1)Linux kernel is *preemptible*. Kernel with CONFIG_PREEMPT_RT option even may preempt
>>>>> *kernel* code in the middle of function. When you are executing a code containing
>>>>> pgdat_resize_lock() and pgdat_resize_unlock(), the process may migrate to another cpu
>>>>> between them.
>>>>>
>>>>> bool cpu               another cpu
>>>>> ----------------------------------
>>>>> pgdat_resize_lock()
>>>>>      spin_lock()
>>>>>      --> migrate to another cpu
>>>>>                          pgdat_resize_unlock()
>>>>>                          spin_unlock_irqrestore(<uninitialized flags>)
>>>>>
>>>>> (Yes, in case of CONFIG_PREEMPT_RT, process is preemptible even after spin_lock() call).
>>>>>
>>>>> This looks like a bad helpers, and we should not introduce such the design.
>>>> Hi Kirill,
>>>>
>>>> Thanks for your comments!
>>>> Sorry for I'm not very clear about this lock/unlock, but I encountered this issue
>>>> with "CONFIG_PREEMPT is not set".
>>> The thing is we simply shouldn't introduce such the primitives since the thread
>>> may migrate to another cpu, while you own the lock. This looks like a buggy design.
>>>
>>>>> 2)I think there is no the problem this patch solves. Do we really this statistics?
>>>>> Can't we simple remove print message from deferred_init_memmap() and solve this?
>>>> Sorry for I've not put this issue very clearly. It's *not* just one statistics log
>>>> with wrong time calculate, but the wall clock is stuck.
>>>> So the 'systemd-analyze' command also give a wrong time as I mentioned in the cover
>>>> letter. I don't think is OK just remove the log, it cannot solve the wall clock latency.
>>> Have you tried temporary enabling interrupts in the middle of cycle after a huge enough
>>> memory block is initialized? Something like:
>>>
>>> deferred_init_memmap()
>>> {
>>>      while (spfn < epfn) {
>>>          nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>>>          local_irq_enable();
>>>          local_irq_disable();
>>>      }
>>> }
>> Yes, I'd tried this for issue confirm, before I sent this patch. Likes I mentioned the debug log in cover letter, I also add mdelay between local_irq_enable/disable, this system jiffies is stuck without update.
>> So I think there must be problem to use spin_lock_irqsave in early boot path on boot CPU.
> This time SMP is enabled. You have many threads are running. Interrupts are enabled
> and they occur. So, it's OK to disable interrupts for some time.
>
> My opinion is we should try to enable interrupts in the cycle after some fixed
> amount of memory is initialized. Say, every 1GB. This should resolve two problems:
> handling timer interrupt with update jiffies at time, and keeping the fix for the issue,
> that Pavel fixed in 3a2d7fa8a3d5.
>
>>> Or, maybe, enable/disable interrupts somewhere inside deferred_init_maxorder().
>>>
>>>>> Also, you may try to check that sched_clock() gives better results with interrupts
>>>>> disabled (on x86 it uses rdtsc, when it's possible. But it also may fallback to
>>>>> jiffies-based clock in some hardware cases, and they also won't go with interrupts
>>>>> disabled).

