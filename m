Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80535C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2220774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgDMJX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:23:28 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:60327 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgDMJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:23:28 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id B6290262307;
        Mon, 13 Apr 2020 17:23:13 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangqing@vivo.com
Cc:     opensource.kernel@vivo.com
Subject: RE:[PATCH] ARM64: fixed dump_backtrace() when task running on another cpu
Date:   Mon, 13 Apr 2020 17:23:08 +0800
Message-Id: <1586769788-5954-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586425106-7369-1-git-send-email-wangqing@vivo.com>
References: <1586425106-7369-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSlVCTkNCQkJCQkpPSk1CSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6HAw*Tjg1MAsfSTQNKhQ9
        CwgwFBRVSlVKTkNNTE1CTEJIQklIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhISUM3Bg++
X-HM-Tid: 0a7172d993279375kuwsb6290262307
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>On Thu, Apr 09, 2020 at 05:38:16PM +0800, Wang Qing wrote:
>> We cannot get FP and PC when the task is running on another CPU,
>> task->thread.cpu_context is the last time the task was switched out,
>> it's better to give a reminder than to provide wrong information.
>> 
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>
>Are you seeing this happen anywhere in particular today?

This problem is not so obvious, because it will not cause any exceptions
but will show "old" stack always ending with switch_to, I finally confirmed
the problem through debugging.

For example:Task blocked in spinlock/interrupt/busy loop, I want to print
the backtrace when detected(like PSI in Android), the printing is wrong(old).

>
>> ---
>>  arch/arm64/kernel/traps.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index cf402be..c04e3e8 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -106,6 +106,14 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>>  		start_backtrace(&frame,
>>  				(unsigned long)__builtin_frame_address(0),
>>  				(unsigned long)dump_backtrace);
>> +	} else if (tsk->on_cpu) {
>> +		/*
>> +		 * The task is running in another cpu, so the call stack
>> +		 * is changing and we cannot get it.
>> +		 */
>> +		pr_warn("tsk: %s is running in CPU%d, Don't call trace!\n",
>> +			tsk->comm, tsk->cpu);
>
>I believe that we can race with a concurrent write to tsk->cpu in both
>cases above. We could use READ_ONCE() to get a snapshot, but we can
>still race and miss cases where the task was runnning as we backtrace
>it.
>
>Thanks,
>Mark.

I will use task_cpu(tsk) instead of tsk->cpu, and add task_running_oncpu() in
include/linux/sched.h instead of tsk->on_cpu, but as you said, by this patch,
we can still race and miss cases where the task was runnning as we backtrace.

But from the user's perspective, printing wrong backtrace is confused when
we call this function while task already running. However, it's reasonable to
print the last backtrace when task enter running during the function is called.

Thanks,
Wang Qing.

>
>> +		return;
>>  	} else {
>>  		/*
>>  		 * task blocked in __switch_to
>> -- 
>> 2.7.4
>> 

