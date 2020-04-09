Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8661EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596C32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDIJCe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:02:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgDIJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:02:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0398X5fw096166
        for <linux-kernel@vger.kernel.org>; Thu, 9 Apr 2020 05:02:34 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30920682bm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 05:02:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Thu, 9 Apr 2020 10:02:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Apr 2020 10:02:13 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03992QOX58392830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Apr 2020 09:02:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CF02AE04D;
        Thu,  9 Apr 2020 09:02:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0ACAAE053;
        Thu,  9 Apr 2020 09:02:25 +0000 (GMT)
Received: from localhost (unknown [9.85.116.227])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Apr 2020 09:02:25 +0000 (GMT)
Date:   Thu, 09 Apr 2020 14:32:21 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
To:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "bibo,mao" <bibo.mao@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
References: <20200408164641.3299633-1-jolsa@kernel.org>
In-Reply-To: <20200408164641.3299633-1-jolsa@kernel.org>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20040909-0012-0000-0000-000003A13F7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040909-0013-0000-0000-000021DE6892
Message-Id: <1586422762.2z1fgtvri9.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_02:2020-04-07,2020-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Jiri Olsa wrote:
> hi,
> Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.
> My test was also able to trigger lockdep output:
> 
>  ============================================
>  WARNING: possible recursive locking detected
>  5.6.0-rc6+ #6 Not tainted
>  --------------------------------------------
>  sched-messaging/2767 is trying to acquire lock:
>  ffffffff9a492798 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_hash_lock+0x52/0xa0
> 
>  but task is already holding lock:
>  ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&(kretprobe_table_locks[i].lock));
>    lock(&(kretprobe_table_locks[i].lock));
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>  1 lock held by sched-messaging/2767:
>   #0: ffffffff9a491a18 (&(kretprobe_table_locks[i].lock)){-.-.}, at: kretprobe_trampoline+0x0/0x50
> 
>  stack backtrace:
>  CPU: 3 PID: 2767 Comm: sched-messaging Not tainted 5.6.0-rc6+ #6
>  Call Trace:
>   dump_stack+0x96/0xe0
>   __lock_acquire.cold.57+0x173/0x2b7
>   ? native_queued_spin_lock_slowpath+0x42b/0x9e0
>   ? lockdep_hardirqs_on+0x590/0x590
>   ? __lock_acquire+0xf63/0x4030
>   lock_acquire+0x15a/0x3d0
>   ? kretprobe_hash_lock+0x52/0xa0
>   _raw_spin_lock_irqsave+0x36/0x70
>   ? kretprobe_hash_lock+0x52/0xa0
>   kretprobe_hash_lock+0x52/0xa0
>   trampoline_handler+0xf8/0x940
>   ? kprobe_fault_handler+0x380/0x380
>   ? find_held_lock+0x3a/0x1c0
>   kretprobe_trampoline+0x25/0x50
>   ? lock_acquired+0x392/0xbc0
>   ? _raw_spin_lock_irqsave+0x50/0x70
>   ? __get_valid_kprobe+0x1f0/0x1f0
>   ? _raw_spin_unlock_irqrestore+0x3b/0x40
>   ? finish_task_switch+0x4b9/0x6d0
>   ? __switch_to_asm+0x34/0x70
>   ? __switch_to_asm+0x40/0x70
> 
> The code within the kretprobe handler checks for probe reentrancy,
> so we won't trigger any _raw_spin_lock_irqsave probe in there.
> 
> The problem is in outside kprobe_flush_task, where we call:
> 
>   kprobe_flush_task
>     kretprobe_table_lock
>       raw_spin_lock_irqsave
>         _raw_spin_lock_irqsave
> 
> where _raw_spin_lock_irqsave triggers the kretprobe and installs
> kretprobe_trampoline handler on _raw_spin_lock_irqsave return.
> 
> The kretprobe_trampoline handler is then executed with already
> locked kretprobe_table_locks, and first thing it does is to
> lock kretprobe_table_locks ;-) the whole lockup path like:
> 
>   kprobe_flush_task
>     kretprobe_table_lock
>       raw_spin_lock_irqsave
>         _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed
> 
>         ---> kretprobe_table_locks locked
> 
>         kretprobe_trampoline
>           trampoline_handler
>             kretprobe_hash_lock(current, &head, &flags);  <--- deadlock
> 
> The change below sets current_kprobe in kprobe_flush_task, so the probe
> recursion protection check is hit and the probe is never set. It seems
> to fix the deadlock.

Good analysis!

> 
> I'm not sure this is the best fix, any ideas are welcome ;-)

I think this is a good way to address this issue.

> 
> thanks,
> jirka
> 
> 
> ---
>  kernel/kprobes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c241ac00..b13247cae752 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1236,6 +1236,10 @@ __releases(hlist_lock)
>  }
>  NOKPROBE_SYMBOL(kretprobe_table_unlock);
>  
> +static struct kprobe kretprobe_dummy = {
> +        .addr = (void *)kretprobe_trampoline,
> +};
> +

Perhaps a more meaningful name, say, kprobe_flush_task_protect ?

>  /*
>   * This function is called from finish_task_switch when task tk becomes dead,
>   * so that we can recycle any function-return probe instances associated
> @@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
>  	INIT_HLIST_HEAD(&empty_rp);
>  	hash = hash_ptr(tk, KPROBE_HASH_BITS);
>  	head = &kretprobe_inst_table[hash];
> +	__this_cpu_write(current_kprobe, &kretprobe_dummy);
>  	kretprobe_table_lock(hash, &flags);
>  	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
>  		if (ri->task == tk)
>  			recycle_rp_inst(ri, &empty_rp);
>  	}
>  	kretprobe_table_unlock(hash, &flags);
> +	__this_cpu_write(current_kprobe, NULL);

I would move this to the end of the function to also cover the below 
code. kprobe_flush_task() is marked NOKPROBE, so it is good to prevent 
probe handling in the below code too.

>  	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
>  		hlist_del(&ri->hlist);
>  		kfree(ri);


- Naveen

