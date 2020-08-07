Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E92C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D663022CF7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHGCSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:18:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9249 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbgHGCSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:18:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7215DAEE717C6995C4D6;
        Fri,  7 Aug 2020 10:18:45 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 10:18:38 +0800
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
 <2086f822-e67a-43e4-76d8-5339eaccd3ac@huawei.com>
 <CAFLxGvzwoC1GcjJOfwpc8V5LD79=8XiJaNV2HjOm8EdQcCbp+w@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5f7ae548-350b-cedf-3c8e-25fea06a8377@huawei.com>
Date:   Fri, 7 Aug 2020 10:18:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzwoC1GcjJOfwpc8V5LD79=8XiJaNV2HjOm8EdQcCbp+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/8/7 4:15, Richard Weinberger 写道:
> On Wed, Aug 5, 2020 at 4:23 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> Er, I can't get the point. I can list two possible situations, did I
>> miss other situations?
> Yes. You keep ignoring the case I brought up.
>
> Let's start from scratch, maybe I miss something.
> So I'm sorry for being persistent.
Never mind, we're all trying to figure it out.  :-) . Besides, I'm not 
good at expressing question in English. (In Practicing...)
> The ubi thread can be reduced to a loop like this one:
> 1. for (;;) {
> 2.      if (kthread_should_stop())
> 3.              break;
> 4.
> 5.      if ( /* no work pending*/ ){
> 6.              set_current_state(TASK_INTERRUPTIBLE);
> 7.              schedule();
> 8.              continue;
> 9.      }
> 10.
> 11.     do_work();
> 12. }
>
> syzcaller found a case where stopping the thread did not work.
> If another task tries to stop the thread while no work is pending and
> the program counter in the thread
> is between lines 5 and 6, the kthread_stop() instruction has no effect.
> It has no effect because the thread sets the thread state to
> interruptible sleep and then schedules away.
>
> This is a common anti-pattern in the Linux kernel, sadly.

Yes, but UBIFS is the exception, my solution looks like UBIFS.

int ubifs_bg_thread(void *info)
{
     while(1) {
         if (kthread_should_stop())
             break;

         set_current_state(TASK_INTERRUPTIBLE);
         if (!c->need_bgt) {
             /*
              * Nothing prevents us from going sleep now and
              * be never woken up and block the task which
              * could wait in 'kthread_stop()' forever.
              */
             if (kthread_should_stop())
                 break;
             schedule();
             continue;
         }
     }
}


>
> Do you agree with me so far or do you think syzcaller found a different issue?
Yes, I agree.
>
> Your patch changes the loop as follows:
> 1. for (;;) {
> 2.      if (kthread_should_stop())
> 3.              break;
> 4.
> 5.      if ( /* no work pending*/ ){
> 6.              set_current_state(TASK_INTERRUPTIBLE);
> 7.
> 8.              if (kthread_should_stop()) {
> 9.                      set_current_state(TASK_RUNNING);
> 10.                     break;
> 11.             }
> 12.
> 13.             schedule();
> 14.             continue;
> 15.     }
> 16.
> 17.     do_work();
> 18. }
>
> That way there is a higher chance that the thread sees the stop flag
> and gracefully terminates, I fully agree on that.
There's no disagreement so far.
> But it does not completely solve the problem.
> If kthread_stop() happens while the program counter of the ubi thread
> is at line 12, the stop flag is still missed
> and we end up in interruptible sleep just like before.

That's where we hold different views. I have 3 viewpoints（You can point 
out which one you disagree.）:

1. If kthread_stop() happens at line 12, ubi thread is *marked* with 
stop flag, it will stop at kthread_should_stop() as long as it can reach 
the next iteration.

2. If task A is on runqueue and its state is TASK_RUNNING, task A will 
be scheduled to execute.

3. If kthread_stop() happens at line 12, after program counter going to 
line 14, ubi thead is on runqueue and its state is TASK_RUNNING. I have 
explained this in situation 1 in last session.


I mean ubi thread is on runqueue with TASK_RUNNING state & stop flag 
after the process you described.

Line 12   kthread_stop()

                  set_bit(mark stop flag) && wake_up_process(enqueue && 
set TASK_RUNNING )    => TASK_RUNNING & stop flag & on runqueue

Line 13  schedule()

                  Do nothing but pick next task to execute

>
> So, to solve the problem entirely I suggest changing schedule() to
> schedule_timeout() and let the thread wake up
> periodically.
>


