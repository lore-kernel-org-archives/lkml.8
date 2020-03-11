Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95663C4CC9E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1285C2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bhJmRdSd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dU+tBjKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgCKRfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:35:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60380 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgCKRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:35:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BHSlrg011760;
        Wed, 11 Mar 2020 10:35:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Rbk9BNhqg3NxrI/19U3XuSiUlBGFX5qG0Vxe/PIHThA=;
 b=bhJmRdSdbCbsl82KqZrz0YaDt1NBUq/3O/PiHNsoBU803BkmGNM5N7TUybVJa5LIGWYq
 qZNJbkMScaXqeKmF2T7ydn1uCJiLs/rDfGmzlwLn7g6TC+iNNeoTPv1gA2mQU+mghmLv
 bNtz9Ko91t9Fe1059626VPFOsNkQkGKYOz4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ypr7su8tw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Mar 2020 10:35:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 10:35:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9rhG4wIWc4uVdofjDMuQRnvMxQvfN//RtrFsteRgtPgY2lyfYfl+8QZLyv3j4HI24NSYGb047RYqrfxWaZ6AgrNLZSYHY2B+VLN7zBybTadrJqOaZNoZSWX2tx1Ae9aqhDjg20bKFVEw78IoXsh3+xCcdxSVlld13Z6bmYyIbkv5bgkY2/OHyNcIVYB1ftrRuJ0FhDkEVm00VHx8Vg5siv+n03VO09sc6w9DKsZ87oU0ffVwoNy0k6vbcyTN2qf6KxtHHpxA7c7sDxugXUrNcJ8s8eQmhiDZ4oMNLXn9CJ9q3P3ttc5UYZBKmioAQF1oINHb7dG/izoaZoyYyjkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbk9BNhqg3NxrI/19U3XuSiUlBGFX5qG0Vxe/PIHThA=;
 b=DLCvZqIGQrPOINvXm8qYeDcS52vS9pWPkF4D8r/DYA/3zR4GTt9vPxmnMG0nHRard71gfLP8Du2qqADybGPmGro7oxSrsajAPFPFtvVwQtdtM/rQtGI8/UumqpNtj+/aH/YjUhmUpoKgUv61d+18+7diXmsM7xiQ4Nt2r/sDZ6fqzgyFm7CM/dBJFPFfcROveDYpL0UCdxswZ6w15NfDSOn/OZYXjZIW2VzvfRhtC63wfAoD7iHx5UaN6IHnOIXyhcW41XEGgGRbHXH/Mf4L+wMEN9a8zrbeoPHbiR7eB+SyEXXHcU5rraB9oXLov3C6KQa98gM95+dC35KgxsN4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbk9BNhqg3NxrI/19U3XuSiUlBGFX5qG0Vxe/PIHThA=;
 b=dU+tBjKWhoBvrkfBa23ImS7Ld/YJxxYm3iri0/mUUyLT66oAZfYoz9WMWDOubj97kDpotg6iIo3O1VBBY2xRiHNhYrXf4Q1MhvzzAy7vgwSXGPfqehRDqtFDyvRmbEwnyg3S73bfdhTYRvGWU1tkPAN/3v1jISrCQQWfEB1PbeQ=
