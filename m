Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE050C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF2820675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="McuqvA01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgCJNiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:38:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgCJNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:38:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADXPB3148544;
        Tue, 10 Mar 2020 13:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=5xE9mIQ6H+w6Y2VIvobhlVn3GINEwJlOuyFmGHNEmlE=;
 b=McuqvA01psxkAOZDl3so/feQCVs24k8YHMk3k+5zXrOjFktuG9JAlhN0xAC2CHvowhaO
 Uz5VlfQlU+/p7NwsfYukbIQTYmFlhhFjgiTnyNg8Kdf0bldL6sg3P66lJK6WouKF3UPN
 4UsGHHl7q+ejle5zzdF1FekeGyIFH9oC0fNZXXG/EtwnjwC58BpD80gE3CzobU/v+CAT
 ABbQTbGyI6n5y76qQ8yigmIQE/pM6wlavXBPiRNffBrvfGDXYP1R30c17XMrLDVbzXJG
 a+JFjDOVanyrpNNv5VQmIpALZN1sj3GS7jBmV3wRFt3bmkgPtS9ekKVA3JJP82hahrig mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yp7hm1xnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 13:37:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADYHcC189898;
        Tue, 10 Mar 2020 13:37:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2yp8prfvc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 13:37:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ADbRxm012120;
        Tue, 10 Mar 2020 13:37:28 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 06:37:27 -0700
Subject: Re: [patch part-II V2 10/13] x86/entry/common: Split
 prepare_exit_to_usermode() and syscall_return_slowpath()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.932307492@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <66bc932f-3ef7-1bcd-c5bc-c546036e2f3f@oracle.com>
Date:   Tue, 10 Mar 2020 14:37:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222609.932307492@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> Split the functions into traceable and probale parts and a part protected

typo: probale -> probeable ?

> from instrumentation.
> 
> This is required because after calling user_exit_irqsoff() kprobes and
> tracepoints/function entry/exit which can be utilized by e.g. BPF are not
> longer safe vs. RCU.
> 
> Preparatory step to move irq flags tracing to C code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch to reduce the churn
> ---
>   arch/x86/entry/common.c |   25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -206,7 +206,7 @@ static void exit_to_usermode_loop(struct
>   }
>   
>   /* Called with IRQs disabled. */
> -__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
> +static noinline void __prepare_exit_to_usermode(struct pt_regs *regs)

Why noinline?

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


>   {
>   	struct thread_info *ti = current_thread_info();
>   	u32 cached_flags;
> @@ -245,11 +245,16 @@ static void exit_to_usermode_loop(struct
>   	 */
>   	ti->status &= ~(TS_COMPAT|TS_I386_REGS_POKED);
>   #endif
> +}
>   
> -	user_enter_irqoff();
> +__visible inline notrace void prepare_exit_to_usermode(struct pt_regs *regs)
> +{
> +	__prepare_exit_to_usermode(regs);
>   
> +	user_enter_irqoff();
>   	mds_user_clear_cpu_buffers();
>   }
> +NOKPROBE_SYMBOL(prepare_exit_to_usermode);
>   
>   #define SYSCALL_EXIT_WORK_FLAGS				\
>   	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
> @@ -277,11 +282,7 @@ static void syscall_slow_exit_work(struc
>   		tracehook_report_syscall_exit(regs, step);
>   }
>   
> -/*
> - * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
> - * state such that we can immediately switch to user mode.
> - */
> -__visible inline void syscall_return_slowpath(struct pt_regs *regs)
> +static void __syscall_return_slowpath(struct pt_regs *regs)
>   {
>   	struct thread_info *ti = current_thread_info();
>   	u32 cached_flags = READ_ONCE(ti->flags);
> @@ -302,8 +303,18 @@ static void syscall_slow_exit_work(struc
>   		syscall_slow_exit_work(regs, cached_flags);
>   
>   	local_irq_disable();
> +}
> +
> +/*
> + * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
> + * state such that we can immediately switch to user mode.
> + */
> +__visible inline notrace void syscall_return_slowpath(struct pt_regs *regs)
> +{
> +	__syscall_return_slowpath(regs);
>   	prepare_exit_to_usermode(regs);
>   }
> +NOKPROBE_SYMBOL(syscall_return_slowpath);
>   
>   #ifdef CONFIG_X86_64
>   static __always_inline
> 
