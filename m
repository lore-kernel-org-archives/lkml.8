Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D71AC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1137F20720
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 01:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ecabn8Y2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="G2NysHCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBDBPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 20:15:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28062 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726872AbgBDBPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 20:15:23 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0141Cx07017327;
        Mon, 3 Feb 2020 17:15:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=LO8SlU/S80k6zjIGdiA5Pa3i0C+Txh4FRZmKoDCOQ/A=;
 b=Ecabn8Y22mQbBYwiuuTKaL4+Z5ARPJrPVVM80hm7J06rW3zrnc7SEgdvenkkReCR7xqt
 coPLXVkjxc9DczebnuWc6cUvG4FIwvkgg/Xe6n10u962JNGnqKzd2+hDq1a4IZd1TsCE
 CUV7Ti+QReKVFs219DB3isRMHWv+QytRIPA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xxt4f99uu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 17:15:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 17:15:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzUnZG4mEobdR0tkEu8dxjX1e52J47l38d0lEWgUja6gnOeQqFLwzKzsQOQPcG0Wsj61aNqFLwDfY/whVS6nt7ki5HCE8aFx6Mp3qZWUcWpitsyI4NCceYqA60TZfW46rNOJhOSRk5A7QsU4+woo83DZCR098IwA/DG/g4aUg87u17l2oHQrFFIu1OwE1GpfWztAcJuAYZPlxPR4T2AfiHDcM97A1rtn0gh7o5fAvT5otobQjMP5rZCWK6jf9ga81ATQKJNkHJbRjMEQgSn8XuFmMQQYpiDPCTCByeBELrXZ1yg3TdiGO5HIntfiaD9btjP4W+oZd8XCoiBStipB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO8SlU/S80k6zjIGdiA5Pa3i0C+Txh4FRZmKoDCOQ/A=;
 b=mwCWmI81cuWWX2Jm/QDHJi/nh99wJWqclB8vnK5pRJM5cZqHu155Ph/Y6J50GWtTFwkvkUAKoO7LNKKyJk9w57amWpDYUavp6qzvbocMcUW5eDyZ4IEKjTPsAdXSW4IY1IyuW9yGi9eUtN3ZcfTquP0laYe2WyQi9DB+1+kW/5j3Fl+sKnx5L5MvvhwJDL5xt2hJmcQXv/cZTTPd9ofLnGMvKQUeRa5ziFf3V07+uaVIAAPsrv/LLEy3uEZ66mha59Rtg7iHfBbmDXXYvQbClHfe7iPGHIvUsP2yJTpuhejauE1HBsoLJOZvXeSpQ5XHtLPgGWszQowBN8JPD0QMig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO8SlU/S80k6zjIGdiA5Pa3i0C+Txh4FRZmKoDCOQ/A=;
 b=G2NysHCxpw8ZAFKX9WucjmQeCcIL5XWh+YqszRtxBX/KG06wozlzFouT1DGx7wJWvLVYZeA/UihOugJb5kngOp3tcvm5oLsV8xlM4vyfgI8qpQxqXxFRV3XOZ9/gm+cnI2FMw9Tzp8AOkoBstU7Pxaq7rYg9eptBf4Nwo85/iV8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2853.namprd15.prod.outlook.com (20.178.238.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 01:15:11 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 01:15:11 +0000
Date:   Mon, 3 Feb 2020 17:15:05 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200204011505.GA9138@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
 <20200203195048.GA4396@cmpxchg.org>
 <20200203205834.GA6781@xps.dhcp.thefacebook.com>
 <20200203221734.GA7345@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203221734.GA7345@cmpxchg.org>
X-ClientProxiedBy: MN2PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:c0::47) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::df9a) by MN2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:208:c0::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.14 via Frontend Transport; Tue, 4 Feb 2020 01:15:09 +0000
X-Originating-IP: [2620:10d:c091:480::df9a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b9a533-a542-46b9-ca71-08d7a90faea2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2853:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB285379663D98FD73B47A864FBE030@BYAPR15MB2853.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(55016002)(478600001)(16526019)(186003)(66946007)(6506007)(6666004)(2906002)(33656002)(5660300002)(86362001)(4326008)(316002)(7696005)(52116002)(81166006)(6916009)(9686003)(54906003)(66556008)(66476007)(81156014)(1076003)(8936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2853;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbgFCVih0IdyzphiKLTOOaCfkQKciWHAkr4OPSEPaelOmQtUR2/QZPn0RTFMpyQPtSp1XC8iok4TTjaY93mWLheye9b3Hv+XO2SCiadbhp3UBBp0OajJ1kvPIBzegXcpvl+RQJ2+KG9VcP0Uty/R7iu93WRg2JBUrV3ntjHNv2pVj3B3U3oAPrWUDYKRFygKYB13SycmnQRF3I9U6wY/EwJ06RxV5vsQOyHsh6W03JRF0StxN4pwyqaw4yz9Hq6FwVshsneCYdpSnPbJevDuXpOOEIbv4zxoFnMmCuJ2R3U+dTtkXmkaT2SQGCaP+VNN99fyrNRDUyM2y57oCbW3j39/3+zgGj+cdgoBYwfw1tsG9sPWFT9EoFiP0Eri57Ehg5LuB3hBoabNmt67eyQGwcZytJGByx0W8qhwwxrNgga4sc9Y4R+cGQ0zwFnPmDih
X-MS-Exchange-AntiSpam-MessageData: no3LFu0N8TztgUrsC6sQ+Z66ti3qVGkVQSYvirp61nb2DnDShXRZUIsiH5U3GSRSBjDM4g8b3PONxBMMX87ug/aQLVTnVzOYThCCYcJI+Mkofg5cHnsn1zy1KeEVedzzvMj9rh9p61moeXZtFZsGn1WnZvgSQ6A9IYyZP6r550I=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b9a533-a542-46b9-ca71-08d7a90faea2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 01:15:11.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsBnF5xZSby9u/Ka8LAAcX75zHyI8tPaV99uf9EuqiUe9XmXmSENKrenxUEbBX4W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2853
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_08:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040006
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 05:17:34PM -0500, Johannes Weiner wrote:
> On Mon, Feb 03, 2020 at 12:58:34PM -0800, Roman Gushchin wrote:
> > On Mon, Feb 03, 2020 at 02:50:48PM -0500, Johannes Weiner wrote:
> > > On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> > > > This is fairly big but mostly red patch, which makes all non-root
> > > > slab allocations use a single set of kmem_caches instead of
> > > > creating a separate set for each memory cgroup.
> > > > 
> > > > Because the number of non-root kmem_caches is now capped by the number
> > > > of root kmem_caches, there is no need to shrink or destroy them
> > > > prematurely. They can be perfectly destroyed together with their
> > > > root counterparts. This allows to dramatically simplify the
> > > > management of non-root kmem_caches and delete a ton of code.
> > > 
> > > This is definitely going in the right direction. But it doesn't quite
> > > explain why we still need two sets of kmem_caches?
> > > 
> > > In the old scheme, we had completely separate per-cgroup caches with
> > > separate slab pages. If a cgrouped process wanted to allocate a slab
> > > object, we'd go to the root cache and used the cgroup id to look up
> > > the right cgroup cache. On slab free we'd use page->slab_cache.
> > > 
> > > Now we have slab pages that have a page->objcg array. Why can't all
> > > allocations go through a single set of kmem caches? If an allocation
> > > is coming from a cgroup and the slab page the allocator wants to use
> > > doesn't have an objcg array yet, we can allocate it on the fly, no?
> > 
> > Well, arguably it can be done, but there are few drawbacks:
> > 
> > 1) On the release path you'll need to make some extra work even for
> >    root allocations: calculate the offset only to find the NULL objcg pointer.
> > 
> > 2) There will be a memory overhead for root allocations
> >    (which might or might not be compensated by the increase
> >    of the slab utilization).
> 
> Those two are only true if there is a wild mix of root and cgroup
> allocations inside the same slab, and that doesn't really happen in
> practice. Either the machine is dedicated to one workload and cgroups
> are only enabled due to e.g. a vendor kernel, or you have cgrouped
> systems (like most distro systems now) that cgroup everything.

