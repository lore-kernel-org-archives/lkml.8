Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D28FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6232176B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SFUL0IhQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Z8CxMRz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgGRXEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 19:04:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgGRXET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 19:04:19 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06IMsV8b009030;
        Sat, 18 Jul 2020 16:03:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=u+wz6cd4i9Wc6sm+OczvdNssnYW5V9ubaG2aV1VDkyU=;
 b=SFUL0IhQScq2st2DZWNKqdT1/A58lRHHVxkYxZIBl1t90CiZL28xLlD3FKodh507WWRv
 dbhKwk402KxQHitMmQ9gyDUsUxgsujsf2mJcfrIuts4KSkl71QzVd+JlwtoVzgF76wby
 UJ5HnqouYshNCu2ZpTpTgxJLCBUPmAosWU8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32bx6ghqa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 18 Jul 2020 16:03:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 18 Jul 2020 16:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ1dN2Ox+So1dXHk+or5KEqL64sEKO/uH5EBvdCJ3H07CjXfnXozsf6FbNrvWdQhC8Zz2GOdsRZN0b1C5biy/HWAvIuGeGgWNeMpLA9wMcPK5vbH++YY8tusdVmE8/ePYYy/fp4btxDgqfmsjwNGqzIUW1wOIHLrk2c2tLZvYDxnS1KCMJz7si0WP+5F0uKKQjJb39JdWs9h+IPgukZy3za5HnV3EshYxQaQP16BG7ayID1iZOhgnyFLx3q/f0QikPeT5wc7cHut4D/rlLnC8BlYCL1JG1E8ajb/12owgXyE3XLSiWfHsSaGeV1FJQM8LK5amaNeaG1SWHyh9rQYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+wz6cd4i9Wc6sm+OczvdNssnYW5V9ubaG2aV1VDkyU=;
 b=PTZYobyEwTgMTzvdgxxlOD184iPTez5HauffLeBDSEHcVjt2iC5vEnS2cVwvTzPjQUu5YR/Iry2cHJKc5FygVnIuvrCJ7rFysVboRIQHOx7K4IrSpzQqNWDwTiaT5RgZ9zbCzFxZrk7EqduLA09NcRUfS6tuTIVsKQ1c3oofLeSPwqn6eHZblAe50XZCCrBIk6XzPzZUckI+L6WDPnlWSWyimpGcGsRAfOCkbX4VYJ2kMRxYw3OP8msaCZ/dSkkZKc8mKzMCiLqf+YOpnN0mrtxRgleAvJ+DdlHIJ0Ip6vmobXz5tMH4/7/TRLugUVvqg4p+SPbW0yx0b577vURQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+wz6cd4i9Wc6sm+OczvdNssnYW5V9ubaG2aV1VDkyU=;
 b=Z8CxMRz6Olinec/Zbo4AyurewHfXhCe6MCetTc/1f1GQ3wwx8d30slENfYsLQxb/R0NpQVkOzBtrcawf7yXTod4xUdl+IjBPutihs7A5gvk2d0jIHuQSRK0txbpBxDOwuRWMhi3/VhiX1UUUOH1AeG2dYF1XoPB5Lo8jYMR8Kyk=
