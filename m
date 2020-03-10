Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB70C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1545E2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MDrcOUiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCJOKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:10:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53560 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:10:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AE2ua7163526;
        Tue, 10 Mar 2020 14:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=f29kP8EPy7TnjRocNsizivmDPXvx0hQFJ7+kQQ00MJY=;
 b=MDrcOUiIxgR2aP56KbUWNhU9Qz63YugyfQz0f4D+L4J5BgcALxcxPNjQp83UYyM4mrZu
 kBN3gdIxcKmxAXxjTEnt4RCuVg2FtszCoVKfj+PSQghtv6U64NL0177Huh4sUsHnRVTe
 PiIky+9d6mCfARnsnyzifDF0mmGUrrnKAnbrYGefxBGrheYayJGYf5GnOHkHu1VzX7BJ
 MhaQodsDKSbQeQ3VRdZD6INSZolvpul5qsdn5FyYb4f8lgiXNQr6yfPFA3UHpzczlhFY
 5hZiL6CJifg2s8aaimLW+FfHCb0hkNzAx64WmcfHOZ0EWKM22hAGNzm5jlYOe9BUsFbJ 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ym31udrqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 14:09:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AE3fKQ085607;
        Tue, 10 Mar 2020 14:09:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yp8rj3676-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 14:09:30 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AE9SZH032502;
        Tue, 10 Mar 2020 14:09:28 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 07:09:28 -0700
Subject: Re: [patch part-II V2 13/13] x86/entry/common: Split irq tracing in
 prepare_exit_to_usermode()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222610.245444311@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <d01a2ab6-db0f-cc0e-83e1-a60d95cde8e9@oracle.com>
Date:   Tue, 10 Mar 2020 15:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222610.245444311@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> As in entry from user mode, lockdep and tracing have different
> requirements. lockdep needs to know about the interrupts off state accross
> the call to user_enter_irqsoff() but tracing is unsafe after the call.

typo: user_enter_irqoff() (no 's' between 'irq' and 'off').

> 
> Split it up and tell the tracer that interrupts are going to be enabled
> before calling user_enter_irqsoff() and tell lockdep afterwards.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/common.c |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -251,9 +251,19 @@ static noinline void __prepare_exit_to_u
>   {
>   	__prepare_exit_to_usermode(regs);
>   
> +	/*
> +	 * Return to user space enables interrupts. Tell the tracer before
> +	 * invoking user_enter_irqsoff() which switches to CONTEXT_USER and

Same typo here: user_enter_irqoff()

> +	 * RCU to rcuidle state. Lockdep still needs to keep the irqs
> +	 * disabled state.
> +	 */
> +	__trace_hardirqs_on();
> +
>   	user_enter_irqoff();
>   	mds_user_clear_cpu_buffers();
> -	trace_hardirqs_on();
> +
> +	/* All done. Tell lockdep as well. */
> +	lockdep_hardirqs_on(CALLER_ADDR0);
>   }
>   NOKPROBE_SYMBOL(prepare_exit_to_usermode);
>   
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.
