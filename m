Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25916C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C98E2077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgGUKpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:45:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726919AbgGUKpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:45:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LAVTvc026544;
        Tue, 21 Jul 2020 06:45:03 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d5h5n3xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 06:45:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LAVumN024353;
        Tue, 21 Jul 2020 10:45:01 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 32brbh3qja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:45:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LAixSD63111286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 10:44:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74839AE059;
        Tue, 21 Jul 2020 10:44:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3999CAE051;
        Tue, 21 Jul 2020 10:44:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.118])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Jul 2020 10:44:57 +0000 (GMT)
Date:   Tue, 21 Jul 2020 13:44:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] x86/mm: Pre-allocate p4d/pud pages for vmalloc
 area
Message-ID: <20200721104454.GF802087@linux.ibm.com>
References: <20200721095953.6218-1-joro@8bytes.org>
 <20200721095953.6218-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721095953.6218-2-joro@8bytes.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_03:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007210070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:59:51AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Pre-allocate the page-table pages for the vmalloc area at the level
> which needs synchronization on x86-64, which is P4D for 5-level and
> PUD for 4-level paging.
> 
> Doing this at boot makes sure all no synchronization of that area is

Nit:                           ^all can be dropped
 
> necessary at runtime. The synchronization takes the pgd_lock and
> iterates over all page-tables in the system, so it can take quite long
> and is better avoided.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/mm/init_64.c | 52 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index dbae185511cd..e76bdb001460 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1238,6 +1238,56 @@ static void __init register_page_bootmem_info(void)
>  #endif
>  }
>  
> +/*
> + * Pre-allocates page-table pages for the vmalloc area in the kernel page-table.
> + * Only the level which needs to be synchronized between all page-tables is
> + * allocated because the synchronization can be expensive.
> + */
> +static void __init preallocate_vmalloc_pages(void)
> +{
> +	unsigned long addr;
> +	const char *lvl;
> +
> +	for (addr = VMALLOC_START; addr <= VMALLOC_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
> +		pgd_t *pgd = pgd_offset_k(addr);
> +		p4d_t *p4d;
> +		pud_t *pud;
> +
> +		p4d = p4d_offset(pgd, addr);
> +		if (p4d_none(*p4d)) {
> +			/* Can only happen with 5-level paging */
> +			p4d = p4d_alloc(&init_mm, pgd, addr);
> +			if (!p4d) {
> +				lvl = "p4d";
> +				goto failed;
> +			}
> +		}
> +
> +		if (pgtable_l5_enabled())
> +			continue;
> +
> +		pud = pud_offset(p4d, addr);
> +		if (pud_none(*pud)) {
> +			/* Ends up here only with 4-level paging */
> +			pud = pud_alloc(&init_mm, p4d, addr);
> +			if (!pud) {
> +				lvl = "pud";
> +				goto failed;
> +			}
> +		}
> +	}
> +
> +	return;
> +
> +failed:
> +
> +	/*
> +	 * The pages have to be there now or they will be missing in
> +	 * process page-tables later.
> +	 */
> +	panic("Failed to pre-allocate %s pages for vmalloc area\n", lvl);
> +}
> +
>  void __init mem_init(void)
>  {
>  	pci_iommu_alloc();
> @@ -1261,6 +1311,8 @@ void __init mem_init(void)
>  	if (get_gate_vma(&init_mm))
>  		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
>  
> +	preallocate_vmalloc_pages();
> +
>  	mem_init_print_info(NULL);
>  }
>  
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
