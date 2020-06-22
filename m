Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41F22076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BqGFSh6G";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UI0ilr1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgFVUh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:37:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1204 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728361AbgFVUhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:37:55 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MKVqgm026191;
        Mon, 22 Jun 2020 13:37:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=8Oxz3EFH1REQxcuzAyIaIfTBn4SQc35zDUJZSt/IJuc=;
 b=BqGFSh6G0QgWctEZ8+L3DO5Wg5PWGCtlyBBuJ+5Uw2aFy1lmJM2QAdfyAi88dGlQ6ieK
 t7/xuE22oqrrPgqXczKcXSVRF2SYWN4SopTlwqCpQLDUKriiyGFxUx6R8NlNfMiPgESp
 Pppi06DnJGmM08j2znqChdOlvvLe9EPywho= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31t2a2fgra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 13:37:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 13:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EADaQKl+tpHVc+nw00YjR1kmnSjU7YPMJU+7pOPRuHyIsbLYigM9FLCU98oFnHVreeU8wcw4jSHYrPVEFQrGZMrXZ73FHAa8WKBOZrarpdUqP+Xjicpt1lqNcfdx6HTxnZpLp/DrseyfaFIpQoAz6LwNJefdD/Edjf7qFHZfPd9eIvhZW3UIYSdfL5auw1iFaIYpLU9WadlEJiBqTwgkXeXxyfkdqh2eVCbo5ugSs//drmylu1XmnY29Tfvw4r1No5rJYQNL1kbGKnFfYFCJpTXMk0LY2Vz64q4S/ZfNmELym0BgOQjwtmbrDOC/UCPHqmZlE+bXQCCg3QRS6+fYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Oxz3EFH1REQxcuzAyIaIfTBn4SQc35zDUJZSt/IJuc=;
 b=oRlwVQmf6eWt+xslQH5aAN5/LTpb4tWUQJweRUFCXuT5rSFkMMIi80iWiBUE+7UWh86069+CQAiwq9Bno6nUnV/qo6SdSOm5BgPwrVH6kFnjGsI5KTtbYaAXqeEkkIv1k+s4B2cuWXM7YwJPRbp+Dob1xhqLen1yJosNkqf9YQ5IqEvtAh2t/LQ7TLxHKcCzKs7lTcvXUgi1y38O/3Ad2uPbXuxUq1fqJoHh2HhggSvmnYUZNWa8IOQq5rzpQR22XPRTPcqRr/4Vs4ziAFk88lpRIuEvP9QXDedgFbCoIuaBIkDk1+0sBoSKWULb7Tf9QachK9X83OBlcYU/xTN8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Oxz3EFH1REQxcuzAyIaIfTBn4SQc35zDUJZSt/IJuc=;
 b=UI0ilr1AX710dQIWYqqvngdZFX9M71WARgo0LaJ8H/zmvpjZ3FduZR5iZH/QT2+dU4qAu39em4J0dG6llSmvMaNG+MDDqwvMyfgszy5ryJtvVmmr4IUWTHNqzCUTa8FK0eBmlGJIQ+H+nLs/wfI6SnoezukiWoTUjIkx3smqONE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3480.namprd15.prod.outlook.com (2603:10b6:a03:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 20:37:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 20:37:42 +0000
Date:   Mon, 22 Jun 2020 13:37:39 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
Message-ID: <20200622203739.GD301338@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-18-guro@fb.com>
 <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:68a8) by BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 20:37:41 +0000
