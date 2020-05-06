Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AC7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65EE20752
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nL3uvcfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgEFNtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:49:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60760 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgEFNtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:49:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046DhHOf041920;
        Wed, 6 May 2020 13:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=t4sRhb0X/251G1cVV1RmskSKn3e8sjNJMHaIFlbBwg8=;
 b=nL3uvcfqB9tTREIiS+hkYXksefzL22cn8i2tq4oVKoVTknO5SKGjESkw71rAhzFK4DI+
 mhZRaqofj+R1cY1NEvYlRf+DlXA5DJcGDswprmHVeJ6mF/2nLnGe9YB/IGpDJo1THIaH
 vAxMaB/ezdedMSxMDu6MXjSPA4yP4ui+PzMGvjXr8z1WgBVKvGo+N6uJyG/27wVaVIAU
 gpOZ311QYDWYEfALp+MF0xmwAUBUNSm3cXT0HWVm1qY2N/bzXa4eTsvxB7NYW3e8O+fe
 zubFqttMLaCKe9qX5OBWxcW+I4GL6leQTEPZXxZaNcxcktqHS8R/1HzCZQueUO39OdrP gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30usgq1h85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:48:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046DlnCM039789;
        Wed, 6 May 2020 13:48:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r7v63h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:48:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046DmGjZ006383;
        Wed, 6 May 2020 13:48:16 GMT
Received: from linux-1.home (/10.175.10.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 06:48:16 -0700
Subject: Re: [patch V4 part 1 08/36] x86/doublefault: Remove memmove() call
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
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.863038566@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <426fb037-9573-f616-6015-b732f66493c0@oracle.com>
Date:   Wed, 6 May 2020 15:47:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134058.863038566@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:16 PM, Thomas Gleixner wrote:
> Use of memmove() in #DF is problematic considered tracing and other
> instrumentation.
> 
> Remove the memmove() call and simply write out what needs doing; this
> even clarifies the code, win-win! The code copies from the espfix64
> stack to the normal task stack, there is no possible way for that to
> overlap.
> 
> Survives selftests/x86, specifically sigreturn_64.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Link: https://lkml.kernel.org/r/20200220121727.GB507@zn.tnic
> ---
>   arch/x86/kernel/traps.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -278,6 +278,7 @@ dotraplinkage void do_double_fault(struc
>   		regs->ip == (unsigned long)native_irq_return_iret)
>   	{
>   		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
> +		unsigned long *p = (unsigned long *)regs->sp;
>   
>   		/*
>   		 * regs->sp points to the failing IRET frame on the
> @@ -285,7 +286,11 @@ dotraplinkage void do_double_fault(struc
>   		 * in gpregs->ss through gpregs->ip.
>   		 *
>   		 */
> -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> +		gpregs->ip	= p[0];
> +		gpregs->cs	= p[1];
> +		gpregs->flags	= p[2];
> +		gpregs->sp	= p[3];
> +		gpregs->ss	= p[4];
>   		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
>   
>   		/*
> 
