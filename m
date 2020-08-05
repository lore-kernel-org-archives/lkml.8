Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A58DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5172320792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHECXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:23:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgHECXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:23:30 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 20BF45C884C4A241AFA3;
        Wed,  5 Aug 2020 10:23:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 5 Aug 2020
 10:23:18 +0800
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
 <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com>
 <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
 <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com>
 <CAFLxGvycs7DNu5o5QY1WwTPfS6cTTykTh-91n9TQZ7yP_ADr4A@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <2086f822-e67a-43e4-76d8-5339eaccd3ac@huawei.com>
Date:   Wed, 5 Aug 2020 10:23:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvycs7DNu5o5QY1WwTPfS6cTTykTh-91n9TQZ7yP_ADr4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/8/5 5:56, Richard Weinberger 写道:
> On Tue, Aug 4, 2020 at 4:58 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> Oh, you're thinking about influence by schedule(), I get it. But I think
>> it still works. Because the ubi_thread is still on runqueue, it will be
>> scheduled to execute later anyway.
> It will not get woken. This is the problem.
>
>> op                                                    state of
>> ubi_thread           on runqueue
>> set_current_state(TASK_INTERRUPTIBLE) TASK_INTERRUPTIBLE              Yes
>> if (kthread_should_stop()) // not satisfy
>> TASK_INTERRUPTIBLE              Yes
>> kthread_stop:
>>     wake_up_process
>>       ttwu_queue
>>         ttwu_do_activate
>>           ttwu_do_wakeup TASK_RUNNING                       Yes
>> schedule
>>     __schedule(false)
>>
>>    // prev->state is TASK_RUNNING, so we cannot move it from runqueue by
>> deactivate_task(). So just pick next task to execute, ubi_thread is
>> still on runqueue and will be scheduled to execute later.
> It will be in state TASK_RUNNING only if your check is reached.
>
> If kthread_stop() is called *before* your code:
> +                       if (kthread_should_stop()) {
> +                               set_current_state(TASK_RUNNING);
> +                               break;
> +                       }
>
> ...everything is fine.
> But there is still a race window between your if
> (kthread_should_stop()) and schedule() in the next line.
> So if kthread_stop() is called right *after* the if and *before*
> schedule(), the task state is still TASK_INTERRUPTIBLE
> --> schedule() will not return unless the task is explicitly woken,
> which does not happen.
Er, I can't get the point. I can list two possible situations, did I 
miss other situations?

P1:ubi_thread
   set_current_state(TASK_INTERRUPTIBLE)
   if (kthread_should_stop()) {
     set_current_state(TASK_RUNNING)
     break
   }
   schedule()                            -> don't *remove* task from 
runqueue if *TASK_RUNNING*, removing operation is protected by rq_lock

P2:kthread_stop
   set_bit(KTHREAD_SHOULD_STOP, &kthread->flags)
   wake_up_process(k)             -> enqueue task & set *TASK_RUNNING*, 
these two operations are protected by rq_lock
   wait_for_completion(&kthread->exited)


Situation 1:
P1_set_current_state               on-rq, TASK_RUNNING -> TASK_INTERRUPTIBLE
P1_kthread_should_stop        on-rq, TASK_INTERRUPTIBLE
P2_set_bit                               on-rq, TASK_INTERRUPTIBLE , 
KTHREAD_SHOULD_STOP
P2_wake_up_process             on-rq, TASK_INTERRUPTIBLE -> TASK_RUNNING 
, KTHREAD_SHOULD_STOP
P1_schedule                           on-rq, TASK_RUNNING , 
KTHREAD_SHOULD_STOP
P2_wait_for_completion        // wait for P1 exit

Situation 2:
P1_set_current_state             on-rq, TASK_RUNNING -> TASK_INTERRUPTIBLE
P1_kthread_should_stop       on-rq, TASK_INTERRUPTIBLE
P2_set_bit                             on-rq, TASK_INTERRUPTIBLE , 
KTHREAD_SHOULD_STOP
P1_schedule                          off-rq, TASK_INTERRUPTIBLE , 
KTHREAD_SHOULD_STOP
P2_wake_up_process             on-rq, TASK_INTERRUPTIBLE -> TASK_RUNNING 
, KTHREAD_SHOULD_STOP
P2_wait_for_completion       // wait for P1 exit
> Before your patch, the race window was much larger, I fully agree, but
> your patch does not cure the problem
> it just makes it harder to hit.
>
> And using mdelay() to verify such a thing is also tricky because
> mdelay() will influence the task state.
>


