Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0681FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35C721744
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgHQOPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:15:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3065 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728831AbgHQOPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:15:53 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 5AC8B462E995EFE33ED2;
        Mon, 17 Aug 2020 22:15:51 +0800 (CST)
Received: from [10.174.186.8] (10.174.186.8) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Mon, 17
 Aug 2020 22:15:50 +0800
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
To:     Marc Zyngier <maz@kernel.org>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
 <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
CC:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "will@kernel.org" <will@kernel.org>, <joelaf@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <suleiman@google.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        <yezengruan@huawei.com>
From:   yezengruan <yezengruan@huawei.com>
Message-ID: <3ff3b016-3f63-7d03-ed4b-c98d74db4af8@huawei.com>
Date:   Mon, 17 Aug 2020 22:15:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.186.8]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/17 20:25, Marc Zyngier wrote:
> On 2020-08-17 13:03, yezengruan wrote:
>> On 2020/8/17 10:03, Sergey Senozhatsky wrote:
>>> On (20/07/21 13:17), Sergey Senozhatsky wrote:
>>>> Hello,
>>>>
>>>>     RFC
>>>>
>>>>     We noticed that in a number of cases when we wake_up_process()
>>>> on arm64 guest we end up enqueuing that task on a preempted VCPU. The culprit
>>>> appears to be the fact that arm64 guests are not aware of VCPU preemption
>>>> as such, so when sched picks up an idle VCPU it always assumes that VCPU
>>>> is available:
>>>>
>>>>       wake_up_process()
>>>>        try_to_wake_up()
>>>>         select_task_rq_fair()
>>>>          available_idle_cpu()
>>>>           vcpu_is_preempted()    // return false;
>>>>
>>>> Which is, obviously, not the case.
>>>>
>>>> This RFC patch set adds a simple vcpu_is_preempted() implementation so
>>>> that scheduler can make better decisions when it search for the idle
>>>> (v)CPU.
>>> Hi,
>>>
>>> A gentle ping.
>>>
>>>     -ss
>>> _______________________________________________
>>> kvmarm mailing list
>>> kvmarm@lists.cs.columbia.edu
>>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>> .
>>
>> Hi Sergey,
>>
>> I have a set of patches similar to yours.
>>
>> https://lore.kernel.org/lkml/20191226135833.1052-1-yezengruan@huawei.com/
>
> It really isn't the same thing at all. You are exposing PV spinlocks,
> while Sergey exposes preemption to vcpus. The former is a massive,
> and probably unnecessary superset of the later, which only impacts
> the scheduler (it doesn't change the way locks are implemented).
>
> You really shouldn't conflate the two (which you have done in your
> series).
>
>         M.


Hi Marc,

Actually, both series support paravirtualization vcpu_is_preempted. My
series regard this as PV lock, but only the vcpu_is_preempted interface
of pv_lock_opt is implemented.

Except wake_up_process(), the vcpu_is_preempted interface of the current
kernel is used in the following scenarios:

kernel/sched/core.c:                            <---- wake_up_process()
--------------------
available_idle_cpu
    vcpu_is_preempted

kernel/locking/rwsem.c:
-----------------------
rwsem_optimistic_spin
    rwsem_spin_on_owner
        owner_on_cpu
            vcpu_is_preempted

kernel/locking/mutex.c:
-----------------------
mutex_optimistic_spin
    mutex_spin_on_owner
        vcpu_is_preempted

kernel/locking/osq_lock.c:
--------------------------
osq_lock
    vcpu_is_preempted


Thanks,

Zengruan

