Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B7CC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AB82464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgBSIXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:23:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726484AbgBSIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:23:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01J8JK1V002798
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:23:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubwtnj7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:23:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 19 Feb 2020 08:23:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Feb 2020 08:23:09 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01J8N8HO61276306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 08:23:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FE064C059;
        Wed, 19 Feb 2020 08:23:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F3444C058;
        Wed, 19 Feb 2020 08:23:06 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.50])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Feb 2020 08:23:06 +0000 (GMT)
Date:   Wed, 19 Feb 2020 09:23:03 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jeremy Cline <jcline@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch 2/2] mm, thp: track fallbacks due to failed memcg charges
 separately
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2002181828400.108053@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2002181828400.108053@chino.kir.corp.google.com>
X-TM-AS-GCONF: 00
x-cbid: 20021908-0012-0000-0000-0000038831E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021908-0013-0000-0000-000021C4C4BB
Message-Id: <20200219082303.GA32242@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_02:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=1 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 06:29:21PM -0800, David Rientjes wrote:
> The thp_fault_fallback stat in /proc/vmstat is incremented if either the
> hugepage allocation fails through the page allocator or the hugepage
> charge fails through mem cgroup.
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

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>	# Documentation

> ---
>  v2:
>   - supported for shmem faults as well per Kirill
>   - fixed worked in documentation and commit description per Mike
> 
>  Documentation/admin-guide/mm/transhuge.rst | 5 +++++
>  include/linux/vm_event_item.h              | 1 +
>  mm/huge_memory.c                           | 2 ++
>  mm/shmem.c                                 | 4 +++-
>  mm/vmstat.c                                | 1 +
>  5 files changed, 12 insertions(+), 1 deletion(-)
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
> +	instead falls back to using small pages even though the
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
> diff --git a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1872,8 +1872,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
>  					    PageTransHuge(page));
>  	if (error) {
> -		if (vmf && PageTransHuge(page))
> +		if (vmf && PageTransHuge(page)) {
>  			count_vm_event(THP_FAULT_FALLBACK);
> +			count_vm_event(THP_FAULT_FALLBACK_CHARGE);
> +		}
>  		goto unacct;
>  	}
>  	error = shmem_add_to_page_cache(page, mapping, hindex,
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

