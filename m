Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6BC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8273F206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+4PnH9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgEKNzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:55:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44028 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgEKNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:55:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BDWmQi076390;
        Mon, 11 May 2020 13:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=l8+HMXEE9aB0aOSWY8gkTyeJdorvKTxSlVmAOSdcjqA=;
 b=g+4PnH9b6IUUTsD5shCXGlMc9mf404vXB7+3/VxoJKWA5XFa/brzGF9lJqPihs/sRuCM
 oCYa+DkhZjCft844U5qlEm7deV0FLYSFqut++LP4dTRVbMYXE3TpcIin/RKuKeC2vLzj
 otJngqrymF0mbpX+msnfzoA1SSbgJNBsrTC5J5TYrmy/C6gjjMf+5g/ZLxa6h+l2kXUN
 sQKogI/jdkEz9u045BrjzUB1Me9aDPjuSP1A4ta8NkcWp/K/OEfNP1GyuV2Z7YSuUKbW
 YGuDw4QYd4l9dglhLMj4RRNI3XXL7VVjOEr+M5kJLLNUqUKgyR7Vk4BjLTWxGBi+9NmE ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30x3gmd71b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 13:54:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BDXY8X016654;
        Mon, 11 May 2020 13:54:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30x63mrmgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 13:54:25 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04BDsLQE010452;
        Mon, 11 May 2020 13:54:22 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 06:54:20 -0700
Subject: Re: [patch V4 part 5 07/31] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
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
References: <20200505135341.730586321@linutronix.de>
 <20200505135828.808686575@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <72cb3e24-3f82-7e2a-7630-233749c780c4@oracle.com>
Date:   Mon, 11 May 2020 15:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505135828.808686575@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=940 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=976
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:53 PM, Thomas Gleixner wrote:
> The pagefault handler cannot use the regular idtentry_enter() because on
> that invokes rcu_irq_enter() the pagefault was caused in the kernel.

I am struggling to understand this part of the sentence: "because on
that invokes rcu_irq_enter() the pagefault was caused in the kernel."

Do you mean: "because that invokes rcu_irq_enter() if the pagefault was
caused in the kernel." ?

alex.

> Not a
> problem per se, but kernel side page faults can schedule which is not
> possible without invoking rcu_irq_exit().
> 
> Adding rcu_irq_exit() and a matching rcu_irq_enter() into the actual
> pagefault handling code is possible, but not pretty either.
> 
> Provide idtentry_entry/exit_cond_rcu() which calls rcu_irq_enter() only
> when RCU is not watching. While this is not a legit kernel #PF establishing
> RCU before handling it avoids RCU side effects which might affect
> debugability.
> 
> The function is also useful for implementing lightweight scheduler IPI
> entry handling later.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c         |  119 ++++++++++++++++++++++++++++++++++------
>   arch/x86/include/asm/idtentry.h |    3 +
>   2 files changed, 106 insertions(+), 16 deletions(-)
