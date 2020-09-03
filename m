Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8725AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AAF2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IHNxczOL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hb4Uq4WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgICQbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:31:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgICQa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:30:57 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083GKR5R004169;
        Thu, 3 Sep 2020 09:25:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=I2uwwRWrTTpMJ0l28C1FLxdPgY7YEI8JCBGJmXdWQ8Y=;
 b=IHNxczOLLXcmg9r6plByXbv7SVQpMthdYvwkJ0b40Jy2h3F3IJf7/N4PHPe4H4WmE1tH
 njQh8iNX9vYf6QVYM3W9kU3LCRxf9Xma7uBny7oyTHzvbvhrBqTzgp1VQ1LhFOouSMaf
 VktEJxWPTb7GkfYPbV+/r4SOF9C7sn5UzjQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 339ws4kc7q-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Sep 2020 09:25:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 09:25:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnZI4QG0J14VJV36oU3FicK4TyEkLsZVzatNUkmD2ipQmnWsRfUz+1QkGDGShQI7g3e6DdPrfa2jAsUR2DlS12+CFi83CXdK8lmQtjTMCRiTNQ5G+qsVTHODFcqdLqfHG3g/9DibvORWsho0ht8cFj5YFrBwBcyqmkaOkUh1FU3rJtVYbJb9j4S9igh339L+pP2tyjuWuRMqF4y0f4TBhVah2aRRL5bUDOcYR8gKbT7zcEHDfiBLTevaadbzYYPLbKdb+/JNe0mCbwHaNqGqQ8UPVpueCQMTKNW9tMhRf0uMqyQM4NTVFUwNL2XmY7I/HTjSQ6qfmOua38VBapP3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2uwwRWrTTpMJ0l28C1FLxdPgY7YEI8JCBGJmXdWQ8Y=;
 b=f8nixVfUShBVTWZUVxz8Rhm6KrPIk612Nv/wI13MT/38ZmbNZMA+NwyyZ0m/wQBuJjHE+HmhKoesH13UuE9rP+XkBL7pwL9U4+zkIFtP3yDj79K88pkaGuCzA0IBmXwQ/HJAoq71Mp1dlXkoPNad3HCDeHjNEbLImUOw97ub1E10vKM9dbTDIaBjRGFCh8ULSP3rHhMkJHom7YPnayHvsv/g60YYPt4hzOfacNkVjB5cPFdKp6XjEysYHXHQswuW6NoG6Z5WG/ryjYJhHn0FNDrS6q8SY8Qgg1rgEXNojAPCqzFoYPd5LN44NFP4w749ed+KJ5IHf1B1XQVQH8MYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2uwwRWrTTpMJ0l28C1FLxdPgY7YEI8JCBGJmXdWQ8Y=;
 b=hb4Uq4WNCgVVmlY8gXeVpNJpzvpINmEx/ibZE9YzjxW66YtFfEQxfVQ6yONrD+rdwB7DXKUpveo5zS3vtUBsx2hdfCH/chj9nFVeoNO8p9n3u3JQkBKH3wOf8kL/Qg6LmlJYcrKSs7XAQMW1u+7ccC1jjVtgu1v9V+W/bkWjX2c=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2517.namprd15.prod.outlook.com (2603:10b6:a03:151::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:25:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 16:25:31 +0000
Date:   Thu, 3 Sep 2020 09:25:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903073254.GP4617@dhcp22.suse.cz>
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR06CA0026.namprd06.prod.outlook.com (2603:10b6:a03:d4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 16:25:30 +0000
X-Originating-IP: [2620:10d:c090:400::5:1b33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dddaf8d5-e094-45fc-7fe0-08d85025f9f5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2517:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2517B219090CC6779DC09623BE2C0@BYAPR15MB2517.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9HRleRayiCLd9jxXNpqFyEofrMHj+SwvZ14zPJMYTjFbCRkzOKUn3wQTIPwIi7poDmMCA3nTTIbn3lx/pQCQjEoh4M2gpoeVaJusXksHk+OwRyDrOSGNxBUmt54zEPiZH7lIsHlQZOm3wzi7ltHUUd/3HriBleBjxJMp1tPsCxeyQoqdDRTskW6i+7g81P36wCceOfYPa9f2GJE4Ma9YEW/F/2hIR9cknMPcmZPB+hF+9lC355qejsOrUoTIlIJoZZh50FCmR3jegviYzyLvDRgFzuoHXpAca9j8ODi1KO7zi7uZ2N2yXzP8v0IGPzw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(956004)(83380400001)(6486002)(2906002)(1076003)(316002)(186003)(7416002)(86362001)(54906003)(16576012)(6666004)(4326008)(8936002)(8676002)(52116002)(9686003)(5660300002)(66946007)(66476007)(478600001)(33656002)(6916009)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lbYSx1LJ3EWzQX33VtFv2OzqHWjyU5QnlZusi9ErYIqKpZxyhTwQDHT5KKqA0J1TSzmTQbnUJyoNaQ5Uo+HipZy7YEk0WLIhUd3sPu8WA0KStNi95SpxoBrXtQmfy6I3GFTDGD2ohu9kwf8CH+s+lon+/qIQAZf2Dg7zAJ9lHe4MxNph7SnVkWfvUrGR7Ia5YfZ1wSw8riLPdNlEgjyVKDcrvGlML28kt8OWRAMOd4Tikh4cd1VuhawTrZehFF7CnGGoLF9juGaCEbv1Box4E2h5bUhMd5GAeEXYbZcyshVMWIUjYm5CbUMYP53OMD37b+d2cIQDXts70lBLzU/eEEbbzG2bUryfxSJ8NNtPjaGnCAxfnihbQupfq+/Mb3QdA1YfQSqdYKZ/XcwFiYWkT9ganr5n0H3J7A86MRmcwOWvf0l1kJjatXJN4+KCNl582jDZY2btTw46Z0/cIoBFqw6Y+Nk+EzQN1OT2P8r3uIjjk+OQErteoc0N374dX38LCAazXuN169yCaQXwI7LybtkQr1XVbXO0MGOIcmT4q9LOgMENeu6j1TdW7YdlXBGjylwIqorT31A/ztw+LDkH8A5uXyTwRHGQhAtQAUK12mKoh3JQzugHgQgZGLuJ3p6id5DaL747IbFWxgM6siFc8IfbQYbktKGBHrl39m/PCCw=
X-MS-Exchange-CrossTenant-Network-Message-Id: dddaf8d5-e094-45fc-7fe0-08d85025f9f5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:25:31.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DO34gwr5r3zQMFJi3y7aTTz3N9jr6u9O3lBX/DGmW9+zjELJqQRc2CapXU53Mjt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2517
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_10:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=5 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030153
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:32:54AM +0200, Michal Hocko wrote:
> On Wed 02-09-20 14:06:12, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> > 
> > Hi all,
> > 
> > This patchset adds support for 1GB THP on x86_64. It is on top of
> > v5.9-rc2-mmots-2020-08-25-21-13.
> > 
> > 1GB THP is more flexible for reducing translation overhead and increasing the
> > performance of applications with large memory footprint without application
> > changes compared to hugetlb.
> 
> Please be more specific about usecases. This better have some strong
> ones because THP code is complex enough already to add on top solely
> based on a generic TLB pressure easing.

Hello, Michal!

We at Facebook are using 1 GB hugetlbfs pages and are getting noticeable
performance wins on some workloads.

Historically we allocated gigantic pages at the boot time, but recently moved
to cma-based dynamic approach. Still, hugetlbfs interface requires more management
than we would like to do. 1 GB THP seems to be a better alternative. So I definitely
see it as a very useful feature.

Given the cost of an allocation, I'm slightly skeptical about an automatic
heuristics-based approach, but if an application can explicitly mark target areas
with madvise(), I don't see why it wouldn't work.

In our case we'd like to have a reliable way to get 1 GB THPs at some point
(usually at the start of an application), and transparently destroy them on
the application exit.

Once we'll have the patchset in a relatively good shape, I'll be happy to give
it a test in our environment and share results.

Thanks!

> 
> > Design
> > =======
> > 
> > 1GB THP implementation looks similar to exiting THP code except some new designs
> > for the additional page table level.
> > 
> > 1. Page table deposit and withdraw using a new pagechain data structure:
> >    instead of one PTE page table page, 1GB THP requires 513 page table pages
> >    (one PMD page table page and 512 PTE page table pages) to be deposited
> >    at the page allocaiton time, so that we can split the page later. Currently,
> >    the page table deposit is using ->lru, thus only one page can be deposited.
> >    A new pagechain data structure is added to enable multi-page deposit.
> > 
> > 2. Triple mapped 1GB THP : 1GB THP can be mapped by a combination of PUD, PMD,
> >    and PTE entries. Mixing PUD an PTE mapping can be achieved with existing
> >    PageDoubleMap mechanism. To add PMD mapping, PMDPageInPUD and
> >    sub_compound_mapcount are introduced. PMDPageInPUD is the 512-aligned base
> >    page in a 1GB THP and sub_compound_mapcount counts the PMD mapping by using
> >    page[N*512 + 3].compound_mapcount.
> > 
> > 3. Using CMA allocaiton for 1GB THP: instead of bump MAX_ORDER, it is more sane
> >    to use something less intrusive. So all 1GB THPs are allocated from reserved
> >    CMA areas shared with hugetlb. At page splitting time, the bitmap for the 1GB
> >    THP is cleared as the resulting pages can be freed via normal page free path.
> >    We can fall back to alloc_contig_pages for 1GB THP if necessary.
> 
> Do those pages get instantiated during the page fault or only via
> khugepaged? This is an important design detail because then we have to
> think carefully about how much automatic we want this to be. Memory
> overhead can be quite large with 2MB THPs already. Also what about the
> allocation overhead? Do you have any numbers?
> 
> Maybe all these details are described in the patcheset but the cover
> letter should contain all that information. It doesn't make much sense
> to dig into details in a patchset this large without having an idea how
> feasible this is.
> 
> Thanks.
>  
> > Patch Organization
> > =======
> > 
> > Patch 01 adds the new pagechain data structure.
> > 
> > Patch 02 to 13 adds 1GB THP support in variable places.
> > 
> > Patch 14 tries to use alloc_contig_pages for 1GB THP allocaiton.
> > 
> > Patch 15 moves hugetlb_cma reservation to cma.c and rename it to hugepage_cma.
> > 
> > Patch 16 use hugepage_cma reservation for 1GB THP allocation.
> > 
> > 
> > Any suggestions and comments are welcome.
> > 
> > 
> > Zi Yan (16):
> >   mm: add pagechain container for storing multiple pages.
> >   mm: thp: 1GB anonymous page implementation.
> >   mm: proc: add 1GB THP kpageflag.
> >   mm: thp: 1GB THP copy on write implementation.
> >   mm: thp: handling 1GB THP reference bit.
> >   mm: thp: add 1GB THP split_huge_pud_page() function.
> >   mm: stats: make smap stats understand PUD THPs.
> >   mm: page_vma_walk: teach it about PMD-mapped PUD THP.
> >   mm: thp: 1GB THP support in try_to_unmap().
> >   mm: thp: split 1GB THPs at page reclaim.
> >   mm: thp: 1GB THP follow_p*d_page() support.
> >   mm: support 1GB THP pagemap support.
> >   mm: thp: add a knob to enable/disable 1GB THPs.
> >   mm: page_alloc: >=MAX_ORDER pages allocation an deallocation.
> >   hugetlb: cma: move cma reserve function to cma.c.
> >   mm: thp: use cma reservation for pud thp allocation.
> > 
> >  .../admin-guide/kernel-parameters.txt         |   2 +-
> >  arch/arm64/mm/hugetlbpage.c                   |   2 +-
> >  arch/powerpc/mm/hugetlbpage.c                 |   2 +-
> >  arch/x86/include/asm/pgalloc.h                |  68 ++
> >  arch/x86/include/asm/pgtable.h                |  26 +
> >  arch/x86/kernel/setup.c                       |   8 +-
> >  arch/x86/mm/pgtable.c                         |  38 +
> >  drivers/base/node.c                           |   3 +
> >  fs/proc/meminfo.c                             |   2 +
> >  fs/proc/page.c                                |   2 +
> >  fs/proc/task_mmu.c                            | 122 ++-
> >  include/linux/cma.h                           |  18 +
> >  include/linux/huge_mm.h                       |  84 +-
> >  include/linux/hugetlb.h                       |  12 -
> >  include/linux/memcontrol.h                    |   5 +
> >  include/linux/mm.h                            |  29 +-
> >  include/linux/mm_types.h                      |   1 +
> >  include/linux/mmu_notifier.h                  |  13 +
> >  include/linux/mmzone.h                        |   1 +
> >  include/linux/page-flags.h                    |  47 +
> >  include/linux/pagechain.h                     |  73 ++
> >  include/linux/pgtable.h                       |  34 +
> >  include/linux/rmap.h                          |  10 +-
> >  include/linux/swap.h                          |   2 +
> >  include/linux/vm_event_item.h                 |   7 +
> >  include/uapi/linux/kernel-page-flags.h        |   2 +
> >  kernel/events/uprobes.c                       |   4 +-
> >  kernel/fork.c                                 |   5 +
> >  mm/cma.c                                      | 119 +++
> >  mm/gup.c                                      |  60 +-
> >  mm/huge_memory.c                              | 939 +++++++++++++++++-
> >  mm/hugetlb.c                                  | 114 +--
> >  mm/internal.h                                 |   2 +
> >  mm/khugepaged.c                               |   6 +-
> >  mm/ksm.c                                      |   4 +-
> >  mm/memcontrol.c                               |  13 +
> >  mm/memory.c                                   |  51 +-
> >  mm/mempolicy.c                                |  21 +-
> >  mm/migrate.c                                  |  12 +-
> >  mm/page_alloc.c                               |  57 +-
> >  mm/page_vma_mapped.c                          | 129 ++-
> >  mm/pgtable-generic.c                          |  56 ++
> >  mm/rmap.c                                     | 289 ++++--
> >  mm/swap.c                                     |  31 +
> >  mm/swap_slots.c                               |   2 +
> >  mm/swapfile.c                                 |   8 +-
> >  mm/userfaultfd.c                              |   2 +-
> >  mm/util.c                                     |  16 +-
> >  mm/vmscan.c                                   |  58 +-
> >  mm/vmstat.c                                   |   8 +
> >  50 files changed, 2270 insertions(+), 349 deletions(-)
> >  create mode 100644 include/linux/pagechain.h
> > 
> > --
> > 2.28.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
