Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F685206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IVsw51cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgFVIxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:53:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgFVIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:53:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05M8phKZ173473;
        Mon, 22 Jun 2020 08:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iKqLzDdZRCX1jMSWUw2bJkZvRptH106KT+PUKTRcO+Q=;
 b=IVsw51czxPVP8wtvrKm6Wpiij8dEO8bm1fic2AxHbMhSZ7Pckz8WxqBQNhGpt4lI+rXJ
 iGf+H0up4bKd5SRkttlw/yKJNtR6FCD20evV/G75D78wrvip90v5jXok2pyOR/ij3hB+
 xRA4iZpbMQPWAxAkXax5nxga2guIrEKF6Qi7IgoZxaGgmO0PBmEpXLsA++46QNb9VoAJ
 j/DvimwBvH68p0uekjCNGE0IwAUYZCK8IaUkFWi1C3fv3P4XmDODsQ/n74VMrLzkYXNN
 zA1z8/j+GKz9yfAACb0MHikj0bsCtJIT67yvRDNgaaAnKG9OVNUBHbFELN0yisAhMIoO MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31sebbd906-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 08:52:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05M8lpwZ117280;
        Mon, 22 Jun 2020 08:52:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31svc0h5xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 08:52:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05M8qYF7004759;
        Mon, 22 Jun 2020 08:52:34 GMT
Received: from linux-1.home (/92.157.81.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 08:52:34 +0000
Subject: Re: [PATCH -next] arch/x86: Return value from notify_die should to be
 checked.
To:     Bo YU <tsu.yubo@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, peterz@infradead.org, luto@kernel.org,
        jannh@google.com, dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20200621102634.n43ozcsiravdi2ie@debian.debian-2>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <4d1ef78e-f001-a685-9a69-afa68454fdc7@oracle.com>
Date:   Mon, 22 Jun 2020 10:52:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200621102634.n43ozcsiravdi2ie@debian.debian-2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 impostorscore=0 cotscore=-2147483648 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/21/20 12:26 PM, Bo YU wrote:
> This is detected by Coverity scan: #CID: 1464472(CHECKED_RETURN)
> 
> FIXES: c94082656dac7(x86: Use enum instead of literals for trap values)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
> arch/x86/kernel/traps.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index af75109485c2..bf014fb59017 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -401,7 +401,8 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
> 
>      nmi_enter();
>      instrumentation_begin();
> -    notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
> +    if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV))
> +        return;
> 

This change is not correct, if there's a double fault then we should die even if
notify_die() fails. So the appropriate change to make Coverity happy is probably:

  (void) notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);

alex.
