Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20EC20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgEUNil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:38:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4770 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728060AbgEUNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:38:40 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04LDWlmR099950;
        Thu, 21 May 2020 09:38:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312wsm59j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 09:38:30 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04LDX603100838;
        Thu, 21 May 2020 09:38:28 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312wsm59h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 09:38:28 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04LDZN60003308;
        Thu, 21 May 2020 13:38:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 313xcd2bt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 13:38:26 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04LDcOjm62062690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 13:38:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5A8452050;
        Thu, 21 May 2020 13:38:24 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.51])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E1E525204F;
        Thu, 21 May 2020 13:38:23 +0000 (GMT)
Date:   Thu, 21 May 2020 16:38:21 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, cai@lca.pw,
        mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200521133821.GR1059226@linux.ibm.com>
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521093606.GA7110@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521093606.GA7110@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_07:2020-05-21,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 cotscore=-2147483648 suspectscore=84 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:36:06AM +0100, Mel Gorman wrote:
> On Thu, May 21, 2020 at 09:44:07AM +0800, Baoquan He wrote:
> > After investigation, it turns out that this is introduced by commit of
> > linux-next: commit f6edbdb71877 ("mm: memmap_init: iterate over memblock
> > regions rather that check each PFN").
> > 
> > After investigation, it turns out that this is introduced by commit of
> > linux-next, the patch subject is:
> >   "mm: memmap_init: iterate over memblock regions rather that check each PFN".
> > 
> 
> Some repetition here. I assume it's because the commit ID is not stable
> because it's in linux-next.
> 
> > Qian added debugging code. The debugging log shows that the fault page is
> > 0x2a800000. From the system e820 map which is pasted at bottom, the page
> > is in e820 reserved range:
> > 	BIOS-e820: [mem 0x0000000029ffe000-0x000000002a80afff] reserved
> > And it's in section [0x28000000, 0x2fffffff]. In that secion, there are
> > several usable ranges and some e820 reserved ranges.
> > 
> > For this kind of e820 reserved range, it won't be added to memblock allocator.
> > However, init_unavailable_mem() will initialize to add them into node 0,
> > zone 0.
> 
> Why is it appropriate for init_unavailable_mem to add a e820 reserved
> range to the zone at all? The bug being triggered indicates there is a
> mismatch between the zone of a struct page and the PFN passed in.
> 
> > Before that commit, later, memmap_init() will add e820 reserved
> > ranges into the zone where they are contained, because it can pass
> > the checking of early_pfn_valid() and early_pfn_in_nid(). In this case,
> > the e820 reserved range where fault page 0x2a800000 is located is added
> > into DMA32 zone. After that commit, the e820 reserved rgions are kept
> > in node 0, zone 0, since we iterate over memblock regions to iniatialize
> > in memmap_init() instead, their node and zone won't be changed.
> > 
> 
> This implies that we have struct pages that should never be used (e820
> reserved) but exist somehow in a zone range but with broken linkages to
> their node and zone.

Unless I misread Baoquan's explanation we do have struct pages for e820
resrved memory, but they are properly linked to their node and zone and
marked as reserved.

Before the commit memmap_init_zone() looped over all pfns in node in
zone and the reserved pages were passed to __init_single_page with node
and zone where their pfn belongs.

Afterwards, free_low_memory_core_early() reserved them because they were
present in memblock.reserved and form here on nothing would touch them.

After the commit, we skip over the holes in memblock.memory during
memmap_init_zone() which leaves the zone and node link zeroed for e820
reserved pages and that evetually triggers
VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn)).

> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/compaction.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 67fd317f78db..9ce4cff4d407 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1418,7 +1418,9 @@ fast_isolate_freepages(struct compact_control *cc)
> >  				cc->free_pfn = highest;
> >  			} else {
> >  				if (cc->direct_compaction && pfn_valid(min_pfn)) {
> > -					page = pfn_to_page(min_pfn);
> > +					page = pageblock_pfn_to_page(min_pfn,
> > +						pageblock_end_pfn(min_pfn),
> > +						cc->zone);
> >  					cc->free_pfn = min_pfn;
> >  				}
> >  			}
> 
> Why is the correct fix not to avoid creating struct pages for e820
> ranges and make sure that struct pages that are reachable have proper
> node and zone linkages?

I think that simpler fix would be to have e820 reserved ranges
reigstered as memory in memblock and not only as reserved. If we will
have these regions in both memblock.memory and memblock.reserved the
struct pages for them will be properly initialized as reserved. 

> -- 
> Mel Gorman
> SUSE Labs

-- 
Sincerely yours,
Mike.
