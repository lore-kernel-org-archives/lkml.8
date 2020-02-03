Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E2DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7582920721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Vs1Jy2xM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hrockmHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgBCW3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:29:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgBCW3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:29:30 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013MT4R7006694;
        Mon, 3 Feb 2020 14:29:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=9haiU9GW+qBQiybpcQC+G2XLBNOGZo3ZrfkUr3CIhTw=;
 b=Vs1Jy2xMMid0044UZzfyIKOtWf8zyqh1DpoqTPk44NcE2yiYaUZZmIIqHe5ckAq5uCFd
 kQAA6zPCQdQTsJYu1DoGSF/4c2EzsB1buJ20PQ/ka4zI86vQNqSXtbByRUXDCFS5perL
 qcob5L76YhySFTCsgAhB/rrkeG1fjFK63ys= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xwsx06xcw-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 14:29:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 14:29:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOMDt/MgMGQA8HfGLrij+7cvA35ezrMtD5FfZ97SlVQhEDd2Si9pXGnFqYLIVdHRvG9fgf6g72fiMET9tmGfVEakrcMssS+zlARl6zoOolA6WnKpzoQW34uqu6fQhzX3ttISMt+rHDViuddWWTR14aTy8UzMDOS0qJYNhwanVHyz9hAGXD0zaueZQR73mGKgjNEPv/nA677S8qw+nSH/7hxis7LjeIjq1Md/H4nIEI0hN46NQCkHmUDny14uOFesPEkMt1d6oTk4EHSg/nCITlX25TpK/Z7U2R2/0Kmc06XrNpTNymIfyH81VYWR8jItJaPZtqyn9lDsmYowYaDLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9haiU9GW+qBQiybpcQC+G2XLBNOGZo3ZrfkUr3CIhTw=;
 b=hbvwhzI8mFFKa7ZDjI+tZ6gk8q2mb6wKVXYMXzUetBH7byZy3MRUxxzrFxrfdDxFcylBT2A06rw8EzMR2onhfCCnWhlYmNvPL+0Y35Ej2s1kh5Pggz/5DbDL9p1iTAQaYxskM6I1OunXyRFym2KqyZWDiVKOnsMf6cY577VzgWIlsXO1yZeJtQ4jeHkSd4XO8Nhs7F5UkumqqDyuRfuDtehRtD9xyb3swU89LY9+L8E8EXrP7ySOt3zjPZ2nGI1EuflMhzoDv2QynC8Ant/8AASiCw/4tOZsUNAJIZ7BkEvTK99uLKPnXdkVATJKxZQJNFHehFyLZjnUagIxIMKanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9haiU9GW+qBQiybpcQC+G2XLBNOGZo3ZrfkUr3CIhTw=;
 b=hrockmHnZDp8SdkyzU+PGflwaim3szMeYws9tF8wT1e+DPERyI/sDBMIoD+rAWMqPDemYGVhbynHm66pSF8xH8qXZiqDtS/eRgUtyVyavi1x3a1ZzMr38QUxVjhFA3+XlVGz6toiGY4ivoLUgvtphWPELLcf2YpmiGtor8pMKcs=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2568.namprd15.prod.outlook.com (20.179.154.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 22:29:02 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 22:29:02 +0000
Date:   Mon, 3 Feb 2020 14:28:53 -0800
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
Message-ID: <20200203222853.GD6781@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-13-guro@fb.com>
 <20200203175818.GF1697@cmpxchg.org>
 <20200203182506.GA3700@xps.dhcp.thefacebook.com>
 <20200203203450.GA6380@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203203450.GA6380@cmpxchg.org>
X-ClientProxiedBy: MN2PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:c0::37) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::9a66) by MN2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:c0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.10 via Frontend Transport; Mon, 3 Feb 2020 22:28:59 +0000
X-Originating-IP: [2620:10d:c091:480::9a66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 754e2d1f-dd06-4da8-b446-08d7a8f8781f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2568BA7913B1ED4A4141581FBE000@BYAPR15MB2568.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(86362001)(5660300002)(6916009)(8936002)(54906003)(81166006)(316002)(81156014)(7696005)(66476007)(66556008)(6666004)(9686003)(8676002)(52116002)(55016002)(66946007)(1076003)(6506007)(33656002)(16526019)(186003)(4326008)(478600001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2568;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6ixQ1Vg5P2DS9Dv4BGe1MVDbS+Fwgb+iJmi7HN+DP0Kr7Aj7DOROi6zklPCeOi70CqDXHI2iwDIO0CWfzn9sP8IbDKdAXD98e4WFpx2urGKpWuTMOUqgq3UTPHwjhQ8RlUx74+My/2Blkyu8XO26XxUUg4sfVxSW8457wc/bEb0y9yw404cSPqxYf2LlrLWGkJETQn+6EBLMUM9hauRNJ4C1tB5AEHxz7Qhye1rU5Yy+xAvvsdwdyK9disr8eYqIvMlK3RwLwuZselXGxQz31+t5+BqIhnihSP/UzsBl8CYX99Z2wjtCvnsDxuLxAAAr2xDuBaZlt4WUbQHxtXe0LjcSqgwjWREt1rLms4Wn3UumMlwR1DvocYU6wX5PSp2lx8QjxEKZfwC7uFM/VbGuDFlHRgoWfsR4LBPTkm5l8hJ5jDnnp7n/2+RYvBS7m4h
X-MS-Exchange-AntiSpam-MessageData: ru+9s44kp4aIBP69Cu3vpA2ctJpFFhYdbRNomf8IE+Au9LGzp2cl1EW9BDn1PW47WyD7vJEyUk9j8n1D/pewaVFuj4LZTCYTLomjs6yu/0x7BgUj9RufDSydeOtqo/iX9MaAATUvyVqPQCnikvdUFagbWkkExOCVsVpdMd/dJto=
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e2d1f-dd06-4da8-b446-08d7a8f8781f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 22:29:02.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djxvj4wV+jJb89TE26hZhSElyD7jy9sh9dqab0MmfxdIsAi7lOUxQuQk3yqyyiYO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_08:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030162
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 03:34:50PM -0500, Johannes Weiner wrote:
> On Mon, Feb 03, 2020 at 10:25:06AM -0800, Roman Gushchin wrote:
> > On Mon, Feb 03, 2020 at 12:58:18PM -0500, Johannes Weiner wrote:
> > > On Mon, Jan 27, 2020 at 09:34:37AM -0800, Roman Gushchin wrote:
> > > > Currently s8 type is used for per-cpu caching of per-node statistics.
> > > > It works fine because the overfill threshold can't exceed 125.
> > > > 
> > > > But if some counters are in bytes (and the next commit in the series
> > > > will convert slab counters to bytes), it's not gonna work:
> > > > value in bytes can easily exceed s8 without exceeding the threshold
> > > > converted to bytes. So to avoid overfilling per-cpu caches and breaking
> > > > vmstats correctness, let's use s32 instead.
> > > > 
> > > > This doesn't affect per-zone statistics. There are no plans to use
> > > > zone-level byte-sized counters, so no reasons to change anything.
> > > 
> > > Wait, is this still necessary? AFAIU, the node counters will account
> > > full slab pages, including free space, and only the memcg counters
> > > that track actual objects will be in bytes.
> > > 
> > > Can you please elaborate?
> > 
> > It's weird to have a counter with the same name (e.g. NR_SLAB_RECLAIMABLE_B)
> > being in different units depending on the accounting scope.
> > So I do convert all slab counters: global, per-lruvec,
> > and per-memcg to bytes.
> 
> Since the node counters tracks allocated slab pages and the memcg
> counter tracks allocated objects, arguably they shouldn't use the same
> name anyway.
> 
> > Alternatively I can fork them, e.g. introduce per-memcg or per-lruvec
> > NR_SLAB_RECLAIMABLE_OBJ
> > NR_SLAB_UNRECLAIMABLE_OBJ
> 
> Can we alias them and reuse their slots?
> 
> 	/* Reuse the node slab page counters item for charged objects */
> 	MEMCG_SLAB_RECLAIMABLE = NR_SLAB_RECLAIMABLE,
> 	MEMCG_SLAB_UNRECLAIMABLE = NR_SLAB_UNRECLAIMABLE,

Yeah, lgtm.

Isn't MEMCG_ prefix bad because it makes everybody think that it belongs to
the enum memcg_stat_item?

> 
> > and keep global counters untouched. If going this way, I'd prefer to make
> > them per-memcg, because it will simplify things on charging paths:
> > now we do get task->mem_cgroup->obj_cgroup in the pre_alloc_hook(),
> > and then obj_cgroup->mem_cgroup in the post_alloc_hook() just to
> > bump per-lruvec counters.
> 
> I don't quite follow. Don't you still have to update the global
> counters?

Global counters are updated only if an allocation requires a new slab
page, which isn't the most common path.
In generic case post_hook is required because it's the only place where
we have both page (to get the node) and memcg pointer.

If NR_SLAB_RECLAIMABLE is tracked only per-memcg (as MEMCG_SOCK),
then post_hook can handle only the rare "allocation failed" case.

I'm not sure here what's better.

> 
> > Btw, I wonder if we really need per-lruvec counters at all (at least
> > being enabled by default). For the significant amount of users who
> > have a single-node machine it doesn't bring anything except performance
> > overhead.
> 
> Yeah, for single-node systems we should be able to redirect everything
> to the memcg counters, without allocating and tracking lruvec copies.

Sounds good. It can lead to significant savings on single-node machines.

> 
> > For those who have multiple nodes (and most likely many many
> > memory cgroups) it provides way too many data except for debugging
> > some weird mm issues.
> > I guess in the absolute majority of cases having global per-node + per-memcg
> > counters will be enough.
> 
> Hm? Reclaim uses the lruvec counters.

Can you, please, provide some examples? It looks like it's mostly based
on per-zone lruvec size counters.

Anyway, it seems to be a little bit off from this patchset, so let's
discuss it separately.
