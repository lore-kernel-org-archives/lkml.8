Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED255C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E0C206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgFJBHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:07:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5872 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgFJBHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:07:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C09C3D5C36590D77C739;
        Wed, 10 Jun 2020 09:07:36 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.93) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 10 Jun 2020
 09:07:33 +0800
Subject: Re: [PATCH v2] sample-trace-array: Fix sleeping function called from
 invalid context
To:     Divya Indi <divya.indi@oracle.com>, <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <0047f80f-4fff-16ff-7ac0-20181f03f06a@oracle.com>
 <20200609135125.2206637-1-wangkefeng.wang@huawei.com>
 <53201591-082d-7e42-9043-237ae4239da6@oracle.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <aff79eb0-a05b-8040-ba21-007cc8d53cb1@huawei.com>
Date:   Wed, 10 Jun 2020 09:07:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <53201591-082d-7e42-9043-237ae4239da6@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.215.93]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/10 0:29, Divya Indi wrote:
> On 6/9/20 6:51 AM, Kefeng Wang wrote:
>>   BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
>>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/5
>>   1 lock held by swapper/5/0:
>>    #0: ffff80001002bd90 (samples/ftrace/sample-trace-array.c:38){+.-.}-{0:0}, at: call_timer_fn+0x8/0x3e0
>>   CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.7.0+ #8
>>   Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>>   Call trace:
>>    dump_backtrace+0x0/0x1a0
>>    show_stack+0x20/0x30
>>    dump_stack+0xe4/0x150
>>    ___might_sleep+0x160/0x200
>>    __might_sleep+0x58/0x90
>>    __mutex_lock+0x64/0x948
>>    mutex_lock_nested+0x3c/0x58
>>    __ftrace_set_clr_event+0x44/0x88
>>    trace_array_set_clr_event+0x24/0x38
>>    mytimer_handler+0x34/0x40 [sample_trace_array]
>>
>> mutex_lock() will be called in interrupt context, using workqueue to fix it.
> Fixes:
Missing it， will send v3， thanks.
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Divya Indi <divya.indi@oracle.com>
>
>

