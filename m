Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5DFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14C620752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vDs1ae+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgEFNyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:54:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36870 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgEFNyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:54:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046DrANn051459;
        Wed, 6 May 2020 13:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=k9gWYPY0X5E58dZlZwODQHvSgUrv5htiTDNKC5QGVCM=;
 b=vDs1ae+LHvrWrIM/Z6b/2FIEc5/KK34XUGzTXU7fBtT9IT6e+6MiQhRtJHwCEtgiiPDv
 YaQ4coq/UGTeTo82zrroCPZqE62RxfauF2wO6M9W5z5kDKEK41hY5gmowP+TztW+p5y0
 xhlvAfipFt9efkcOIJWVz9wp4+BCjwguTCOPDq07LwXLiUgFXQ5Rr4ZYW6yss73qfGql
 c8UWtgQuKV9gpGC+xEiZ29GrtsuI+o2HnXYZ2Qzi3aufjv33RiCX3QTO5tEtY8VECg4H
 DCD5tsQcx5ou7JYyyHYyMuWBW2jcQlUz05gy2tC1fww6VXJRDDTM1kEv1QnDfodqCMXU mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30usgq1j6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:53:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046DqcJ6078877;
        Wed, 6 May 2020 13:53:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30us7mr9xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:53:33 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046DrVUO015330;
        Wed, 6 May 2020 13:53:31 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 06:53:31 -0700
Subject: Re: [patch V4 part 1 10/36] x86/entry: Remove the unused
 LOCKDEP_SYSEXIT cruft
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134059.061301403@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <e8f30d35-ab13-1050-a33c-d2bc76977b5a@oracle.com>
Date:   Wed, 6 May 2020 15:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.061301403@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> No users left since two years due to commit 21d375b6b34f ("x86/entry/64:
> Remove the SYSCALL64 fast path")
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/thunk_64.S       |    5 -----
>   arch/x86/include/asm/irqflags.h |   24 ------------------------
>   2 files changed, 29 deletions(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/entry/thunk_64.S
> +++ b/arch/x86/entry/thunk_64.S
> @@ -42,10 +42,6 @@ SYM_FUNC_END(\name)
>   	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
>   #endif
>   
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -	THUNK lockdep_sys_exit_thunk,lockdep_sys_exit
> -#endif
> -
>   #ifdef CONFIG_PREEMPTION
>   	THUNK preempt_schedule_thunk, preempt_schedule
>   	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
> @@ -54,7 +50,6 @@ SYM_FUNC_END(\name)
>   #endif
>   
>   #if defined(CONFIG_TRACE_IRQFLAGS) \
> - || defined(CONFIG_DEBUG_LOCK_ALLOC) \
>    || defined(CONFIG_PREEMPTION)
>   SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
>   	popq %r11
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -180,30 +180,6 @@ static inline int arch_irqs_disabled(voi
>   #  define TRACE_IRQS_ON
>   #  define TRACE_IRQS_OFF
>   #endif
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
> -#  ifdef CONFIG_X86_64
> -#    define LOCKDEP_SYS_EXIT		call lockdep_sys_exit_thunk
> -#    define LOCKDEP_SYS_EXIT_IRQ \
> -	TRACE_IRQS_ON; \
> -	sti; \
> -	call lockdep_sys_exit_thunk; \
> -	cli; \
> -	TRACE_IRQS_OFF;
> -#  else
> -#    define LOCKDEP_SYS_EXIT \
> -	pushl %eax;				\
> -	pushl %ecx;				\
> -	pushl %edx;				\
> -	call lockdep_sys_exit;			\
> -	popl %edx;				\
> -	popl %ecx;				\
> -	popl %eax;
> -#    define LOCKDEP_SYS_EXIT_IRQ
> -#  endif
> -#else
> -#  define LOCKDEP_SYS_EXIT
> -#  define LOCKDEP_SYS_EXIT_IRQ
> -#endif
>   #endif /* __ASSEMBLY__ */
>   
>   #endif
> 
