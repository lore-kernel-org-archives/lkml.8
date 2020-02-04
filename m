Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3496C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4EC20732
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pu+fNVP/";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ks9y89IW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBDBpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 20:45:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgBDBpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 20:45:05 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0141dvW5024985;
        Mon, 3 Feb 2020 17:44:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=x8cTfWCueaxE4pCiQSf3nORJ+n+bBGHxOSC3aRjWOgI=;
 b=pu+fNVP/MUHkjX1oFzy/HBOw3sZKYgC8f+QNiazxpnXKTAXEZzS9sReTRyz7pVaQz+CF
 ipJk7ufr+1Qf3awgxnYrbGfN1KFwRmdyEnJ0AfO30xaeMp/WRHEj5gT+ORZ2IYIT6kbF
 xEoMMDltbrkwvt4Vk4cQR0JMU5BkN695Oso= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xxpxqjg47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 17:44:54 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 17:44:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB7dGG0n6LGuQHVVDZ5S2dyAWZUEobDOHM1IDS+rkZGUjBLbcY6H3T3cheHqXYWMKBSqv7pMI8QxKGv8raTgVT1U2X5AwmXO7RDnOm1k08T7H4wRL/iTZs/GHOkhQSVaaasI+bLY10aTTBdlaWXQGQHGVwWGPlzNKP4Uj9mLZgOBp9kzLCE2D/Kp1+DDDMn357GcX6Zv7jOVLfrINUq9SWrGOlVQqtpahRE+fINPV716trLAFgKLzsopqz3Qo3JXGNnGjY9yABRKAKLb6ngfoVjxADYiVIGJ4ItcPLpf8jsRPU+VG0srmVMsvLKVFs5NzEkY8y2NOA37iO5FeCD6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8cTfWCueaxE4pCiQSf3nORJ+n+bBGHxOSC3aRjWOgI=;
 b=BC3xSNQW5iAGxPg07iSsophxD2kJoaJzY8yK1Q7e/ZKT0+6kKFU/e6gJsk/IhelHJrb24o7lMoSAtDg3P72513QXPgAOn4AMYgCt0Hc/EALr7dHY8C1obQ30VM2G6Tu6lJZsuvLmgSdvmXb03uvx6ye1fnLlByp6vU+sKZUeQyaClaPA4A5gB23NuGiPyLp1JfWsYwpYM3l4cEb2fV1pzTJgnv8VBGweJwO4tA+VJKX9z7cqKhVqBTLPuHR6/t795b2S1gIzcozc0CM9daLaWlV37eSo4r0UJscXWjMhcNZYznbaWTYAQbHgMhS6BDRlpu46mjAnOH0Y9Pzh+ZzzdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8cTfWCueaxE4pCiQSf3nORJ+n+bBGHxOSC3aRjWOgI=;
 b=ks9y89IWYqA25u55FFNZfMq6KXgEYQI+kEaIf6uXdDGVNq4dFv9m1r1M45o2YuZlGiy+oWtWRSWqvLSGUBqgeIbAbxG4k8pxlWnaJB5YLFOeUjzN8Gfr1xuq4W5/NGqhwaT/M1Di1aiBEG64MM/aWmKx6As5B/8EigwIIgkuaiE=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2951.namprd15.prod.outlook.com (20.178.237.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Tue, 4 Feb 2020 01:44:53 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 01:44:53 +0000
Date:   Mon, 3 Feb 2020 17:44:46 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 12/28] mm: vmstat: use s32 for vm_node_stat_diff in
 struct per_cpu_nodestat
