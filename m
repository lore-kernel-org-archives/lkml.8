Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DFCC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9EB206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CprgbpiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390817AbgDCP5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:57:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50300 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgDCP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:57:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Fmkei060789;
        Fri, 3 Apr 2020 15:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=MzcEPsaAgNUkBImNr/zrDhf2ysA5Vv2D7EAM71MO2d0=;
 b=CprgbpiZJESxYfsiGeWjS9fbdpqMzft46zlN+MO7Z/wRZRSXUee0QVyRziFaodGT4ZYu
 7HmdkDEQ0ECPu6M25JtWC9XABevsvZN0jnbD63q/UbhnEOu0d3DQ6nokHet4EVWQRA4S
 AjC1iCOTHrDzy7iBBrZT30sOvuQT7ycREhngEOGPqi2mM1p9KQy5DqMeclDEVq1X5Ta/
 djZIdxBI5QKuIBtSF7yT5gF2EjkfIE1VlL4kg4/DpkrUvHwd3Mfdrv4pqTahWBP4t/Gy
 wOA167egI8MJWoxMjMEGujXLE0L9kdCsUJL4I1s95rnFFKAGQKbAsZbJ8++RmS+z+Xmy AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 303aqj2c5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 15:57:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Fl3He172436;
        Fri, 3 Apr 2020 15:57:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2nc6sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 15:57:03 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033Fuw5w022157;
        Fri, 3 Apr 2020 15:56:59 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 08:56:58 -0700
Subject: Re: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages
 using cma 65;5803;1c Commit 944d9fec8d7a ("hugetlb: add support for gigantic
 page allocation at runtime") has added the run-time allocation of gigantic
 pages. However it actually works only at early stages of the system loading,
 when the majority of memory is free. After some time the memory gets
 fragmented by non-movable pages, so the chances to find a contiguous 1 GB
 block are getting close to zero. Even dropping caches manually doesn't help a
 lot.
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>
References: <20200311220920.2487528-1-guro@fb.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <46ae32bd-0be9-fa7a-1eff-65ab69af5703@oracle.com>
Date:   Fri, 3 Apr 2020 08:56:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200311220920.2487528-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/20 3:09 PM, Roman Gushchin wrote:
> At large scale rebooting servers in order to allocate gigantic hugepages
> is quite expensive and complex. At the same time keeping some constant
> percentage of memory in reserved hugepages even if the workload isn't
> using it is a big waste: not all workloads can benefit from using 1 GB
> pages.
> 
> The following solution can solve the problem:
> 1) On boot time a dedicated cma area* is reserved. The size is passed
>    as a kernel argument.
> 2) Run-time allocations of gigantic hugepages are performed using the
>    cma allocator and the dedicated cma area
> 
> In this case gigantic hugepages can be allocated successfully with a
> high probability, however the memory isn't completely wasted if nobody
> is using 1GB hugepages: it can be used for pagecache, anon memory,
> THPs, etc.
> 
> * On a multi-node machine a per-node cma area is allocated on each node.
>   Following gigantic hugetlb allocation are using the first available
>   numa node if the mask isn't specified by a user.
> 
> Usage:
> 1) configure the kernel to allocate a cma area for hugetlb allocations:
>    pass hugetlb_cma=10G as a kernel argument
> 
> 2) allocate hugetlb pages as usual, e.g.
>    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 
> If the option isn't enabled or the allocation of the cma area failed,
> the current behavior of the system is preserved.
> 
> x86 and arm-64 are covered by this patch, other architectures can be
> trivially added later.
> 
> v3:
>   - added fallback to the existing allocation mechanism
>   - added min/max checks
>   - switched to MiB in debug output
>   - removed percentage option
>   - added arch-specific order argument to determine an alignment
>   - added arm support
>   - fixed the !CONFIG_HUGETLBFS build
> 
>   Thanks to Michal, Mike, Andreas and Rik for ideas and suggestions!
> 
> v2:
>   -fixed !CONFIG_CMA build, suggested by Andrew Morton
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

It is a bit difficult to keep track of all the followup patches.  One
small issue below.

> ---
>  .../admin-guide/kernel-parameters.txt         |   7 ++
>  arch/arm64/mm/init.c                          |   6 +
>  arch/x86/kernel/setup.c                       |   4 +
>  include/linux/hugetlb.h                       |   8 ++
>  mm/hugetlb.c                                  | 116 ++++++++++++++++++
>  5 files changed, 141 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0c9894247015..9eb0df40643d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1452,6 +1452,13 @@
>  	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
>  			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
>  
> +	hugetlb_cma=	[x86-64] The size of a cma area used for allocation
> +			of gigantic hugepages.
> +			Format: nn[KMGTPE]
> +
> +			If enabled, boot-time allocation of gigantic hugepages
> +			is skipped.
> +
>  	hugepages=	[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
>  	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
>  			On x86-64 and powerpc, this option can be specified
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b65dffdfb201..e42727e3568e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -29,6 +29,7 @@
>  #include <linux/mm.h>
>  #include <linux/kexec.h>
>  #include <linux/crash_dump.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/boot.h>
>  #include <asm/fixmap.h>
> @@ -457,6 +458,11 @@ void __init arm64_memblock_init(void)
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  
>  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> +
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> +#endif
> +
>  }

The documentation is already 'out of date' as you added support for arm64.
Not a huge deal as documentation rarely keeps up with code, but we should
at least be correct here.

I have a patch series in progress which cleans up existing hugetlb command
line processing.
https://lore.kernel.org/linux-mm/20200401183819.20647-1-mike.kravetz@oracle.com/

No need to make any changes here, but assuming this support goes in first
I would make the following changes as part of my series:
- Don't list architectures in Documentation.  Just say support is arch
  dependent.
- Introduce some mechanism to print an error if hugetlb_cma is specified
  on the command line, but not supported by architecture.  IIUC, no message
  is printed today.  IMO, this only becomes important if the documentation
  does not list supported architectures.
 
Not insisting that documentation be updated to include arm64.
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
