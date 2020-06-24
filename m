Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9775120702
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="S+BgbnwI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="apFtnOb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbgFXBxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:53:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20490 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388035AbgFXBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:53:51 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05O1okor021451;
        Tue, 23 Jun 2020 18:53:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=f3bryRlqbbrzEAjTvmgmqwhv0C3WedU6TocaWWS/xpg=;
 b=S+BgbnwIbm7A0FaWrmEgaCvyTDl/hFMedKVnMkDajn1SYljbSFKzhUsKJRT+JpWDN38C
 VGscGzKUVtYG9G+lZKalK+tYBJ3Yx+atkWeGXvrXx54BcWahhi4+A2xwdpjlXnStZs+Q
 mdotkKF7hRu3+uRGmM1gAI0wDoP/cUlSKzo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31uuqggd8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 18:53:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 18:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx+ayBAHtqWhxLAiGZ5GujtkYFT0qisw0zCdRNLkGAOzhGYN4G1x3+yWp6PmqoF8+O1doo11sBcCPMr4wXai13S6E7vSVMjBGT69H9C/8H0f1kDKZaJnzEBf15MBLqq+7fELsWOBtVq/stlCkWGYeZk5Zl7c56P2aWmX/QLtt+ymM0yjv3rzCiPzm/oWc+5N4fXiLhfInhEJ41+XJ5F0BNYh4be8Azbqzgnjanl1vWiVhsjWu4fgLKcFwAWbhpgjfZ4BfB4HhTOucjDieIF4xsME2QFo/DzucwzJA7piD2T1GBSRD5pXMDMpmGLo3ziyzqjie0CnYC1SgvV3jI4HPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3bryRlqbbrzEAjTvmgmqwhv0C3WedU6TocaWWS/xpg=;
 b=dAVldxJiCbQauoUbLFGmowAwic3MBtEzo8ILzn6C/4jzFepe/Hc6e2jdVP7dsaucoZDLAtsC4/waJlhhIY33IapF+tzOCcdTjBxSvMrAIkmoNZFBI2LrxD5iR2z1cUFwnM3KC1yhr1NzypzTMkVFXyYel3fGdPgf1otb2F16uKxBpKhmqaUT7jS+D/7sd2BhBK2EEnG/ppKQRvnWEUK8OP65QSMInsW3rdVMor7/wMA68o7WEBm1HdGQyw54NDJydmQ+Ne6PDHn7RgDCI9hlE6ANcRvCC57+91Blc7gM2vT1PGpbhByfMRQL5N75NBhuJIhQfpboy2c6WKFNPYTKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3bryRlqbbrzEAjTvmgmqwhv0C3WedU6TocaWWS/xpg=;
 b=apFtnOb0ODvvhjT6w4Lb9Jjjc8hukC18E0cxMfHV8y5w8xxJjJFE8HnNtO8lBNc6JUj44mj0u8P+seiBYePlfl7wPE/kU/ssWBXCkRrDkuYjbz0bQj/4In7iip2bPmjqzbKTGvHT12YHZaJu/4B7rK/YJpnbgV4hZGNs5bVD7hA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 01:53:37 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 01:53:37 +0000
