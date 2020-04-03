Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36D6C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D612073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hVVWbLh5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="THjBVkQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404515AbgDCQ01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:26:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1786 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404064AbgDCQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:26:27 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033GJaCW008462;
        Fri, 3 Apr 2020 09:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=k0dqDqQi8QU8Uo+6hjQLZ/FvuVpfk84HNx1ZClaimto=;
 b=hVVWbLh5Knv8CuJMdxv7vTWkfB2zzqm1Li6+lD+jpWO2SS9GrQ8q1QTvoNOelUZZpfOd
 rxiXli6AXSnKiQ4YN7uYj9bLm2htPMupn77yjgr4w0ZVmiHKN7aqY+eWaKTXiagiNQC+
 CcPQGYg5n0YKELDDTN9XjhvCT7OT1Zwi6jk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 304c9b81fn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Apr 2020 09:26:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 3 Apr 2020 09:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vaat0/5/jw1rU9DPMmDcDr3rNZ+Ox2vQc7s0INapsezLW2xue4YhNFFuPbX6JbtksbKU8r14NZcD5rOSy0oAkAp0P/GjRBFhTJkSNEgV+QfNx355+IpgxDoP16VP40+w5Pc6QFhh/rZlfc5+ozxZs6RbKLN1wWtMY/xIy0m+ajEiKY2tLPQLFiV2sNKDm4pRUlqdUkKmzm3F8OZfZVKGygm6ojkp0CWp19VYEfd0vY6Cx3pKcG6AovApzWvycrbR4GWocB5QYXqxrFf6cmbexW3T0gq8GBKyxM2SI/dOwtya0VAWYiOgyFbEaxrDweKL6LAyAlk+2yPa53lGZdZ95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0dqDqQi8QU8Uo+6hjQLZ/FvuVpfk84HNx1ZClaimto=;
 b=DO0aCFYnzrFxw6JjWt6mKsEYQB9c+PabxsObd5FLSvCiRIIkJScb+E+P8jXVXhaUKXuSiRVNjdEcnpIn5VDmDYFdyGNyZknTfc98M0KJnNtxXsKDSOcY1FqgKQw8M721NWneZ1EA8KKURkvY++vD7DJaqJFrcPE66AlNhKf788KpsgYwBRy7NZOTQEy2Ry6DQMdmFMYbJbv7Qv5+JCMLm83zBb8Kk3i2yhgVOnU5xO0IAu2il92Cqux8kUHiW5SHU5/++EAZOlfkCRe0l7uLn6oWlVf+vbUTh55WazMVR84J1mcD9oy408hq0iY92wFPkNW/DerVysJWAWw7EK/yRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0dqDqQi8QU8Uo+6hjQLZ/FvuVpfk84HNx1ZClaimto=;
 b=THjBVkQ5532zFQ28Xz+TF1VTjgygFP+vF0fiPtRGlx3elOJmROt5rYZmRSHf6/Lo1HY9Mdqk99IgSdeTFcOFIpoB3F9z987xf8DAz2DkzVG++y0//ifzW0GZTr2Ks7EUqvZnEYlFinas/z6GBQwqQ9UVYIVgnh+a01AmFrzheAM=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3398.namprd15.prod.outlook.com (2603:10b6:a03:10e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 16:26:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 16:26:10 +0000
