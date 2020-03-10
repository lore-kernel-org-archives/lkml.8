Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A537C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19D721D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EPLJkNxY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PjTRHccJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCJTTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:19:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40070 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgCJTTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:19:32 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AJBO79032547;
        Tue, 10 Mar 2020 12:19:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QAWeRZ9RFbzgtTJFaN5Lg5RAxBTA3ANTCXldzjGUFLk=;
 b=EPLJkNxYhGlG2cqdRguuZbAZ+FbxcSkZb7yYZg4vudbkGHva94oZcM6/WTCzLO9RvimY
 PyQ6LDQHrYlLMqIQWCvCDLLJBp6VteQtZKGgx/+1ZRHU14+4DHhJpoe79ivUKIerssYy
 TF4K9RcPJW0SXQsjMjDd7mzUqJjTmMpg3VA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ypfj40hxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Mar 2020 12:19:15 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 10 Mar 2020 12:19:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee1Kd+cW7sfkMBGIUw7CvsLjVcl9auj3NoQNAV61vcJOeQy2qK0GfiOmaXtq9rLDouOvG9vg3umNINxuIL6cnw7lmDPBagfDnvuao1mV+hzzPJ2FnPf84Hxh3yqTYf1FOtUuU+guEn5pE6idc/i/1jYrspc61RS7kL3fTF0Zaks1k5Qyx8SUebktj6qs8NXCbopVaQjwWyRB882USkBlNB6mL/fjI0MKV2LKGYl+eAyv40gf3pGy78dOBOT8T13OYDJTEyJYhbaayhbm/QdnUNK38p+16z1ZrZP15UASf5iTfpgYbh+N2onJnnV2vV1vtCJFW4fxCxpQZeJBC0pinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAWeRZ9RFbzgtTJFaN5Lg5RAxBTA3ANTCXldzjGUFLk=;
 b=Wk8Ba/3wAiQ8jQKM1Tr5OqRkC8QzFCLkqg1TIU3MKBEYU2ATsZFPBUaCwZ1FE6JbcEH2knAyBsyiAeSFY8NGt4wFRERwRk6ZJ8UOHlpgHbOejSBKkqod9yEoGk2fofJ9BNqXq/uNpGx6rXryA/pim26tQ/QBCSdhpv7A0zdDoO1KTimrtOxILqF0Ln7CWHF3D18sgfg18h0tJ4g13kgdkfUeApxBPeyRD5y+M8SvzmESKulBMvoNj2eXjQvkC/JjOQOxymTFAtzXsv2o2nr1giynImBOcwjYQAPERXtaZeEF6u7KpjFhKfjkbP0NTZT7j+1biv8NvpnGuPvWYgBbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAWeRZ9RFbzgtTJFaN5Lg5RAxBTA3ANTCXldzjGUFLk=;
 b=PjTRHccJfPPcrA/QC4pNdm5CnAMihJupk0mEbD5th2K1B9GHgIUNJbJxc/TMMKvufqRmyitf+ZbYdNT9PtnBsHqhzw9nCq7HMCKpqTZ3hJrsXR/ARxHyU7zK9OmvY9sVb+hpUZRlV+CAMaECGEF4b5kjiFVA+B6pcsZDiROIx40=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1903.namprd15.prod.outlook.com (2603:10b6:301:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 19:19:11 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 19:19:11 +0000
Date:   Tue, 10 Mar 2020 12:19:06 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
 <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
X-ClientProxiedBy: CO2PR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:104:3::13) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5cf7) by CO2PR06CA0055.namprd06.prod.outlook.com (2603:10b6:104:3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 19:19:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:5cf7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e220f8ae-556f-4fe5-ed51-08d7c527e995
X-MS-TrafficTypeDiagnostic: MWHPR15MB1903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1903D2F95162DA98240671C2BEFF0@MWHPR15MB1903.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(376002)(136003)(189003)(199004)(6666004)(316002)(8936002)(8676002)(54906003)(2906002)(478600001)(81166006)(6506007)(53546011)(1076003)(81156014)(4326008)(33656002)(86362001)(16526019)(5660300002)(186003)(6916009)(9686003)(52116002)(7696005)(55016002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1903;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M94oiazx9qQwLzx510nUn8RxNB3a5hTy8P6BnJeqdl1ygR9FZOKApcjrEoygTf7iEv03SmhLhQmnRcXDti/URckjsXIhUXFI2RGfaJfZHMAEFu0qAhn7UOsgQTW9P4Mj6lEqm4WP87fVr4Es7oGX+vVSLeZG+JCil+3BRq0GX0VwDTnz0u7mRYKFFSX8+6c0z0zgWd6Nyj2gnD50itugD1+pmU+2W7MbugNdB/J7C2fKUFbrK1YP8WPjLMlXQURo7RKixv+4oQ5yHpDnkWLyuVWGCSY65nKAGNPjzCy5HG9gD3PzZLfhVpDHLmbuuhKDVLqfJuZ09JE3rdT1apfFqq/gjSx1zmrTdqaWFYkd/gg3ukChFshudMqRLbnQM7o1ZPVhoxOhMTljjsVDyiAODJWGvNR3VfdbWYQC/v3E1PYh/4REqW151OW3eD8tq/FU
X-MS-Exchange-AntiSpam-MessageData: i1812DjTV9z3Sl6Jk6ArdjBwlyf15td7Pjp8cIWJ+haHdUG3MwRd9rD5VRZfsgMxS/eTp2PfnwO78v1XqVg5WAQdaS0ziyEqSKT4joXWycRo3KW4HBevd4X45ua69b6FHr2YhksiumP90IR1Hkg6cZ6I00iWZOkcIB9PU0h3e4yHlHL45cxqWZ34CdcPbUUU
X-MS-Exchange-CrossTenant-Network-Message-Id: e220f8ae-556f-4fe5-ed51-08d7c527e995
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 19:19:11.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie5LQqQPxGOZosF+2FKpaRYIxgVAYie86B6J49RHtoZZ3kFfd8m2pdEA0kvoxAi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1903
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_13:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=1 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100113
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:33:47AM -0700, Mike Kravetz wrote:
> On 3/10/20 11:05 AM, Roman Gushchin wrote:
> > On Tue, Mar 10, 2020 at 10:27:01AM -0700, Mike Kravetz wrote:
> >> On 3/9/20 5:25 PM, Roman Gushchin wrote:
> >>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >>> index a74262c71484..ceeb06ddfd41 100644
> >>> --- a/arch/x86/kernel/setup.c
> >>> +++ b/arch/x86/kernel/setup.c
> >>> @@ -16,6 +16,7 @@
> >>>  #include <linux/pci.h>
> >>>  #include <linux/root_dev.h>
> >>>  #include <linux/sfi.h>
> >>> +#include <linux/hugetlb.h>
> >>>  #include <linux/tboot.h>
> >>>  #include <linux/usb/xhci-dbgp.h>
> >>>  
> >>> @@ -1158,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
> >>>  	initmem_init();
> >>>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
> >>>  
> >>> +	hugetlb_cma_reserve();
> >>> +
> >>
> >> I know this is called from arch specific code here to fit in with the timing
> >> of CMA setup/reservation calls.  However, there really is nothing architecture
> >> specific about this functionality.  It would be great IMO if we could make
> >> this architecture independent.  However, I can not think of a straight forward
> >> way to do this.
> > 
> > I agree. Unfortunately I have no better idea than having an arch-dependent hook.
> > 
> >>
> >>>  	/*
> >>>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> >>>  	 * won't consume hotpluggable memory.
> >> <snip>
> >>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> <snip>
> >>> +void __init hugetlb_cma_reserve(void)
> >>> +{
> >>> +	unsigned long totalpages = 0;
> >>> +	unsigned long start_pfn, end_pfn;
> >>> +	phys_addr_t size;
> >>> +	int nid, i, res;
> >>> +
> >>> +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
> >>> +		return;
> >>> +
> >>> +	if (hugetlb_cma_percent) {
> >>> +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> >>> +				       NULL)
> >>> +			totalpages += end_pfn - start_pfn;
> >>> +
> >>> +		size = PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
> >>> +			10000UL;
> >>> +	} else {
> >>> +		size = hugetlb_cma_size;
> >>> +	}
> >>> +
> >>> +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
> >>> +		size / nr_online_nodes);
> >>> +
> >>> +	size /= nr_online_nodes;
> >>> +
> >>> +	for_each_node_state(nid, N_ONLINE) {
> >>> +		unsigned long min_pfn = 0, max_pfn = 0;
> >>> +
> >>> +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> >>> +			if (!min_pfn)
> >>> +				min_pfn = start_pfn;
> >>> +			max_pfn = end_pfn;
> >>> +		}
> >>> +
> >>> +		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> >>> +					     PFN_PHYS(max_pfn), (1UL << 30),
> >>
> >> The alignment is hard coded for x86 gigantic page size.  If this supports
> >> more architectures or becomes arch independent we will need to determine
> >> what this alignment should be.  Perhaps an arch specific call back to get
> >> the alignment for gigantic pages.  That will require a little thought as
> >> some arch's support multiple gigantic page sizes.
> > 
> > Good point!
> > Should we take the biggest possible size as a reference?
> > Or the smallest (larger than MAX_ORDER)?
> 
> As mentioned, it is pretty simple for architectures like x86 that only
> have one gigantic page size.  Just a random thought, but since
> hugetlb_cma_reserve is called from arch specific code perhaps the arch
> code could pass in at least alignment as an argument to this function?
> That way we can somewhat push the issue to the architectures.  For example,
> power supports 16GB gigantic page size but I believe they are allocated
> via firmware somehow.  So, they would not pass 16G as alignment.  In this
> case setup of the CMA area is somewhat architecture dependent.  So, perhaps
> the call from arch specific code is not such a bad idea.
> 
> With that in mind, we may want some type of coordination between arch
> specific and independent code.  Right now, cmdline_parse_hugetlb_cma
> is will accept a hugetlb_cma command line option without complaint even
> if the architecture does not call hugetlb_cma_reserve.
> 
> Just a nit, but cma_declare_contiguous if going to round up size by alignment.  So, the actual reserved size may not match what is printed with,
> +		pr_info("hugetlb_cma: successfully reserved %llu on node %d\n",
> +			size, nid);
> 
> I found this out by testing code and specifying hugetlb_cma=2M.  Messages
> in log were:
> 	kernel: hugetlb_cma: reserve 2097152, 1048576 per node
> 	kernel: hugetlb_cma: successfully reserved 1048576 on node 0
> 	kernel: hugetlb_cma: successfully reserved 1048576 on node 1
> But, it really reserved 1GB per node.

Good point! In the passed size is too small to cover a single huge page,
we should probably print a warning and bail out.

Will fix in the next version.

Thanks!
