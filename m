Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E400C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204822467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zJP/W8Y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCJK0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:26:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36900 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgCJK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:26:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAPZfc137749;
        Tue, 10 Mar 2020 10:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B/Emey4uhKmGBrEwuwYnXL8QgpV2j+OMtu0+KZIgHcY=;
 b=zJP/W8Y4kw752e7Lq/BwsezzMGvrpwX/UHoax0jKSaeOd4V/XpONwxpd5uhoTRBUIXAf
 4jaXXKbo0o7CKSUprrpWEfp1JLQC8UA0Vut+3gWAgsiviDuVyz0aoSN1hVi4KR0FBvPB
 4ML9PtukCJhrD6J+g//td2NgK3qzmp67cupwLmK7wLQNaT5ZlMrVo0r0R+dNuVrrGesc
 MAFtc1NvZOqMI8hFHeRFvcukDKBffmYugOC5UQMviBgLWbYru+vFys7dExhZc0sDzwL4
 dKb6cu9ihqyLx3cc7SER436hDI27ITDa47Lt4KHPOKL1mi3woS416yJg58gpNH2Md/wq gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ym3jqmq13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:25:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AANxFF122557;
        Tue, 10 Mar 2020 10:25:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yp8rha5uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:25:54 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AAPqLJ016235;
        Tue, 10 Mar 2020 10:25:52 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 03:25:52 -0700
Subject: Re: [patch part-II V2 04/13] x86/entry/64: Trace irqflags
 unconditionally as ON when returning to user space
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.314596327@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <40696243-992c-915d-09b5-b088f7331a18@oracle.com>
Date:   Tue, 10 Mar 2020 11:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222609.314596327@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> User space cannot longer disable interrupts so trace return to user space
> unconditionally as IRQS_ON.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Cover 32bit as well
> ---
>   arch/x86/entry/entry_32.S |    2 +-
>   arch/x86/entry/entry_64.S |    4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1088,7 +1088,7 @@ SYM_FUNC_START(entry_INT80_32)
>   	STACKLEAK_ERASE
>   
>   restore_all:
> -	TRACE_IRQS_IRET
> +	TRACE_IRQS_ON
>   	SWITCH_TO_ENTRY_STACK
>   	CHECK_AND_APPLY_ESPFIX
>   
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -174,7 +174,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_h
>   	movq	%rsp, %rsi
>   	call	do_syscall_64		/* returns with IRQs disabled */
>   
> -	TRACE_IRQS_IRETQ		/* we're about to change IF */
> +	TRACE_IRQS_ON			/* return enables interrupts */
>   
>   	/*
>   	 * Try to use SYSRET instead of IRET if we're returning to
> @@ -619,7 +619,7 @@ SYM_CODE_START_LOCAL(common_interrupt)
>   .Lretint_user:
>   	mov	%rsp,%rdi
>   	call	prepare_exit_to_usermode
> -	TRACE_IRQS_IRETQ
> +	TRACE_IRQS_ON
>   
>   SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
>   #ifdef CONFIG_DEBUG_ENTRY
> 
