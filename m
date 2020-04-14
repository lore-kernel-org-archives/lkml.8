Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6865AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3618820678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="S3TZKg3B";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UKfgISu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440789AbgDNPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:42:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24144 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407226AbgDNPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:42:31 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03EFg39v015837;
        Tue, 14 Apr 2020 08:42:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gaRHXgn5XXHeHa/79lKmpReU3ihbjngGtpfxG5bY6pY=;
 b=S3TZKg3BU0E6Wf2X2ZFnJzss39h5esQOdZbEJx3+CowofSSV5Pactcypftll7uFf6ZBo
 Q+GENBvHjtqJn/2NypXxHQJhimdNInZFVmrutiG175r/qvidi4mKvI9I3QkdcSpXKf72
 Svex6coDxN+1Ehqs1KBGlrpMt25UA1E0y3g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 30c9vbs1sm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Apr 2020 08:42:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 14 Apr 2020 08:42:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvM9h5/qxwCFwH2ObC/hku1PrIYrjTaDVLX7WiQBRh9E3RJZX0u8Kh6uXSkk4wBic+yJyiwnNmdqqt3TJrDZ6z2E2hvF7kJadMssveHubanDnEamyvGWA+vJIaPKMnC5QlQQKE+EUUsFCwf9oA0AE5aUvghrrnSsy2fl6m+ehqJJq8tgP3BefGHCGj0jLt1/3c5CKUshT3uVehKon9zuMqN+U0fjqx8nag6v7uWz6jPjW4ogjMIdAvkxAsH+Nb/urHjeWrzKqMZw5DwWzGdqjKlrhEz5xqGEa6bjkQrVKEztaV46LfLGUyy6aVIDUpFs5/3/OVFELnOkwXGNqyKV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaRHXgn5XXHeHa/79lKmpReU3ihbjngGtpfxG5bY6pY=;
 b=gzPr4WSSK0ohMhxWqS5AUH8lwCfHsjhGPjDXSH/aB3Bt7MJAM4wanbr3gw0D2COtJr5m7e2ILz/jWRcWbm83UX+jZZSjt2lL8XqxYVKeETI16ejBDAjOPJtVlJ9PCC9uzSuO7dR0a1p4LQsMXSje0bOXuPqrXc6k8axQvmTfEbbnZIwlNE5DQsfHGqvkWxso8gBMrwqSxeJzL0m5MJxOduMJWvUF0w5anWLNTZVjjv6RCF9ES/2eGk99Oi2x0ItN9a6896gic1R/UWJHFZsbxm4Hpy8kr8kqqLu/cJ7Au5tMSMYrmKSjZWPreZWw0ld8FLD0LZCwC4n0HYwZn7UM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaRHXgn5XXHeHa/79lKmpReU3ihbjngGtpfxG5bY6pY=;
 b=UKfgISu1DNehlflSXJEMtco6nVgJY8Mu0zwer7UrqQWRN0C2LTAfiygH75QvdBjWrTBkKT8cmm9e6Bve8cx2cX4op6sFsQLpVWYNeua6eIZf/kD+pSzSYbQjHG4k71OeXU5mR7OIv+AKRSa8r6LmokG+0lfhmBt7CIr/I9MNLhA=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3496.namprd15.prod.outlook.com (2603:10b6:a03:112::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 15:42:09 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 15:42:09 +0000
Date:   Tue, 14 Apr 2020 08:42:04 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Qian Cai <cai@lca.pw>, Andrea Arcangeli <aarcange@redhat.com>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH RFC] mm: compaction: avoid migrating non-cma pages to a
 cma area
Message-ID: <20200414154204.GC42877@carbon.lan>
References: <20200408194119.1076232-1-guro@fb.com>
 <225868db-b9b0-3614-de0f-4b264023df2b@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225868db-b9b0-3614-de0f-4b264023df2b@suse.cz>
