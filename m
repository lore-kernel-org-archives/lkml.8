Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E6AC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43ACF21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mRtaisKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEGRXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:23:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57494 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgEGRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:23:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HI3hW138476;
        Thu, 7 May 2020 17:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vJrbkdZBUoaq1pXS4ignZ6pMF+uDpzQFiLZti+eZ70E=;
 b=mRtaisKOzCs2MRCCaIfiEhopEwKHU51t6oyUc+jzzGDYYiZjMbgPgcQKHX+HixSM08t4
 pzGl07bLdEfYU8K7ac0gXGoOdD1/OudYEpmUfJRzM8ncMydUJjQ4tpeZIaQXS3WIKB+4
 1r5Jqo55orYXSGwZWdtmFQcZWCX6KITiyJc2OrVRY4zUQ/clubqwPfCKmQ/c5cbml9a/
 Yr+C8/haFNe9/NARngk0JwY7jXyLVbCZCY2Arcv6kCfrGENY25iIzSf5bs7hKSU87/px
 0hBbtlblkrR8WqxL4K8z5fnDUiFFVhadmCi15uhn1zIjxqRqnFz95vSIPhEACgg6MX4V Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30veckjv68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:20:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HGew2045635;
        Thu, 7 May 2020 17:20:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30us7r23bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 17:20:00 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 047HJt4Q019013;
        Thu, 7 May 2020 17:19:56 GMT
Received: from linux-1.home (/10.175.40.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 10:19:55 -0700
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
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
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200505134926.578885807@linutronix.de>
 <20200505135314.808628211@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <16c57a7e-8d39-d77e-915d-41b7f5e042fd@oracle.com>
Date:   Thu, 7 May 2020 19:18:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505135314.808628211@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:49 PM, Thomas Gleixner wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> DR6/7 should be handled before nmi_enter() is invoked and restore after
> nmi_exit() to minimize the exposure.
> 
> Split it out into helper inlines and bring it into the correct order.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/hw_breakpoint.c |    6 ---
>   arch/x86/kernel/traps.c         |   62 +++++++++++++++++++++++++++-------------
>   2 files changed, 44 insertions(+), 24 deletions(-)
> 
...
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -691,6 +691,44 @@ static bool is_sysenter_singlestep(struc
>   #endif
>   }
>   
> +static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
> +{
> +	/*
> +	 * Disable breakpoints during exception handling; recursive exceptions
> +	 * are exceedingly 'fun'.
> +	 *
> +	 * Since this function is NOKPROBE, and that also applies to
> +	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
> +	 * HW_BREAKPOINT_W on our stack)
> +	 *
> +	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
> +	 * includes the entry stack is excluded for everything.
> +	 */
> +	get_debugreg(*dr7, 6);

Do you mean  get_debugreg(*dr7, 7); ?

alex.
