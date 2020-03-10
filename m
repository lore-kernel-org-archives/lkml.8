Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94714C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6067E2468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xCZPDG1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgCJK4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:56:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgCJK4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:56:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAqcwN094799;
        Tue, 10 Mar 2020 10:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XXjzFNB9cRgttYtET8dUuiD6TKGwXuCnG+xeyoL7B14=;
 b=xCZPDG1FV3MzrR3RkkxTniETVeialYVxkXfq+aOUJ4fPHN2HccnQcx8PfKVhjySY+CKD
 cm5m62lSfL3g5qYVhY7FrOnpQJToQXvw8woD3bFQdwXaAF/osiHxgEC+2HWFYjxP6JoG
 cKPou7fFYs+uF1WGHYq7zV/SeS/uKbyVezycw/DyfL+mUMo+WviYYI0crGVQi151wE6O
 tpEvjv3ElMyghJ+CDUmZXNOhkzX+XPjywlakQvsfU6TPOEErRO60SqthgNT+48wyNJYa
 N91TVy82HG2JqHuJQECRFMZuvfuRSfiLNU1okcENE5u8SZsaUbnHg0sP/I+kTOkMU1db Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ym31ucu7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:55:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAl7Mv189027;
        Tue, 10 Mar 2020 10:55:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2yp8qmq5ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:55:55 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AAtsQA005766;
        Tue, 10 Mar 2020 10:55:54 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 03:55:54 -0700
Subject: Re: [patch part-II V2 08/13] tracing: Provide lockdep less
 trace_hardirqs_on/off() variants
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.731890049@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <07a50582-1c2f-7f45-c7dd-5ff9c2ff3052@oracle.com>
Date:   Tue, 10 Mar 2020 11:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222609.731890049@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> trace_hardirqs_on/off() is only partially safe vs. RCU idle. The tracer
> core itself is safe, but the resulting tracepoints can be utilized by
> e.g. BPF which is unsafe.
> 
> Provide variants which do not contain the lockdep invocation so the lockdep
> and tracer invocations can be split at the call site and placed properly.
> 
> The new variants also do not use rcuidle as they are going to be called
> from entry code after/before context tracking.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>   include/linux/irqflags.h        |    4 ++++
>   kernel/trace/trace_preemptirq.c |   23 +++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -29,6 +29,8 @@
>   #endif
>   
>   #ifdef CONFIG_TRACE_IRQFLAGS
> +  extern void __trace_hardirqs_on(void);
> +  extern void __trace_hardirqs_off(void);
>     extern void trace_hardirqs_on(void);
>     extern void trace_hardirqs_off(void);
>   # define trace_hardirq_context(p)	((p)->hardirq_context)
> @@ -52,6 +54,8 @@ do {						\
>   	current->softirq_context--;		\
>   } while (0)
>   #else
> +# define __trace_hardirqs_on()		do { } while (0)
> +# define __trace_hardirqs_off()		do { } while (0)
>   # define trace_hardirqs_on()		do { } while (0)
>   # define trace_hardirqs_off()		do { } while (0)
>   # define trace_hardirq_context(p)	0
> --- a/kernel/trace/trace_preemptirq.c
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -19,6 +19,17 @@
>   /* Per-cpu variable to prevent redundant calls when IRQs already off */
>   static DEFINE_PER_CPU(int, tracing_irq_cpu);
>   
> +void __trace_hardirqs_on(void)
> +{
> +	if (this_cpu_read(tracing_irq_cpu)) {
> +		if (!in_nmi())
> +			trace_irq_enable(CALLER_ADDR0, CALLER_ADDR1);
> +		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
> +		this_cpu_write(tracing_irq_cpu, 0);
> +	}
> +}
> +NOKPROBE_SYMBOL(__trace_hardirqs_on);
> +

Shouldn't trace_hardirqs_on() be updated to call __trace_hardirqs_on()? It's the same
code except for the lockdep call.

void trace_hardirqs_on(void)
{
         __trace_hardirqs_on();
         lockdep_hardirqs_on(CALLER_ADDR0);
}
EXPORT_SYMBOL(trace_hardirqs_on);
NOKPROBE_SYMBOL(trace_hardirqs_on);


>   void trace_hardirqs_on(void)
>   {
>   	if (this_cpu_read(tracing_irq_cpu)) {
> @@ -33,6 +44,18 @@ void trace_hardirqs_on(void)
>   EXPORT_SYMBOL(trace_hardirqs_on);
>   NOKPROBE_SYMBOL(trace_hardirqs_on);
>   
> +void __trace_hardirqs_off(void)
> +{
> +	if (!this_cpu_read(tracing_irq_cpu)) {
> +		this_cpu_write(tracing_irq_cpu, 1);
> +		tracer_hardirqs_off(CALLER_ADDR0, CALLER_ADDR1);
> +		if (!in_nmi())
> +			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
> +	}
> +
> +}
> +NOKPROBE_SYMBOL(__trace_hardirqs_off);
> +

Same comment here.

alex.

>   void trace_hardirqs_off(void)
>   {
>   	if (!this_cpu_read(tracing_irq_cpu)) {
> 
