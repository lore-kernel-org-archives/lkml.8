Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CFAC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A71224649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tuj17UKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgCJNbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgCJNbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADSOLi087988;
        Tue, 10 Mar 2020 13:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DSgnezMb2QdUmnV2xd4QebInlsJvoxs50foHZWkt7og=;
 b=tuj17UKPx9J7QqbR7M85Pd8GQvPPx9R579HUFkMsQyiKOns+XVZHgUXbj6NOPXsEJMgh
 uV8AkXKeBlcYvMWjGzT32D+WiWmnnAFQ1OoqLi/Erz6sA5XZ0Ck4kRlib42hOSrfsE6z
 1k3YyGgtftQ+N94i23tD/VxhouvKxA8PvFWAkukVf7ENghg3in7hK+ne+SrS1+xOTiyW
 PCuC23+mCjBSWC70vm8KSjg3TA+lyYgGUyZK+2fzEqIFDj4ebeAqweL40TLEIPFeJV+o
 lleR/SyzS226lyzV8fN9Q40ruee96oqhj+w+S43F+g1t7xEyhHE5uSvO30BsRaJzBdL3 6w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yp9v60m2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 13:30:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ADRDDI178975;
        Tue, 10 Mar 2020 13:28:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yp8qn7ax6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 13:28:23 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ADSKog014517;
        Tue, 10 Mar 2020 13:28:20 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 06:28:20 -0700
Subject: Re: [patch part-II V2 09/13] x86/entry/common: Split hardirq tracing
 into lockdep and ftrace parts
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.825111830@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <e7b7bc51-33a4-1370-68e4-b1e1b9d2360e@oracle.com>
Date:   Tue, 10 Mar 2020 14:28:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222609.825111830@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> trace_hardirqs_off() is in fact a tracepoint which can be utilized by BPF,
> which is unsafe before calling enter_from_user_mode(), which in turn
> invokes context tracking. trace_hardirqs_off() also invokes
> lockdep_hardirqs_off() under the hood.
> 
> OTOH lockdep needs to know about the interrupts disabled state before
> enter_from_user_mode(). lockdep_hardirqs_off() is safe to call at this
> point.
> 
> Split it so lockdep knows about the state and invoke the tracepoint after
> the context is set straight.
> 
> Even if the functions attached to a tracepoint would all be safe to be
> called in rcuidle having it split up is still giving a performance
> advantage because rcu_read_lock_sched() is avoiding the whole dance of:
> 
>     scru_read_lock();
>     rcu_irq_enter_irqson();
>     ...
>     rcu_irq_exit_irqson();
>     scru_read_unlock();
>     
> around the tracepoint function invocation just to have the C entry points
> of syscalls call enter_from_user_mode() right after the above dance.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>   arch/x86/entry/common.c |   13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)


Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.


> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -60,10 +60,19 @@ static __always_inline void syscall_entr
>   {
>   	/*
>   	 * Usermode is traced as interrupts enabled, but the syscall entry
> -	 * mechanisms disable interrupts. Tell the tracer.
> +	 * mechanisms disable interrupts. Tell lockdep before calling
> +	 * enter_from_user_mode(). This is safe vs. RCU while the
> +	 * tracepoint is not.
>   	 */
> -	trace_hardirqs_off();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
> +
>   	enter_from_user_mode();
> +
> +	/*
> +	 * Tell the tracer about the irq state as well before enabling
> +	 * interrupts.
> +	 */
> +	__trace_hardirqs_off();
>   	local_irq_enable();
>   }
>   
> 
