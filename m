Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA186C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9386220722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eAH5+9B8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgCZSH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:07:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35784 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgCZSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:07:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QI3LR7083907;
        Thu, 26 Mar 2020 18:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BJaWZQd3Uzd0rIHPr8Tee7YFwxS0GsA8ikWhqjK/e0I=;
 b=eAH5+9B8Dlao4gANk+9VC3KHEoCNjPwSA1bFece9Z7Eeu2OwXw+qkyABtsWD0KqcGEl2
 JiKWqMclSTNfdN+Lo3FnSYtR4auuXSu6+31R9gUmsApdFj0gn2HXoRw6dRH91JJ1arp6
 czecPixOUhR54tKla1baSgGcHLiDiKfWgx+i0BxSilUGAoq+8vkZHIUNaaSoTHnAusuf
 DnXVQZhVluGRx1wSdTSRWA2AnzHH8iQm6fHXr3cWCIkYhrzalj/AYS/OxrA8sv/UHFP5
 PCCXk0UD/JoV7VOTwuE2YoX4iijwJ58kFHiWWEY8TWEVVMUYZtFSFG/NtCxwsBzEgO5h DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ywavmhdca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 18:07:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QI2cJ4175416;
        Thu, 26 Mar 2020 18:07:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30073e3vta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 18:07:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QI6wo6016073;
        Thu, 26 Mar 2020 18:06:58 GMT
Received: from tomti.i.net-space.pl (/10.175.206.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 11:06:57 -0700
Date:   Thu, 26 Mar 2020 19:06:53 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [RFC PATCH 01/12] x86: Secure Launch Kconfig
Message-ID: <20200326180653.nyfkbrczl5gxbukl@tomti.i.net-space.pl>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <20200325194317.526492-2-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325194317.526492-2-ross.philipson@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 03:43:06PM -0400, Ross Philipson wrote:
> Initial bits to bring in Secure Launch functionality. Add Kconfig
> options for compiling in/out the Secure Launch code.
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e8949953660..7f3406a9948b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2014,6 +2014,17 @@ config EFI_MIXED
>
>  	   If unsure, say N.
>
> +config SECURE_LAUNCH
> +	bool "Secure Launch support"
> +	default n
> +	depends on X86_64
> +	help
> +	  This Secure Launch kernel feature allows a bzImage to be loaded
> +	  directly through Intel TXT or AMD SKINIT measured launch. This

I think that you should drop AMD SKINIT from here. This should be added
when AMD secure launch implementation is added.

...and why we need this as separate patch? Could not we add this in
a patch which uses CONFIG_SECURE_LAUNCH for first time?

Daniel
