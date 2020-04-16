Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF877C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D825C207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgDPRJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:09:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727795AbgDPRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:09:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GH4vJ2082249
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 13:09:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30eswvbdtv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 13:09:14 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 16 Apr 2020 18:08:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Apr 2020 18:08:25 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03GH973a27853010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 17:09:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F30942041;
        Thu, 16 Apr 2020 17:09:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91CD94203F;
        Thu, 16 Apr 2020 17:09:06 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.78])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Apr 2020 17:09:06 +0000 (GMT)
Date:   Thu, 16 Apr 2020 20:09:04 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH RFC 2/2] mm/memory_hotplug: handle memblocks only with
 CONFIG_ARCH_KEEP_MEMBLOCK
References: <20200416104707.20219-1-david@redhat.com>
 <20200416104707.20219-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416104707.20219-3-david@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 20041617-0020-0000-0000-000003C90001
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041617-0021-0000-0000-00002221E808
Message-Id: <20200416170904.GA13521@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=5 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 12:47:07PM +0200, David Hildenbrand wrote:
> The comment in add_memory_resource() is stale: hotadd_new_pgdat() will
> no longer call get_pfn_range_for_nid(), as a hotadded pgdat will simply
> span no pages at all, until memory is moved to the zone/node via
> move_pfn_range_to_zone() - e.g., when onlining memory blocks.
> 
> The only archs that care about memblocks for hotplugged memory (either
> for iterating over all system RAM or testing for memory validity) are
> arm64, s390x, and powerpc - due to CONFIG_ARCH_KEEP_MEMBLOCK. Without
> CONFIG_ARCH_KEEP_MEMBLOCK, we can simply stop messing with memblocks.
> 
> For s390x, it seems to be fairly easy to avoid CONFIG_ARCH_KEEP_MEMBLOCK.
> arm64 could rework most code (esp., pfn_valid(), valid_phys_addr_range()
> and kexec_file_load()) to not require memblocks for hotplugged
> memory. E.g., as hotplugged memory has no holes and can be identified
> using !early_section(), arm64's variant of pfn_valid() could be reworked
> fairly easily to not require memblocks for hotadded memory. powerpc might
> be more involed.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/Kconfig          |  3 +++
>  mm/memory_hotplug.c | 13 +++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1acc34c1c35..a063fd9cdff4 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -136,6 +136,9 @@ config HAVE_FAST_GUP
>  	depends on MMU
>  	bool
>  
> +# Don't discard allocated memory used to track "memory" and "reserved" memblocks
> +# after early boot, so it can still be used to test for validity of memory.
> +# Also, memblocks are updated with memory hot(un)plug.
>  config ARCH_KEEP_MEMBLOCK
>  	bool
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9b15ce465be2..104285ee9ae8 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1020,13 +1020,9 @@ int __ref add_memory_resource(int nid, struct resource *res)
>  
>  	mem_hotplug_begin();
>  
> -	/*
> -	 * Add new range to memblock so that when hotadd_new_pgdat() is called
> -	 * to allocate new pgdat, get_pfn_range_for_nid() will be able to find
> -	 * this new range and calculate total pages correctly.  The range will
> -	 * be removed at hot-remove time.
> -	 */
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
>  	memblock_add_node(start, size, nid);
> +#endif
>  
>  	ret = __try_online_node(nid, false);
>  	if (ret < 0)
> @@ -1075,7 +1071,9 @@ int __ref add_memory_resource(int nid, struct resource *res)
>  	/* rollback pgdat allocation and others */
>  	if (new_node)
>  		rollback_node_hotadd(nid);
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
>  	memblock_remove(start, size);
> +#endif
>  	mem_hotplug_done();
>  	return ret;
>  }
> @@ -1751,8 +1749,11 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>  	mem_hotplug_begin();
>  
>  	arch_remove_memory(nid, start, size, NULL);
> +
> +#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
>  	memblock_free(start, size);
>  	memblock_remove(start, size);
> +#endif
>  	__release_memory_resource(start, size);
>  
>  	try_offline_node(nid);
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.

