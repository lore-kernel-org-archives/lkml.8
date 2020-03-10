Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DDC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F21B20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rTixhLAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJKRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:17:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39326 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgCJKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:17:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AA3Hwr122950;
        Tue, 10 Mar 2020 10:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7sCznqIL6gIPYAX8P2LFWxeyh1Nnbv7oFLHeKxsEIUc=;
 b=rTixhLAFAddEj2YNGfA06aCY7S2MRrjbXLm3YjhuIoA2imsFhZoVPyGNsfX4KNkfCWR5
 eUKVWQ2EevX1KxHtEisZrI1NptToWsvF3rm+zC7/RsRpIz0Gtt0BFrqGU2vQHEXwWctb
 gUUx7PDL6ldj7jz+3CNHnnnriNnni7ewP/Y+I1EfbhumbazQGkpmz2yvku6iFXrSpjLO
 eS4AybV6OauleVRsWx/Wb9YKKsvwbihyQDMv3UwuUj+OXD7jHDUQN5kHdAYJUYs+YCoE
 JJgk/ZU+pKj1XK5ncEb572bCSZ6xRKJBfa390Q5ZYRLy/LHMbrcInwZoOyBCwdVwzoz+ Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yp7hm11de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:16:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AADDMk001761;
        Tue, 10 Mar 2020 10:16:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yp8qmj2hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 10:16:46 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AAGjLG015441;
        Tue, 10 Mar 2020 10:16:45 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 03:16:44 -0700
Subject: Re: [patch part-II V2 03/13] x86/entry/32: Remove unused label
 restore_nocheck
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.219366430@linutronix.de>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <cecbe5ac-f2ad-beb8-b724-aae8fa00f501@oracle.com>
Date:   Tue, 10 Mar 2020 11:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200308222609.219366430@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/20 11:24 PM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/entry/entry_32.S |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1091,7 +1091,7 @@ SYM_FUNC_START(entry_INT80_32)
>   	TRACE_IRQS_IRET
>   	SWITCH_TO_ENTRY_STACK
>   	CHECK_AND_APPLY_ESPFIX
> -.Lrestore_nocheck:
> +
>   	/* Switch back to user CR3 */
>   	SWITCH_TO_USER_CR3 scratch_reg=%eax
>   
> 
