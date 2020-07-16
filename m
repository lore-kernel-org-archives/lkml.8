Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9725AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DB220663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGPC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:27:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgGPC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:27:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G21fjI038567;
        Wed, 15 Jul 2020 22:27:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329uej2pfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 22:27:41 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G22SBt045227;
        Wed, 15 Jul 2020 22:27:40 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329uej2pf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 22:27:40 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G2PgDn011514;
        Thu, 16 Jul 2020 02:27:39 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 327529ppqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 02:27:39 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G2RcCj56033684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 02:27:39 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1D8F112062;
        Thu, 16 Jul 2020 02:27:38 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CCF5112061;
        Thu, 16 Jul 2020 02:27:34 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.73.114])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 02:27:34 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466100206.24747.3782313430191321863.stgit@hbathini.in.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 11/12] ppc64/kexec_file: add appropriate regions for memory reserve map
In-reply-to: <159466100206.24747.3782313430191321863.stgit@hbathini.in.ibm.com>
Date:   Wed, 15 Jul 2020 23:27:30 -0300
Message-ID: <87sgds8a99.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> While initrd, elfcorehdr and backup regions are already added to the
> reserve map, there are a few missing regions that need to be added to
> the memory reserve map. Add them here. And now that all the changes
> to load panic kernel are in place, claim likewise.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Just one oinor nit below.

> ---
>
> v2 -> v3:
> * Unchanged. Added Tested-by tag from Pingfan.
>
> v1 -> v2:
> * Updated add_rtas_mem_range() & add_opal_mem_range() callsites based on
>   the new prototype for these functions.
>
>
>  arch/powerpc/kexec/file_load_64.c |   58 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 2531bb5..29e5d11 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -193,6 +193,34 @@ static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
>  }
>  
>  /**
> + * get_reserved_memory_ranges - Get reserve memory ranges. This list includes
> + *                              memory regions that should be added to the
> + *                              memory reserve map to ensure the region is
> + *                              protected from any mischeif.

s/mischeif/mischief/

> + * @mem_ranges:                 Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int get_reserved_memory_ranges(struct crash_mem **mem_ranges)
> +{
> +	int ret;
> +
> +	ret = add_rtas_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_tce_mem_ranges(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_reserved_ranges(mem_ranges);
> +out:
> +	if (ret)
> +		pr_err("Failed to setup reserved memory ranges\n");
> +	return ret;
> +}

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
