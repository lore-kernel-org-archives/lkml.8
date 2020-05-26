Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDA0208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgEZLdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:33:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726974AbgEZLdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:33:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QBWH67110624;
        Tue, 26 May 2020 07:32:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316yqj1uym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 07:32:51 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04QBWpsP112583;
        Tue, 26 May 2020 07:32:51 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 316yqj1uxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 07:32:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04QBPEH4020485;
        Tue, 26 May 2020 11:32:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 316uf8wtx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 11:32:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04QBVX3e57934122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 11:31:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2D6C4C062;
        Tue, 26 May 2020 11:32:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 185F84C04A;
        Tue, 26 May 2020 11:32:46 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.200.96])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 May 2020 11:32:45 +0000 (GMT)
Date:   Tue, 26 May 2020 14:32:44 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     mgorman@suse.de, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, cai@lca.pw,
        mhocko@kernel.org
Subject: Re: [PATCH] mm/compaction: Fix the incorrect hole in
 fast_isolate_freepages()
Message-ID: <20200526113244.GH13212@linux.ibm.com>
References: <20200521014407.29690-1-bhe@redhat.com>
 <20200521092612.GP1059226@linux.ibm.com>
 <20200521155225.GA20045@MiWiFi-R3L-srv>
 <20200521171836.GU1059226@linux.ibm.com>
 <20200522070114.GE26955@MiWiFi-R3L-srv>
 <20200522072524.GF26955@MiWiFi-R3L-srv>
 <20200522142053.GW1059226@linux.ibm.com>
 <20200526084543.GG26955@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526084543.GG26955@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_01:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=5 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005260083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Baoquan,

On Tue, May 26, 2020 at 04:45:43PM +0800, Baoquan He wrote:
> On 05/22/20 at 05:20pm, Mike Rapoport wrote:
> > Hello Baoquan,
> > 
> > On Fri, May 22, 2020 at 03:25:24PM +0800, Baoquan He wrote:
> > > On 05/22/20 at 03:01pm, Baoquan He wrote:
> > > > 
> > > > So let's add these unavailable ranges into memblock and reserve them
> > > > in init_unavailable_range() instead. With this change, they will be added
> > > > into appropriate node and zone in memmap_init(), and initialized in
> > > > reserve_bootmem_region() just like any other memblock reserved regions.
> > > 
> > > Seems this is not right. They can't get nid in init_unavailable_range().
> > > Adding e820 ranges may let them get nid. But the hole range won't be
> > > added to memblock, and still has the issue.
> > > 
> > > Nack this one for now, still considering.
> > 
> > Why won't we add  the e820 reserved ranges to memblock.memory during
> > early boot as I suggested?
> > 
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index c5399e80c59c..b0940c618ed9 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1301,8 +1301,11 @@ void __init e820__memblock_setup(void)
> >  		if (end != (resource_size_t)end)
> >  			continue;
> >  
> > -		if (entry->type == E820_TYPE_SOFT_RESERVED)
> > +		if (entry->type == E820_TYPE_SOFT_RESERVED ||
> > +		    entry->type == E820_TYPE_RESERVED) {
> > +			memblock_add(entry->addr, entry->size);
> >  			memblock_reserve(entry->addr, entry->size);
> > +		}
> >  
> >  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> >  			continue;
> > 
> > The setting of node later  in numa_init() will assign the proper node
> > for these regions as it does for the usable memory.
> 
> Yes, if it's only related to e820 reserved region, this truly works.
> 
> However, it also has ACPI table regions. That's why I changed to call
> the problematic area as firmware reserved ranges later.
> 
> Bisides, you can see below line, there's another reserved region which only
> occupies one page in one memory seciton. If adding to memblock.memory, we also
> will build struct mem_section and the relevant struct pages for the whole
> section. And then the holes around that page will be added and initialized in
> init_unavailable_mem(). numa_init() will assign proper node for memblock.memory
> and memblock.reserved, but won't assign proper node for the holes.
> 
> ~~~
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> ~~~
> 
> So I still think we should not add firmware reserved range into
> memblock for fixing this issue.
> 
> And, the fix in the original patch seems necessary. You can see in
> compaction code, the migration source is chosen from LRU pages or
> movable pages, the migration target has to be got from Buddy. However,
> only the min_pfn in fast_isolate_freepages(), it's calculated by
> distance between cc->free_pfn - cc->migrate_pfn, we can't guarantee it's
> safe, then use it as the target to handle.

I do not object to your original fix with careful check for pfn validity.

But I still think that the memory reserved by the firmware is still
memory and it should be added to memblock.memory. This way the memory
map will be properly initialized from the very beginning and we won't
need init_unavailable_mem() and alike workarounds and. Obviously, the patch
above is not enough, but it's a small step in this direction.

I believe that improving the early memory initialization would make many
things simpler and more robust, but that's a different story :)

-- 
Sincerely yours,
Mike.
