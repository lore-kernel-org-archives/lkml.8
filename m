Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CBFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E5D246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DfuA4gDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgB1OOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:14:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60824 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1OOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:14:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SEDGEH030147;
        Fri, 28 Feb 2020 14:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=UF/Ibz9yEueUU22SCkllkLeUsJGMpQJosNWzjRfm4q8=;
 b=DfuA4gDiYFYTEwRPM7UPr3Yun86W/GL9O8uMto1GTjJtIdgbDNXCoI2WsR/ddlWDVwic
 v13RacE1BpwokFiTz+4M8pGmIANn5yFVWTiW6A+mm4YmhyYTTcIEB7BEkgtLysk+Uhqx
 UGMYe7fbRqSzKlJF4juYKj/S1329HC36i9oXCwzGG+TrBdhNaUjbZ2727qVqO1ZfKrya
 ZaRRYNt+RwMp9BTTPnXh+Q7t7iEig9pPHIuOv+fM+glHEmyztjfqfcGsneTxUZAlT6Yo
 8EPXK53kEGn3tfdvoquSTSPVUmCfZkI4lcjb/aEjCU3uEdCRO4gNzGGJEbIVpXpErzG9 uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ydct3k21e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 14:13:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SEDQAr163224;
        Fri, 28 Feb 2020 14:13:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ydcsfch93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 14:13:47 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SEDgTQ001236;
        Fri, 28 Feb 2020 14:13:42 GMT
Received: from [10.39.209.75] (/10.39.209.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 06:13:42 -0800
Subject: Re: [patch 07/24] x86/traps: Prepare for using DEFINE_IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.880108780@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <af1808f4-93a3-d015-753f-168c742f89f7@oracle.com>
Date:   Fri, 28 Feb 2020 15:13:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.880108780@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/20 11:16 PM, Thomas Gleixner wrote:
> Prepare for using IDTENTRY to define the C exception/trap entry points. It
> would be possible to glue this into the existing macro maze, but it's
> simpler and better to read at the end to just make them distinct. Provide
> a trivial inline helper to read the trap address.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/traps.c |    5 +++++
>   1 file changed, 5 insertions(+)
> 
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -274,6 +274,11 @@ static void do_error_trap(struct pt_regs
>   	}
>   }
>   
> +static inline void __user *error_get_trap_addr(struct pt_regs *regs)
> +{
> +	return (void __user *)uprobe_get_trap_addr(regs);
> +}
> +
>   #define IP ((void __user *)uprobe_get_trap_addr(regs))

And you will eventually get rid of this IP macro, right?

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

>   #define DO_ERROR(trapnr, signr, sicode, addr, str, name)		   \
>   dotraplinkage void do_##name(struct pt_regs *regs, long error_code)	   \
> 
> 
