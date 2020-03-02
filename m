Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA43C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF4C217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cf3Cx9ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCBOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:36:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35891 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbgCBOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583159762;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwEel4uE0Cdd4JHfFWuutC2fbn5lHLwoc+9Xeu/u7ZY=;
        b=Cf3Cx9lsYaFNvpNb4BfdSG5Xbu9R0hPaHpPs0OaQhjRrsbBLOEX+otRRZR6uT5MnzIOqpK
        dfv8DXx0qWn6Mco3FRkkhc+CeaB8lJdlHjmNMe34+Lyq0NLlUt9LUEmMIV3NTff+aNiGJV
        C8TpF1VsdnKJ9QKWi/GjcZgjGbshrKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-iNJD-8apO3Ojb5Dgy2NStw-1; Mon, 02 Mar 2020 09:36:00 -0500
X-MC-Unique: iNJD-8apO3Ojb5Dgy2NStw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B02DD85EE6D;
        Mon,  2 Mar 2020 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-46.bne.redhat.com [10.64.54.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34A5E619DB;
        Mon,  2 Mar 2020 14:35:55 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/kernel: Simplify __cpu_up() by bailing out early
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        shan.gavin@gmail.com
References: <20200302020340.119588-1-gshan@redhat.com>
 <20200302122135.GB56497@lakrids.cambridge.arm.com>
 <ddbb5cb2-e8b6-ab1c-d283-fb0f402d2a4f@redhat.com>
 <20200302140640.GC56497@lakrids.cambridge.arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <803b09ec-233d-8994-3dad-5a4a4ad85412@redhat.com>
Date:   Tue, 3 Mar 2020 01:35:54 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200302140640.GC56497@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/20 1:06 AM, Mark Rutland wrote:
> On Tue, Mar 03, 2020 at 12:38:48AM +1100, Gavin Shan wrote:
>> On 3/2/20 11:21 PM, Mark Rutland wrote:
>>> On Mon, Mar 02, 2020 at 01:03:40PM +1100, Gavin Shan wrote:
>>>> The function __cpu_up() is invoked to bring up the target CPU through
>>>> the backend, PSCI for example. The nested if statements won't be needed
>>>> if we bail out early on the following two conditions where the status
>>>> won't be checked. The code looks simplified in that case.
>>>>
>>>>      * Error returned from the backend (e.g. PSCI)
>>>>      * The target CPU has been marked as onlined
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>
>>> FWIW, this looks like a nice cleanup to me:
>>>
>>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>>>
>>> While this patch leaves secondary_data.{task,stack} stale on a
>>> successful onlining, that was already the case for a timeout, and should
>>> be fine (since the next attempt at onlining will configure those before
>>> poking the CPU).
>>>
>>> Thanks,
>>> Mark.
>>>
>>
>> Thanks, Mark. Yeah, it should be fine as you said. There are something else,
>> which might be not relevant. @secondary_data could be accessed by multiple CPUs
>> in parallel. For example, the master CPU boots CPU#1 and timeouts to wait it
>> to be online in 5 seconds. CPU#1 isn't necessarily stuck in somewhere. After
>> that, CPU#2 is brought up and might be accessing @secondary_data. At this point,
>> CPU#1 can come back to access it either. However, @secondary_data isn't valid
>> for CPU#1 anymore.
> 
> Sure; I'm aware of improvements that could be made here, but I don't
> think they need to block this patch.
> 

Yep, I think this patch is ready to go in if nobody else objects.

>> I was thinking of something to improve the situation, but not sure if it makes
>> any sense to do so. There are several options: (1) Make @secondary_data per-cpu
>> variable, which looks a nature way to go. (2) To shutdown the CPU on timeout.
>> The shutdown request can be failed to be served in theory, but it seems still
>> an improvement.
> 
> I think #2 is a bad idea, since if the CPU gets into the kernel at all,
> it may have done stuff (e.g. acquiring locks), and ripping it out is
> liable to cause more problems.
> 
> I think doing #1 might be nice, but some caveats apply.
> 
> I'd like to clean up the secondary stack/task hand-over to use an atomic
> cmpxchg pair, so that we can detect when the secondary has possibly
> tried to use the stack/task. That requires splitting that from the
> MMU-off bits from the MMU-on bits, and I'm not sure how well that
> interacts with #1. It might mean that the per-cpu part isn't that
> worthwhile.
> 

Right, #2 isn't good if the acquired resource (e.g. lock) can't be released.

It's something like to introduce a lock to the shared @secondary_data with
atomic cmpxchg pair. With that, I don't think per-cpu part is needed, not
so useful at least.

Thanks,
Gavin

>>
>>>> ---
>>>>    arch/arm64/kernel/smp.c | 79 +++++++++++++++++++----------------------
>>>>    1 file changed, 37 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>>> index d4ed9a19d8fe..2a9d8f39dc58 100644
>>>> --- a/arch/arm64/kernel/smp.c
>>>> +++ b/arch/arm64/kernel/smp.c
>>>> @@ -115,60 +115,55 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>>>    	update_cpu_boot_status(CPU_MMU_OFF);
>>>>    	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>>>> -	/*
>>>> -	 * Now bring the CPU into our world.
>>>> -	 */
>>>> +	/* Now bring the CPU into our world */
>>>>    	ret = boot_secondary(cpu, idle);
>>>> -	if (ret == 0) {
>>>> -		/*
>>>> -		 * CPU was successfully started, wait for it to come online or
>>>> -		 * time out.
>>>> -		 */
>>>> -		wait_for_completion_timeout(&cpu_running,
>>>> -					    msecs_to_jiffies(5000));
>>>> -
>>>> -		if (!cpu_online(cpu)) {
>>>> -			pr_crit("CPU%u: failed to come online\n", cpu);
>>>> -			ret = -EIO;
>>>> -		}
>>>> -	} else {
>>>> +	if (ret) {
>>>>    		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>>>>    		return ret;
>>>>    	}
>>>> +	/*
>>>> +	 * CPU was successfully started, wait for it to come online or
>>>> +	 * time out.
>>>> +	 */
>>>> +	wait_for_completion_timeout(&cpu_running,
>>>> +				    msecs_to_jiffies(5000));
>>>> +	if (cpu_online(cpu))
>>>> +		return 0;
>>>> +
>>>> +	pr_crit("CPU%u: failed to come online\n", cpu);
>>>>    	secondary_data.task = NULL;
>>>>    	secondary_data.stack = NULL;
>>>>    	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
>>>>    	status = READ_ONCE(secondary_data.status);
>>>> -	if (ret && status) {
>>>> -
>>>> -		if (status == CPU_MMU_OFF)
>>>> -			status = READ_ONCE(__early_cpu_boot_status);
>>>> +	if (status == CPU_MMU_OFF)
>>>> +		status = READ_ONCE(__early_cpu_boot_status);
>>>> -		switch (status & CPU_BOOT_STATUS_MASK) {
>>>> -		default:
>>>> -			pr_err("CPU%u: failed in unknown state : 0x%lx\n",
>>>> -					cpu, status);
>>>> -			cpus_stuck_in_kernel++;
>>>> -			break;
>>>> -		case CPU_KILL_ME:
>>>> -			if (!op_cpu_kill(cpu)) {
>>>> -				pr_crit("CPU%u: died during early boot\n", cpu);
>>>> -				break;
>>>> -			}
>>>> -			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
>>>> -			/* Fall through */
>>>> -		case CPU_STUCK_IN_KERNEL:
>>>> -			pr_crit("CPU%u: is stuck in kernel\n", cpu);
>>>> -			if (status & CPU_STUCK_REASON_52_BIT_VA)
>>>> -				pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
>>>> -			if (status & CPU_STUCK_REASON_NO_GRAN)
>>>> -				pr_crit("CPU%u: does not support %luK granule \n", cpu, PAGE_SIZE / SZ_1K);
>>>> -			cpus_stuck_in_kernel++;
>>>> +	switch (status & CPU_BOOT_STATUS_MASK) {
>>>> +	default:
>>>> +		pr_err("CPU%u: failed in unknown state : 0x%lx\n",
>>>> +		       cpu, status);
>>>> +		cpus_stuck_in_kernel++;
>>>> +		break;
>>>> +	case CPU_KILL_ME:
>>>> +		if (!op_cpu_kill(cpu)) {
>>>> +			pr_crit("CPU%u: died during early boot\n", cpu);
>>>>    			break;
>>>> -		case CPU_PANIC_KERNEL:
>>>> -			panic("CPU%u detected unsupported configuration\n", cpu);
>>>>    		}
>>>> +		pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
>>>> +		/* Fall through */
>>>> +	case CPU_STUCK_IN_KERNEL:
>>>> +		pr_crit("CPU%u: is stuck in kernel\n", cpu);
>>>> +		if (status & CPU_STUCK_REASON_52_BIT_VA)
>>>> +			pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
>>>> +		if (status & CPU_STUCK_REASON_NO_GRAN) {
>>>> +			pr_crit("CPU%u: does not support %luK granule\n",
>>>> +				cpu, PAGE_SIZE / SZ_1K);
>>>> +		}
>>>> +		cpus_stuck_in_kernel++;
>>>> +		break;
>>>> +	case CPU_PANIC_KERNEL:
>>>> +		panic("CPU%u detected unsupported configuration\n", cpu);
>>>>    	}
>>>>    	return ret;
>>>> -- 
>>>> 2.23.0
>>>>
>>>
>>
> 