Received: from MWHPR15MB1661.namprd15.prod.outlook.com (2603:10b6:300:124::23)
 by MWHPR15MB1359.namprd15.prod.outlook.com (2603:10b6:300:b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Wed, 11 Mar
 2020 17:35:30 +0000
Received: from MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef]) by MWHPR15MB1661.namprd15.prod.outlook.com
 ([fe80::f930:6bf2:6d2:93ef%8]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 17:35:30 +0000
Date:   Wed, 11 Mar 2020 10:35:26 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
X-ClientProxiedBy: MWHPR2201CA0055.namprd22.prod.outlook.com
 (2603:10b6:301:16::29) To MWHPR15MB1661.namprd15.prod.outlook.com
 (2603:10b6:300:124::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:820) by MWHPR2201CA0055.namprd22.prod.outlook.com (2603:10b6:301:16::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 17:35:29 +0000
X-Originating-IP: [2620:10d:c090:400::5:820]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4812235-a36d-4ec0-0baf-08d7c5e2983c
X-MS-TrafficTypeDiagnostic: MWHPR15MB1359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1359D97919456A0FE097E52DBEFC0@MWHPR15MB1359.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(86362001)(81166006)(8936002)(1076003)(8676002)(81156014)(5660300002)(478600001)(66476007)(66946007)(53546011)(6506007)(16526019)(66556008)(186003)(316002)(9686003)(55016002)(33656002)(2906002)(6916009)(54906003)(4326008)(6666004)(52116002)(7696005)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1359;H:MWHPR15MB1661.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjnv4ZKHOuiA+WRQgB5BOXF/L25D5cn1gfpDMggNgeQzlzviY7/CltzUKmOQobZRFv5k5NvsMdOZKJGtjltu5TYvtGEEYMT6m7Xe8wA5ufQGzDwc9opKI4/5+1br3PK0o1MR4GBQqKpG/F5qt/2PyIVfweLvcOu5gqWk+2sTYEN6hitqeeo09m34We0bsUklLFyyczZKJsnO5+l/CC7Eylh/OwwF8cQI6B52tEM1tKAdSQhlt4Z3TG9MBy6UH4+UaYMEOGOg/cOX+VQYEEMXoggr5TdvJippvbQ/tw95i9bzKKJBRmZidfLR4VAOOJPMTJ68KdHpCpWivty29GFFAF1mZSis8knjHVn56WLYvRInvc6go4hNNWQd38pFnQjaCAEYIIH9BkRSeq79ts+yLgiEOqSozKtZJCzp2VcPZSehv3Z2N5g+/ktjKZd6t38EFYiBDlIOCvZQFnOze0AyvaMPpsyISXy4MzhVpzN/w3VauT/X7l0z9AypvVLbkOam
X-MS-Exchange-AntiSpam-MessageData: FheSwvJzupDjCehpEpo8sGcfMAff64jQG+5zK8vSfWXZr/rRfgqHeGzkKQlukOvSjJUc8dpof1PnBgF0xEvLwMlpkF1hOyuJwjhRERBp5eHk6vi0//FH3llGJt+aY7v44zreiEoFYpVDfPnu4oREjQhzzP7NjKP/64ko76JOzKfChGz0jI9XCjU3foPsBih7
X-MS-Exchange-CrossTenant-Network-Message-Id: f4812235-a36d-4ec0-0baf-08d7c5e2983c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 17:35:30.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw0A8RFNMTYyv+1423o/l8TnnhTcYx1BEEUkvSgBcsnF9fsDZUyPzH/C+0bro1PZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1359
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_07:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=853 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=1 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110102
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> On 3/6/20 9:01 PM, Rik van Riel wrote:
> > Posting this one for Roman so I can deal with any upstream feedback and
> > create a v2 if needed, while scratching my head over the next piece of
> > this puzzle :)
> > 
> > ---8<---
> > 
> > From: Roman Gushchin <guro@fb.com>
> > 
> > Currently a cma area is barely used by the page allocator because
> > it's used only as a fallback from movable, however kswapd tries
> > hard to make sure that the fallback path isn't used.
> 
> Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
> cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
> unresolved bugs. Perhaps the idea could be resurrected now?

Hi Vlastimil!

Thank you for this reminder! I actually looked at it and also asked Joonsoo in private
about the state of this patch(set). As I understand, Joonsoo plans to resubmit
it later this year.

What Rik and I are suggesting seems to be much simpler, however it's perfectly
possible that Joonsoo's solution is preferable long-term.

So if the proposed patch looks ok for now, I'd suggest to go with it and return
to this question once we'll have a new version of ZONE_MOVABLE solution.

Thanks!