It's actually a questionable statement: we do skip allocations from certain
contexts, and we do merge slab caches.

Most likely it's true for certain slab_caches and not true for others.
Think of kmalloc-* caches.

Also, because obj_cgroup vectors will not be freed without underlying pages,
most likely the percentage of pages with obj_cgroups will grow with uptime.
In other words, memcg allocations will fragment root slab pages.

> 
> > 3) I'm working on percpu memory accounting that resembles the same scheme,
> >    except that obj_cgroups vector is created for the whole percpu block.
> >    There will be root- and memcg-blocks, and it will be expensive to merge them.
> >    I kinda like using the same scheme here and there.
> 
> It's hard to conclude anything based on this information alone. If
> it's truly expensive to merge them, then it warrants the additional
> complexity. But I don't understand the desire to share a design for
> two systems with sufficiently different constraints.
> 
> > Upsides?
> > 
> > 1) slab utilization might increase a little bit (but I doubt it will have
> >    a huge effect, because both merging sets should be relatively big and well
> >    utilized)
> 
> Right.
> 
> > 2) eliminate memcg kmem_cache dynamic creation/destruction. it's nice,
> >    but there isn't so much code left anyway.
> 
> There is a lot of complexity associated with the cache cloning that
> isn't the lines of code, but the lifetime and synchronization rules.

Quite opposite: the patchset removes all the complexity (or 90% of it),
because it makes the kmem_cache lifetime independent from any cgroup stuff.

Kmem_caches are created on demand on the first request (most likely during
the system start-up), and destroyed together with their root counterparts
(most likely never or on rmmod). First request means globally first request,
not a first request from a given memcg.

Memcg kmem_cache lifecycle has nothing to do with memory/obj_cgroups, and
after creation just matches the lifetime of the root kmem caches.

The only reason to keep the async creation is that some kmem_caches
are created very early in the boot process, long before any cgroup
stuff is initialized.

> 
> And these two things are the primary aspects that make my head hurt
> trying to review this patch series.
> 
> > So IMO it's an interesting direction to explore, but not something
> > that necessarily has to be done in the context of this patchset.
> 
> I disagree. Instead of replacing the old coherent model and its
> complexities with a new coherent one, you are mixing the two. And I
> can barely understand the end result.
> 
> Dynamically cloning entire slab caches for the sole purpose of telling
> whether the pages have an obj_cgroup array or not is *completely
> insane*. If the controller had followed the obj_cgroup design from the
> start, nobody would have ever thought about doing it like this.

It's just not true. The whole point of having root- and memcg sets is
to be able to not look for a NULL pointer in the obj_cgroup vector on
releasing of the root object. In other words, it allows to keep zero
overhead for root allocations. IMHO it's an important thing, and calling
it *completely insane* isn't the best way to communicate.

> 
> From a maintainability POV, we cannot afford merging it in this form.

It sounds strange: the patchset eliminates 90% of the complexity,
but it's unmergeable because there are 10% left.

I agree that it's an arguable question if we can tolerate some
additional overhead on root allocations to eliminate these additional
10%, but I really don't think it's so obvious that even discussing
it is insane.

Btw, there is another good idea to explore (also suggested by Christopher
Lameter): we can put memcg/objcg pointer into the slab page, avoiding
an extra allocation.
