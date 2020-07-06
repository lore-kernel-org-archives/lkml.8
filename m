Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580F1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27889206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZMFPEHFg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="faif92X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGFX1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:27:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49534 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726280AbgGFX1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:27:51 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 066NKlCf002548;
        Mon, 6 Jul 2020 16:26:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+AkeFm48G9sztMNU2Hy2ZBeG9OBRanf23KlNxDlwvoo=;
 b=ZMFPEHFg5z5AMaXDIGpkIBXAxLYO1AcnhxRr3BWL848n2FK+UrxrOOxEJxc6bi3M4XRV
 cFWNihgk/bbvP4BiKQpSI0FlDFIyWTkrqPao4O8DYJgVvFa/VdWU0MCJIrlEFvh6QvId
 vrkzhPElWNj/QS5qOw5XfJFd0fUVQ/2vquM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 322n90htj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jul 2020 16:26:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 6 Jul 2020 16:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIrUIRmqdWARuZjHxyTh/jUsQQA0CMG9IZJFKzmDslO2vjST75OxYDtnJV7WHkXNACgK2SR4oy0Mslv0t3Cp9vU8oRYiSh0AAQYtziWeYGyQkCsgX+dpfNchCMoUCqAS8FFvP4ukeM02czftJ033TxP6v3eRjk9XAeFoki9kPoqFU6R2q5m5BGhdveOn58/IHkNlPpyvj085wr/pGYpxiNjfEsM5qwe+kFwWd6yBiJk2lZ0b/1LcI4MrUvW4Z9bL42YPUu9K4ycVIXzCqHZi7Hgb6cQaEjn4Lo3tZaocGG6RaxmkN/AuUR4iOYs9VXgQv4oqVjy/DFbnegts8Fx6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AkeFm48G9sztMNU2Hy2ZBeG9OBRanf23KlNxDlwvoo=;
 b=Ct7o49Xdc5pKFnkp3H9TWMQ0gppjwG4MpjG2Cllz6C19AGzK9PS3PExTr22uX1Stq5q5amLoYP0BNU+Z72c/EeIQrd+o3c5FpFX0pQcbOpgI3LCFtk3zLaBZnUtd/vbzjCSdxT/8P4JPWZzvm8SrG1xLQBHfiTJcSVdrjDZLPkE7FB6FM86/luNPZm+GOlj0jNRX66E2rgPa6SVQ3tAm6gJXIUzqwtDvhVp15bxqLuPRftQBrasFz07LJyjO+Z+E8BrlM/FgxPyHB28h6HEJOAnaWR303LbwC58Hqg3cM0jO9YN9vW4RbzSha/w/dzF0SI9NDKER2m1EuqNOoklZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AkeFm48G9sztMNU2Hy2ZBeG9OBRanf23KlNxDlwvoo=;
 b=faif92X3WZR+RkY9raP7H2HRpJy6lh3GvYGLM/uTtbSsaCvBQQu8iUhH+r3Rh3BDeycB6vjHD835MXaiYO/5/ezneezgSsWFpCJw3uPT7Je/9COOAwLbqfzuV9aFUTCn4BNAsShDZoRalf09eHqyS5M2sqngb798ZzzLRWJkcI0=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2632.namprd15.prod.outlook.com (2603:10b6:a03:152::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 23:26:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 23:26:05 +0000
Date:   Mon, 6 Jul 2020 16:26:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] mm/hugetlb: avoid hardcoding while checking if cma is
 reserved
