Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4080EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E360A20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qZfxwvqR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XcMWqoxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCJSGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:06:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbgCJSGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:06:16 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AHtTuA002400;
        Tue, 10 Mar 2020 11:06:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vLlCKE3WAr0m59sWXWJwXlaSx2AfJH0bQ/ywFOK39D0=;
 b=qZfxwvqRzC+CnXET3TJjAvX8sGj483Nh4gVwS2KebOC9YJbkFeN8yj/hP1SDu5KGKuxo
 2wiE2PYzKEf4wZAlWP1Kb3z5SvJZuMjVT0gA2QZCaydVbRd6FKiDTG2JfMR05UpleBk7
 6Ga9AmuCtsFAXbVkY5e/yHrYOFIq27Uw3Ns= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ypfj4058f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 11:06:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 11:06:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh11QCxKhVBDlLQ09/YNyeo7wtotKZF1f9LNovOIsXFQwOlSS3LEizXo0jcbtJoY40Npf1+UhyckRe56SUnl43MXMGhAdDmVvbQr3DUMkKAYx3rEl5EHaV/Z+i84sFbY3GYeh7oc9F6MJ7Ip9Tka/xUJRG2Imn1poPu8eBzZ7eNMfzAAPZ0qNEZN/dRyq+cWuVZzFAsz/zDj810jzX24IVphQTcdYLWvpEkxoZSrFSbZZhOgs/7esV2Lx+kFRr5tM90Xrw3XU0/pOEydzdFyBgsZRQQkPgUsJ2k5yJmBltwvxTFkVvk4hq2HmmvCkdQDcb6CCUC6R3ENjTY2qCMBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLlCKE3WAr0m59sWXWJwXlaSx2AfJH0bQ/ywFOK39D0=;
 b=kmWuRh8VGFxDVMdWqdd+yPOTRPX/F8r09qI3V5VHGF4PUWb+t3Z5bfa21GKdIZ3B+KITWiUZlXUm4SbMsCTKXtoxoOdNVyaevty258YUBtksmynoj5rwBNZRETPs/Ni4jWB5upeA2/uUCCVc5yaT94qP1SgwW3NTmJchtUukGrzA10aUs4dIlzRpfqFdGfkShDNTIj7niUYMCdJ80kfvYI14gvnhhzfbpyqKaQzDEFwwAab4a5FVj4mNW7dGLyYXnPjOETSAC+oxEcPMbF3Fv9+g4gMVA9uhsazZcS6AETRjs3lZBWr9lJ8JR1Dn3d+MFdCQkzXjjhk4iCfa7X4LYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLlCKE3WAr0m59sWXWJwXlaSx2AfJH0bQ/ywFOK39D0=;
 b=XcMWqoxaxwnonjl/NVMIoTVsmeHnklRo/uBISu/DfaLI24RUoIOQq2dZ6kxh6x4SQvL6YTqOv35R1hC6enwBGA+8Xe5Lpmp+0ATMbLERru0XZp0SAMb9zaZSaIVesslkyGQE+vd/OCSBguT2zmwoAOTDvCxgn3Rla70/DkGsG6Q=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1519.namprd15.prod.outlook.com (2603:10b6:300:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 18:06:02 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 18:06:02 +0000
Date:   Tue, 10 Mar 2020 11:05:58 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
X-ClientProxiedBy: MWHPR10CA0063.namprd10.prod.outlook.com
 (2603:10b6:300:2c::25) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3d1f) by MWHPR10CA0063.namprd10.prod.outlook.com (2603:10b6:300:2c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Tue, 10 Mar 2020 18:06:01 +0000
X-Originating-IP: [2620:10d:c090:400::5:3d1f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd015d2-0769-4b12-afdc-08d7c51db176
X-MS-TrafficTypeDiagnostic: MWHPR15MB1519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1519F07D67C7F6D18DBC2458BEFF0@MWHPR15MB1519.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(7696005)(8676002)(52116002)(33656002)(6506007)(8936002)(316002)(6666004)(1076003)(81156014)(5660300002)(2906002)(53546011)(81166006)(6916009)(55016002)(66476007)(66556008)(66946007)(4326008)(86362001)(16526019)(186003)(478600001)(9686003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1519;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SEe9GgU8tGjnm+Qbj+72SP52fvPXb3fU8wHl8xzGERTrRJXbydO/o4QqIzQ7WqfEipcUl2l5uRmoEOWaUs5WzSFbLcI9nY6TYklis8xgpMh0FvYhMJs1Nu+SSaP5LDrNkw5bx5SqlbUvj6Mh1HnyeFME3xNNUQ3eqqAwyjNjrvEIWDE9cWmfnmRf4CTGbZd8Ifa73YuBXvGD8R7AIvL4HVnNe2Xpgaw2fpvSlCxgnzwUyH4TVt0gw3/A9fThlybFclhc0YocIK5MrEmRImHjjM6kxKd6Xq7t/DzDFopqOEJiBPC5D4wWzapT2FEMF/w3h8aoZlTGh0j8DJ2p/BOiVVUubaucQVMfhcSZ/AxkITf689dOL1k0meOAIogvvoVAJUEfV9Q2/EIrDBWJkdrfnzCbryfvxI78Gxia1F0xVzbWA6KpsNW0qARmCFs5RrE0
X-MS-Exchange-AntiSpam-MessageData: 9Ltjg4BqroXgMSo8jw8HFm3ojFoXEqp1qbNSE+5d4UgnXoZkg7l0JXCA0SsBX9NuUYdIuCpMrMqEF1kVydx3Rk5St2mQYYtk9ZYSnDOrTbgqFyLfSEyd/J5Gmht8HmzP1ddAz19sMjedIJdDFD4fKbZsPO7e+oqSPyGlGoOK6bMbu3wSWqPP4on7Pl1Ij+0G
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd015d2-0769-4b12-afdc-08d7c51db176
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 18:06:02.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9qA8PjYYwJu8Fyv/U0LihdeWgzosQ2rjC1ZeAQYgS90quZWqFpy7Cl8q2lkANhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_12:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=1 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100109
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:27:01AM -0700, Mike Kravetz wrote:
> On 3/9/20 5:25 PM, Roman Gushchin wrote:
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
> > 
> > v2: fixed !CONFIG_CMA build, suggested by Andrew Morton
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Thanks!  I really like this idea.

Thank you!

> 
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   7 ++
> >  arch/x86/kernel/setup.c                       |   3 +
> >  include/linux/hugetlb.h                       |   2 +
> >  mm/hugetlb.c                                  | 115 ++++++++++++++++++
> >  4 files changed, 127 insertions(+)
> > 
> <snip>
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
> 
> I know this is called from arch specific code here to fit in with the timing
> of CMA setup/reservation calls.  However, there really is nothing architecture
> specific about this functionality.  It would be great IMO if we could make
> this architecture independent.  However, I can not think of a straight forward
> way to do this.

I agree. Unfortunately I have no better idea than having an arch-dependent hook.

> 
> >  	/*
> >  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> >  	 * won't consume hotpluggable memory.
> <snip>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> <snip>
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
> > +
> > +		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> > +					     PFN_PHYS(max_pfn), (1UL << 30),
> 
> The alignment is hard coded for x86 gigantic page size.  If this supports
> more architectures or becomes arch independent we will need to determine
> what this alignment should be.  Perhaps an arch specific call back to get
> the alignment for gigantic pages.  That will require a little thought as
> some arch's support multiple gigantic page sizes.

Good point!
Should we take the biggest possible size as a reference?
Or the smallest (larger than MAX_ORDER)?

Thanks!