X-ClientProxiedBy: MWHPR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:300:ae::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:1ce7) by MWHPR14CA0021.namprd14.prod.outlook.com (2603:10b6:300:ae::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18 via Frontend Transport; Tue, 14 Apr 2020 15:42:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:1ce7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f667aa26-cb0d-450a-b616-08d7e08a645a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3496:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3496A95BD9547328C6236E9BBEDA0@BYAPR15MB3496.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(136003)(39860400002)(346002)(366004)(396003)(55016002)(2906002)(9686003)(33656002)(1076003)(52116002)(53546011)(6506007)(7696005)(86362001)(36756003)(316002)(66946007)(66476007)(66556008)(4326008)(54906003)(5660300002)(6666004)(8936002)(8886007)(7416002)(16526019)(478600001)(186003)(6916009)(81156014)(8676002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TmglCme8xKakQ/Fz/ijtZbzOmh3Hb/GLjEAdnFUkFUsc7wnRjE2/rKAbNQAKaiyaYEDvqrSEq8E3Fe4C5XmGWoKkUuRaohaE25N8KtJtJEYWkYoxt3JMVgm0MZs+fD1eiTS5DZb7QVcj/CcZ0ma+DaX/RbujX+tNGvVpzPM+2hgKdWbmekFKJo6K69S1okrfXys/k6aNiA8xR/MtTeR3HsvFElYbDkmIwjhbff43zXIIDXpn+KsXboAZYHkoPs/Qjdgb5KtK/UE48ipO4okoamm6+8NQsrlT+OeY281fZ5P1WVH39eC2sRf3pyEhKGo/+7PFIR3VibGVxvkC5oA2J0ep/n6Q34fEOu2mjYq//nAU6cHvIkRAgAaUegDPtzpOjg2M4dmtPWhwYn88xk0KRGG1VJwKd9OkvTUxKu4TvdaPopYrloahdknh6H6H7yD
X-MS-Exchange-AntiSpam-MessageData: EXUc7Zfm/BsH9tfAiD9wxVswTD3XqfgO6J+ZfkKOUVOEPNLhIfiIf9zoq6RR2Enu2CZvdarQedLwRnj+JVZoitAq2G+w0sXGJ2XPZI5WHRJl78ZGizGJ2sigsMdppny7DXkqAJX2pliuzZ1p6Z5xEkm99bLnc1S9stiUvc6psA9ZfAjA2S+/NwIhfMi+gbV6
X-MS-Exchange-CrossTenant-Network-Message-Id: f667aa26-cb0d-450a-b616-08d7e08a645a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 15:42:09.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJQ2rMfULIFglcReOu7oFVg6OYLM8/B8nPJ3c30P9KnF7zB5Di+sZ0VstKZHJ//2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3496
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_07:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=5 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004140125
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:49:45PM +0200, Vlastimil Babka wrote:
> On 4/8/20 9:41 PM, Roman Gushchin wrote:
> > Compaction does treat cma pageblocks on pair with any movable
> > pageblocks. It means it can easily move non-cma pages into a cma zone.
> > 
> > It can create problems for the cma allocator.
> > 
> > The particular problem I'm looking at is related to btrfs metadata
> > pages, which are allocated without __GFP_MOVABLE, but beside that
> > are generic pagecache pages. In fact, they are sometimes movable
> > and sometimes not, depending on whether they are dirty and also
> > on the extent buffer reference counter.
>

Hello, Vlastimil!

Thank you for looking  into it.

> Hm I think I'd rather make such pages really unmovable (by a pin?) than deny the
> whole CMA area to compaction. Would it be feasible?

Well, it's an option too, however I'm not sure it's the best one.
First, because these pages can be moved quite often, making
them completely unmovable will make the compaction less efficient.
Second, because it's not only about these pages, but in general
about migrating pages into a cma area without a clear need.

As I wrote in the commit log, if a cma area is located close to end
of a node (which seems to be default at least on x86 without a movable
zone), compaction can fill it quite aggressively. And it might bring
some hot pages (e.g. executable pagecache pages), which will cause
cma allocation failures. I've seen something like this in our prod.

> 
> > Compaction moves them to the hugetlb_cma area, and then sometimes
> > the cma allocator fails to move them back from the cma area. It
> > results in failures of gigantic hugepages allocations.
> > 
> > Also in general cma areas are reserved close to the end of a zone,
> > and it's where compaction tries to migrate pages. It means
> > compaction will aggressively fill cma areas, which makes not much
> > sense.
> 
> So now the free page scanner will have to skip those areas, which is not much
> effective. But I suspect a worse problem in __compaction_suitable() which will
> now falsely report that there are enough free pages, so compaction will start
> but fail to do anytning. Minimally the __zone_watermark_ok() check there would
> have to lose ALLOC_CMA, but there might be other similar checks that would need
> adjusting.

A really good point! I've looked around for any other checks, but haven't found
anything. Please, find an updated version of the patch below.

> 
> And long-term what happens if the "CMA using ZONE_MOVABLE" approach is merged
> and there are not more CMA migratetypes to test? Might this change actually also
> avoid your issue, as said pages without __GFP_MOVABLE won't end up in a
> ZONE_MOVABLE?

Yeah, this is what I was thinking about. Basically I want to mimic this behavior
right now. Once this approach will be implemented and merged, it will happen
automatically: obviously, compaction won't move pages between different zones.

Thank you!

--

From f4a0cfff41c7acab78116478e8e69ae8773b405c Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Wed, 8 Apr 2020 11:16:38 -0700
Subject: [PATCH v2] mm: compaction: avoid migrating non-cma pages to a cma
 area

Compaction does treat cma pageblocks on pair with any movable
pageblocks. It means it can easily move non-cma pages into a cma zone.

It can create problems for the cma allocator.

The particular problem I'm looking at is related to btrfs metadata
pages, which are allocated without __GFP_MOVABLE, but beside that
are generic pagecache pages. In fact, they are sometimes movable
and sometimes not, depending on whether they are dirty and also
on the extent buffer reference counter.

Compaction moves them to the hugetlb_cma area, and then sometimes
the cma allocator fails to move them back from the cma area. It
results in failures of gigantic hugepages allocations.

Also in general cma areas are reserved close to the end of a zone,
and it's where compaction tries to migrate pages. It means
compaction will aggressively fill cma areas, which makes not much
sense.

So to avoid it, let's preserve non-cma pages from being moved into
a cma area. Because cma areas are usually quite large and the number
of areas is small, it should not significantly affect the memory
fragmentation.

v2:
  1) adjusted the __zone_watermark_ok() check, suggested by
     Vlastimil Babka
  2) fixed a typo in a comment

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/compaction.c | 10 ++++++++--
 mm/internal.h   |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 46f0fcc93081..9ca036cb148a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1159,6 +1159,10 @@ static bool suitable_migration_target(struct compact_control *cc,
 			return false;
 	}
 
