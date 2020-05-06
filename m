Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3755C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF49120746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HoZygMGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEFMog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:44:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35840 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgEFMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:44:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046CfOe4118814;
        Wed, 6 May 2020 12:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Apqskal/b0nvOUTCatKWmbsNQirc8GyhXqenmq20Xb0=;
 b=HoZygMGL3xRx8vFPswPMft+cOa5636uAi3evpeF2DLn3brrvYkPDCIqqQ4qeB6RYmWpf
 RSowqqTLUyfH/TmJ+Gkcmkxe8axk2+KzbbliH3YqKS8nWl85tbyzG9Lw8vYUgBpgjoGP
 qYxQaQTnrL9xCMp/LrwXXVA29OVBckMiRgTNFLhfr04kbWEfHtex7GbDvamGv0cZLcNO
 7rZvQDe8FupE9hXvtZJxvf6IsMsKxJ86JTOn3iYGkVNLFdyiZa9aXesJJs4jj29JiObE
 syJevovZrkGhXMQZf7FOXt3Y9tR5V4kNYfCGRgJMXn7b+L6d18GHWQtD9s7J5gS1o2gM xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gn9wya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:43:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046CaioU158995;
        Wed, 6 May 2020 12:43:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30us7mkdc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 12:43:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046ChjYB019533;
        Wed, 6 May 2020 12:43:45 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 05:43:44 -0700
Subject: Re: [patch V4 part 1 04/36] sched: Make scheduler_ipi inline
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
 <20200505134058.453581595@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <3e191b63-9125-25a8-4784-e7a737d71b05@oracle.com>
Date:   Wed, 6 May 2020 14:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134058.453581595@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> Now that the scheduler IPI is trivial and simple again there is no point to
> have the little function out of line. This simplifies the effort of
> constraining the instrumentation nicely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/sched.h |   10 +++++++++-
>   kernel/sched/core.c   |   10 ----------
>   2 files changed, 9 insertions(+), 11 deletions(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1719,7 +1719,15 @@ extern char *__get_task_comm(char *to, s
>   })
>   
>   #ifdef CONFIG_SMP
> -void scheduler_ipi(void);
> +static __always_inline void scheduler_ipi(void)
> +{
> +	/*
> +	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
> +	 * TIF_NEED_RESCHED remotely (for the first time) will also send
> +	 * this IPI.
> +	 */
> +	preempt_fold_need_resched();
> +}
>   extern unsigned long wait_task_inactive(struct task_struct *, long match_state);
>   #else
>   static inline void scheduler_ipi(void) { }
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2312,16 +2312,6 @@ static void wake_csd_func(void *info)
>   	sched_ttwu_pending();
>   }
>   
> -void scheduler_ipi(void)
> -{
> -	/*
> -	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
> -	 * TIF_NEED_RESCHED remotely (for the first time) will also send
> -	 * this IPI.
> -	 */
> -	preempt_fold_need_resched();
> -}
> -
>   static void ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
>   {
>   	struct rq *rq = cpu_rq(cpu);
> 
