Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED06CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6055206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p0e8gSt3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XPPiIR00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgF3TLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:11:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56782 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbgF3TLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:11:00 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05UJ5utj020272;
        Tue, 30 Jun 2020 12:08:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zODMjdsLQ/CLlx5SK3PLZZDepHK8jE3QBzRUfmmzem8=;
 b=p0e8gSt3xsig1ZkMMBOyWCkJSNvxfLPDuwDQAnsgoQ1UL39v/CYPVlvXr4nZG+3bQyzv
 AK9kGj7nwx/m8IZndYeOYsq7CKaJzyGRxaMtr458LklI+mUE7yVZQ3IqnBEVJoeUhgLe
 /zPruclA55pOiVNkNDu5ttFUnjmLqumrNLE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 320anf06fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 12:08:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 12:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdFoq4A5NKr1P+2X12nVPVQPWwzuKElpq95u81IT5DU8+kcKsFD3nmHk8EELoVpn7Y4O3eAIqKs9v3CS4vwGAVBcfw+3c11E4ECGY3O94tSvqQNyDs9NDdeRf+ji3EBk4ppGHbwVOE5o210lJ8Dz0sBqzoiu3R/HV2S+3Xc5lJJtf3jF+i+wgrle4mqM9Xr5CLMb7iXCC8mFTgTT0gJknaJw/nu1Xj5t3cz97g/YVLlkt2zwihHcPu/mAhHYimtnRUMPc677M52QHpRV32dVSWPOMXVAUCKfIXZ4Jz+C9PAzQf2psnoa5t2au6TAx6OLHxD4k0S/IHgB2aIEjqs9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zODMjdsLQ/CLlx5SK3PLZZDepHK8jE3QBzRUfmmzem8=;
 b=fOU6/aTFubXT3HojeUz1Q9DYGFLoknN3+pREBm+rjnPXQ01ac5sVYro8wxKTpHfYLQ23PFFd3IwOwqeRdDzGVDzQUJ7cBklauoF5fDebIf4oCTKG/yF2K+222V5EpgHBYxwemltb17RzzhlRKYq23T4W6KNLZkcPTLf0c0wIzCIN41PmAYXxjRTZFopTshOXjGIxQ5pWKP8roc2eQgVMwJkhk2kWWPSlCSDpHfA0KlhN+Iwt9q3RVSX7ygZ/n1WzgsJUmFH1fQpqAwO6Q++SxkzBLORTfJj4aNP48XAiz07MGY5auL1Yha6jhp4IMBocAhGtnJ5do6RkOUZr+0QRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zODMjdsLQ/CLlx5SK3PLZZDepHK8jE3QBzRUfmmzem8=;
 b=XPPiIR00tJIzisctGtUxtaYIHIMFN/yUBLbDjcpYlayliYIlRESUpjNd+1CrFkR3W6S5w+4ifZ6X/Bjp3zyg7tBYiy5JUOMAIAGiNzYCfaz/iaRHvWbhUE1bd36NMDcL4nWc0MTJfuz7lp9Ni6OgPQAOiVaQjPJ5M31jKb9N7uE=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2984.namprd15.prod.outlook.com (2603:10b6:a03:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Tue, 30 Jun
 2020 19:08:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 19:08:28 +0000
Date:   Tue, 30 Jun 2020 12:08:25 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mm/cma.c: use exact_nid true to fix possible per-numa
 cma leak
Message-ID: <20200630190825.GB37586@carbon.dhcp.thefacebook.com>
References: <20200628074345.27228-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628074345.27228-1-song.bao.hua@hisilicon.com>
X-ClientProxiedBy: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c1f6) by BYAPR07CA0105.namprd07.prod.outlook.com (2603:10b6:a03:12b::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24 via Frontend Transport; Tue, 30 Jun 2020 19:08:27 +0000
X-Originating-IP: [2620:10d:c090:400::5:c1f6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdfde2e0-e790-44bd-d3d0-08d81d28f8d3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2984604F64A9CBEA1FC91BC8BE6F0@BYAPR15MB2984.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZaUJ2RQ7FHGSl4kGOVRhX1qdKWJ0FlW0Jrohi3rJsxGYEf0UXMi/ypY5xN1NCjSNTXwAkul81IKJoYP2t6iZOsGd7iac0BTM8mm8PktJzKw9WcYlzii4Pfy0vOefJv3O446KnSHwooA9Dc/oTPeQseTE8ApJEscpveoOUaeUqOdOKTEOmqfV0mWNj9CMZbwoS1lrz/nnSwQ30e+jwf4IaB/SZzU8Y7gmaEUWV/8laZmVdsoDJ7tQmPxioEyfEKd/jvDzR2Gj9OOV9iFW0YryBcYLGvF9doOtNerboeNbL8QtJVsXGtcKZxR0z2fv39Y/wSv5RMsh8VIOBk9JmflhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(39860400002)(376002)(136003)(55016002)(186003)(6506007)(1076003)(9686003)(83380400001)(54906003)(6916009)(7416002)(52116002)(478600001)(7696005)(66946007)(2906002)(66476007)(66556008)(8936002)(16526019)(4326008)(86362001)(33656002)(5660300002)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QJMN1dfPM8G9X+0A213YaeKsnomLNaiTa06thZJf+6f6+fuV/4a4UZA1PYF61lmKmLI2vMg+rBWUHxtOlQFB4+Gl4bvpmKQJqwZ6o2fl9nEDsYYCwdx9jO+AsGnsPkX8NtnLYBtXSTIUmJ+JVWsQWkf1DABUeY4k4PObEpGOV46I1xPfw/R8QYEbE42eAj2NmTBo0FGy5os/sKjvbRAkgwWDRZhsldWUToLP1inKCi5LrRTLa07wT43zUAKoZknpeanPXT5sehTtpagzJ6N4n+p4YEzVrI4JR16g6tbB2ZJsQdK64XfwScsHnaQPu+BmaGfg9aqt38SOZoKDAOeQMyPCvmo1nFbrfPiQwbnngWYBdswcgR04v0qpuajgNk/fnUjIqO/jMUvDXxKtxE0n3CVa376+pP0fksZQxtIov5wNB3lEqk/zjtCBmnh807ZBDhT27EmMOjtZ8wlr+K3DwfSqLXGfSRDSb04rB/CkRHTqL6vuv+m0VS0oNzOuK756Ui0SfmcNNZ0UDRt5sMDQ4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfde2e0-e790-44bd-d3d0-08d81d28f8d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 19:08:28.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw0PvlCUU1de3tOh7QVi1bOeW4kNhtOWaodzuthcdrdd0pqN3/agq691daPKPJro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2984
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=5
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 cotscore=-2147483648 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300129
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 07:43:45PM +1200, Barry Song wrote:
> Calling cma_declare_contiguous_nid() with false exact_nid for per-numa
> reservation can easily cause cma leak and various confusion.
> For example, mm/hugetlb.c is trying to reserve per-numa cma for gigantic
> pages. But it can easily leak cma and make users confused when system has
> memoryless nodes.
> 
> In case the system has 4 numa nodes, and only numa node0 has memory.
> if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
> for 4 different numa nodes. since exact_nid=false in current code, all
> 4 numa nodes will get cma successfully from node0, but hugetlb_cma[1 to 3]
> will never be available to hugepage will only allocate memory from
> hugetlb_cma[0].
> 
> In case the system has 4 numa nodes, both numa node0&2 has memory, other
> nodes have no memory.
> if we set hugetlb_cma=4G in bootargs, mm/hugetlb.c will get 4 cma areas
> for 4 different numa nodes. since exact_nid=false in current code, all
> 4 numa nodes will get cma successfully from node0 or 2, but hugetlb_cma[1]
> and [3] will never be available to hugepage as mm/hugetlb.c will only
> allocate memory from hugetlb_cma[0] and hugetlb_cma[2].
> This causes permanent leak of the cma areas which are supposed to be
> used by memoryless node.
> 
> Of cource we can workaround the issue by letting mm/hugetlb.c scan all
> cma areas in alloc_gigantic_page() even node_mask includes node0 only.
> that means when node_mask includes node0 only, we can get page from
> hugetlb_cma[1] to hugetlb_cma[3]. But this will cause kernel crash in
> free_gigantic_page() while it wants to free page by:
> cma_release(hugetlb_cma[page_to_nid(page)], page, 1 << order)
> 
> On the other hand, exact_nid=false won't consider numa distance, it
> might be not that useful to leverage cma areas on remote nodes.
> I feel it is much simpler to make exact_nid true to make everything
> clear. After that, memoryless nodes won't be able to reserve per-numa
> CMA from other nodes which have memory.

Totally agree.

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Aslan Bakirov <aslan@fb.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andreas Schaufler <andreas.schaufler@gmx.de>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Joonsoo Kim <js1304@gmail.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  mm/cma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index b24151fa2101..f472f398026f 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -338,13 +338,13 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>  		 */
>  		if (base < highmem_start && limit > highmem_start) {
>  			addr = memblock_alloc_range_nid(size, alignment,
> -					highmem_start, limit, nid, false);
> +					highmem_start, limit, nid, true);
>  			limit = highmem_start;
>  		}
>  
>  		if (!addr) {
>  			addr = memblock_alloc_range_nid(size, alignment, base,
> -					limit, nid, false);
> +					limit, nid, true);
>  			if (!addr) {
>  				ret = -ENOMEM;
>  				goto err;
> -- 
> 2.27.0
> 
> 
