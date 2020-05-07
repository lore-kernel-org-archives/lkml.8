Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B26C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CB520708
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jmBKqgml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgEGNRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:17:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55744 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:17:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047D9FjA072838;
        Thu, 7 May 2020 13:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fUbGWLFS+jWKkk/BdI0Cv8l5aoGUDqGExKPATn7zLRM=;
 b=jmBKqgmlhAFGfYi4Z6xdQ35U3FsQGU0hPSeP5Rs5V5nPF9vY+1aa2quInKl7/+imF4w5
 zbKh/6bjg+JNvHZnRtp+GHy/oDoAkqbKoXSz1uL+bhivLkELVX2VW0RPCdY8rzZPIcwf
 joJ62mtbveiGA/aU5SMTmVuOgMnL1q7Uq6YT4QEKADKOQWhDRfr9aIo7Sr7fP44EibNc
 ny6I3HFkeSgMVRCGrq/YeXbBJ7meEgQ5CWJpf4MJX2tcCAVjCX0V0z/47GApjH1dRy7m
 WPEbN7ocxcKr9+wx8ORKQHlXGmTI2hTYdOolbVovbAyUkfW055ZWFNDpsKcK9E1bdzSp ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30usgq74ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 13:16:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047D7ojp011987;
        Thu, 7 May 2020 13:16:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1rakxdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 13:16:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047DGbEt028126;
        Thu, 7 May 2020 13:16:37 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 06:16:37 -0700
Subject: Re: [patch V4 part 2 02/18] x86/entry/32: Move non entry code into
 .text section
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
References: <20200505134112.272268764@linutronix.de>
 <20200505134340.320164650@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <6e8a7549-9c0a-f863-fc7d-fcbfcb642bc4@oracle.com>
Date:   Thu, 7 May 2020 15:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134340.320164650@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/20 3:41 PM, Thomas Gleixner wrote:
> All ASM code which is not part of the entry functionality can move out into
> the .text section. No reason to keep it in the non-instrumentable entry
> section.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_32.S |   11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -729,7 +729,8 @@
>   /*
>    * %eax: prev task
>    * %edx: next task
> - */
> +*/

Misaligned comment end, this line shouldn't change.

alex.

> +.pushsection .text, "ax"
>   SYM_CODE_START(__switch_to_asm)
>   	/*
>   	 * Save callee-saved registers
> @@ -776,6 +777,7 @@ SYM_CODE_START(__switch_to_asm)
>   
>   	jmp	__switch_to
>   SYM_CODE_END(__switch_to_asm)
> +.popsection
>   
>   /*
>    * The unwinder expects the last frame on the stack to always be at the same
> @@ -784,6 +786,7 @@ SYM_CODE_END(__switch_to_asm)
>    * asmlinkage function so its argument has to be pushed on the stack.  This
>    * wrapper creates a proper "end of stack" frame header before the call.
>    */
> +.pushsection .text, "ax"
>   SYM_FUNC_START(schedule_tail_wrapper)
>   	FRAME_BEGIN
>   
> @@ -794,6 +797,8 @@ SYM_FUNC_START(schedule_tail_wrapper)
>   	FRAME_END
>   	ret
>   SYM_FUNC_END(schedule_tail_wrapper)
> +.popsection
> +
>   /*
>    * A newly forked process directly context switches into this address.
>    *
> @@ -801,6 +806,7 @@ SYM_FUNC_END(schedule_tail_wrapper)
>    * ebx: kernel thread func (NULL for user thread)
>    * edi: kernel thread arg
>    */
> +.pushsection .text, "ax"
>   SYM_CODE_START(ret_from_fork)
>   	call	schedule_tail_wrapper
>   
> @@ -825,6 +831,7 @@ SYM_CODE_START(ret_from_fork)
>   	movl	$0, PT_EAX(%esp)
>   	jmp	2b
>   SYM_CODE_END(ret_from_fork)
> +.popsection
>   
>   /*
>    * Return to user mode is not as complex as all this looks,
> @@ -1693,6 +1700,7 @@ SYM_CODE_START(general_protection)
>   	jmp	common_exception
>   SYM_CODE_END(general_protection)
>   
> +.pushsection .text, "ax"
>   SYM_CODE_START(rewind_stack_do_exit)
>   	/* Prevent any naive code from trying to unwind to our caller. */
>   	xorl	%ebp, %ebp
> @@ -1703,3 +1711,4 @@ SYM_CODE_START(rewind_stack_do_exit)
>   	call	do_exit
>   1:	jmp 1b
>   SYM_CODE_END(rewind_stack_do_exit)
> +.popsection
> 