Message-ID: <20200204014446.GB9138@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-13-guro@fb.com>
 <20200203175818.GF1697@cmpxchg.org>
 <20200203182506.GA3700@xps.dhcp.thefacebook.com>
 <20200203203450.GA6380@cmpxchg.org>
 <20200203222853.GD6781@xps.dhcp.thefacebook.com>
 <20200203223954.GE6380@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203223954.GE6380@cmpxchg.org>
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::d108) by MN2PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Tue, 4 Feb 2020 01:44:50 +0000
X-Originating-IP: [2620:10d:c091:480::d108]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 738e283f-9671-4d8f-05f5-08d7a913d435
X-MS-TrafficTypeDiagnostic: BYAPR15MB2951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2951222D052BCE9D464E83BABE030@BYAPR15MB2951.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(396003)(346002)(39860400002)(189003)(199004)(5660300002)(66946007)(33656002)(6666004)(2906002)(52116002)(66556008)(7696005)(66476007)(8936002)(6916009)(86362001)(81166006)(316002)(6506007)(478600001)(16526019)(186003)(9686003)(4326008)(1076003)(8676002)(81156014)(54906003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2951;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsx4+4stQb68wab6sYWhezdQm5x6W/8yqPHgbGYgIMxwYhAsc+S+5CxcdSFy4FzS4fLr6+czbhhH9MtE54ypErf7kn/ZyV45Z4Th7OpjF7ZYPBlMYxbF/mDh1pAVu5PU1aDHfV6q77reK9jqjUL0ZpnmwXGrOx94SUr8EsmcbGfXZFD8tBNNEEXiN3qmjk7z7/6H2eQEmvzfZ0hB1ByLqzXJDRAXI1aJKeUlKaq26ft3q+KtwlKLLTVvZCfA61SWs+RqJkNleLjUzn33C9UmjQoEVVF8ZLCbnj0Mt2ajEwCLEzTMQi9u6V3JbXW+VXhB4nrEgzeArO8S6Qi4fQQE6+HLwoR84BOO57O055IgpCNJFtA37B0aGJGFxRQe9SFVOa+IkWQ7eNbicKorTfJrGQ+U7VCZ3pgSAJybHlJhibalZcCVbuEEvtfkxmX1q4bh
X-MS-Exchange-AntiSpam-MessageData: TP9188W/+5EYqYqQz2xuEQspSIbRKtPWJjcRmP0wc8bl6Qr8dCgaITSDFLiPmVJUKd54a+NYSimmUH7KROiyVmSGnBcTr3USPmLpbuJNdN410MUOJbbJS3TNh0OeFVMy0j5SzjYZjXV63HYWWv8EgVHhI9yfmxB9p9+mPHGKrd8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 738e283f-9671-4d8f-05f5-08d7a913d435
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 01:44:52.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoP4h1LvE5BqLzFJ/tp+RzZQn3JVcMsbvVpAB3wKBZ6bHe//Dsvfg7R3IkU7wr+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2951
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_08:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=5 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040010
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 05:39:54PM -0500, Johannes Weiner wrote:
> On Mon, Feb 03, 2020 at 02:28:53PM -0800, Roman Gushchin wrote:
> > On Mon, Feb 03, 2020 at 03:34:50PM -0500, Johannes Weiner wrote:
> > > On Mon, Feb 03, 2020 at 10:25:06AM -0800, Roman Gushchin wrote:
> > > > On Mon, Feb 03, 2020 at 12:58:18PM -0500, Johannes Weiner wrote:
> > > > > On Mon, Jan 27, 2020 at 09:34:37AM -0800, Roman Gushchin wrote:
> > > > > > Currently s8 type is used for per-cpu caching of per-node statistics.
> > > > > > It works fine because the overfill threshold can't exceed 125.
> > > > > > 
> > > > > > But if some counters are in bytes (and the next commit in the series
> > > > > > will convert slab counters to bytes), it's not gonna work:
> > > > > > value in bytes can easily exceed s8 without exceeding the threshold
> > > > > > converted to bytes. So to avoid overfilling per-cpu caches and breaking
> > > > > > vmstats correctness, let's use s32 instead.
> > > > > > 
> > > > > > This doesn't affect per-zone statistics. There are no plans to use
> > > > > > zone-level byte-sized counters, so no reasons to change anything.
> > > > > 
> > > > > Wait, is this still necessary? AFAIU, the node counters will account
> > > > > full slab pages, including free space, and only the memcg counters
> > > > > that track actual objects will be in bytes.
> > > > > 
> > > > > Can you please elaborate?
> > > > 
> > > > It's weird to have a counter with the same name (e.g. NR_SLAB_RECLAIMABLE_B)
> > > > being in different units depending on the accounting scope.
> > > > So I do convert all slab counters: global, per-lruvec,
> > > > and per-memcg to bytes.
> > > 
> > > Since the node counters tracks allocated slab pages and the memcg
> > > counter tracks allocated objects, arguably they shouldn't use the same
> > > name anyway.
> > > 
> > > > Alternatively I can fork them, e.g. introduce per-memcg or per-lruvec
> > > > NR_SLAB_RECLAIMABLE_OBJ
> > > > NR_SLAB_UNRECLAIMABLE_OBJ
> > > 
> > > Can we alias them and reuse their slots?
> > > 
> > > 	/* Reuse the node slab page counters item for charged objects */
> > > 	MEMCG_SLAB_RECLAIMABLE = NR_SLAB_RECLAIMABLE,
> > > 	MEMCG_SLAB_UNRECLAIMABLE = NR_SLAB_UNRECLAIMABLE,
> > 
> > Yeah, lgtm.
> > 
> > Isn't MEMCG_ prefix bad because it makes everybody think that it belongs to
> > the enum memcg_stat_item?
> 
> Maybe, not sure that's a problem. #define CG_SLAB_RECLAIMABLE perhaps?

Maybe not. I'll probably go with 
    MEMCG_SLAB_RECLAIMABLE_B = NR_SLAB_RECLAIMABLE,
    MEMCG_SLAB_UNRECLAIMABLE_B = NR_SLAB_UNRECLAIMABLE,

Please, let me know if you're not ok with it.

> 
> > > > and keep global counters untouched. If going this way, I'd prefer to make
> > > > them per-memcg, because it will simplify things on charging paths:
> > > > now we do get task->mem_cgroup->obj_cgroup in the pre_alloc_hook(),
> > > > and then obj_cgroup->mem_cgroup in the post_alloc_hook() just to
> > > > bump per-lruvec counters.
> > > 
> > > I don't quite follow. Don't you still have to update the global
> > > counters?
> > 
> > Global counters are updated only if an allocation requires a new slab
> > page, which isn't the most common path.
> 
> Right.
> 
> > In generic case post_hook is required because it's the only place where
> > we have both page (to get the node) and memcg pointer.
> > 
> > If NR_SLAB_RECLAIMABLE is tracked only per-memcg (as MEMCG_SOCK),
> > then post_hook can handle only the rare "allocation failed" case.
> > 
> > I'm not sure here what's better.
> 
> If it's tracked only per-memcg, you still have to account it every
> time you charge an object to a memcg, no? How is it less frequent than
> acconting at the lruvec level?

It's not less frequent, it just can be done in the pre-alloc hook
when there is a memcg pointer available.

The problem with the obj_cgroup thing is that we get it indirectly
from current memcg in the pre_alloc_hook, then pass it to obj_cgroup API,
internally we might need to get the memcg from it to charge a page,
and then again in the post_hook we need to get memcg to bump
per-lruvec stats. In other words we make several memcg <-> objcg
conversions, which isn't very nice on the hot path.

I see that in the future we might optimize the initial lookup
of objcg, but getting memcg just to bump vmstats looks unnecessarily expensive.
One option I think about is to handle byte-sized stats on obj_cgroup
level and flush whole pages to memcg level.

> 
> > > > Btw, I wonder if we really need per-lruvec counters at all (at least
> > > > being enabled by default). For the significant amount of users who
> > > > have a single-node machine it doesn't bring anything except performance
> > > > overhead.
> > > 
> > > Yeah, for single-node systems we should be able to redirect everything
> > > to the memcg counters, without allocating and tracking lruvec copies.
> > 
> > Sounds good. It can lead to significant savings on single-node machines.
> > 
> > > 
> > > > For those who have multiple nodes (and most likely many many
> > > > memory cgroups) it provides way too many data except for debugging
> > > > some weird mm issues.
> > > > I guess in the absolute majority of cases having global per-node + per-memcg
> > > > counters will be enough.
> > > 
> > > Hm? Reclaim uses the lruvec counters.
> > 
> > Can you, please, provide some examples? It looks like it's mostly based
> > on per-zone lruvec size counters.
> 
> It uses the recursive lruvec state to decide inactive_is_low(),
> whether refaults are occuring, whether to trim cache only or go for
> anon etc. We use it to determine refault distances and how many shadow
> nodes to shrink.
> 
> Grep for lruvec_page_state().

I see... Thanks!

> 
> > Anyway, it seems to be a little bit off from this patchset, so let's
> > discuss it separately.
> 
> True
