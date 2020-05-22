Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A84C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88031223C7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgEVOVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:21:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729399AbgEVOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:21:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ME56LO170679;
        Fri, 22 May 2020 10:21:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3160mk91ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 10:21:00 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04ME6VJN180235;
        Fri, 22 May 2020 10:21:00 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3160mk91bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 10:21:00 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04MEK1Sd001060;
        Fri, 22 May 2020 14:20:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 313xdhu5sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 May 2020 14:20:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04MEKu1C45678702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 14:20:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DC895204F;
        Fri, 22 May 2020 14:20:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.207.117])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8FA1E5204E;
        Fri, 22 May 2020 14:20:55 +0000 (GMT)
Date:   Fri, 22 May 2020 17:20:53 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     mgorman@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, cai@lca.pw, mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200522142053.GW1059226@linux.ibm.com>
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521092612.GP1059226@linux.ibm.com>
 <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522072524.GF26955@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_05:2020-05-22,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 cotscore=-2147483648 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Baoquan,

On Fri, May 22, 2020 at 03:25:24PM +0800, Baoquan He wrote:
> On 05/22/20 at 03:01pm, Baoquan He wrote:
> > 
> > So let's add these unavailable ranges into memblock and reserve them
> > in init_unavailable_range() instead. With this change, they will be added
> > into appropriate node and zone in memmap_init(), and initialized in
> > reserve_bootmem_region() just like any other memblock reserved regions.
> 
> Seems this is not right. They can't get nid in init_unavailable_range().
> Adding e820 ranges may let them get nid. But the hole range won't be
> added to memblock, and still has the issue.
> 
> Nack this one for now, still considering.

Why won't we add  the e820 reserved ranges to memblock.memory during
early boot as I suggested?

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

The setting of node later  in numa_init() will assign the proper node
for these regions as it does for the usable memory.

> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/page_alloc.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 603187800628..3973b5fdfe3f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6925,7 +6925,7 @@ static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
> >  static void __init init_unavailable_mem(void)
> >  {
> >  	phys_addr_t start, end;
> > -	u64 i, pgcnt;
> > +	u64 i, pgcnt, size;
> >  	phys_addr_t next = 0;
> >  
> >  	/*
> > @@ -6934,9 +6934,11 @@ static void __init init_unavailable_mem(void)
> >  	pgcnt = 0;
> >  	for_each_mem_range(i, &memblock.memory, NULL,
> >  			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
> > -		if (next < start)
> > -			pgcnt += init_unavailable_range(PFN_DOWN(next),
> > -							PFN_UP(start));
> > +		if (next < start) {
> > +			size = PFN_UP(start) - PFN_DOWN(next);
> > +			memblock_add(PFN_DOWN(next), size);
> > +			memblock_reserve(PFN_DOWN(next), size);
> > +		}
> >  		next = end;
> >  	}
> >  
> > @@ -6947,8 +6949,11 @@ static void __init init_unavailable_mem(void)
> >  	 * considered initialized. Make sure that memmap has a well defined
> >  	 * state.
> >  	 */
> > -	pgcnt += init_unavailable_range(PFN_DOWN(next),
> > -					round_up(max_pfn, PAGES_PER_SECTION));
> > +	size = round_up(max_pfn, PAGES_PER_SECTION) - PFN_DOWN(next);
> > +	if (size) {
> > +		memblock_add(PFN_DOWN(next), size);
> > +		memblock_reserve(PFN_DOWN(next), size);
> > +	}
> >  
> >  	/*
> >  	 * Struct pages that do not have backing memory. This could be because
> > -- 
> > 2.17.2
> > 
> 

-- 
Sincerely yours,
Mike.
