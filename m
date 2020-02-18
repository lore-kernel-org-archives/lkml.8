Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067DC34033
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727D621D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgBRJe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:34:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgBRJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:34:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I9U6m5008913
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:34:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e2f7nq3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 04:34:24 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 18 Feb 2020 09:34:22 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Feb 2020 09:34:19 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01I9YIrt54394982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 09:34:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6BD211C04C;
        Tue, 18 Feb 2020 09:34:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8694C11C04A;
        Tue, 18 Feb 2020 09:34:18 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.0.197])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Feb 2020 09:34:18 +0000 (GMT)
Date:   Tue, 18 Feb 2020 11:34:17 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, thp: track fallbacks due to failed memcg charges
 separately
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
X-TM-AS-GCONF: 00
x-cbid: 20021809-0028-0000-0000-000003DC0B7B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021809-0029-0000-0000-000024A113D9
Message-Id: <20200218093417.GB24430@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=1 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:41:40PM -0800, David Rientjes wrote:
> The thp_fault_fallback stat in either /proc/vmstat is incremented if 

Nit:                            ^ "either" here looks wrong

> either the hugepage allocation fails through the page allocator or the 
> hugepage charge fails through mem cgroup.
> 
> This patch leaves this field untouched but adds a new field,
> thp_fault_fallback_charge, which is incremented only when the mem cgroup
> charge fails.
> 
> This distinguishes between faults that want to be backed by hugepages but
> fail due to fragmentation (or low memory conditions) and those that fail
> due to mem cgroup limits.  That can be used to determine the impact of 
> fragmentation on the system by excluding faults that failed due to memcg 
> usage.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 5 +++++
>  include/linux/vm_event_item.h              | 1 +
>  mm/huge_memory.c                           | 2 ++
>  mm/vmstat.c                                | 1 +
>  4 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -310,6 +310,11 @@ thp_fault_fallback
>  	is incremented if a page fault fails to allocate
>  	a huge page and instead falls back to using small pages.
>  
> +thp_fault_fallback_charge
> +	is incremented if a page fault fails to charge a huge page and
> +	instead falls back to using small pages even through the

						    ^ though

> +	allocation was successful.
> +
>  thp_collapse_alloc_failed
>  	is incremented if khugepaged found a range
>  	of pages that should be collapsed into one huge page but failed
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -73,6 +73,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  		THP_FAULT_ALLOC,
>  		THP_FAULT_FALLBACK,
> +		THP_FAULT_FALLBACK_CHARGE,
>  		THP_COLLAPSE_ALLOC,
>  		THP_COLLAPSE_ALLOC_FAILED,
>  		THP_FILE_ALLOC,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -597,6 +597,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
>  		put_page(page);
>  		count_vm_event(THP_FAULT_FALLBACK);
> +		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>  		return VM_FAULT_FALLBACK;
>  	}
>  
> @@ -1406,6 +1407,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
>  			put_page(page);
>  		ret |= VM_FAULT_FALLBACK;
>  		count_vm_event(THP_FAULT_FALLBACK);
> +		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>  		goto out;
>  	}
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1254,6 +1254,7 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	"thp_fault_alloc",
>  	"thp_fault_fallback",
> +	"thp_fault_fallback_charge",
>  	"thp_collapse_alloc",
>  	"thp_collapse_alloc_failed",
>  	"thp_file_alloc",

-- 
Sincerely yours,
Mike.