Message-ID: <20200706232601.GA156963@carbon.dhcp.thefacebook.com>
References: <20200706084405.14236-1-song.bao.hua@hisilicon.com>
 <20200706214808.GB152560@carbon.lan>
 <B926444035E5E2439431908E3842AFD2559717@DGGEMI525-MBS.china.huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD2559717@DGGEMI525-MBS.china.huawei.com>
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2db9) by BYAPR11CA0088.namprd11.prod.outlook.com (2603:10b6:a03:f4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 23:26:04 +0000
X-Originating-IP: [2620:10d:c090:400::5:2db9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7277ae11-1c38-4a0c-fdbb-08d82203f422
X-MS-TrafficTypeDiagnostic: BYAPR15MB2632:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2632175B7CA5C4C2E8122A10BE690@BYAPR15MB2632.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lotsDKBvfgO7bGjpmmU7zCgfeEQuZPxYLVj6kFa/zMy8E1nc2cJK1G+B+TZ7jeAld/XZUP2ZJerZ7gbX0pHk/Oc4vaxE2Nd93Nw46JViWwNb2zME65EWj900LHRDeTnPb0sKthXD4nqACRApM+7n0P524wIAudyNlkFgdVXnRlK630XYHXQqY2Ac+/RFwDK+EDpbXzjNAxvKS8mltYBYhZ5bnGVGQxlXYsJqHl1heFr0144dHiy81GdV5z+64ymx5rIzagMoNEDjXl0MFJ/dR30CzeSgLryv3MvFtJTUXIiYo2ulyWm7NaT8GF3WiUT0qUk6L8SSp8gbx+fWi5204A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(366004)(396003)(136003)(55016002)(6916009)(5660300002)(6666004)(2906002)(16526019)(316002)(53546011)(186003)(52116002)(7696005)(6506007)(54906003)(4326008)(8936002)(86362001)(8676002)(478600001)(33656002)(9686003)(1076003)(66556008)(66476007)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oO+tBVogqKU8N01BeT3Iw2XXYZFnYU7OscZ8fszSMH6A77HrvqHYAqo2D4OWvVjx2v/6D0tRCRdqAzbaFHlCwwpPSP6FAxyB3cQOWEpCDKhmocbjcQW0pPccKDh+RrC9FqYXRkBUSJxBBX6vukgeiXOJs83Q4cILYJQKqWofSe8Bqq2mZz6q+YTob8+H0RRSA1opOCRYioPXg54zgCJIo6dTbaaGnrolnGA9oNgHT6238xhc9k2SqWDEyfwVRUj/5cXcjGDWHchLBVztI+Y/XwBC0MIW26lD+q1LkXW53nhmhyj8VGTapfMcCTLeKLC3092t0G45RDtfvMWqWHgXRZty1boPbHLmV5PYJKlH4mVz6AFxRbfJrnbD6V9lPFESqjp+61HZqzel2YfTsOwk/gCnvEYgNP83G6wgs/csfN0KVMXAaBg+o0PZSnjLHAT9CqQYtTkzzVgJxkWdTNnip9GcQgRIQtdpE3380wh9vcp6CXM2s+yL/YreIXYbCo1I
X-MS-Exchange-CrossTenant-Network-Message-Id: 7277ae11-1c38-4a0c-fdbb-08d82203f422
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 23:26:05.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1xnAKPOs2LHxqA9mqo0jqpfy9WtXEN5jckLokEy/BGqekDrOIxCfoDuzdXr6kbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_20:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=1 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060162
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 10:30:40PM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Song Bao Hua (Barry Song)
> > Sent: Tuesday, July 7, 2020 10:12 AM
> > To: 'Roman Gushchin' <guro@fb.com>
> > Cc: akpm@linux-foundation.org; linux-mm@kvack.org;
> > linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Mike
> > Kravetz <mike.kravetz@oracle.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>
> > Subject: RE: [PATCH] mm/hugetlb: avoid hardcoding while checking if cma is
> > reserved
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Roman Gushchin [mailto:guro@fb.com]
> > > Sent: Tuesday, July 7, 2020 9:48 AM
> > > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > > Cc: akpm@linux-foundation.org; linux-mm@kvack.org;
> > > linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Mike
> > > Kravetz <mike.kravetz@oracle.com>; Jonathan Cameron
> > > <jonathan.cameron@huawei.com>
> > > Subject: Re: [PATCH] mm/hugetlb: avoid hardcoding while checking if
> > > cma is reserved
> > >
> > > On Mon, Jul 06, 2020 at 08:44:05PM +1200, Barry Song wrote:
> > >
> > > Hello, Barry!
> > >
> > > > hugetlb_cma[0] can be NULL due to various reasons, for example,
> > > > node0 has no memory. Thus, NULL hugetlb_cma[0] doesn't necessarily
> > > > mean cma is not enabled. gigantic pages might have been reserved on
> > other nodes.
> > >
> > > Just curious, is it a real-life problem you've seen? If so, I wonder
> > > how you're using the hugetlb_cma option, and what's the outcome?
> > 
> > Yes. It is kind of stupid but I once got a board on which node0 has no DDR
> > though node1 and node3 have memory.
> > 
> > I actually prefer we get cma size of per node by:
> > cma size of one node = hugetlb_cma/ (nodes with memory) rather than:
> > cma size of one node = hugetlb_cma/ (all online nodes)
> > 
> > but unfortunately, or the N_MEMORY infrastructures are not ready yet. I
> > mean:
> > 
> > for_each_node_state(nid, N_MEMORY) {
> > 		int res;
> > 
> > 		size = min(per_node, hugetlb_cma_size - reserved);
> > 		size = round_up(size, PAGE_SIZE << order);
> > 
> > 		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
> > 						 0, false, "hugetlb",
> > 						 &hugetlb_cma[nid], nid);
> > 		...
> > 	}
> > 
> 
> And for a server, there are many memory slots. The best config would be
> making every node have at least one DDR. But it isn't necessarily true, it
> is totally up to the users.
> 
> If we move hugetlb_cma_reserve() a bit later, we probably make hugetlb_cma size
> completely consistent by splitting it to nodes with memory rather than nodes 
> which are online:
> 
> void __init bootmem_init(void)
> {
> 	...
> 
> 	arm64_numa_init();
> 
> 	/*
> 	 * must be done after arm64_numa_init() which calls numa_init() to
> 	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
> 	 * while allocating required CMA size across online nodes.
> 	 */
> - #ifdef CONFIG_ARM64_4K_PAGES
> -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> - #endif
> 
> 	...
> 
> 	sparse_init();
> 	zone_sizes_init(min, max);
> 
> + #ifdef CONFIG_ARM64_4K_PAGES
> +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> + #endif
> 	memblock_dump_all();
> }
> 
> For x86, it could be done in similar way. Do you think it is worth to try?

It sounds like a good idea to me!

Thanks.
