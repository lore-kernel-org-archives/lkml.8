Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBA82076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cBzenF4x";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZENQ581C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgHKRGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:06:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13770 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729161AbgHKRG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:06:29 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07BH4cVa017059;
        Tue, 11 Aug 2020 10:06:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=CbSmh8UXuEpQiApSbvycdTICM1ESyRpIS47YqzAmU10=;
 b=cBzenF4xb5GwkZYwjIna3MXJWzpLgMeZjn5pCV16iTyCwhwwDVgPKLthpbckvsQ70GF+
 uWDnxPrpHXk4W89vuXGDayQi189S9WL8iaYsJXeaSJbFGj5FE52p1D1+qiTUwYxbA2vv
 CQgsBYa4gWKSksPovhlmV5UK0r+DvK5NhIQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32uxp788k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Aug 2020 10:06:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 11 Aug 2020 10:06:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li0LG9mKozYkl8D9tOYZzXiF/XNlP5pOs4nmDJc7GzGCeM0By8s0twOS1SSnI+To7oEGUcO2IUIKYRGanIs3SDXCVu4Gkh4C1bJtbq0zt7OcbKIhWn/p9usr9ZEw9B0hzUfxK59bxUmLee4UQ7Tj0p6NjM21Z/B82Db66gZUYCbrqROnzN1KHLSQnNW2zKVqKKlnq0uywRIKmAwElTEmvuEefjTSHVhJz+nfDgk1DfnKYHmIy8VvzGbSaIEwg+mk5OJIMokGV3EPd+RwghoLgykCJ+bW5L+upPdAy1SakXpbfRoAI3lJd2prgruCeGjqFUamHTfgvhGwI5EW540fyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbSmh8UXuEpQiApSbvycdTICM1ESyRpIS47YqzAmU10=;
 b=l8wkLtVZNq224UFN4qU3H2Q9ql/7ZgN6vomkwSFZ3Me5JejK4eG7mU+0RpNh+DvNtNoH4+szlBfrcd1UascQHY7n2g9Mu4k1m3TkDITA/9IebyzMIvTVbdhjtu8rHcYGE7oz4gs0bDl5YBrFaQn6i9EuXu549RxKWaSzwlyLJSconNBw7Zh7MuECGzE6QqfHgmDLnivDbI0goQiBW7OLXdPcky0FwmjYG5EsvTjbP2RvVqjjWncydx1XGnqMbVBAg8ZqYl919N5qsMhefhHyOEC45tqDhxXsJ3QRWh2nv/QTDwvKtFh3o5I5Sf39LWESpoSbdP9CFk+QJmt8vy2Few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbSmh8UXuEpQiApSbvycdTICM1ESyRpIS47YqzAmU10=;
 b=ZENQ581C1PREoipMF6glJRUZ/hVEEvEWwgW6p0o3dX+eZcCVLd5mN8fdEY3SfUBngT86CNt6YAFhJLqoqvj/+ARi2egIc3EXdxj7PDMiOdtHKEya3ubeKKevlJgD7hbgKV5Pc04bdoBDl/0VQ48yTVSkrD2ZJxrg1vYQfEh6DrI=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2598.namprd15.prod.outlook.com (2603:10b6:a03:14d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 11 Aug
 2020 17:06:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 17:06:14 +0000
Date:   Tue, 11 Aug 2020 10:06:11 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200811170611.GB1507044@carbon.DHCP.thefacebook.com>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200811152737.GB650506@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811152737.GB650506@cmpxchg.org>
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fa33) by BYAPR08CA0055.namprd08.prod.outlook.com (2603:10b6:a03:117::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 17:06:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:fa33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b827c471-9761-4d33-e6b2-08d83e18daab
X-MS-TrafficTypeDiagnostic: BYAPR15MB2598:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25981F38BDE608FBB91715D0BE450@BYAPR15MB2598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(346002)(396003)(8936002)(6916009)(8676002)(186003)(6506007)(16526019)(478600001)(7696005)(52116002)(1076003)(86362001)(83380400001)(55016002)(5660300002)(9686003)(33656002)(54906003)(2906002)(316002)(66556008)(66476007)(66946007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-CrossTenant-Network-Message-Id: b827c471-9761-4d33-e6b2-08d83e18daab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 17:06:14.3470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YVeaHBH9x1eMpYLHjWf/LKWdwjJHatZlZLR84jyjBBEmQAkM1ZpHWqq0cBulauL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_15:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=5
 priorityscore=1501 mlxlogscore=962 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:27:37AM -0400, Johannes Weiner wrote:
> On Tue, Jun 23, 2020 at 11:45:14AM -0700, Roman Gushchin wrote:
> > Memory cgroups are using large chunks of percpu memory to store vmstat
> > data.  Yet this memory is not accounted at all, so in the case when there
> > are many (dying) cgroups, it's not exactly clear where all the memory is.
> > 
> > Because the size of memory cgroup internal structures can dramatically
> > exceed the size of object or page which is pinning it in the memory, it's
> > not a good idea to simple ignore it.  It actually breaks the isolation
> > between cgroups.
> > 
> > Let's account the consumed percpu memory to the parent cgroup.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Dennis Zhou <dennis@kernel.org>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thank you!

> 
> This makes sense, and the accounting is in line with how we track and
> distribute child creation quotas (cgroup.max.descendants and
> cgroup.max.depth) up the cgroup tree.
> 
> I have one minor comment that isn't a dealbreaker for me:
> 
> > @@ -5069,13 +5069,15 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
> >  	if (!pn)
> >  		return 1;
> >  
> > -	pn->lruvec_stat_local = alloc_percpu(struct lruvec_stat);
> > +	pn->lruvec_stat_local = alloc_percpu_gfp(struct lruvec_stat,
> > +						 GFP_KERNEL_ACCOUNT);
> >  	if (!pn->lruvec_stat_local) {
> >  		kfree(pn);
> >  		return 1;
> >  	}
> >  
> > -	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
> > +	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
> > +					       GFP_KERNEL_ACCOUNT);
> >  	if (!pn->lruvec_stat_cpu) {
> >  		free_percpu(pn->lruvec_stat_local);
> >  		kfree(pn);
> > @@ -5149,11 +5151,13 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
> >  		goto fail;
> >  	}
> >  
> > -	memcg->vmstats_local = alloc_percpu(struct memcg_vmstats_percpu);
> > +	memcg->vmstats_local = alloc_percpu_gfp(struct memcg_vmstats_percpu,
> > +						GFP_KERNEL_ACCOUNT);
> >  	if (!memcg->vmstats_local)
> >  		goto fail;
> >  
> > -	memcg->vmstats_percpu = alloc_percpu(struct memcg_vmstats_percpu);
> > +	memcg->vmstats_percpu = alloc_percpu_gfp(struct memcg_vmstats_percpu,
> > +						 GFP_KERNEL_ACCOUNT);
> >  	if (!memcg->vmstats_percpu)
> >  		goto fail;
> >  
> > @@ -5202,7 +5206,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
> >  	struct mem_cgroup *memcg;
> >  	long error = -ENOMEM;
> >  
> > +	memalloc_use_memcg(parent);
> >  	memcg = mem_cgroup_alloc();
> > +	memalloc_unuse_memcg();
> 
> The disconnect between 1) requesting accounting and 2) which cgroup to
> charge is making me uneasy. It makes mem_cgroup_alloc() a bit of a
> handgrenade, because accounting to the current task is almost
> guaranteed to be wrong if the use_memcg() annotation were to get lost
> in a refactor or not make it to a new caller of the function.
> 
> The saving grace is that mem_cgroup_alloc() is pretty unlikely to be
> used elsewhere. And pretending it's an independent interface would be
> overengineering. But how about the following in mem_cgroup_alloc() and
> alloc_mem_cgroup_per_node_info() to document that caller relationship:
> 
> 	/* We charge the parent cgroup, never the current task */
> 	WARN_ON_ONCE(!current->active_memcg);

I have nothing against.

Andrew, can you, please, squash the following diff into the patch?

Thanks!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 130093bdf74b..e25f2db7e61c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5137,6 +5137,9 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
        if (!pn)
                return 1;
 
+       /* We charge the parent cgroup, never the current task */
+       WARN_ON_ONCE(!current->active_memcg);
+
        pn->lruvec_stat_local = alloc_percpu_gfp(struct lruvec_stat,
                                                 GFP_KERNEL_ACCOUNT);
        if (!pn->lruvec_stat_local) {
@@ -5219,6 +5222,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
                goto fail;
        }
 
+       /* We charge the parent cgroup, never the current task */
+       WARN_ON_ONCE(!current->active_memcg);
+
        memcg->vmstats_local = alloc_percpu_gfp(struct memcg_vmstats_percpu,
                                                GFP_KERNEL_ACCOUNT);
        if (!memcg->vmstats_local)
