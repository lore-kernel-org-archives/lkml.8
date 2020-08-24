Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A179AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A340206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHXOqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:46:01 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:22226 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgHXOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:46:00 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OEhSMi026501;
        Mon, 24 Aug 2020 14:45:28 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 332um956t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 14:45:28 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 0CC0755;
        Mon, 24 Aug 2020 14:45:25 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.226.216])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id EEF854B;
        Mon, 24 Aug 2020 14:45:23 +0000 (UTC)
Date:   Mon, 24 Aug 2020 09:45:23 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
Message-ID: <20200824144523.GB60946@swahl-home.5wahls.com>
References: <20200821154848.GI7871@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821154848.GI7871@localhost.localdomain>
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=2 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Darren Hart, Andy Shevchenko, Thomas Gleixner, Ingo Molnar,
Borislav Petkov, and x86.kernel.org, after being told that
get_maintainers.pl doesn't work on MAINTAINERS.

Thanks,

Steve Wahl, HPE

On Fri, Aug 21, 2020 at 10:48:49AM -0500, Steve Wahl wrote:
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..4c2143d8ae45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18874,6 +18874,15 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
>  F:	arch/x86/platform
>  
> +X86 PLATFORM UV HPE SUPERDOME FLEX
> +M:	Steve Wahl <steve.wahl@hpe.com>
> +R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
> +R:	Russ Anderson <russ.anderson@hpe.com>
> +S:	Supported
> +F:	arch/x86/include/asm/uv/
> +F:	arch/x86/kernel/apic/x2apic_uv_x.c
> +F:	arch/x86/platform/uv/
> +
>  X86 VDSO
>  M:	Andy Lutomirski <luto@kernel.org>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.12.3
> 
