Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D98C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C09207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgE2F43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:56:29 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45024 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgE2F43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:56:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=wetp.zy@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TzxLNk._1590731785;
Received: from wetpdeMacBook-Pro.local(mailfrom:wetp.zy@linux.alibaba.com fp:SMTPD_---0TzxLNk._1590731785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 13:56:26 +0800
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
 <881b990a-2198-8e80-036e-bfa6f88070ff@linux.alibaba.com>
 <20200529021224.GA345@hori.linux.bs1.fc.nec.co.jp>
From:   wetp <wetp.zy@linux.alibaba.com>
Message-ID: <e4da056c-8d6c-9687-0785-b1900cb7c3e2@linux.alibaba.com>
Date:   Fri, 29 May 2020 13:56:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529021224.GA345@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/29 上午10:12, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, May 28, 2020 at 02:50:09PM +0800, wetp wrote:
>> On 2020/5/28 上午10:22, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> Hi Zhang,
>>>
>>> Sorry for my late response.
>>>
>>> On Tue, May 26, 2020 at 03:06:41PM +0800, Wetp Zhang wrote:
>>>> From: Zhang Yi <wetpzy@gmail.com>
>>>>
>>>> If a process don't need early-kill, it may not care the BUS_MCEERR_AO.
>>>> Let the process to be killed when it really access the corrupted memory.
>>>>
>>>> Signed-off-by: Zhang Yi <wetpzy@gmail.com>
>>> Thank you for pointing this. This looks to me a bug (per-process flag
>>> is ignored when system-wide flag is set).
>> The flag is not problem for me.
>>
>> In my case, two processes share memory with no any flag setting, both will
>> be killed when only one
>>
>> access the fail memory.
> Thanks, now your problem seems clearer.
>
> It seems that this happens because in "Action Required" case kill_proc()
> takes the first branch for current process, while it takes the else branch
> for other affected processes:
>
>      static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>      {
>              ...
>      
>              if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
>                      ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
>                                             addr_lsb);
>              } else {
>                      /*
>                       * Don't use force here, it's convenient if the signal
>                       * can be temporarily blocked.
>                       * This could cause a loop when the user sets SIGBUS
>                       * to SIG_IGN, but hopefully no one will do that?
>                       */
>                      ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
>                                            addr_lsb, t);  /* synchronous? */
>              }
>
> Sending SIGBUS with BUS_MCEERR_AO for action optional error is strange, so
> maybe this logic should be like this:
>
>
>              if (flags & MF_ACTION_REQUIRED) {
>                      if (t->mm == current->mm)
>                              ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
>                                             addr_lsb);
>                      /* send no signal to non-current processes */
Ok, this can solve my problem.

>              } else {
>                      /*
>                       * Don't use force here, it's convenient if the signal
>                       * can be temporarily blocked.
>                       * This could cause a loop when the user sets SIGBUS
>                       * to SIG_IGN, but hopefully no one will do that?
>                       */
>                      ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
>                                            addr_lsb, t);  /* synchronous? */
>              }
>
>>>> ---
>>>>    mm/memory-failure.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index a96364be8ab4..2db13d48865c 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -210,7 +210,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>>>>    {
>>>>    	struct task_struct *t = tk->tsk;
>>>>    	short addr_lsb = tk->size_shift;
>>>> -	int ret;
>>>> +	int ret = 0;
>>>>
>>>>    	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
>>>>    		pfn, t->comm, t->pid);
>>>> @@ -225,8 +225,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>>>>    		 * This could cause a loop when the user sets SIGBUS
>>>>    		 * to SIG_IGN, but hopefully no one will do that?
>>>>    		 */
>>>> -		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
>>>> -				      addr_lsb, t);  /* synchronous? */
>>>> +		if ((t->flags & PF_MCE_PROCESS) && (t->flags & PF_MCE_EARLY))
>>>> +			ret = send_sig_mceerr(BUS_MCEERR_AO,
>>>> +				(void __user *)tk->addr, addr_lsb, t);
>>> kill_proc() could be called only for processes that are selected by
>>> collect_procs() with task_early_kill().  So I think that we should fix
>>> task_early_kill(), maybe by reordering sysctl_memory_failure_early_kill
>>> check and find_early_kill_thread() check.
>>>
>>>       static struct task_struct *task_early_kill(struct task_struct *tsk,
>>>                                                  int force_early)
>>>       {
>>>               struct task_struct *t;
>>>               if (!tsk->mm)
>>>                       return NULL;
>>>               if (force_early)
>>>                       return tsk;
>> The force_early is rely the flag MF_ACTION_REQUIRED, so it is always true
>> when MCE occurs.
>>
>> This leads always sending SIGBUS to processes even if those are not current
>> or no flag setting.
>>
>>   I think it could keep the non-current processes which has no flag setting
>> running.
>>
>>
>> Besides, base on your recommendation I reorder the force_early check and
>> find_early_kill_thread()
>>
>> check, to send the signal to the right thread.
> Sorry, my previous comment around task_early_kill() is for a separate problem,
> so I'll try some fix on this later.
Thanks.

Should me send the patch V2 for my problem alone?  Or you will fix it 
with task_early_kill() together ？


> Thanks,
> Naoya Horiguchi