Date:   Tue, 23 Jun 2020 18:53:24 -0700
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
Subject: Re: [PATCH v7 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
Message-ID: <20200624015324.GC358561@carbon.lan>
References: <20200623174037.3951353-1-guro@fb.com>
 <20200623174037.3951353-11-guro@fb.com>
 <CALvZod6bShcP2X0W=UmY_oUzXuUdPhuQJviL6rgBYOqvLuf=Gw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6bShcP2X0W=UmY_oUzXuUdPhuQJviL6rgBYOqvLuf=Gw@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::46) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:72a3) by BY5PR17CA0033.namprd17.prod.outlook.com (2603:10b6:a03:1b8::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 24 Jun 2020 01:53:36 +0000
X-Originating-IP: [2620:10d:c090:400::5:72a3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9f7659d-8715-4645-c57d-08d817e16917
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB27597E179F32EF71E1400E06BE950@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ih9TNZ6SgX130fJCnnXT1EGLSZ7hLhPWE3FHLStT+hWiageA9phCZsQq7iTJW85sOF37vfZx/GY61jeWG7ST4H5XhmWtsTAPigFVIsPjEf93qaJBoK8gsFFuL8q4OnEIS/1Pf55jxkBbCsvZzpVxlwA1mCj8qD2infY7yC459qoDf3OAKe/WnO1pMdF/U4UpQ5jZkPDumGcZHJEE/Ygf+uLGHw4JV/p0nsp2RzRquPlA3NSypQ5X09vfffHpGvzxVN6LtkSJQf8V6uLiXeaqZj7OQybtBrUxUTGBNtKqBcoF9ngTtAzb3MtqD2yRxuh9Lhr70Ch831dN1iUIHN3HOUe9fhtNiJ7/62PXIg21YXx+RQMzgv8mtcMealZ7Gr98
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(366004)(346002)(39860400002)(136003)(66556008)(7696005)(33656002)(186003)(2906002)(66946007)(86362001)(6916009)(83380400001)(16526019)(54906003)(36756003)(316002)(8886007)(55016002)(5660300002)(9686003)(478600001)(52116002)(66476007)(4326008)(6666004)(1076003)(8676002)(6506007)(8936002)(53546011)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JMRgcR3DutLjm+z+qG9wpEly7x0X3oae7s67s9aGLoBlC7HqUOMDU63tWmNWM+ZC5FtGme0CNQCQf3S76pseJVDi8lFDGJaLt1+J1dAPg4Z1lZ+4vDJMR6I9YV4EP4fLN/rlFJiCNoYAXTVs/gRmBkDWHWevL2lEgIZY+XSCAjSSeFWZ2swJlkMQoKKV5u83ZhV8F7OZVyPWH6ITODdC+nn5A/2AyzKLm7iWGoYIlriO4tmtSlsLY9JsQwPx5Pp8T+ZLjw+ZIrOLNHVl4TFEp+dgtPsbWooHQYVlOB97/1M44MSyHx/Je3TT1jYePUEcEIfktQRTcJosFUk7bQF7pm8aBxCcG37inVmQ16yv/KkvGNT1Alh21P8z/LJ1RpSBb+/vync5Ps85IyUvvJy3MPYdZ+hZPLNYhGta7cSXyc50NAMTi1CD8Rl+4fxWRRDQp3LMemGhjUL05N0kNUPlmtD9fx+r+Cc0lfbXHYAKs5L7IcZxhKOUher/mTXgZQ5/25Et7codQFLKm6oYdeLWUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f7659d-8715-4645-c57d-08d817e16917
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 01:53:37.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1KBOUxufJUXmsbtXBVqJptmR3Ib0pPkTMw1tm5ZbaV7Uqm56jEpeJ3eJpMb8CUK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_17:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 mlxlogscore=999 suspectscore=2
 impostorscore=0 mlxscore=0 clxscore=1015 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240011
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:43:38PM -0700, Shakeel Butt wrote:
> On Tue, Jun 23, 2020 at 10:40 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > Deprecate memory.kmem.slabinfo.
> >
> > An empty file will be presented if corresponding config options are
> > enabled.
> >
> > The interface is implementation dependent, isn't present in cgroup v2, and
> > is generally useful only for core mm debugging purposes.  In other words,
> > it doesn't provide any value for the absolute majority of users.
> >
> > A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> 
> tools/cgroup/memcg_slabinfo.py*

Oh, right, I did rename it at some point to avoid a confusion with the existing
slabinfo tool.

An update version below.

Thanks!

--

From a25bb12666ada55d1a0a47ca40b8d5ccedc639d9 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Sun, 21 Jun 2020 05:35:01 +0000
Subject: [PATCH v7 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo

Deprecate memory.kmem.slabinfo.

An empty file will be presented if corresponding config options are
enabled.

The interface is implementation dependent, isn't present in cgroup v2, and
is generally useful only for core mm debugging purposes.  In other words,
it doesn't provide any value for the absolute majority of users.

A drgn-based replacement can be found in tools/cgroup/memcg_slabinfo.py .
It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output and
also allows to get any additional information without a need to recompile
the kernel.

If a drgn-based solution is too slow for a task, a bpf-based tracing tool
can be used, which can easily keep track of all slab allocations belonging
to a memory cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c  |  3 ---
 mm/slab_common.c | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e55c7afc18c..ad43e5bc482b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5118,9 +5118,6 @@ static struct cftype mem_cgroup_legacy_files[] = {
 	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
 	{
 		.name = "kmem.slabinfo",
-		.seq_start = memcg_slab_start,
-		.seq_next = memcg_slab_next,
-		.seq_stop = memcg_slab_stop,
 		.seq_show = memcg_slab_show,
 	},
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4fb76b45ce23..42edfa46fee6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1523,35 +1523,12 @@ void dump_unreclaimable_slab(void)
 }
 
 #if defined(CONFIG_MEMCG_KMEM)
-void *memcg_slab_start(struct seq_file *m, loff_t *pos)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-
-	mutex_lock(&slab_mutex);
-	return seq_list_start(&memcg->kmem_caches, *pos);
-}
-
-void *memcg_slab_next(struct seq_file *m, void *p, loff_t *pos)
-{
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-
-	return seq_list_next(p, &memcg->kmem_caches, pos);
-}
-
-void memcg_slab_stop(struct seq_file *m, void *p)
-{
-	mutex_unlock(&slab_mutex);
-}
-
 int memcg_slab_show(struct seq_file *m, void *p)
 {
-	struct kmem_cache *s = list_entry(p, struct kmem_cache,
-					  memcg_params.kmem_caches_node);
-	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-
-	if (p == memcg->kmem_caches.next)
-		print_slabinfo_header(m);
-	cache_show(s, m);
+	/*
+	 * Deprecated.
+	 * Please, take a look at tools/cgroup/slabinfo.py .
+	 */
 	return 0;
 }
 #endif
-- 
2.26.2


