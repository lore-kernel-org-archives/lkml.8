Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47BCC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9260520768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGWWM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:12:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9996 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgGWWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:12:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NM2OA9120750;
        Thu, 23 Jul 2020 18:12:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9bev32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 18:12:16 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NM8mKS148551;
        Thu, 23 Jul 2020 18:12:16 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32fb9bev2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 18:12:15 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NMAVBG003713;
        Thu, 23 Jul 2020 22:12:15 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 32brqa3kn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 22:12:15 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NMCB0u34144844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 22:12:11 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94D9578066;
        Thu, 23 Jul 2020 22:12:13 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 372747809B;
        Thu, 23 Jul 2020 22:12:10 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.53.35])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Jul 2020 22:12:09 +0000 (GMT)
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com> <159524946347.20855.15784642736087777919.stgit@hbathini.in.ibm.com>
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
Subject: Re: [PATCH v4 03/12] powerpc/kexec_file: add helper functions for getting memory ranges
In-reply-to: <159524946347.20855.15784642736087777919.stgit@hbathini.in.ibm.com>
Date:   Thu, 23 Jul 2020 19:12:05 -0300
Message-ID: <878sf96fuy.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> In kexec case, the kernel to be loaded uses the same memory layout as
> the running kernel. So, passing on the DT of the running kernel would
> be good enough.
>
> But in case of kdump, different memory ranges are needed to manage
> loading the kdump kernel, booting into it and exporting the elfcore
> of the crashing kernel. The ranges are exclude memory ranges, usable
> memory ranges, reserved memory ranges and crash memory ranges.
>
> Exclude memory ranges specify the list of memory ranges to avoid while
> loading kdump segments. Usable memory ranges list the memory ranges
> that could be used for booting kdump kernel. Reserved memory ranges
> list the memory regions for the loading kernel's reserve map. Crash
> memory ranges list the memory ranges to be exported as the crashing
> kernel's elfcore.
>
> Add helper functions for setting up the above mentioned memory ranges.
> This helpers facilitate in understanding the subsequent changes better
> and make it easy to setup the different memory ranges listed above, as
> and when appropriate.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

Just one comment below, but regardless:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> +/**
> + * add_htab_mem_range - Adds htab range to the given memory ranges list,
> + *                      if it exists
> + * @mem_ranges:         Range list to add the memory range to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int add_htab_mem_range(struct crash_mem **mem_ranges)
> +{
> +	if (!htab_address)
> +		return 0;
> +
> +	return add_mem_range(mem_ranges, __pa(htab_address), htab_size_bytes);
> +}

I believe you need to surround this function with `#ifdef
CONFIG_PPC_BOOK3S_64` and `#endif` to match what is done in
<asm/kexec_ranges.h>.

--
Thiago Jung Bauermann
IBM Linux Technology Center