Date:   Fri, 3 Apr 2020 09:26:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>
Subject: Re: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages
 using cma 65;5803;1c Commit 944d9fec8d7a ("hugetlb: add support for gigantic
 page allocation at runtime") has added the run-time allocation of gigantic
 pages. However it actually works only at early stages of the system loading,
 when the majority of memory is free. After some time the memory gets
 fragmented by non-movable pages, so the chances to find a contiguous 1 GB
 block are getting close to zero. Even dropping caches manually doesn't help
 a lot.
Message-ID: <20200403162605.GB220160@carbon.lan>
References: <20200311220920.2487528-1-guro@fb.com>
 <46ae32bd-0be9-fa7a-1eff-65ab69af5703@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ae32bd-0be9-fa7a-1eff-65ab69af5703@oracle.com>
X-ClientProxiedBy: MWHPR21CA0033.namprd21.prod.outlook.com
 (2603:10b6:300:129::19) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:6713) by MWHPR21CA0033.namprd21.prod.outlook.com (2603:10b6:300:129::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.0 via Frontend Transport; Fri, 3 Apr 2020 16:26:09 +0000
X-Originating-IP: [2620:10d:c090:400::5:6713]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0975ea3-d547-40f8-58f5-08d7d7ebb800
X-MS-TrafficTypeDiagnostic: BYAPR15MB3398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3398885B68D92682D0CAF4CEBEC70@BYAPR15MB3398.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:OSPM;SFTY:;SFS:(10019020)(136003)(396003)(366004)(376002)(39860400002)(346002)(52116002)(5660300002)(4326008)(9686003)(54906003)(2906002)(33656002)(7696005)(186003)(36756003)(16526019)(316002)(1076003)(8886007)(53546011)(6506007)(6916009)(66946007)(86362001)(8676002)(81156014)(478600001)(81166006)(55016002)(6666004)(66556008)(966005)(8936002)(66476007)(27376004)(37363001);DIR:OUT;SFP:1501;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfWTA8wF/L/R3y4kFeoXlKgQ7IJMagd0akoXRJl2cZZk8POAHSntmw0BRhL1WYmtGp3wAF9WC2cZNQFGwEwjQcfGXB4IHFQrzrDYLGtNs97lFWGTI3GULPe3O3WFp5gTdFrhpM7hbm53vFcKH+xEJ8KFDPxwi4BRUZpJqr0NvdX1Q+cAnmsYxIzxOIpBQQBKXMNNavA2adpHvnIdqj/6jsnqwROqT3ajqwLNEHngWwCOOYzQybg2EUBfXaOVMZFtD1hI+tbVx9UFzuOQh+ywxuMHH5haNq0+eykZyNL8j7CQpu+NSyzTM3y4hv0ekJjrNOuSckiotPfy1P/4cgNdWFz0Yk16QfeaM7ine8PR2IqoVn1PbZDgZkQc+P65GsXRBuuBE2DyYHIGSBsLDlo+JkBOpA6SPWNYqPvHPFA7Kn4pIQBvdKyF56+9yF3PJuIdonqVHDxTB8VlW6zgBrK7PUAMARoxWf7F5vRatOqRQisEx8zPCtWRmEyy+KqCmae6vHNtxcxJ8YQc25RY6Looskez2wjNqvh6BKHpJnVPTxQr51IjBWqYHwwM/4FAZPgV4COgglqld3Ef0Y7DEIan+h0zFEnrAwZs0JZaT0PCDARqPd7Fbfa8uunRrnd/GlhgzbGdWjXlMZ4gnfBp3WdaZ95+GkHn/U44ngpdO1uJ1zZT9C9b1qDuppXzkOfpWFVb9d/y+ZtwKkXdPPBGAGzMsz2YdDgkc5FtLFPXmXicnhl+n6f4ohv8hDD5xHI1JGhbr5xHn9HdKYWQYKNch+e+d91UfmoFprvGLenJqHGDu6fjCCGnBwFivSB/1AD4RBR6vRx9GvBPovQAuqdwgXyCF4iD2FIYB/eq1vwrrbEiG8H6I4nwFbkzTaVnvLVgwNlM
X-MS-Exchange-AntiSpam-MessageData: a+jiRdAZEGzWSxkekmDzvBa3ivP03/OdRHQiQ9iiBKj+IVZMnb1LO2t3JoYyNLYlYDGFKEziEpFnpRFMCrSkPA71mmEM28qP0HmFNU/oGEnniLklh1i7r6DG8f+bcm48ol0a7XhYkLoDDJEnsN1HkAfXxcuKE+x+NEk8s8fNxCL1OG/1LpzUAojv4hbSeFpL
X-MS-Exchange-CrossTenant-Network-Message-Id: a0975ea3-d547-40f8-58f5-08d7d7ebb800
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 16:26:10.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egMPqQNsaNAI3Q8nxQmzVOmRYS7UOHqajy3QCowrlSQ4RWzBgMiGl04OGnNFGyrs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3398
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_12:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030139
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 08:56:57AM -0700, Mike Kravetz wrote:
> On 3/11/20 3:09 PM, Roman Gushchin wrote:
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
> > x86 and arm-64 are covered by this patch, other architectures can be
> > trivially added later.
> > 
> > v3:
> >   - added fallback to the existing allocation mechanism
> >   - added min/max checks
> >   - switched to MiB in debug output
> >   - removed percentage option
> >   - added arch-specific order argument to determine an alignment
> >   - added arm support
> >   - fixed the !CONFIG_HUGETLBFS build
> > 
> >   Thanks to Michal, Mike, Andreas and Rik for ideas and suggestions!
> > 
> > v2:
> >   -fixed !CONFIG_CMA build, suggested by Andrew Morton
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> It is a bit difficult to keep track of all the followup patches.  One
> small issue below.

I agree. There was a dozen of cleanups and fixes from several other people,
so it's a bit messy now.
I'll merge it all together (including documentation fixes proposed by you)
and resend, as soon as I'll figure out the hugetlb/cma locking issue.

> 
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   7 ++
> >  arch/arm64/mm/init.c                          |   6 +
> >  arch/x86/kernel/setup.c                       |   4 +
> >  include/linux/hugetlb.h                       |   8 ++
> >  mm/hugetlb.c                                  | 116 ++++++++++++++++++
> >  5 files changed, 141 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0c9894247015..9eb0df40643d 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1452,6 +1452,13 @@
> >  	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
> >  			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
> >  
> > +	hugetlb_cma=	[x86-64] The size of a cma area used for allocation
> > +			of gigantic hugepages.
> > +			Format: nn[KMGTPE]
> > +
> > +			If enabled, boot-time allocation of gigantic hugepages
> > +			is skipped.
> > +
> >  	hugepages=	[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
> >  	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
> >  			On x86-64 and powerpc, this option can be specified
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index b65dffdfb201..e42727e3568e 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/kexec.h>
> >  #include <linux/crash_dump.h>
> > +#include <linux/hugetlb.h>
> >  
> >  #include <asm/boot.h>
> >  #include <asm/fixmap.h>
> > @@ -457,6 +458,11 @@ void __init arm64_memblock_init(void)
> >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> >  
> >  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> > +
> > +#ifdef CONFIG_ARM64_4K_PAGES
> > +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> > +#endif
> > +
> >  }
> 
> The documentation is already 'out of date' as you added support for arm64.
> Not a huge deal as documentation rarely keeps up with code, but we should
> at least be correct here.
> 
> I have a patch series in progress which cleans up existing hugetlb command
> line processing.
> https://lore.kernel.org/linux-mm/20200401183819.20647-1-mike.kravetz@oracle.com/
> 
> No need to make any changes here, but assuming this support goes in first
> I would make the following changes as part of my series:
> - Don't list architectures in Documentation.  Just say support is arch
>   dependent.
> - Introduce some mechanism to print an error if hugetlb_cma is specified
>   on the command line, but not supported by architecture.  IIUC, no message
>   is printed today.  IMO, this only becomes important if the documentation
>   does not list supported architectures.
>  
> Not insisting that documentation be updated to include arm64.
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Thank you!

Roman
