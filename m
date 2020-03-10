Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23345C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56DE2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0LVi/Rec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCJR13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:27:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:27:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AHQPfZ091794;
        Tue, 10 Mar 2020 17:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=pF62Fl9n3hLaC/9fx7+0TCIeLjvePYs54Kor98cC3bU=;
 b=0LVi/Recrroz+h0BejT26wbyY6sBrBp1gyymxHJ9BDWvxmMQc/dDMXG9ChJWf1P2tn2V
 PD+41FD1DYKM+WRaCxKf7DieGezpHmHNdX8s70dVJM6RHRKXh6N31zOj+MofRuHeYu1b
 T/tEBP0Ou2aCM/WDJ5vOGvC6q838PiEXwfD9pNF82ShukjYdCfUzcEXRzRhhnDBM8qYA
 kCvq+s57DvAshPbEE2HBbvj37wLuYiK3eWvUgXaNbq/vRfbY1xjNRlfzkLxvqEJ8TmRQ
 BA+gmSx5F/KLl5fjnXsAaaVYUxY9BIJTdY7aAdjp2KUEbPJhqURwoGF/n6Dcaa0QqZJP +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yp7hm3byp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 17:27:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AHRFE3022118;
        Tue, 10 Mar 2020 17:27:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2yp8qpe6ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 17:27:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AHR2vc013906;
        Tue, 10 Mar 2020 17:27:03 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 10:27:02 -0700
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
References: <20200310002524.2291595-1-guro@fb.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
Date:   Tue, 10 Mar 2020 10:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310002524.2291595-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/20 5:25 PM, Roman Gushchin wrote:
> Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation
> at runtime") has added the run-time allocation of gigantic pages. However
> it actually works only at early stages of the system loading, when
> the majority of memory is free. After some time the memory gets
> fragmented by non-movable pages, so the chances to find a contiguous
> 1 GB block are getting close to zero. Even dropping caches manually
> doesn't help a lot.
> 
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
> Only x86 is covered by this patch, but it's trivial to extend it to
> cover other architectures as well.
> 
> v2: fixed !CONFIG_CMA build, suggested by Andrew Morton
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Thanks!  I really like this idea.

> ---
>  .../admin-guide/kernel-parameters.txt         |   7 ++
>  arch/x86/kernel/setup.c                       |   3 +
>  include/linux/hugetlb.h                       |   2 +
>  mm/hugetlb.c                                  | 115 ++++++++++++++++++
>  4 files changed, 127 insertions(+)
> 
<snip>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a74262c71484..ceeb06ddfd41 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -16,6 +16,7 @@
>  #include <linux/pci.h>
>  #include <linux/root_dev.h>
>  #include <linux/sfi.h>
> +#include <linux/hugetlb.h>
>  #include <linux/tboot.h>
>  #include <linux/usb/xhci-dbgp.h>
>  
> @@ -1158,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>  
> +	hugetlb_cma_reserve();
> +

I know this is called from arch specific code here to fit in with the timing
of CMA setup/reservation calls.  However, there really is nothing architecture
specific about this functionality.  It would be great IMO if we could make
this architecture independent.  However, I can not think of a straight forward
way to do this.

>  	/*
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
<snip>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
<snip>
> +void __init hugetlb_cma_reserve(void)
> +{
> +	unsigned long totalpages = 0;
> +	unsigned long start_pfn, end_pfn;
> +	phys_addr_t size;
> +	int nid, i, res;
> +
> +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
> +		return;
> +
> +	if (hugetlb_cma_percent) {
> +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> +				       NULL)
> +			totalpages += end_pfn - start_pfn;
> +
> +		size = PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
> +			10000UL;
> +	} else {
> +		size = hugetlb_cma_size;
> +	}
> +
> +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
> +		size / nr_online_nodes);
> +
> +	size /= nr_online_nodes;
> +
> +	for_each_node_state(nid, N_ONLINE) {
> +		unsigned long min_pfn = 0, max_pfn = 0;
> +
> +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> +			if (!min_pfn)
> +				min_pfn = start_pfn;
> +			max_pfn = end_pfn;
> +		}
> +
> +		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> +					     PFN_PHYS(max_pfn), (1UL << 30),

The alignment is hard coded for x86 gigantic page size.  If this supports
more architectures or becomes arch independent we will need to determine
what this alignment should be.  Perhaps an arch specific call back to get
the alignment for gigantic pages.  That will require a little thought as
some arch's support multiple gigantic page sizes.

-- 
Mike Kravetz

> +					     0, false,
> +					     "hugetlb", &hugetlb_cma[nid]);
> +		if (res) {
> +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
> +				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
> +
> +			for (; nid >= 0; nid--)
> +				hugetlb_cma[nid] = NULL;
> +
> +			break;
> +		}
> +
> +		pr_info("hugetlb_cma: successfully reserved %llu on node %d\n",
> +			size, nid);
> +	}
> +}
> +
> +#else /* CONFIG_CMA */
> +void __init hugetlb_cma_reserve(void)
> +{
> +}
> +
> +#endif /* CONFIG_CMA */
