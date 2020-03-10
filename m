Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE77C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A124020637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QkQQOGv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCJKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:12:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34568 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgCJKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:12:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AA3F4k122852;
        Tue, 10 Mar 2020 10:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NwLOWRFWQiueXZ/T6wZO3RExAUeDO7RuhVslA14vlsk=;
 b=QkQQOGv4U93m2QsiTciyW+ErarTpoVly3OH1jPzWGzqjD93Ud6BHype5gf4znBd+idDB
 vqna0kz2S9HsnUYSyEAu5SHD+qpUwv62Y055WNWZUFUaNmhvq7i2Z6DoSyISdnjie4Ta
 seB9IjwHmEo8/0HZ1FmGpjeLFomrT1RK/lMi0TYxZkNynQSE4KnR8pGUArvQRFwmbfSQ
 TdeUC4WfZsM+pAR+fS2jQD1qKaJSIwz6gr/vY5jlcrNfbnqlzPbhSwEsiEU2p/8pO1TR
 AzufH7bOtSpf/zi6rG/Qsm5p0ewJGMWYJnW6D+AX2G6H9oLD69xczTJEOXLI8u29mHiE Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yp7hm10k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:12:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAC5R6037831;
        Tue, 10 Mar 2020 10:12:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yp8rh91mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:12:12 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AACATf013288;
        Tue, 10 Mar 2020 10:12:10 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 03:12:09 -0700
Subject: Re: [patch part-II V2 01/13] context_tracking: Ensure that the
 critical path cannot be instrumented
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.017810037@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <ca03a66a-a632-e646-ed3d-d350f78f7d79@oracle.com>
Date:   Tue, 10 Mar 2020 11:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222609.017810037@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> context tracking lacks a few protection mechanisms against instrumentation:
> 
>   - While the core functions are marked NOKPROBE they lack protection
>     against function tracing which is required as the function entry/exit
>     points can be utilized by BPF.
> 
>   - static functions invoked from the protected functions need to be marked
>     as well as they can be instrumented otherwise.
> 
>   - using plain inline allows the compiler to emit traceable and probable
>     functions.
> 
> Fix this by adding the missing notrace/NOKPROBE annotations and converting
> the plain inlines to __always_inline.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/context_tracking.h       |   14 +++++++-------
>   include/linux/context_tracking_state.h |    6 +++---
>   kernel/context_tracking.c              |    9 +++++----
>   3 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/include/linux/context_tracking.h
> +++ b/include/linux/context_tracking.h
> @@ -20,32 +20,32 @@ extern void context_tracking_exit(enum c
>   extern void context_tracking_user_enter(void);
>   extern void context_tracking_user_exit(void);
>   
> -static inline void user_enter(void)
> +static __always_inline void user_enter(void)
>   {
>   	if (context_tracking_enabled())
>   		context_tracking_enter(CONTEXT_USER);
>   
>   }
> -static inline void user_exit(void)
> +static __always_inline void user_exit(void)
>   {
>   	if (context_tracking_enabled())
>   		context_tracking_exit(CONTEXT_USER);
>   }
>   
>   /* Called with interrupts disabled.  */
> -static inline void user_enter_irqoff(void)
> +static __always_inline void user_enter_irqoff(void)
>   {
>   	if (context_tracking_enabled())
>   		__context_tracking_enter(CONTEXT_USER);
>   
>   }
> -static inline void user_exit_irqoff(void)
> +static __always_inline void user_exit_irqoff(void)
>   {
>   	if (context_tracking_enabled())
>   		__context_tracking_exit(CONTEXT_USER);
>   }
>   
> -static inline enum ctx_state exception_enter(void)
> +static __always_inline enum ctx_state exception_enter(void)
>   {
>   	enum ctx_state prev_ctx;
>   
> @@ -59,7 +59,7 @@ static inline enum ctx_state exception_e
>   	return prev_ctx;
>   }
>   
> -static inline void exception_exit(enum ctx_state prev_ctx)
> +static __always_inline void exception_exit(enum ctx_state prev_ctx)
>   {
>   	if (context_tracking_enabled()) {
>   		if (prev_ctx != CONTEXT_KERNEL)
> @@ -75,7 +75,7 @@ static inline void exception_exit(enum c
>    * is enabled.  If context tracking is disabled, returns
>    * CONTEXT_DISABLED.  This should be used primarily for debugging.
>    */
> -static inline enum ctx_state ct_state(void)
> +static __always_inline enum ctx_state ct_state(void)
>   {
>   	return context_tracking_enabled() ?
>   		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -26,12 +26,12 @@ struct context_tracking {
>   extern struct static_key_false context_tracking_key;
>   DECLARE_PER_CPU(struct context_tracking, context_tracking);
>   
> -static inline bool context_tracking_enabled(void)
> +static __always_inline bool context_tracking_enabled(void)
>   {
>   	return static_branch_unlikely(&context_tracking_key);
>   }
>   
> -static inline bool context_tracking_enabled_cpu(int cpu)
> +static __always_inline bool context_tracking_enabled_cpu(int cpu)
>   {
>   	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
>   }
> @@ -41,7 +41,7 @@ static inline bool context_tracking_enab
>   	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
>   }
>   
> -static inline bool context_tracking_in_user(void)
> +static __always_inline bool context_tracking_in_user(void)
>   {
>   	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
>   }
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(context_tracking_key);
>   DEFINE_PER_CPU(struct context_tracking, context_tracking);
>   EXPORT_SYMBOL_GPL(context_tracking);
>   
> -static bool context_tracking_recursion_enter(void)
> +static notrace bool context_tracking_recursion_enter(void)
>   {
>   	int recursion;
>   
> @@ -44,8 +44,9 @@ static bool context_tracking_recursion_e
>   
>   	return false;
>   }
> +NOKPROBE_SYMBOL(context_tracking_recursion_enter);
>   
> -static void context_tracking_recursion_exit(void)
> +static __always_inline void context_tracking_recursion_exit(void)
>   {
>   	__this_cpu_dec(context_tracking.recursion);
>   }
> @@ -59,7 +60,7 @@ static void context_tracking_recursion_e
>    * instructions to execute won't use any RCU read side critical section
>    * because this function sets RCU in extended quiescent state.
>    */
> -void __context_tracking_enter(enum ctx_state state)
> +void notrace __context_tracking_enter(enum ctx_state state)
>   {
>   	/* Kernel threads aren't supposed to go to userspace */
>   	WARN_ON_ONCE(!current->mm);
> @@ -142,7 +143,7 @@ NOKPROBE_SYMBOL(context_tracking_user_en
>    * This call supports re-entrancy. This way it can be called from any exception
>    * handler without needing to know if we came from userspace or not.
>    */
> -void __context_tracking_exit(enum ctx_state state)
> +void notrace __context_tracking_exit(enum ctx_state state)
>   {
>   	if (!context_tracking_recursion_enter())
>   		return;
> 
