Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E73C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 02:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0889420722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 02:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHCCB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 22:01:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgHCCB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 22:01:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4E8D9DAB2F7AAB45C5FE;
        Mon,  3 Aug 2020 10:01:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 10:01:15 +0800
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com>
Date:   Mon, 3 Aug 2020 10:01:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/8/3 5:25, Richard Weinberger 写道:
> On Mon, Jun 1, 2020 at 11:13 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> A detach hung is possible when a race occurs between the detach process
>> and the ubi background thread. The following sequences outline the race:
>>
>>    ubi thread: if (list_empty(&ubi->works)...
>>
>>    ubi detach: set_bit(KTHREAD_SHOULD_STOP, &kthread->flags)
>>                => by kthread_stop()
>>                wake_up_process()
>>                => ubi thread is still running, so 0 is returned
>>
>>    ubi thread: set_current_state(TASK_INTERRUPTIBLE)
>>                schedule()
>>                => ubi thread will never be scheduled again
>>
>>    ubi detach: wait_for_completion()
>>                => hung task!
>>
>> To fix that, we need to check kthread_should_stop() after we set the
>> task state, so the ubi thread will either see the stop bit and exit or
>> the task state is reset to runnable such that it isn't scheduled out
>> indefinitely.
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Cc: <Stable@vger.kernel.org>
>> Fixes: 801c135ce73d5df1ca ("UBI: Unsorted Block Images")
>> Reported-by: syzbot+853639d0cb16c31c7a14@syzkaller.appspotmail.com
>> ---
>>   drivers/mtd/ubi/wl.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
>> index 5146cce5fe32..a4d4343053d7 100644
>> --- a/drivers/mtd/ubi/wl.c
>> +++ b/drivers/mtd/ubi/wl.c
>> @@ -1628,6 +1628,19 @@ int ubi_thread(void *u)
>>                      !ubi->thread_enabled || ubi_dbg_is_bgt_disabled(ubi)) {
>>                          set_current_state(TASK_INTERRUPTIBLE);
>>                          spin_unlock(&ubi->wl_lock);
>> +
>> +                       /*
>> +                        * Check kthread_should_stop() after we set the task
>> +                        * state to guarantee that we either see the stop bit
>> +                        * and exit or the task state is reset to runnable such
>> +                        * that it's not scheduled out indefinitely and detects
>> +                        * the stop bit at kthread_should_stop().
>> +                        */
>> +                       if (kthread_should_stop()) {
>> +                               set_current_state(TASK_RUNNING);
>> +                               break;
>> +                       }
>> +
> Hmm, I see the problem but I fear this patch does not cure the race completely.
> It just lowers the chance to hit it.
> What if KTHREAD_SHOULD_STOP is set right after you checked for it?

The patch can handle this case. ubi_thread will exit at 
kthread_should_stop() in next iteration.


You can apply following patch to verify it. (You may set 
'kernel.hung_task_timeout_secs = 10' by sysctl)


diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 27636063ed1b..44047861c2a1 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -91,6 +91,7 @@
  #include <linux/kthread.h>
  #include "ubi.h"
  #include "wl.h"
+#include <linux/delay.h>

  /* Number of physical eraseblocks reserved for wear-leveling purposes */
  #define WL_RESERVED_PEBS 1
@@ -1627,8 +1628,10 @@ int ubi_thread(void *u)
         for (;;) {
                 int err;

-               if (kthread_should_stop())
+               if (kthread_should_stop()) {
+                       pr_err("Exit at stop A\n");
                         break;
+               }

                 if (try_to_freeze())
                         continue;
@@ -1638,6 +1641,15 @@ int ubi_thread(void *u)
                     !ubi->thread_enabled || ubi_dbg_is_bgt_disabled(ubi)) {
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
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 132f84a5fde3..18627acb9573 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -590,6 +590,10 @@ int kthread_stop(struct task_struct *k)
         get_task_struct(k);
         kthread = to_kthread(k);
         set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
+
+       if (k->comm && !strncmp(k->comm, "ubi_bgt0d", strlen("ubi_bgt0d")))
+               pr_err("Stop flag has been set for task %s\n", k->comm);
+
         kthread_unpark(k);
         wake_up_process(k);
         wait_for_completion(&kthread->exited);

kernel msg:
[  210.602005] Check should stop B             # Please execute 
ubi_detach manually when you see this
[  211.347638] Stop flag has been set for task ubi_bgt0d
[  215.603026] delay 5000ms
[  215.605728] Exit at stop A
>>                          schedule();
>>                          continue;
>>                  }
>


