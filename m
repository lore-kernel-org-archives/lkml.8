Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2E206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f0NM/Pko";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FCUm5Qy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgGFVtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:49:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38108 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgGFVtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:49:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066Lkovo030575;
        Mon, 6 Jul 2020 14:48:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=G/nZGai0gzk7QV/WWcDpecddOMckcLD7SjtbEUobHNQ=;
 b=f0NM/Pko+wlScm0YIaGBF3h8qypWFqFz7DRAspauI5O25GkHX0lQ3td9u7eMRaXKpCfw
 RDER4fzYQ+BDyh0ixCby15jNuztZA3OQoPMPw6RthXVT2aty08F+JbH/bin3GFV0nYeR
 0iTmqQlNUcVrhoSoWgjoNlkuNU5DyyykY1M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3239fnpkgw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jul 2020 14:48:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 6 Jul 2020 14:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6FEhdUeIjHaDbZa+3+wIHO1XucUGR0V3Zp3KYH05V6GTraCV1xEIRjQ5n4l0ET0kdWmhHP4a/cYzWvlQJBp6+wUVhpQTDV8If9Z50bg7TqEMISmh9ih3tFuqEfj1A/E+6ApSscw4u6N0atNkzGxWMyC0vtOzeOxKlj5asxFVgi5uwLLMAnPAMdAwBBcIqlqCtArg1j7MadyBiqhj2OLI4uENQv+N04bxRnYJmXA/seTfO/PXHUO1E08cndKsWOpRP6SM64Nc42Ek/mODH/vIivYI2sGt/iL7ilLCf04EowaZD67FOlmIZxbPIpfcXPyckr4xWsrPxQQHbLBwsSuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/nZGai0gzk7QV/WWcDpecddOMckcLD7SjtbEUobHNQ=;
 b=BV4SA6vIahMwxAWEB2i86wbkxK+iWqr+tGYkLiLDM70fzl/3j4YY+Jql+9pmZwGBdhVySnZYcRBH7GM+svbnuTfcawbiKW02p9ABk5E0o34ZNv1lqFS2MlRxzRW3MVJbQ15F4DAP6R4fL1ajPAea46nIYzr4JsPTBoI7jxcWneINH/yJLDccsx2OlAdFHXbJxv11VDE9GXYq79VlTIpGc7jQVHON1CohxQxT6/vMVM/Rtg/XLiBD/wmHGZZDNEEyt98n8sBFAp6rpRJgaXtuEb6RQg9pX5Hf7/4SMQL4UvPBdUkucos9p6lw07J/x/5RUpsZ7Qq0bfD3zQ+mT0c4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/nZGai0gzk7QV/WWcDpecddOMckcLD7SjtbEUobHNQ=;
 b=FCUm5Qy/lbdF+Ga1He+d0Z/0rNiCFR+SYmW3kd03+6fNQZn9N1ozBmbJSByFcFplmdUqTTCmgDegov1/LNy5BQ8ax2Q/WPxLpwieOf6dxVwGlOwTrK3BF7TtN0OQoAN7Flj9xEVKZwWR6llimprUa8grtYlzXWoIylqnuXiqALg=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3477.namprd15.prod.outlook.com (2603:10b6:a03:10e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 21:48:11 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 21:48:11 +0000
Date:   Mon, 6 Jul 2020 14:48:08 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH] mm/hugetlb: avoid hardcoding while checking if cma is
 reserved
