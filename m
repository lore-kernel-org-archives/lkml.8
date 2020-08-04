Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58925C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697C22086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHDC6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:58:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbgHDC6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:58:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 56039FC0FAA3C1FC15C3;
        Tue,  4 Aug 2020 10:58:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 4 Aug 2020
 10:58:01 +0800
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
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com>
Date:   Tue, 4 Aug 2020 10:58:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/8/4 6:11, Richard Weinberger 写道:
> On Mon, Aug 3, 2020 at 4:01 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>> Hmm, I see the problem but I fear this patch does not cure the race completely.
>>> It just lowers the chance to hit it.
>>> What if KTHREAD_SHOULD_STOP is set right after you checked for it?
>> The patch can handle this case. ubi_thread will exit at
>> kthread_should_stop() in next iteration.
> How can it reach the next iteration?
> Maybe I didn't fully get your explanation.
>
> As far as I understand the problem correctly, the following happens:
> 1. ubi_thread is running and the program counter is somewhere between
> "if (kthread_should_stop())"
> and schedule()
> 2. While detaching kthread_stop() is called
> 3. Since the program counter in the thread is right before schedule(),
> it does not check KTHREAD_SHOULD_STOP
> and blindly calls into schedule()
> 4. The thread goes to sleep and nothing wakes it anymore -> endless wait.
>
> Is this correct so far?
Oh, you're thinking about influence by schedule(), I get it. But I think 
it still works. Because the ubi_thread is still on runqueue, it will be 
scheduled to execute later anyway.

op                                                    state of 
ubi_thread           on runqueue
set_current_state(TASK_INTERRUPTIBLE) TASK_INTERRUPTIBLE              Yes
if (kthread_should_stop()) // not satisfy 
TASK_INTERRUPTIBLE              Yes
kthread_stop:
   wake_up_process
     ttwu_queue
       ttwu_do_activate
         ttwu_do_wakeup TASK_RUNNING                       Yes
schedule
   __schedule(false)

  // prev->state is TASK_RUNNING, so we cannot move it from runqueue by 
deactivate_task(). So just pick next task to execute, ubi_thread is 
still on runqueue and will be scheduled to execute later.


The test patch added mdelay(5000) before schedule(), which can make sure 
kthread_stop()->wake_up_process() executed before schedule(). Previous 
analysis can be proved through test.

@@ -1638,6 +1641,15 @@ int ubi_thread(void *u)
                     !ubi->thread_enabled || 
ubi_dbg_is_bgt_disabled(ubi)) {
                         set_current_state(TASK_INTERRUPTIBLE);
                         spin_unlock(&ubi->wl_lock);
+                       if (kthread_should_stop()) {
+                               set_current_state(TASK_RUNNING);
+                               break;
+                       }
+
+                       pr_err("Check should stop B\n");
+                       mdelay(5000);
+                       pr_err("delay 5000ms \n");
+
                         schedule();
                         continue;
                 }

>
> Your solution is putting another check for KTHREAD_SHOULD_STOP before
> schedule().
> I argue that this will just reduce the chance to hit the race window
> because it can still happen
> that kthread_stop() is being called right after the second check and
> again before schedule().
> Then we end up with the same situation.
>


