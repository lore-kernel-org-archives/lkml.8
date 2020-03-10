Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB57C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E157D2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="heWe+Cjt";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JFE72vnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCJR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:26:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgCJR03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:26:29 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02AHP1a1007658;
        Tue, 10 Mar 2020 10:26:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FPc2L9p5zMAoqw4+4j1/G/pmwIAPk8LwMeb7OtovDpg=;
 b=heWe+CjtvqZBj6lCDEYEB9cSmggJc6HqDuO2xvNY6okp8+ZqkGm+zDg3PQSiIi/4Nl7N
 voJkoyeIYZsEdJ0n5t+sBJc1Z/3FpzpSAsRS84Mh9qEdg9nN6bNVogkaIbJOHcNjoYwu
 Qp6eypUatpl1ecDORpEa4VuoIDMD5TjAWuw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2yme3vnf8s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 10:26:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 10:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF6hq1++g9GrbDovnyikzSLuCJnR8qacpnyibApbqTjR2o8+BfwnE02kFijyQw44D03GNFi+QvktdEHCNIBl7oDZ7e3PRCe+MwtbEfW4CAVSLtVekia4YHO6NFbpDh01Fdym+j3DkWULfco0Hk88be6xBUddFoyS3b11ZDleLgbh5rlk5bjlDIO2pthQVYazDoAIxZNEOEi/eCHg6ZqqGm0fujhWesxdtJJAXrDQkrcBqb9YRTaPrWqgv9YvuI+Pv+X5s4w40dszVbr2xlrcZKWoMcpIFQYNrYWrPu0m0pH78yklXGXBkojU7mud4vAb5bYtqTOYwETT1B1K+bEOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPc2L9p5zMAoqw4+4j1/G/pmwIAPk8LwMeb7OtovDpg=;
 b=AqlJn3Nn9ieR2FHm6SZzIobsNuEggF0aY2i7WkJ8ETu2Kxsk4af244G4v0BlorbaN0eWQz5n0lCMwFNwhTrsArbsNb8yRzGZ0xWwIY6G1mdLKeOeAWR8jSZzScjUYWcmp8VHz1wcS0F83lNqQu/MOoAbM9r1G9thXlB+8ivRG62tj2UrYqPlHZ/d9FdqjVOHSuGzg4lO5dlQetUkkauVpWogerD+hKu+S6BNzk8e+QFq5ih6kNZRb4VyIp3CS5uytV2QhNdwYsieUu0xTxw812mOI+A5ll0go59A77Oq3tB2iugS/L2xUjaaibWGK6feN3Iwm6kIJLvd3hJILfIJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPc2L9p5zMAoqw4+4j1/G/pmwIAPk8LwMeb7OtovDpg=;
 b=JFE72vnWI4LHBHyfbROdP2eSaB6T6N6q+zN3Lq8dZb/07uxnxtMPdTki9RHG+wBKJp/9kKt1+D2y4WM52wkxl4Y1KXSJZEjGozJDwSDnwOOtrBXTdW+YaT/qOhpjGGwJG29Jro03Tu1rfCSKwLahQSW+zMIsZGZVfPQAZGH2qYI=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1262.namprd15.prod.outlook.com (2603:10b6:320:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 17:26:09 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 17:26:09 +0000
Date:   Tue, 10 Mar 2020 10:25:59 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310172559.GA85000@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <20200310084544.GY8447@dhcp22.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310084544.GY8447@dhcp22.suse.cz>
X-ClientProxiedBy: CO2PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:104:4::14) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:27e5) by CO2PR04CA0160.namprd04.prod.outlook.com (2603:10b6:104:4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 17:26:08 +0000
X-Originating-IP: [2620:10d:c090:400::5:27e5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8599927b-c361-4cb4-9db4-08d7c5181f07
X-MS-TrafficTypeDiagnostic: MWHPR15MB1262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1262016FD76369C9BD56DF97BEFF0@MWHPR15MB1262.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(33656002)(6916009)(7696005)(52116002)(6506007)(81156014)(4326008)(8936002)(6666004)(81166006)(8676002)(478600001)(54906003)(9686003)(1076003)(86362001)(66946007)(5660300002)(55016002)(66556008)(2906002)(66476007)(186003)(16526019)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1262;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXELIWQli+KqKMwhbMl/BOn6/t379FZhuB1M3YOKyBw91I4IrExJSQ/XqzAg60/ByZZ2s7cf8FhPC7Dnm3PQ4VoSfV9azMOoNJhHLLhWQs03/aRLMrOC8zC6PgSLT6Vi4XHO/qm3WWLQHZnrSGP0x0nDVRpmJ5Nc1esmGnjjndYe6G+fCV53qzLY0iw/QExOJkA9jzij1nZGv2fwnETkuiu1Bp81ywpJrz1CObw9QTTp5s5NjIXHvM5cxVkpA8Lwmf4e9XaNh+X8OnygTjiQh2BH3lvwhE4TYSyBQfRXcqyWiBR5uEhc1TuR9DFjRtwdoQJzWaRFLCx5C94Uw7FgR1+gQdBs3tyhv6yv/LnP6x02bPLOg4KEArEajHSruGaXeRSdIDj1guyZRADSL6v83Gxz+eRbSJyNHiOxQdsKoB5bfXxP2D2M1W/l4BPb0oCQ
X-MS-Exchange-AntiSpam-MessageData: o/9c1SKNt4HvfMvN1kxXREeNNgk5ut8d4Joo/Gsp9iyFosySpyvns04X6pZOGfdmoLGU+LsBS0XUjW6/AjDutNTsp9q1OhU9GdwX7vG3ry91db666mOuSjKzdk6htYLY6U7lw/DP9sj98fxeRiYSMyAc3f6q4vuzprCL8M4oPQNVIfP5Ij4UB6wLUFeDyGN7
X-MS-Exchange-CrossTenant-Network-Message-Id: 8599927b-c361-4cb4-9db4-08d7c5181f07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 17:26:09.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRvT6CI87p9XjjFhyy1Fz2cmBZPBi+YTeAYtJmdm2xJVu/B5sMeCK4mcm2wND4ee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_12:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999 suspectscore=5
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100105
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal!

On Tue, Mar 10, 2020 at 09:45:44AM +0100, Michal Hocko wrote:
> [Cc Mike as hugetlb maintainer and keeping the full context for his
> reference]

Thanks!

> 
> On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
> > Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation
> > at runtime") has added the run-time allocation of gigantic pages. However
> > it actually works only at early stages of the system loading, when
> > the majority of memory is free. After some time the memory gets
> > fragmented by non-movable pages, so the chances to find a contiguous
> > 1 GB block are getting close to zero. Even dropping caches manually
> > doesn't help a lot.
> > 
> > At large scale rebooting servers in order to allocate gigantic hugepages
> > is quite expensive and complex. At the same time keeping some constant
> > percentage of memory in reserved hugepages even if the workload isn't
> > using it is a big waste: not all workloads can benefit from using 1 GB
> > pages.
> > 
> > The following solution can solve the problem:
> > 1) On boot time a dedicated cma area* is reserved. The size is passed
> >    as a kernel argument.
> > 2) Run-time allocations of gigantic hugepages are performed using the
> >    cma allocator and the dedicated cma area
> > 
> > In this case gigantic hugepages can be allocated successfully with a
> > high probability, however the memory isn't completely wasted if nobody
> > is using 1GB hugepages: it can be used for pagecache, anon memory,
> > THPs, etc.
> > 
> > * On a multi-node machine a per-node cma area is allocated on each node.
> >   Following gigantic hugetlb allocation are using the first available
> >   numa node if the mask isn't specified by a user.
> > 
> > Usage:
> > 1) configure the kernel to allocate a cma area for hugetlb allocations:
> >    pass hugetlb_cma=10G as a kernel argument
> > 
> > 2) allocate hugetlb pages as usual, e.g.
> >    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> > 
> > If the option isn't enabled or the allocation of the cma area failed,
> > the current behavior of the system is preserved.
> > 
> > Only x86 is covered by this patch, but it's trivial to extend it to
> > cover other architectures as well.
> 
> Overall idea makes sense to me. I am worried about the configuration
> side of the thing. Not only I would stick with the absolute size for now
> for simplicity and because percentage usecase is not really explained
> anywhere. I am also worried about the resulting memory layout you will
> get when using the parameter.

