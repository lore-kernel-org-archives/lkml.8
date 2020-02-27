Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB1C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB7724697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L9T5BHuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgB0Pok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:44:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgB0Poj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:44:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RFd8js155298;
        Thu, 27 Feb 2020 15:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QXSlkRHI3hoTR7/VwE5TTXP/LbuzhXfAtFrIHPkf9uQ=;
 b=L9T5BHuICjX473yacWxJ7GFtNu0hn9ymyVfIpKXSuFavLqGUHOvGSBp76n4rmNWbCv6D
 EwEUfYIKNPkZ6XugFrIsblYQfn7mYqzXNQhPZGMwShdvuiMwzKXra7KZG+foXJPC1u9s
 /JJmtn8K0Xvoep8ol9hai43kylkPck9SevDFqpQVVTKJTV7FmXY+ooNvCVe5Py7wxl9n
 O5LKfYfP2cZ9FUZGg/X+KLotKFXdU9UtUzG8fD+qWeg3etQEQLRktCfOg9k5F8lmtbIc
 7xSKxoGVvvoAybi01keg4cLAHGuBr2CE/tdPinBnbbcM5SgGIpZtEAIgff9X7KnVUOeN uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct3brsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 15:43:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01RFh5tw194923;
        Thu, 27 Feb 2020 15:43:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ydcs5gupf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 15:43:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01RFhfFj008399;
        Thu, 27 Feb 2020 15:43:41 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 07:43:41 -0800
Subject: Re: [patch 5/8] x86/entry/common: Provide trace/kprobe safe exit to
 user space functions
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.719921962@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <71271e39-1dbd-0bd6-2435-fc8a30f47b7d@oracle.com>
Date:   Thu, 27 Feb 2020 16:43:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225221305.719921962@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002270123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/20 11:08 PM, Thomas Gleixner wrote:
> Split prepare_enter_to_user_mode() and mark it notrace/noprobe so the irq
> flags tracing on return can be put into it.

This splits prepare_exit_to_usermode() not prepare_enter_to_user_mode().


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c |   15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -196,7 +196,7 @@ static void exit_to_usermode_loop(struct
>   }
>   
>   /* Called with IRQs disabled. */
> -__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
> +static inline void __prepare_exit_to_usermode(struct pt_regs *regs)
>   {
>   	struct thread_info *ti = current_thread_info();
>   	u32 cached_flags;
> @@ -241,6 +241,12 @@ static void exit_to_usermode_loop(struct
>   	mds_user_clear_cpu_buffers();
>   }
>   
> +__visible inline notrace void prepare_exit_to_usermode(struct pt_regs *regs)
> +{
> +	__prepare_exit_to_usermode(regs);
> +}
> +NOKPROBE_SYMBOL(prepare_exit_to_usermode);


Would it be worth grouping local_irq_disable() and prepare_exit_to_usermode()
(similarly to what was done entry with syscall_entry_fixups()) and then put
trace_hardirqs_on() there too. For example:

static __always_inline void syscall_exit_fixups(struct pt_regs *regs)
{
         local_irq_disable();
         prepare_exit_to_usermode(regs);
         trace_hardirqs_on();
}

Or is this planned once prepare_exit_from_usermode() is not used by idtentry
anymore?

Thanks,

alex.

>   #define SYSCALL_EXIT_WORK_FLAGS				\
>   	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
>   	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
> @@ -271,7 +277,7 @@ static void syscall_slow_exit_work(struc
>    * Called with IRQs on and fully valid regs.  Returns with IRQs off in a
>    * state such that we can immediately switch to user mode.
>    */
> -__visible inline void syscall_return_slowpath(struct pt_regs *regs)
> +__visible inline notrace void syscall_return_slowpath(struct pt_regs *regs)
>   {
>   	struct thread_info *ti = current_thread_info();
>   	u32 cached_flags = READ_ONCE(ti->flags);
> @@ -292,8 +298,9 @@ static void syscall_slow_exit_work(struc
>   		syscall_slow_exit_work(regs, cached_flags);
>   
>   	local_irq_disable();
> -	prepare_exit_to_usermode(regs);
> +	__prepare_exit_to_usermode(regs);
>   }
> +NOKPROBE_SYMBOL(syscall_return_slowpath);
>   
>   #ifdef CONFIG_X86_64
>   static __always_inline
> @@ -417,7 +424,7 @@ static __always_inline long do_fast_sysc
>   		/* User code screwed up. */
>   		local_irq_disable();
>   		regs->ax = -EFAULT;
> -		prepare_exit_to_usermode(regs);
> +		__prepare_exit_to_usermode(regs);
>   		return 0;	/* Keep it simple: use IRET. */
>   	}
>   
> 
