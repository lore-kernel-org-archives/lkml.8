Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CD02065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GdWFJO3q";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FrRzWPd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGHSsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:48:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25038 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbgGHSsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:48:07 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068IYBkN017393;
        Wed, 8 Jul 2020 11:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DImYospgzoZHQr9Y+r0Vx0+UpNhAp0vw55eHaUZHCFg=;
 b=GdWFJO3q8e3xbh4b5fZnaJGAe3oUEkwyh/nQlfMyxHCMIu98Yx63bFd7RGOX8j3oKG5F
 pIZPJDh86WBig5x6vseqYfQIRAc2bGgBO9PgJ0AIMT74Lo/M+2VYbFFI8oJxPOJOTW9D
 oRKmY578l33AVKMoR+z1j48ldvG4frHqLFs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 325k288bng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Jul 2020 11:46:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 11:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muuPhDpa9uclXXfbaalo36cR3vj7+BTz/yPs3k3eRtO9r+LbsETGGfMv42k6sdUn/NkLZnQPojLIFH61ruOh6hNPwM7Qp9ajmhhJ/WjxueNkIVXfy+yIknPfxZu0ItiiaVzwUU4Oi9NSmNhX8oQWUNCnNL64HaQsRKeVNcZgnYXNO+9WRHEgyM9B6YI6ZbZEm/jqUIR2WrjGDHF9k28DJzawonmNT41IJoc7B1fODrI2EGfw5AXwidcXeuPQIIcKhkyDeuCl4hBUTRQTFDkng1th2RpCItY0XSJTmKg+fQqcVrh7L2TU9bDYsVRD7aqYGyWhgu/qbw4yN2sV7jizlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DImYospgzoZHQr9Y+r0Vx0+UpNhAp0vw55eHaUZHCFg=;
 b=V0khlsDmdPhNI9YKpxS2z6BjlzORkP2Oi2YT7y9RQSPWnqaAh2ONH8j1zSU9yOPCz+Ly36CLyHyPQHnxJS/r91wM5ry+IEOAhlwfLzV7/SVFvU2GS+P3VpDlR2zgO0HW8gQsRqQmjqiBlbjZrbGP3ozSo/e3BhpkanWyAzVRS2ZJ1mwr/vNAGdEF2lIqCVJcTXuuLOd9Bmt8E27Ogj6nEVJu0Vu1ZVNMigdcWTrZWZmEm3flK4PqDQ7Kp9+gb8KvpPWtmNus+4stpx2wZGetiOMXzGw+yUOmbvrA2PPxceE1Qb2aZ/B5SkpuunGwQHDAG0PqjbzayVq+G+gC1J0xSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DImYospgzoZHQr9Y+r0Vx0+UpNhAp0vw55eHaUZHCFg=;
 b=FrRzWPd+R99Dmja0JBOMhX0PczM652DWKSF4X3aAq02wcQSjS2z1nDkFvPB/7rBnMxqL/H0zHUaL90tnCeoeevIN1jx+D5sAVTSZq7UY7WF3FMc0RZvttYXzDkE0ZmtlhKoH/n06h/z0zdUdN6rsHHWrK9/9MZ86CneaC2Wwjj4=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2391.namprd15.prod.outlook.com (2603:10b6:a02:8c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Wed, 8 Jul
 2020 18:46:18 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 18:46:18 +0000
Date:   Wed, 8 Jul 2020 11:46:15 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma is
 enable
Message-ID: <20200708184615.GA251665@carbon.dhcp.thefacebook.com>
References: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
 <20200707125641.dbd2ccd63f525aa5870069d8@linux-foundation.org>
 <9066e009-5ed2-1992-d70d-fd27b4bf5871@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9066e009-5ed2-1992-d70d-fd27b4bf5871@oracle.com>
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:9af9) by BY5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:a03:1a0::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 18:46:17 +0000
X-Originating-IP: [2620:10d:c090:400::5:9af9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c01bf8-cc9a-475d-2d6a-08d8236f3315
X-MS-TrafficTypeDiagnostic: BYAPR15MB2391:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2391A9AF9E19D733FB1CE240BE670@BYAPR15MB2391.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQq5v4ojO42IHsB9AKe7N+/OGb6rBoCnQ7ge/EDxAcvQaD0+AoWZXqcSdHnbJ64ma/0NDB1jVUzBAn4LbiqFQEFDumEZSDkdtg1BC4D61JdZmAi7bod6aDgHj0fqTUEDwNS0XxFuJEdbLSlySspQnGQXQ+muXlBBK53WtybyGdpdEgn8JakNFZAFaRf2x8QKqRH17TUb2aTOzPGzBOCTqVgX6gIUobvH+SvBtX5kSAKQdlZFJ8iEWKZmKrKDzooy7hJ38gFM5UCjiHd3anm/y3sQAnw6w0h3KVVm6Kl1YaDcr4cbsXy6QG1VnQdq9bNvhAUppwsymJzKGc8rU6zEFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(376002)(396003)(39860400002)(83380400001)(6506007)(5660300002)(316002)(54906003)(478600001)(33656002)(6916009)(66946007)(7696005)(52116002)(66556008)(66476007)(8676002)(8936002)(86362001)(53546011)(55016002)(9686003)(1076003)(4326008)(186003)(16526019)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: D0sRMcKokzs8OdkCQ4BHjPmRp81vmEBvsSPqClxE8mP/BFqq7i2v7mybKhFXHMk7vvSqRwsdtoTQbSnI2EEGNEfbPhc3qOcoCtcQH7LANJDw21zoCJIWZlyeCxbUNPzfSkzuABmvPF79Qo5HkzPACDoNn0Bq20Ch/8CPqjU50FXkncDintG8UkDxpo1M7zrpliWb47Ui+LETkE6RyIQA5zAhJWLThSFPIVTu04opAq6/Dgf+5675/dSpQRZ9E3GEfW5NCHS2WkmCnaY0Wj86qsTpDEVENEM3gB85kKbeBTNtQJa6uhSCYOdQabhY6/HcPlUllU8XlvmDCd1ld3V03ETNzfK0ClOGBhI97t84VNUnF1yOLKJBL/o98s++x2q0rFDT+FeP2GhQYsjyxAfZ805NVWTSnagiq+Ry9NRftonmUzxp9IyTJ2KmTfXi2mqik3IbQLBuDTADI7+UVZssP5jKABfVk8Eh25e8OYwtBe9bcL/cxFOl0J0LlBB6brdNqqKFnGKn/M/RzCzqkbWa0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c01bf8-cc9a-475d-2d6a-08d8236f3315
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 18:46:18.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8itNt3e9Q+wX2v+/jnTiC+mhQltaw0ISaeYZsF8mzUX36yMYg7TBkBZuYeNKpUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2391
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_16:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=1 mlxscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007080114
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 10:45:16AM -0700, Mike Kravetz wrote:
> On 7/7/20 12:56 PM, Andrew Morton wrote:
> > On Tue, 7 Jul 2020 16:02:04 +1200 Barry Song <song.bao.hua@hisilicon.com> wrote:
> > 
> >> hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> >> no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> >> enabled. gigantic pages might have been reserved on other nodes.
> > 
> > I'm trying to figure out whether this should be backported into 5.7.1,
> > but the changelog doesn't describe any known user-visible effects of
> > the bug.  Are there any?
> 
> Barry must have missed this email.  He reported the issue so I was hoping
> he would reply.
> 
> Based on the code changes, I believe the following could happen:
> - Someone uses 'hugetlb_cma=' kernel command line parameter to reserve
>   CMA for gigantic pages.
> - The system topology is such that no memory is on node 0.  Therefore,
>   no CMA can be reserved for gigantic pages on node 0.  CMA is reserved
>   on other nodes.
> - The user also specifies a number of gigantic pages to pre-allocate on
>   the command line with hugepagesz=<gigantic_page_size> hugepages=<N>
> - The routine which allocates gigantic pages from the bootmem allocator
>   will not detect CMA has been reserved as there is no memory on node 0.
>   Therefore, pages will be pre-allocated from bootmem allocator as well
>   as reserved in CMA.
> 
> This double allocation (bootmem and CMA) is the worst case scenario.  Not
> sure if this is what Barry saw, and I suspect this would rarely happen.
> 
> After writing this, I started to think that perhaps command line parsing
> should be changed.  If hugetlb_cma= is specified, it makes no sense to
> pre-allocate gigantic pages.  Therefore, the hugepages=<N> paramemter
> should be ignored and flagged with a warning if  hugetlb_cma= is specified.
> This could be checked at parsing time and there would be no need for such
> a check in the allocation code (except for sanity cheching).
> 
> Thoughts?  I just cleaned up the parsing code and could make such a change
> quite easily.

I agree. Basically, if hugetlb_cma_size > 0, we should not pre-allocate
gigantic pages. It would be much simpler and more reliable than the existing
code.

Thank you!
