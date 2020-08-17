Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F932C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5436120758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TVS7v7rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgHQIEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:04:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23726 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgHQIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:04:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07H7WgUm074359;
        Mon, 17 Aug 2020 04:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9/CSpea4kqrzEYzRW/MN88fHEds8Fzxmq8f4HKb00ro=;
 b=TVS7v7rYgNmqXqJy7wTvc5W7m42xyYyEBKmXTuzZQ0UhzB/vmWMZmofaDK5lsTctOVic
 JgEADcWMNawbiij6iz+D4F7Vm2lhBf8lPAbjwcuu/v6WeEBd4Nukue2Oj/YDaR86M74e
 SoU+qYBMOiZx6D82AS9fo3vn8mNKIRhjIm23ZBU/Wd9rNT4WxsIMnc9pEyNKa+Zsy5I1
 xIPEW++9zZX09JkURNNm/n9m75djhBVz3pRf82fRZmbQCjxAMn4kccYA5uODDq/njccw
 Wdp6VgtoCCbctOhAoJaqiGWa3D/ZDUEBH6qr7v6jvhQPecb+gICdG0+1keB2v0VoEnCD kQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32y7g29b3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 04:04:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07H7j96C020476;
        Mon, 17 Aug 2020 08:04:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32x7b8206q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 08:04:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07H848RL27525436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 08:04:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A11CEAE055;
        Mon, 17 Aug 2020 08:04:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36808AE051;
        Mon, 17 Aug 2020 08:04:07 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.34.219])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Aug 2020 08:04:07 +0000 (GMT)
Date:   Mon, 17 Aug 2020 11:04:05 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Wei Li <liwei213@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        saberlily.xia@hisilicon.com, puck.chen@hisilicon.com,
        butao@hisilicon.com, fengbaopeng2@hisilicon.com,
        nsaenzjulienne@suse.de, steve.capper@arm.com,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sujunfei2@hisilicon.com
Subject: Re: [PATCH v2] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Message-ID: <20200817080405.GL969206@linux.ibm.com>
References: <20200812010655.96339-1-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812010655.96339-1-liwei213@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_02:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=5 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008170059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 09:06:55AM +0800, Wei Li wrote:
> For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> do not free the reserved memory for the page map, this patch do it.

I've been thinking about it a bit more and it seems that instead of
freeing unused memory map it would be better to allocate the exact
memory map from the beginning.

In sparse_init_nid() we can replace PAGES_PER_SECTION parameter to
__populate_section_memmap() with the calculated value for architectures
that define HAVE_ARCH_PFN_VALID.

Than, I beleive it would be possible to remove free_unused_memmap() in
arm64 and probably in arm32 as well.

> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> 
> v2: fix the patch v1 compile errors that are not based on the latest mainline.
> ---
>  arch/arm64/mm/init.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1e93cfc7c47a..600889945cd0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -441,7 +441,48 @@ void __init bootmem_init(void)
>  	memblock_dump_all();
>  }
> 
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#define VMEMMAP_PAGE_INUSE 0xFD
> +static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	unsigned long addr, end;
> +	unsigned long next;
> +	pmd_t *pmd;
> +	void *page_addr;
> +	phys_addr_t phys_addr;
> +
> +	addr = (unsigned long)pfn_to_page(start_pfn);
> +	end = (unsigned long)pfn_to_page(end_pfn);
> +
> +	pmd = pmd_off_k(addr);
> +	for (; addr < end; addr = next, pmd++) {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (!pmd_present(*pmd))
> +			continue;
> +
> +		if (IS_ALIGNED(addr, PMD_SIZE) &&
> +			IS_ALIGNED(next, PMD_SIZE)) {
> +			phys_addr = __pfn_to_phys(pmd_pfn(*pmd));
> +			memblock_free(phys_addr, PMD_SIZE);
> +			pmd_clear(pmd);
> +		} else {
> +			/* If here, we are freeing vmemmap pages. */
> +			memset((void *)addr, VMEMMAP_PAGE_INUSE, next - addr);
> +			page_addr = page_address(pmd_page(*pmd));
> +
> +			if (!memchr_inv(page_addr, VMEMMAP_PAGE_INUSE,
> +				PMD_SIZE)) {
> +				phys_addr = __pfn_to_phys(pmd_pfn(*pmd));
> +				memblock_free(phys_addr, PMD_SIZE);
> +				pmd_clear(pmd);
> +			}
> +		}
> +	}
> +
> +	flush_tlb_all();
> +}
> +#else
>  static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	struct page *start_pg, *end_pg;
> @@ -468,31 +509,53 @@ static inline void free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  		memblock_free(pg, pgend - pg);
>  }
> 
> +#endif
> +
>  /*
>   * The mem_map array can get very big. Free the unused area of the memory map.
>   */
>  static void __init free_unused_memmap(void)
>  {
> -	unsigned long start, prev_end = 0;
> +	unsigned long start, cur_start, prev_end = 0;
>  	struct memblock_region *reg;
> 
>  	for_each_memblock(memory, reg) {
> -		start = __phys_to_pfn(reg->base);
> +		cur_start = __phys_to_pfn(reg->base);
> 
>  #ifdef CONFIG_SPARSEMEM
>  		/*
>  		 * Take care not to free memmap entries that don't exist due
>  		 * to SPARSEMEM sections which aren't present.
>  		 */
> -		start = min(start, ALIGN(prev_end, PAGES_PER_SECTION));
> -#endif
> +		start = min(cur_start, ALIGN(prev_end, PAGES_PER_SECTION));
> +
>  		/*
> -		 * If we had a previous bank, and there is a space between the
> -		 * current bank and the previous, free it.
> +		 * Free memory in the case of:
> +		 * 1. if cur_start - prev_end <= PAGES_PER_SECTION,
> +		 * free pre_end ~ cur_start.
> +		 * 2. if cur_start - prev_end > PAGES_PER_SECTION,
> +		 * free pre_end ~ ALIGN(prev_end, PAGES_PER_SECTION).
>  		 */
>  		if (prev_end && prev_end < start)
>  			free_memmap(prev_end, start);
> 
> +		/*
> +		 * Free memory in the case of:
> +		 * if cur_start - prev_end > PAGES_PER_SECTION,
> +		 * free ALIGN_DOWN(cur_start, PAGES_PER_SECTION) ~ cur_start.
> +		 */
> +		if (cur_start > start &&
> +		    !IS_ALIGNED(cur_start, PAGES_PER_SECTION))
> +			free_memmap(ALIGN_DOWN(cur_start, PAGES_PER_SECTION),
> +				    cur_start);
> +#else
> +		/*
> +		 * If we had a previous bank, and there is a space between the
> +		 * current bank and the previous, free it.
> +		 */
> +		if (prev_end && prev_end < cur_start)
> +			free_memmap(prev_end, cur_start);
> +#endif
>  		/*
>  		 * Align up here since the VM subsystem insists that the
>  		 * memmap entries are valid from the bank end aligned to
> @@ -507,7 +570,6 @@ static void __init free_unused_memmap(void)
>  		free_memmap(prev_end, ALIGN(prev_end, PAGES_PER_SECTION));
>  #endif
>  }
> -#endif	/* !CONFIG_SPARSEMEM_VMEMMAP */
> 
>  /*
>   * mem_init() marks the free areas in the mem_map and tells us how much memory
> @@ -524,9 +586,8 @@ void __init mem_init(void)
> 
>  	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
> 
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
>  	free_unused_memmap();
> -#endif
> +
>  	/* this will put all unused low memory onto the freelists */
>  	memblock_free_all();
> 
> --
> 2.15.0
> 

-- 
Sincerely yours,
Mike.