Thanks! I agree, we can drop the percentage configuration for the simplicity.

> 
> Let's scroll down to the setup code ...
> 
> > v2: fixed !CONFIG_CMA build, suggested by Andrew Morton
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   7 ++
> >  arch/x86/kernel/setup.c                       |   3 +
> >  include/linux/hugetlb.h                       |   2 +
> >  mm/hugetlb.c                                  | 115 ++++++++++++++++++
> >  4 files changed, 127 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0c9894247015..d3349ec1dbef 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1452,6 +1452,13 @@
> >  	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
> >  			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
> >  
> > +	hugetlb_cma=	[x86-64] The size of a cma area used for allocation
> > +			of gigantic hugepages.
> > +			Format: nn[GTPE] | nn%
> > +
> > +			If enabled, boot-time allocation of gigantic hugepages
> > +			is skipped.
> > +
> >  	hugepages=	[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
> >  	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
> >  			On x86-64 and powerpc, this option can be specified
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index a74262c71484..ceeb06ddfd41 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/root_dev.h>
> >  #include <linux/sfi.h>
> > +#include <linux/hugetlb.h>
> >  #include <linux/tboot.h>
> >  #include <linux/usb/xhci-dbgp.h>
> >  
> > @@ -1158,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
> >  	initmem_init();
> >  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
> >  
> > +	hugetlb_cma_reserve();
> > +
> >  	/*
> >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> >  	 * won't consume hotpluggable memory.
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 50480d16bd33..50050c981ab9 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -157,6 +157,8 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
> >  extern int sysctl_hugetlb_shm_group;
> >  extern struct list_head huge_boot_pages;
> >  
> > +extern void __init hugetlb_cma_reserve(void);
> > +
> >  /* arch callbacks */
> >  
> >  pte_t *huge_pte_alloc(struct mm_struct *mm,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 7fb31750e670..c6f58bab879c 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/jhash.h>
> >  #include <linux/numa.h>
> >  #include <linux/llist.h>
> > +#include <linux/cma.h>
> >  
> >  #include <asm/page.h>
> >  #include <asm/pgtable.h>
> > @@ -44,6 +45,9 @@
> >  int hugetlb_max_hstate __read_mostly;
> >  unsigned int default_hstate_idx;
> >  struct hstate hstates[HUGE_MAX_HSTATE];
> > +
> > +static struct cma *hugetlb_cma[MAX_NUMNODES];
> > +
> >  /*
> >   * Minimum page order among possible hugepage sizes, set to a proper value
> >   * at boot time.
> > @@ -1228,6 +1232,11 @@ static void destroy_compound_gigantic_page(struct page *page,
> >  
> >  static void free_gigantic_page(struct page *page, unsigned int order)
> >  {
> > +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> > +		cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order);
> > +		return;
> > +	}
> > +
> >  	free_contig_range(page_to_pfn(page), 1 << order);
> >  }
> >  
> > @@ -1237,6 +1246,23 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
> >  {
> >  	unsigned long nr_pages = 1UL << huge_page_order(h);
> >  
> > +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> > +		struct page *page;
> > +		int nid;
> > +
> > +		for_each_node_mask(nid, *nodemask) {
> > +			if (!hugetlb_cma[nid])
> > +				break;
> > +
> > +			page = cma_alloc(hugetlb_cma[nid], nr_pages,
> > +					 huge_page_order(h), true);
> > +			if (page)
> > +				return page;
> > +		}
> > +
> > +		return NULL;
> > +	}
> > +
> >  	return alloc_contig_pages(nr_pages, gfp_mask, nid, nodemask);
> >  }
> >  
> > @@ -2439,6 +2465,10 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> >  
> >  	for (i = 0; i < h->max_huge_pages; ++i) {
> >  		if (hstate_is_gigantic(h)) {
> > +			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> > +				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> > +				break;
> > +			}
> >  			if (!alloc_bootmem_huge_page(h))
> >  				break;
> >  		} else if (!alloc_pool_huge_page(h,
> > @@ -5372,3 +5402,88 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
> >  		spin_unlock(&hugetlb_lock);
> >  	}
> >  }
> > +
> > +#ifdef CONFIG_CMA
> > +static unsigned long hugetlb_cma_size __initdata;
> > +static unsigned long hugetlb_cma_percent __initdata;
> > +
> > +static int __init cmdline_parse_hugetlb_cma(char *p)
> > +{
> > +	unsigned long long val;
> > +	char *endptr;
> > +
> > +	if (!p)
> > +		return -EINVAL;
> > +
> > +	/* Value may be a percentage of total memory, otherwise bytes */
> > +	val = simple_strtoull(p, &endptr, 0);
> > +	if (*endptr == '%')
> > +		hugetlb_cma_percent = clamp_t(unsigned long, val, 0, 100);
> > +	else
> > +		hugetlb_cma_size = memparse(p, &p);
> > +
> > +	return 0;
> > +}
> > +
> > +early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
> > +
> > +void __init hugetlb_cma_reserve(void)
> > +{
> > +	unsigned long totalpages = 0;
> > +	unsigned long start_pfn, end_pfn;
> > +	phys_addr_t size;
> > +	int nid, i, res;
> > +
> > +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
> > +		return;
> > +
> > +	if (hugetlb_cma_percent) {
> > +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> > +				       NULL)
> > +			totalpages += end_pfn - start_pfn;
> > +
> > +		size = PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
> > +			10000UL;
> > +	} else {
> > +		size = hugetlb_cma_size;
> > +	}
> > +
> > +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
> > +		size / nr_online_nodes);
> > +
> > +	size /= nr_online_nodes;
> > +
> > +	for_each_node_state(nid, N_ONLINE) {
> > +		unsigned long min_pfn = 0, max_pfn = 0;
> > +
> > +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > +			if (!min_pfn)
> > +				min_pfn = start_pfn;
> > +			max_pfn = end_pfn;
> > +		}
> 
> Do you want to compare the range to the size?

You mean add a check that the range is big enough?

> But besides that, I
> believe this really needs to be much more careful. I believe you do not
> want to eat a considerable part of the kernel memory because the
> resulting configuration will really struggle (yeah all the low mem/high
> mem problems all over again).

Well, so far I was focused on a particular case when the target cma size
is significantly smaller than the total RAM size (~5-10%). What is the right
thing to do here? Fallback to the current behavior if the requested size is
more than x% of total memory? 1/2? How do you think?

We've discussed it with Rik in private, and he expressed an idea to start
with ~50% always and then shrink it on-demand. Something that we might
have here long-term.


Thank you!
