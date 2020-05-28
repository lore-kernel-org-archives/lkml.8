Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A075C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F253F207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgE1Gui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:50:38 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:47774 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgE1Gui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:50:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=wetp.zy@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tzs7xye_1590648610;
Received: from wetpdeMacBook-Pro.local(mailfrom:wetp.zy@linux.alibaba.com fp:SMTPD_---0Tzs7xye_1590648610)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 May 2020 14:50:25 +0800
Subject: Re: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to early-kill
 process
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1590476801-19882-1-git-send-email-wetp.zy@linux.alibaba.com>
 <20200528022241.GA1401@hori.linux.bs1.fc.nec.co.jp>
From:   wetp <wetp.zy@linux.alibaba.com>
Message-ID: <881b990a-2198-8e80-036e-bfa6f88070ff@linux.alibaba.com>
Date:   Thu, 28 May 2020 14:50:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528022241.GA1401@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/28 上午10:22, HORIGUCHI NAOYA(堀口 直也) wrote:
> Hi Zhang,
>
> Sorry for my late response.
>
> On Tue, May 26, 2020 at 03:06:41PM +0800, Wetp Zhang wrote:
>> From: Zhang Yi <wetpzy@gmail.com>
>>
>> If a process don't need early-kill, it may not care the BUS_MCEERR_AO.
>> Let the process to be killed when it really access the corrupted memory.
>>
>> Signed-off-by: Zhang Yi <wetpzy@gmail.com>
> Thank you for pointing this. This looks to me a bug (per-process flag
> is ignored when system-wide flag is set).

The flag is not problem for me.

In my case, two processes share memory with no any flag setting, both 
will be killed when only one

access the fail memory.

>> ---
>>   mm/memory-failure.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a96364be8ab4..2db13d48865c 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -210,7 +210,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>>   {
>>   	struct task_struct *t = tk->tsk;
>>   	short addr_lsb = tk->size_shift;
>> -	int ret;
>> +	int ret = 0;
>>
>>   	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
>>   		pfn, t->comm, t->pid);
>> @@ -225,8 +225,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>>   		 * This could cause a loop when the user sets SIGBUS
>>   		 * to SIG_IGN, but hopefully no one will do that?
>>   		 */
>> -		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
>> -				      addr_lsb, t);  /* synchronous? */
>> +		if ((t->flags & PF_MCE_PROCESS) && (t->flags & PF_MCE_EARLY))
>> +			ret = send_sig_mceerr(BUS_MCEERR_AO,
>> +				(void __user *)tk->addr, addr_lsb, t);
> kill_proc() could be called only for processes that are selected by
> collect_procs() with task_early_kill().  So I think that we should fix
> task_early_kill(), maybe by reordering sysctl_memory_failure_early_kill
> check and find_early_kill_thread() check.
>
>      static struct task_struct *task_early_kill(struct task_struct *tsk,
>                                                 int force_early)
>      {
>              struct task_struct *t;
>              if (!tsk->mm)
>                      return NULL;
>              if (force_early)
>                      return tsk;

The force_early is rely the flag MF_ACTION_REQUIRED, so it is always 
true when MCE occurs.

This leads always sending SIGBUS to processes even if those are not 
current or no flag setting.

  I think it could keep the non-current processes which has no flag 
setting running.


Besides, base on your recommendation I reorder the force_early check and 
find_early_kill_thread()

check, to send the signal to the right thread.

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2db13d48865c..33a87d7b3e61 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c

@@ -399,11 +402,11 @@ static struct task_struct *task_early_kill(struct task_struct *tsk,
  	struct task_struct *t;
  	if (!tsk->mm)
  		return NULL;
-	if (force_early)
-		return tsk;
  	t = find_early_kill_thread(tsk);
  	if (t)
  		return t;
+	if (force_early && tsk->mm == current->mm)
+		return tsk;
  	if (sysctl_memory_failure_early_kill)
  		return tsk;
  	return NULL;

>              t = find_early_kill_thread(tsk);
>              if (t)
>                      return t;
>              if (sysctl_memory_failure_early_kill)
>                      return tsk;
>              return NULL;
>      }
>
> One subtleness is to make sure that find_early_kill_thread() should distinguish
> default value and explicitly set value, so we might need some modification
> on find_early_kill_thread().
>
> Can you try that?
>
> Thanks,
> Naoya Horiguchi
