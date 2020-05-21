Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613B42072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEUJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:26:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32410 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbgEUJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:26:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L92oo1047808;
        Thu, 21 May 2020 05:26:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312wskxy7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 05:26:20 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04L938OO049041;
        Thu, 21 May 2020 05:26:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312wskxy67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 05:26:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04L9Gedi021811;
        Thu, 21 May 2020 09:26:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 313xehnayr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 09:26:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04L9QF2s59899988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 09:26:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D450AE056;
        Thu, 21 May 2020 09:26:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1221AE053;
        Thu, 21 May 2020 09:26:14 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.206.2])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 May 2020 09:26:14 +0000 (GMT)
Date:   Thu, 21 May 2020 12:26:12 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mgorman@suse.de,
        mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200521092612.GP1059226@linux.ibm.com>
References: <20200521014407.29690-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521014407.29690-1-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_05:2020-05-20,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=973
 lowpriorityscore=0 cotscore=-2147483648 suspectscore=86 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

On Thu, May 21, 2020 at 09:44:07AM +0800, Baoquan He wrote:
> Qian reported that a crash happened in compaction.
> http://lkml.kernel.org/r/8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw
> 
V> LTP: starting swapping01 (swapping01 -i 5)
> page:ffffea0000aa0000 refcount:1 mapcount:0 mapping:000000002243743b index:0x0
> flags: 0x1fffe000001000(reserved)
> raw: 001fffe000001000 ffffea0000aa0008 ffffea0000aa0008 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
> page_owner info is not present (never set?)
> ------------[ cut here ]------------
> kernel BUG at mm/page_alloc.c:533!

...

> After investigation, it turns out that this is introduced by commit of
> linux-next: commit f6edbdb71877 ("mm: memmap_init: iterate over memblock
> regions rather that check each PFN").
> 
> After investigation, it turns out that this is introduced by commit of
> linux-next, the patch subject is:
>   "mm: memmap_init: iterate over memblock regions rather that check each PFN".
> 
> Qian added debugging code. The debugging log shows that the fault page is
> 0x2a800000. From the system e820 map which is pasted at bottom, the page
> is in e820 reserved range:
> 	BIOS-e820: [mem 0x0000000029ffe000-0x000000002a80afff] reserved
> And it's in section [0x28000000, 0x2fffffff]. In that secion, there are
> several usable ranges and some e820 reserved ranges.
> 
> For this kind of e820 reserved range, it won't be added to memblock allocator.
> However, init_unavailable_mem() will initialize to add them into node 0,
> zone 0. Before that commit, later, memmap_init() will add e820 reserved
> ranges into the zone where they are contained, because it can pass
> the checking of early_pfn_valid() and early_pfn_in_nid(). In this case,
> the e820 reserved range where fault page 0x2a800000 is located is added
> into DMA32 zone. After that commit, the e820 reserved rgions are kept
> in node 0, zone 0, since we iterate over memblock regions to iniatialize
> in memmap_init() instead, their node and zone won't be changed.

I wonder why woudn't we add the reserved memory to memblock from the
very beginning...
I've tried to undestand why this was not done, but I couldn't find the
reasoning behind that.

Can you please try the below patch and see if it helps or, on the
contrary, breaks anything else :)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c5399e80c59c..b0940c618ed9 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1301,8 +1301,11 @@ void __init e820__memblock_setup(void)
 		if (end != (resource_size_t)end)
 			continue;
 
-		if (entry->type == E820_TYPE_SOFT_RESERVED)
+		if (entry->type == E820_TYPE_SOFT_RESERVED ||
+		    entry->type == E820_TYPE_RESERVED) {
+			memblock_add(entry->addr, entry->size);
 			memblock_reserve(entry->addr, entry->size);
+		}
 
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
 			continue;

> Now, fast_isolate_freepages() will use min mark directly as the migration
> target if no page is found from buddy. However, the min mark is not checked
> carefully, it could be in e820 reserved range, and trigger the
> VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn)) when try to mark it
> as skip.
> 
> Here, let's call pageblock_pfn_to_page() to get page of min_pfn, since it
> will do careful checks and return NULL if the pfn is not qualified.
> 
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008bfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000028328fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000028329000-0x0000000028568fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000028569000-0x0000000028d85fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000028d86000-0x0000000028ee5fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000028ee6000-0x0000000029a04fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000029a05000-0x0000000029a08fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000029a09000-0x0000000029ee4fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000029ee5000-0x0000000029ef2fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000029ef3000-0x0000000029f22fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000029f23000-0x0000000029f23fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000029f24000-0x0000000029f24fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000029f25000-0x0000000029f28fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000029f29000-0x0000000029f29fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000029f2a000-0x0000000029f2bfff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000029f2c000-0x0000000029f2cfff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000029f2d000-0x0000000029f2ffff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000029f30000-0x0000000029ffdfff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000029ffe000-0x000000002a80afff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000002a80b000-0x000000002a80efff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000002a80f000-0x000000002a81ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000002a820000-0x000000002a822fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x000000002a823000-0x0000000033a22fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000033a23000-0x0000000033a32fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000033a33000-0x0000000033a42fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000033a43000-0x0000000033a52fff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x0000000033a53000-0x0000000077ffffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000078000000-0x000000008fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087effffff] usable
> [    0.000000] BIOS-e820: [mem 0x000000087f000000-0x000000087fffffff] reserved
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/compaction.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 67fd317f78db..9ce4cff4d407 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1418,7 +1418,9 @@ fast_isolate_freepages(struct compact_control *cc)
>  				cc->free_pfn = highest;
>  			} else {
>  				if (cc->direct_compaction && pfn_valid(min_pfn)) {
> -					page = pfn_to_page(min_pfn);
> +					page = pageblock_pfn_to_page(min_pfn,
> +						pageblock_end_pfn(min_pfn),
> +						cc->zone);
>  					cc->free_pfn = min_pfn;
>  				}
>  			}
> -- 
> 2.17.2
> 

-- 
Sincerely yours,
Mike.