+	/* Do not bring non-cma pages into a cma area */
+	if (is_migrate_cma(get_pageblock_migratetype(page)) && !cc->cma)
+		return false;
+
 	if (cc->ignore_block_suitable)
 		return true;
 
@@ -1832,6 +1836,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		if (!low_pfn)
 			return ISOLATE_ABORT;
 
+		cc->cma = is_migrate_cma(get_pageblock_migratetype(page));
+
 		/*
 		 * Either we isolated something and proceed with migration. Or
 		 * we failed and compact_zone should decide if we should
@@ -2000,8 +2006,8 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
 				low_wmark_pages(zone) : min_wmark_pages(zone);
 	watermark += compact_gap(order);
-	if (!__zone_watermark_ok(zone, 0, watermark, classzone_idx,
-						ALLOC_CMA, wmark_target))
+	if (!__zone_watermark_ok(zone, 0, watermark, classzone_idx, 0,
+				 wmark_target))
 		return COMPACT_SKIPPED;
 
 	return COMPACT_CONTINUE;
diff --git a/mm/internal.h b/mm/internal.h
index b5634e78f01d..0ce649da824b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -232,6 +232,7 @@ struct compact_control {
 	bool contended;			/* Signal lock or sched contention */
 	bool rescan;			/* Rescanning the same pageblock */
 	bool alloc_contig;		/* alloc_contig_range allocation */
+	bool cma;			/* migratepages contains cma pages */
 };
 
 /*
-- 
2.25.2

