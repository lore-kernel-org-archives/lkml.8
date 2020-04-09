Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21095C2BBFD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E436E208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgDINRA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:17:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgDINRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:17:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 039D3dDk139234
        for <linux-kernel@vger.kernel.org>; Thu, 9 Apr 2020 09:16:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 309209yqdw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:16:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Thu, 9 Apr 2020 14:16:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Apr 2020 14:16:38 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 039DGpKa49807606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Apr 2020 13:16:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64FD2A405F;
        Thu,  9 Apr 2020 13:16:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04876A4066;
        Thu,  9 Apr 2020 13:16:51 +0000 (GMT)
Received: from localhost (unknown [9.85.116.227])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Apr 2020 13:16:50 +0000 (GMT)
Date:   Thu, 09 Apr 2020 18:46:47 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
To:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "bibo,mao" <bibo.mao@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
References: <20200408164641.3299633-1-jolsa@kernel.org>
        <20200409213806.7657ec27d1b5cbd8243505b9@kernel.org>
In-Reply-To: <20200409213806.7657ec27d1b5cbd8243505b9@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20040913-0012-0000-0000-000003A16536
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040913-0013-0000-0000-000021DE8F3F
Message-Id: <1586437540.j6vekko069.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_04:2020-04-07,2020-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Masami Hiramatsu wrote:
> Hi Jiri,
> 
> On Wed,  8 Apr 2020 18:46:41 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
>> hi,
>> Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.
> 
> Hmm, kprobe is lockless, but kretprobe involves spinlock.
> Thus, eventually, I will blacklist the _raw_spin_lock_irqsave()
> for kretprobe.

As far as I can see, this is the only place where probing 
_raw_spin_lock_irqsave() is an issue.  Should we blacklist all users for 
this case alone?

> If you need to trace spinlock return, please consider to putting
> kprobe at "ret" instruction.
> 
>> My test was also able to trigger lockdep output:
>> 
>>  ============================================
>>  WARNING: possible recursive locking detected
>>  5.6.0-rc6+ #6 Not tainted
>>  --------------------------------------------
>>  sched-messaging/2767 is trying to acquire lock:
>>  ffffffff9a492798 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_hash_lock+0x52/0xa0
>> 
>>  but task is already holding lock:
>>  ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
>> 
>>  other info that might help us debug this:
>>   Possible unsafe locking scenario:
>> 
>>         CPU0
>>         ----
>>    lock(&(kretprobe_table_locks[i].lock));
>>    lock(&(kretprobe_table_locks[i].lock));
>> 
>>   *** DEADLOCK ***
>> 
>>   May be due to missing lock nesting notation
>> 
>>  1 lock held by sched-messaging/2767:
>>   #0: ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
>> 
>>  stack backtrace:
>>  CPU: 3 PID: 2767 Comm: sched-messaging Not tainted 5.6.0-rc6+ #6
>>  Call Trace:
>>   dump_stack+0x96/0xe0
>>   __lock_acquire.cold.57+0x173/0x2b7
>>   ? native_queued_spin_lock_slowpath+0x42b/0x9e0
>>   ? lockdep_hardirqs_on+0x590/0x590
>>   ? __lock_acquire+0xf63/0x4030
>>   lock_acquire+0x15a/0x3d0
>>   ? kretprobe_hash_lock+0x52/0xa0
>>   _raw_spin_lock_irqsave+0x36/0x70
>>   ? kretprobe_hash_lock+0x52/0xa0
>>   kretprobe_hash_lock+0x52/0xa0
>>   trampoline_handler+0xf8/0x940
>>   ? kprobe_fault_handler+0x380/0x380
>>   ? find_held_lock+0x3a/0x1c0
>>   kretprobe_trampoline+0x25/0x50
>>   ? lock_acquired+0x392/0xbc0
>>   ? _raw_spin_lock_irqsave+0x50/0x70
>>   ? __get_valid_kprobe+0x1f0/0x1f0
>>   ? _raw_spin_unlock_irqrestore+0x3b/0x40
>>   ? finish_task_switch+0x4b9/0x6d0
>>   ? __switch_to_asm+0x34/0x70
>>   ? __switch_to_asm+0x40/0x70
>> 
>> The code within the kretprobe handler checks for probe reentrancy,
>> so we won't trigger any _raw_spin_lock_irqsave probe in there.
>> 
>> The problem is in outside kprobe_flush_task, where we call:
>> 
>>   kprobe_flush_task
>>     kretprobe_table_lock
>>       raw_spin_lock_irqsave
>>         _raw_spin_lock_irqsave
>> 
>> where _raw_spin_lock_irqsave triggers the kretprobe and installs
>> kretprobe_trampoline handler on _raw_spin_lock_irqsave return.
> 
> Hmm, OK. In this case, I think we should mark this process is
> going to die and never try to kretprobe on it.
> 
>> 
>> The kretprobe_trampoline handler is then executed with already
>> locked kretprobe_table_locks, and first thing it does is to
>> lock kretprobe_table_locks ;-) the whole lockup path like:
>> 
>>   kprobe_flush_task
>>     kretprobe_table_lock
>>       raw_spin_lock_irqsave
>>         _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed
>> 
>>         ---> kretprobe_table_locks locked
>> 
>>         kretprobe_trampoline
>>           trampoline_handler
>>             kretprobe_hash_lock(current, &head, &flags);  <--- deadlock
>> 
>> The change below sets current_kprobe in kprobe_flush_task, so the probe
>> recursion protection check is hit and the probe is never set. It seems
>> to fix the deadlock.
>> 
>> I'm not sure this is the best fix, any ideas are welcome ;-)
> 
> Hmm, this is a bit tricky to fix this issue. Of course, temporary disable
> kprobes (and kretprobe) on an area by filling current_kprobe might
> be a good idea, but it also involves other kprobes.

Not sure how you mean that. Jiri's RFC patch would be disabling 
k[ret]probes within kprobe_flush_task(), which is only ever invoked from 
finish_task_switch(). I only see calls to spin locks and kfree() from 
here. Besides, kprobe_flush_task() itself is NOKPROBE, so we would 
ideally want to not trace/probe other functions it calls.

> 
> How about let kretprobe skip the task which state == TASK_DEAD ?
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 627fc1b7011a..3f207d2e0afb 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1874,9 +1874,12 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  	 * To avoid deadlocks, prohibit return probing in NMI contexts,
>  	 * just skip the probe and increase the (inexact) 'nmissed'
>  	 * statistical counter, so that the user is informed that
> -	 * something happened:
> +	 * something happened.
> +	 * Also, if the current task is dead, we will already in the process
> +	 * to reclaim kretprobe instances from hash list. To avoid memory
> +	 * leak, skip to run the kretprobe on such task.
>  	 */
> -	if (unlikely(in_nmi())) {
> +	if (unlikely(in_nmi()) || current->state == TASK_DEAD) {

I'm wondering if this actually works. kprobe_flush_task() seems to be 
called from finish_task_switch(), after the task switch is complete. So, 
current task won't actually be dead here.


- Naveen