Authentication-Results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2808.namprd15.prod.outlook.com (2603:10b6:a03:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Sat, 18 Jul
 2020 23:03:26 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.024; Sat, 18 Jul 2020
 23:03:26 +0000
Date:   Sat, 18 Jul 2020 16:03:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
Message-ID: <20200718230322.GB124789@carbon.DHCP.thefacebook.com>
References: <20200623174037.3951353-1-guro@fb.com>
 <20200623174037.3951353-18-guro@fb.com>
 <20200718172449.GA48060@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718172449.GA48060@roeck-us.net>
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:5229) by BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Sat, 18 Jul 2020 23:03:25 +0000
X-Originating-IP: [2620:10d:c090:400::5:5229]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 284e5e91-40b2-49b2-8762-08d82b6ec6e8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2808411ACEC2AA4BBAB721B2BE7D0@BYAPR15MB2808.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSLxboMWC74+PcyHlpvDzdRqlFqisAyVU0Z9EnpPb3Cv9bD0esT3QYuS388AiNMKgoVeqFz0BA4A+YLYOgZiakaEaKDLCWYoQH9jyAVNiMtwQBt4ZcxzyvCl6wMCBcl+8q35x7LEMrnv5/KLH/adN4gaz0fYb22x/EwSILVOoLJgguVn4s0lnzWtk18tWa9gWL+TtrlDyeHYC9jn7UX13ht1D1bmIzEw5EqyWbwxbPyrYLv0Atcn6hRQ3bwLPCLNIU0GiGMs9mOzKlGvsEQh7T2ZlFhtUniwBxAyzttqRYO4t4mAHG9OUk4Rhm6LbS27PZcF6IKyLtJGReO8KDWrqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(186003)(16526019)(8936002)(478600001)(66946007)(66476007)(52116002)(66556008)(8676002)(7696005)(6666004)(86362001)(6916009)(4326008)(316002)(55016002)(9686003)(2906002)(6506007)(54906003)(1076003)(5660300002)(33656002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ecclCZAT5h8G8jc2eH5LUelCc8iYNPm6bJlTDU6ce1Md66k+EtbT8txPmFk9VdRbrNgzk9CMLeqmkNqjH9cjg5+vsKgX5DUMHFfCt4Ac0RmoCos5WGh/Jw5U803Rys7o7UbSur+KTphfca68JZpAKgxGfqikBFipHVXQ+ViU5fRuR2MIXIsrGjeQhNW3xl9jcSqGDplcFyxnV6ruQTUpClo9ApNN+ukZJn7FEw9bqcTf9fGswKVHYZcs85UC5DM+ZXAwnGHop2DCAXYVamvbZ+b3T6QMMUAxBrb3nfDFFCa8ztPmsb3NBRPup/qbg34KvMMuRNWbo0C6QsH2TPkqGK7k8j/14KITKf14xg/UO911UkijKf5U9oZUJIZt1Umn4uvUB8c/MEzLs7tgk54JVNe0fMTq/T34HUcnqp6cQnP9KCJmDlPhDhN1DaV4KP2IdfXEyXitJcgaroKXvT+eaBmJ5wLlaa9DGA3a0atMQ/HTnqlBwnXSsiMOQ6PHIlcPfmTUr4qfZn5vMbtkcKOk9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 284e5e91-40b2-49b2-8762-08d82b6ec6e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2020 23:03:26.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRz/62iDm/0kJgHLIqkHyyOmdNZPBtdPnDPSnCjbQGA9svkj7Cyj6zQEcSzwS2ge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2808
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-18_12:2020-07-17,2020-07-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=1 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=991 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007180180
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 10:24:49AM -0700, Guenter Roeck wrote:
> On Tue, Jun 23, 2020 at 10:40:35AM -0700, Roman Gushchin wrote:
> > Instead of having two sets of kmem_caches: one for system-wide and
> > non-accounted allocations and the second one shared by all accounted
> > allocations, we can use just one.
> > 
> > The idea is simple: space for obj_cgroup metadata can be allocated on
> > demand and filled only for accounted allocations.
> > 
> > It allows to remove a bunch of code which is required to handle kmem_cache
> > clones for accounted allocations.  There is no more need to create them,
> > accumulate statistics, propagate attributes, etc.  It's a quite
> > significant simplification.
> > 
> > Also, because the total number of slab_caches is reduced almost twice (not
> > all kmem_caches have a memcg clone), some additional memory savings are
> > expected.  On my devvm it additionally saves about 3.5% of slab memory.
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> 
> This patch results in:
> 
> {standard input}: Assembler messages:
> {standard input}:140: Warning: macro instruction expanded into multiple instructions
> mm/slub.c: In function 'slab_alloc.constprop':
> mm/slub.c:2897:30: error: inlining failed in call to always_inline 'slab_alloc.constprop': recursive inlining
>  static __always_inline void *slab_alloc(struct kmem_cache *s,
> 
> and many similar messages when trying to build mips:64r6el_defconfig
> or mips:defconfig. Bisect log attached.

Hello, Guenter!

Thank you for reporting the problem!
Actually, I've already fixed it, and Andrew pulled the fix yesterday.
So in few days the fix should appear in the next tree.

Sorry for the inconvenience and please let me know if the problem will persist
after a couple of days.

Roman
