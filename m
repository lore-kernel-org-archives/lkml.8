Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB14BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B8C2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="augVEg3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgEFQAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:00:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:00:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046Fx9Ct106891;
        Wed, 6 May 2020 15:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LOQ/A3fG6m7wFDoUQdwF4Fo8BrWLMmlp7AtGe0BFJ8c=;
 b=augVEg3tSFiYs2V+PISkeevIH2eox669hc9KqKo1DTANfKi6mX2QEzQK4HvkHJjV039B
 dR7eg8fsgr93p9OkEPqdRRebdb8YzzU5kHQLLuU+5Gc/07nd/Vp6XST2dgc0hbBajCmd
 QGPzJ7GqLYJPULNplElGgLb2nQFQAdugNaH9uACdRlMxCuqT5QXuvUwdt63M497wc4XN
 cQjSw2BcQ5uLY53Dvr02v7pd8L4cvSTebN4vrVvJICGHYBTR2p8sHl498IoWks9/WDvG
 IRXDUPv8P+VmdhG9oB1dR/HbcG20Vyvg1LbvshCziP/TwywFVhIqUdcWuRN7sZrGp+j9 Cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30usgq2br2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:59:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046FvRZM046369;
        Wed, 6 May 2020 15:59:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnjvup3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 15:59:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046FxAqg010711;
        Wed, 6 May 2020 15:59:10 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 08:59:09 -0700
Subject: Re: [patch V4 part 1 18/36] samples/kprobes: Add __kprobes and
 NOKPROBE_SYMBOL() for handlers.
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
 <20200505134059.878578033@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <0de1b743-74ee-5c9a-4eed-ff999c9aa370@oracle.com>
Date:   Wed, 6 May 2020 17:57:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.878578033@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Add __kprobes and NOKPROBE_SYMBOL() for sample kprobe handlers.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/158523421177.24735.16273975317343670204.stgit@devnote2
> 
> ---
>   samples/kprobes/kprobe_example.c    |    6 ++++--
>   samples/kprobes/kretprobe_example.c |    2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> 
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -25,7 +25,7 @@ static struct kprobe kp = {
>   };
>   
>   /* kprobe pre_handler: called just before the probed instruction is executed */
> -static int handler_pre(struct kprobe *p, struct pt_regs *regs)
> +static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>   {
>   #ifdef CONFIG_X86
>   	pr_info("<%s> pre_handler: p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
> @@ -54,7 +54,7 @@ static int handler_pre(struct kprobe *p,
>   }
>   
>   /* kprobe post_handler: called after the probed instruction is executed */
> -static void handler_post(struct kprobe *p, struct pt_regs *regs,
> +static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>   				unsigned long flags)
>   {
>   #ifdef CONFIG_X86
> @@ -90,6 +90,8 @@ static int handler_fault(struct kprobe *
>   	/* Return 0 because we don't handle the fault. */
>   	return 0;
>   }
> +/* NOKPROBE_SYMBOL() is also available */
> +NOKPROBE_SYMBOL(handler_fault);
>   
>   static int __init kprobe_init(void)
>   {
> --- a/samples/kprobes/kretprobe_example.c
> +++ b/samples/kprobes/kretprobe_example.c
> @@ -48,6 +48,7 @@ static int entry_handler(struct kretprob
>   	data->entry_stamp = ktime_get();
>   	return 0;
>   }
> +NOKPROBE_SYMBOL(entry_handler);
>   
>   /*
>    * Return-probe handler: Log the return value and duration. Duration may turn
> @@ -67,6 +68,7 @@ static int ret_handler(struct kretprobe_
>   			func_name, retval, (long long)delta);
>   	return 0;
>   }
> +NOKPROBE_SYMBOL(ret_handler);
>   
>   static struct kretprobe my_kretprobe = {
>   	.handler		= ret_handler,
> 
