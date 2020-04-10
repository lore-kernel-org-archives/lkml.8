Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE032C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5F020936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/vgyQQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDJBbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:31:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgDJBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586482278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCi2hTSEiV9JmPL4EwDOU8qrlZzvezmWlD40jG+oje8=;
        b=C/vgyQQXZio37xZbrvhsfDjbzda37Srm1n/J1S6RAbdzaPJQCFmgFUUkgUHtYxvCqY6IfH
        EKegOB5EhXp7NiUknB9+aHKOpNeNqTHQjObe2CvBLKA+p5GEluWHpVxduZlMkvGBXNYXF8
        01a90GaANXyai0iPyRuo1y1zgCGEXZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-2xPQ_zelMAa7Fh-Hod-yGg-1; Thu, 09 Apr 2020 21:31:14 -0400
X-MC-Unique: 2xPQ_zelMAa7Fh-Hod-yGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1216F1005509;
        Fri, 10 Apr 2020 01:31:13 +0000 (UTC)
Received: from i7.zsun.org (ovpn-12-249.pek2.redhat.com [10.72.12.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94FF660BFB;
        Fri, 10 Apr 2020 01:31:09 +0000 (UTC)
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
To:     Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>, sztsian@gmail.com
References: <20200408164641.3299633-1-jolsa@kernel.org>
 <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
 <20200409184451.GG3309111@krava> <20200409201336.GH3309111@krava>
From:   "Ziqian SUN (Zamir)" <zsun@redhat.com>
Message-ID: <5334d3b4-4020-6705-9bcc-e6777070c9c7@redhat.com>
Date:   Fri, 10 Apr 2020 09:31:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409201336.GH3309111@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/20 4:13 AM, Jiri Olsa wrote:
> On Thu, Apr 09, 2020 at 08:45:01PM +0200, Jiri Olsa wrote:
>> On Thu, Apr 09, 2020 at 11:41:01PM +0900, Masami Hiramatsu wrote:
>>
>> SNIP
>>
>>>> ---
>>>>   kernel/kprobes.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>>> index 2625c241ac00..b13247cae752 100644
>>>> --- a/kernel/kprobes.c
>>>> +++ b/kernel/kprobes.c
>>>> @@ -1236,6 +1236,10 @@ __releases(hlist_lock)
>>>>   }
>>>>   NOKPROBE_SYMBOL(kretprobe_table_unlock);
>>>>   
>>>> +static struct kprobe kretprobe_dummy = {
>>>> +        .addr = (void *)kretprobe_trampoline,
>>>> +};
>>>> +
>>>>   /*
>>>>    * This function is called from finish_task_switch when task tk becomes dead,
>>>>    * so that we can recycle any function-return probe instances associated
>>>> @@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
>>>>   	INIT_HLIST_HEAD(&empty_rp);
>>>>   	hash = hash_ptr(tk, KPROBE_HASH_BITS);
>>>>   	head = &kretprobe_inst_table[hash];
>>>> +	__this_cpu_write(current_kprobe, &kretprobe_dummy);
>>>
>>> Can you also set the kcb->kprobe_state = KPROBE_HIT_ACTIVE?
>>>
>>> BTW, we may be better to introduce a common kprobe_reject_section_start()
>>> and kprobe_reject_section_end() so that the user don't need to prepare
>>> dummy kprobes.
>>
>> sure, will do
>>
>> thank you both for review
> 
> ok, found out it's actually arch code..  would you guys be ok with something like below?
> 
> jirka
> 

Hi Jiri,

In my origin test lockup happens on both x86_64 and ppc64le. So I would 
appreciate if you can also come up with a solution for both of the 
architectures.

> 
> ---
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4d7022a740ab..081d0f366c99 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -757,12 +757,33 @@ static struct kprobe kretprobe_kprobe = {
>   	.addr = (void *)kretprobe_trampoline,
>   };
>   
> +void arch_kprobe_reject_section_start(void)
> +{
> +	struct kprobe_ctlblk *kcb;
> +
> +	preempt_disable();
> +
> +	/*
> +	 * Set a dummy kprobe for avoiding kretprobe recursion.
> +	 * Since kretprobe never run in kprobe handler, kprobe must not
> +	 * be running behind this point.
> +	 */
> +	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
> +	kcb = get_kprobe_ctlblk();
> +	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +}
> +
> +void arch_kprobe_reject_section_end(void)
> +{
> +	__this_cpu_write(current_kprobe, NULL);
> +	preempt_enable();
> +}
> +
>   /*
>    * Called from kretprobe_trampoline
>    */
>   __used __visible void *trampoline_handler(struct pt_regs *regs)
>   {
> -	struct kprobe_ctlblk *kcb;
>   	struct kretprobe_instance *ri = NULL;
>   	struct hlist_head *head, empty_rp;
>   	struct hlist_node *tmp;
> @@ -772,16 +793,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>   	void *frame_pointer;
>   	bool skipped = false;
>   
> -	preempt_disable();
> -
> -	/*
> -	 * Set a dummy kprobe for avoiding kretprobe recursion.
> -	 * Since kretprobe never run in kprobe handler, kprobe must not
> -	 * be running at this point.
> -	 */
> -	kcb = get_kprobe_ctlblk();
> -	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
> -	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +	arch_kprobe_reject_section_start();
>   
>   	INIT_HLIST_HEAD(&empty_rp);
>   	kretprobe_hash_lock(current, &head, &flags);
> @@ -873,8 +885,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>   
>   	kretprobe_hash_unlock(current, &flags);
>   
> -	__this_cpu_write(current_kprobe, NULL);
> -	preempt_enable();
> +	arch_kprobe_reject_section_end();
>   
>   	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
>   		hlist_del(&ri->hlist);
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c241ac00..935dd8c87705 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1236,6 +1236,14 @@ __releases(hlist_lock)
>   }
>   NOKPROBE_SYMBOL(kretprobe_table_unlock);
>   
> +void __weak arch_kprobe_reject_section_start(void)
> +{
> +}
> +
> +void __weak arch_kprobe_reject_section_end(void)
> +{
> +}
> +
>   /*
>    * This function is called from finish_task_switch when task tk becomes dead,
>    * so that we can recycle any function-return probe instances associated
> @@ -1253,6 +1261,8 @@ void kprobe_flush_task(struct task_struct *tk)
>   		/* Early boot.  kretprobe_table_locks not yet initialized. */
>   		return;
>   
> +	arch_kprobe_reject_section_start();
> +
>   	INIT_HLIST_HEAD(&empty_rp);
>   	hash = hash_ptr(tk, KPROBE_HASH_BITS);
>   	head = &kretprobe_inst_table[hash];
> @@ -1266,6 +1276,8 @@ void kprobe_flush_task(struct task_struct *tk)
>   		hlist_del(&ri->hlist);
>   		kfree(ri);
>   	}
> +
> +	arch_kprobe_reject_section_end();
>   }
>   NOKPROBE_SYMBOL(kprobe_flush_task);
>   
> 

-- 
Ziqian SUN (Zamir)
9F Raycom office (NAY)
Red Hat Software (Beijing) Co.,Ltd
IRC: zsun (internal and freenode)
Tel: +86 10 65627458
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E