X-Originating-IP: [2620:10d:c090:400::5:68a8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5cec280-ebca-491f-f7a9-08d816ec1c81
X-MS-TrafficTypeDiagnostic: BYAPR15MB3480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3480A5B616893B1840074789BE970@BYAPR15MB3480.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8Nu/SPBwdPan9KP89NjeHzSW8S1XkP3R/OJxNCXvilb4vgDZZA2MUwxn15RtWlnHzhNDY5YbP6vS3+mkAijM5RtolfT7qQT9ENSpK1+CAyI+FPzGWM1l+1Iipdd3oYP6sElS54YlU0wky1U+0uySTUcMseUlVihWewVdQL8dGrpbfl4ObjQZrEHn5KU74t9ISaSVApga5SeoQ8rWyPp2LTfNh0e6j33SPeu7nmjiNlZwJ6Qse83FWfg/nFkegFGVr3qb9alaT//SQ9QaAhKkg/415sFwYPN0TVon9HJIkps6riZamJbuOFJPQ8A5CJHncnFeWwlwbC3j9RKrUdByw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(376002)(396003)(136003)(4326008)(66476007)(6916009)(316002)(52116002)(7696005)(33656002)(478600001)(83380400001)(54906003)(5660300002)(55016002)(9686003)(53546011)(6506007)(8936002)(1076003)(16526019)(66556008)(66946007)(2906002)(8676002)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ipKe5Mx/iB12fV+iXqA4U1pkAjL6lEZNfz/X/dQLyeZI+PeaG8FTzDZihiT62LCQ8tbnSoK+rtnprvg0yyTRkE52T9Gyg6yUU2WTmL89xC2mktTzSnqGU6ng41Kjq1Eij8u5gutj4ZhSGUq+bYHWq194tJ+AjOj4EXDH+CcMLO38KLCvY3CxTaK7l01wk/l9p/Lcf2BfSj7TgpGAv3/cHR/4ui09qKP/SPuPdPPH7qWonE0EM3bdT2/RcHm6Wds7K/wLW+WzMrEUvqZ9FNl/s9fXBeZ5Vwu68xL8EZIYzJ+iBakTzEWDmZjH6s7d1vQqj9Gx0jwifC3Bz7W6n+gyuUTetX74ZH8yKEhdV/MayOf+tQ2W21VFivA5s4lJtSo2mJ4/CSiGJJMZTzg/UCZyQcAWGObGqOHdTYupiu4uBvMzvpC0NoGo765W41CbwBaXkaT4Z962xeHOPln3EcMDqmpclBXxemmKpTGGPQBJgv6uylcBl5hAqQGkJ5oqJ0enAtc/f0hzatzvwhQtk1KB3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cec280-ebca-491f-f7a9-08d816ec1c81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 20:37:42.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UV9SZnifugx0SLrXXxkXfoAKAlVI4JqDeJri0UxAZX/AOpMDAFals+tMrAD/y5VM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3480
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_12:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=926 bulkscore=0 cotscore=-2147483648 mlxscore=0
 impostorscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:21:28PM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Instead of having two sets of kmem_caches: one for system-wide and
> > non-accounted allocations and the second one shared by all accounted
> > allocations, we can use just one.
> >
> > The idea is simple: space for obj_cgroup metadata can be allocated
> > on demand and filled only for accounted allocations.
> >
> > It allows to remove a bunch of code which is required to handle
> > kmem_cache clones for accounted allocations. There is no more need
> > to create them, accumulate statistics, propagate attributes, etc.
> > It's a quite significant simplification.
> >
> > Also, because the total number of slab_caches is reduced almost twice
> > (not all kmem_caches have a memcg clone), some additional memory
> > savings are expected. On my devvm it additionally saves about 3.5%
> > of slab memory.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> [snip]
> >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> >                                               struct obj_cgroup *objcg,
> > -                                             size_t size, void **p)
> > +                                             gfp_t flags, size_t size,
> > +                                             void **p)
> >  {
> >         struct page *page;
> >         unsigned long off;
> >         size_t i;
> >
> > +       if (!objcg)
> > +               return;
> > +
> > +       flags &= ~__GFP_ACCOUNT;
> >         for (i = 0; i < size; i++) {
> >                 if (likely(p[i])) {
> >                         page = virt_to_head_page(p[i]);
> > +
> > +                       if (!page_has_obj_cgroups(page) &&
> 
> The page is already linked into the kmem_cache, don't you need
> synchronization for memcg_alloc_page_obj_cgroups().

Hm, yes, in theory we need it. I guess the reason behind why I've never seen any issues
here is the SLUB percpu partial list.

So in theory we need something like:

diff --git a/mm/slab.h b/mm/slab.h
index 0a31600a0f5c..44bf57815816 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -237,7 +237,10 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
        if (!vec)
                return -ENOMEM;
 
-       page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
+       if (cmpxchg(&page->obj_cgroups, 0,
+                   (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
+               kfree(vec);
+
        return 0;
 }


But I wonder if we might put it under #ifdef CONFIG_SLAB?
Or any other ideas how to make it less expensive?

> What's the reason to remove this from charge_slab_page()?

Because at charge_slab_page() we don't know if we'll ever need
page->obj_cgroups. Some caches might have only few or even zero
accounted objects.

> 
> > +                           memcg_alloc_page_obj_cgroups(page, s, flags)) {
> > +                               obj_cgroup_uncharge(objcg, obj_full_size(s));
> > +                               continue;
> > +                       }
> > +
> >                         off = obj_to_index(s, page, p[i]);
> >                         obj_cgroup_get(objcg);
> >                         page_obj_cgroups(page)[off] = objcg;