Message-ID: <20200706214808.GB152560@carbon.lan>
References: <20200706084405.14236-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706084405.14236-1-song.bao.hua@hisilicon.com>
X-ClientProxiedBy: BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:b17f) by BYAPR01CA0061.prod.exchangelabs.com (2603:10b6:a03:94::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Mon, 6 Jul 2020 21:48:10 +0000
X-Originating-IP: [2620:10d:c090:400::5:b17f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b378577-6d24-442a-0888-08d821f6472d
X-MS-TrafficTypeDiagnostic: BYAPR15MB3477:
X-Microsoft-Antispam-PRVS: <BYAPR15MB347776CDEF016D1C4C4E65EEBE690@BYAPR15MB3477.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMhps0BS2gHz/oj/TC7gn58SMpzWfJc/OaYFpIXSpVQVWw4C3UOJ0t6EPtRVsB45zTacI0Z+0mMoE0MbzipV7g0RtYyWiIgrnFPwuAxyREnBZYOhKTpyw7oAQoaULrToeHNCgD5CzN1iAGREIx0FwR2uTS2pls8KUM3fjNKs8Sar8ScfuFH3TKauRo6pHNpLmDPkoIKRQikBQ0mAX5jg2x0g2vOdHDVQqfWGHrKFVKJbBEL5N1W9UAqIL77ZKROTLEi10QfKjYrX/Tt1yM2hakj4qL3mFQuZ4/f8sYgToW69XFu4ImkqWCe/1uo8zWVgpexLkIaukPfZRzu709K+jYCXjCPal+xEMTRjNujzJa56uiexPgxtql/sQahIwLpd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(8936002)(5660300002)(9686003)(66556008)(6506007)(66946007)(33656002)(66476007)(52116002)(7696005)(1076003)(55016002)(36756003)(4326008)(83380400001)(316002)(8886007)(8676002)(86362001)(6916009)(478600001)(54906003)(2906002)(16526019)(186003)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nssd1X87wegzA0zXi9UbGxZ1sSL9OjwXKATtDE2BJwsRZN/SFWQGErHaPYIWDFziYXc7wGIHNQHIEbQ5P0GWGivd52M0VMD9+zVB3Q28V6jW7/aXWeDJawvlyH79qo8BADcSUVBzC7jPgXSyfQJQH31EJX/yUpZ5Yif7N0ua9wjp5lt8YeUp9Nuq9bRxfZq2kZNniB2pRHZIjOzMIKqtrfetFj38oyViFKlPQoYBuezMx4tETS3zM6RUz/5K63g34BjU6bB3UhcShogo3mnfWLgDpHJAB9fDrFX9jiKzL3w+OlPq6ZTMYfqe6qOqhPFu/NJObnsJQ/SX62I4vsRql5Wso8kmPDsQSeLdSMJQjmkJXd7+tR/0peKcQs7C/PsBaUrQ/s2CYG8mlFVsI2GMDtMYU+0f/BwS8hdgk3w/LDul8d1au3J0NXId1oa0vh24n1Oz/cLy21en2bBeQbioEEzVj/kDnuRXBjhV43PGMpkyIUGMI2y12EvgFyiu8vhqIe+xwCkuWPzrmdcWmG4Rkg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b378577-6d24-442a-0888-08d821f6472d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 21:48:11.4529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSvJyvN5AxiSnrT1BVYAwKEXo+/cYpwq6Yu9DXr3Ig4DiMzSKbuKHhBFZl/+e+KI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3477
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_20:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 cotscore=-2147483648 priorityscore=1501 suspectscore=1 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060148
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 08:44:05PM +1200, Barry Song wrote:

Hello, Barry!

> hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> no memory. Thus, NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> enabled. gigantic pages might have been reserved on other nodes.

Just curious, is it a real-life problem you've seen? If so, I wonder how
you're using the hugetlb_cma option, and what's the outcome?

> 
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  mm/hugetlb.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57ece74e3aae..603aa854aa89 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2571,9 +2571,21 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>  
>  	for (i = 0; i < h->max_huge_pages; ++i) {
>  		if (hstate_is_gigantic(h)) {
> -			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> -				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
> -				break;
> +			if (IS_ENABLED(CONFIG_CMA)) {
> +				int nid;
> +				bool cma_reserved = false;
> +
> +				for_each_node_state(nid, N_ONLINE) {
> +					if (hugetlb_cma[nid]) {
> +						pr_warn_once("HugeTLB: hugetlb_cma is reserved,"
> +								"skip boot time allocation\n");
> +						cma_reserved = true;
> +						break;
> +					}
> +				}
> +
> +				if (cma_reserved)
> +					break;

It's a valid problem, and I like to see it fixed. But I wonder if it would be better
to introduce a new helper bool hugetlb_cma_enabled()? And move both IS_ENABLED(CONFIG_CMA)
and hugetlb_cma[nid] checks there?

Thank you!
