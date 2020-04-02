Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671AFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274F6206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hZZdj2As";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gex+XOHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbgDBTnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:43:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729033AbgDBTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:43:02 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 032JgM5s011578;
        Thu, 2 Apr 2020 12:42:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=PmQs771vH+Aas2yWm8O4Ink/APoF6Y8Q86sp2Xu9+hY=;
 b=hZZdj2AsiQiInafWSOjaNZe0kig2dwlX6LuyYirKehlFY0DHI+YmU4cedJk5wJ6bvkzp
 /VrIig0xE65HDHw9k3wj3rGfMu9pg6pG9P0lDJcHYRWl9YSvzbYWiLSEr4dMA0OneNEN
 LUHG7X/+EN/fbTa6+5Wy+RCgfqmWivnRpZE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 304wbbf4ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Apr 2020 12:42:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 2 Apr 2020 12:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHDcQq80OEYgH5BxKch/EthwHVSOxHibzAsEFzwMXDnfcc1BoFzxTkE3m5nY+DSuFW1XFr8V/C7kY9yk1RuvcMqx7m9Vgu+umjjXBLdSVgcGpz91u0CzzjPA+0nsWCiRLrt92s2vkxyCRilmdTTT8u0RcC6+WxzUhU2onGskfL7SpfPzQpuRvVESZskASo+JXRa1iEJV7tawAQgztH1Osxtwemf1iG3LAX2vjTxfm1KlUrhukTcU0pE5lFEoWGteS0kCE8LyMsS7u+7FyFHwz8FwGksorBtXSlO6jb0IxAe6MpOy8VuBfou8PcwHICDXxw5Dm4mTsMT9PbyuBAGk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmQs771vH+Aas2yWm8O4Ink/APoF6Y8Q86sp2Xu9+hY=;
 b=WOMgCc0iaZMVXfQ0bZmwgJjtsdvFHUpMJPS9DujIc7pFv+vsPP9indkG0qMG6VkRm61RrSEwajIjfhMnAfuR8ZFmvQZlU17KuFksBk4x0Hx7vmvM853FWCdZErkdvY39T2plLSTIci/qweyHEITK8lgtGzGuwz510aGm2MSxWECySpRqgEEVTBBBmOA7VmDnlbLaAZwQqs2oyz4MCp9Vjy82ry1nlccyOfq5CVZ/CQTPvQulqT4sRJiOu/ZIAiJVASwyQEB3C2xPcmZoCex2RuCzVAzUfsDSBAUS/71zb8v9TdNFtElHRO7J//deF/qI0r9QqRdLwDSQP5gHdSFMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmQs771vH+Aas2yWm8O4Ink/APoF6Y8Q86sp2Xu9+hY=;
 b=gex+XOHRqeZO9YsszJ59h4fTnHgU6yOGfb6MiztRmwJatZIpUlLZk3kQ4gw2XC7m1kb6Q1a0MLbcbu7Kxp0R464ssMZt4EUlnIzxCL4kn8Z4hNI3bKUUDHE19PoXmCZ9Q8UqEzkCei5cWztozz4YpR5qUiqs/WavFPtQqUBWoqo=
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2279.namprd15.prod.outlook.com (2603:10b6:a02:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 2 Apr
 2020 19:42:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 19:42:39 +0000
Date:   Thu, 2 Apr 2020 12:42:33 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Joonsoo Kim <js1304@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200402194233.GA171919@carbon.DHCP.thefacebook.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <8e67d88f-3ec8-4795-35dc-47e3735e530e@suse.cz>
 <20200311173526.GH96999@carbon.dhcp.thefacebook.com>
 <CAAmzW4PRCGdZXGceSCfzpesUXNd8GU-zLt-m+t762=WH-BjmoA@mail.gmail.com>
 <20200401191322.a5c99b408aa8601f999a794a@linux-foundation.org>
 <20200402025335.GB69473@carbon.DHCP.thefacebook.com>
 <CAAmzW4PF1AXcZnQpWmqWgTShu+5v7B=nv8waRv+vk-0Bd78cZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4PF1AXcZnQpWmqWgTShu+5v7B=nv8waRv+vk-0Bd78cZw@mail.gmail.com>
X-ClientProxiedBy: MWHPR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:300:4b::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:41e0) by MWHPR02CA0024.namprd02.prod.outlook.com (2603:10b6:300:4b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.17 via Frontend Transport; Thu, 2 Apr 2020 19:42:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:41e0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2dd183-ffb5-4d70-04e8-08d7d73e0040
X-MS-TrafficTypeDiagnostic: BYAPR15MB2279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB22794FF690FC9BFA2399F78BBEC60@BYAPR15MB2279.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(39860400002)(366004)(376002)(136003)(396003)(66476007)(5660300002)(1076003)(16526019)(8936002)(6506007)(81166006)(33656002)(6666004)(2906002)(52116002)(66946007)(186003)(8676002)(66556008)(53546011)(7696005)(81156014)(9686003)(316002)(4326008)(6916009)(55016002)(86362001)(478600001)(54906003)(7416002)(142933001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uyuk6O2xbue3difq/M7U6cfge0c6LduJXvwlwWfpTWXAzOmJJNYIL3FK2M4pbd4wXwRJzTL7nVwKFTJiDHnwI8r0DE1odEnhr6rVimb3yHSvSeMXd3PdFjSu09oQ5zT89w+VzTt5x3Z0FM0tsXtT6yecHoqw+JFXvEhdmXQECgCMWhGfJ4fH85K32abvBQlUA+AHbgVxH8sj9PsydQ4QYH13zLDTpW5ZMJPZyV7t4bdpeyqIzVL0W9VpsL/THNRNE1IkqA79SaXoecEJqU5hWtaMcSM65v7O4OAn3DcajrPZ/tYcpqlh4qtUnaVpTKadp1n0TY0U+Kj2ridvMdzoUCpG5BxE+kWzszAF38MkIb7JUWM3lXhxEDz5RHp0ySFZ85mWVkIpF4pD2B2kRKCJhGomGj8+8Fc5TBby4KIe5Z992GOG7r8IazYc3q1NQk4Sr5EJdheQsqVABIiSqAcTo4F3/qRYyQLT5E11pBMQfYQxAs4kH+TVWQl3VHrL3rUG
X-MS-Exchange-AntiSpam-MessageData: wgQ7Pu8mF2aNAMEAr3dffCiKYQU53LUy+nGbp0mHhL+OWmnYLutTOpGG/uYoP2tGmWWQUfyiH/EbBKBf/VQObMefeGJuBCX5FNc/fwp+6iB+xEHkopWWN+r/jnPlWZEZc5XIKEVTZpOLzbHRJNt09ZiObbJ8Mraj7mEbZIx4kB/yAc2m/J2TayGzL9tGK9e0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2dd183-ffb5-4d70-04e8-08d7d73e0040
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 19:42:39.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rUwWdlty9ZDh8kRsoj0CNdmrtmkixByKm/AQ19RIvdquifmzuj4L/9plaz20QoK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2279
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_09:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020145
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:43:49PM +0900, Joonsoo Kim wrote:
> 2020년 4월 2일 (목) 오전 11:54, Roman Gushchin <guro@fb.com>님이 작성:
> >
> > On Wed, Apr 01, 2020 at 07:13:22PM -0700, Andrew Morton wrote:
> > > On Thu, 12 Mar 2020 10:41:28 +0900 Joonsoo Kim <js1304@gmail.com> wrote:
> > >
> > > > Hello, Roman.
> > > >
> > > > 2020년 3월 12일 (목) 오전 2:35, Roman Gushchin <guro@fb.com>님이 작성:
> > > > >
> > > > > On Wed, Mar 11, 2020 at 09:51:07AM +0100, Vlastimil Babka wrote:
> > > > > > On 3/6/20 9:01 PM, Rik van Riel wrote:
> > > > > > > Posting this one for Roman so I can deal with any upstream feedback and
> > > > > > > create a v2 if needed, while scratching my head over the next piece of
> > > > > > > this puzzle :)
> > > > > > >
> > > > > > > ---8<---
> > > > > > >
> > > > > > > From: Roman Gushchin <guro@fb.com>
> > > > > > >
> > > > > > > Currently a cma area is barely used by the page allocator because
> > > > > > > it's used only as a fallback from movable, however kswapd tries
> > > > > > > hard to make sure that the fallback path isn't used.
> > > > > >
> > > > > > Few years ago Joonsoo wanted to fix these kinds of weird MIGRATE_CMA corner
> > > > > > cases by using ZONE_MOVABLE instead [1]. Unfortunately it was reverted due to
> > > > > > unresolved bugs. Perhaps the idea could be resurrected now?
> > > > >
> > > > > Hi Vlastimil!
> > > > >
> > > > > Thank you for this reminder! I actually looked at it and also asked Joonsoo in private
> > > > > about the state of this patch(set). As I understand, Joonsoo plans to resubmit
> > > > > it later this year.
> > > > >
> > > > > What Rik and I are suggesting seems to be much simpler, however it's perfectly
> > > > > possible that Joonsoo's solution is preferable long-term.
> > > > >
> > > > > So if the proposed patch looks ok for now, I'd suggest to go with it and return
> > > > > to this question once we'll have a new version of ZONE_MOVABLE solution.
> > > >
> > > > Hmm... utilization is not the only matter for CMA user. The more
> > > > important one is
> > > > success guarantee of cma_alloc() and this patch would have a bad impact on it.
> > > >
> > > > A few years ago, I have tested this kind of approach and found that increasing
> > > > utilization increases cma_alloc() failure. Reason is that the page
> > > > allocated with
> > > > __GFP_MOVABLE, especially, by sb_bread(), is sometimes pinned by someone.
> > > >
> > > > Until now, cma memory isn't used much so this problem doesn't occur easily.
> > > > However, with this patch, it would happen.
> > >
> > > So I guess we keep Roman's patch on hold pending clarification of this
> > > risk?
> >
> > The problem here is that we can't really find problems if we don't use CMA as intended
> > and just leave it free. Me and Rik are actively looking for page migration problems
> > in our production, and we've found and fixed some of them. Our setup is likely different
> > from embedded guys who are in my understanding most active cma users, so even if we
> > don't see any issues I can't guarantee it for everybody.
> >
> > So given Joonsoo's ack down in the thread (btw, I'm sorry I've missed a good optimization
> > he suggested, will send a patch for that), I'd go with this patch at least until
> 
> Looks like you mean Minchan's ack. Anyway, I don't object this one.

Right, I'm really sorry.

> 
> In fact, I've tested this patch and your fixes for migration problem
> and found that there is
> still migration problem and failure rate is increased by this patch.

Do you mind sharing any details? What kind of pages are those?

I'm using the following patch to dump failed pages:

@@ -1455,6 +1455,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 						private, page, pass > 2, mode,
 						reason);
 
+			if (rc && reason == MR_CONTIG_RANGE)
+				dump_page(page, "unmap_and_move");
+
 			switch(rc) {
 			case -ENOMEM:
 				/*


> However, given that
> there is no progress on this area for a long time, I think that
> applying the change aggressively
> is required to break the current situation.

I totally agree!

Btw, I've found that cma_release() grabs the cma->lock mutex,
so it can't be called from the atomic context (I've got a lockdep warning).

Of course, I can change the calling side, but I think it's better to change
the cma code to make cma_release() more accepting. What do you think
about the following patch?

Thank you!

--

From 3f3f43746391705c0b57ea3846d74c1af2684c11 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Thu, 2 Apr 2020 12:24:13 -0700
Subject: [PATCH] mm: cma: convert cma->lock into a spinlock

Currently cma->lock is a mutex which protects cma->bitmap.
cma_release() grabs this mutex in cma_clear_bitmap().

It means that cma_release() can't be called from the atomic
context, which is not very convenient for a generic memory
release function.

There are two options to solve this problem:
1) introduce some sort of a delayed deallocation
2) convert the mutex into a spinlock

This patch implements the second approach.
Indeed, bitmap operations cannot sleep and should be relatively fast,
so there are no reasons why a spinlock can't do the synchronization.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/cma.c | 21 ++++++++++++---------
 mm/cma.h |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index be55d1988c67..cb4a3e0a9eeb 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -88,9 +88,9 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
 	bitmap_no = (pfn - cma->base_pfn) >> cma->order_per_bit;
 	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 
-	mutex_lock(&cma->lock);
+	spin_lock(&cma->lock);
 	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
-	mutex_unlock(&cma->lock);
+	spin_unlock(&cma->lock);
 }
 
 static int __init cma_activate_area(struct cma *cma)
@@ -126,7 +126,7 @@ static int __init cma_activate_area(struct cma *cma)
 		init_cma_reserved_pageblock(pfn_to_page(base_pfn));
 	} while (--i);
 
-	mutex_init(&cma->lock);
+	spin_lock_init(&cma->lock);
 
 #ifdef CONFIG_CMA_DEBUGFS
 	INIT_HLIST_HEAD(&cma->mem_head);
@@ -381,22 +381,25 @@ static void cma_debug_show_areas(struct cma *cma)
 	unsigned long nr_part, nr_total = 0;
 	unsigned long nbits = cma_bitmap_maxno(cma);
 
-	mutex_lock(&cma->lock);
 	pr_info("number of available pages: ");
 	for (;;) {
+		spin_lock(&cma->lock);
 		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
-		if (next_zero_bit >= nbits)
+		if (next_zero_bit >= nbits) {
+			spin_unlock(&cma->lock);
 			break;
+		}
 		next_set_bit = find_next_bit(cma->bitmap, nbits, next_zero_bit);
 		nr_zero = next_set_bit - next_zero_bit;
 		nr_part = nr_zero << cma->order_per_bit;
+		spin_unlock(&cma->lock);
+
 		pr_cont("%s%lu@%lu", nr_total ? "+" : "", nr_part,
 			next_zero_bit);
 		nr_total += nr_part;
 		start = next_zero_bit + nr_zero;
 	}
 	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
-	mutex_unlock(&cma->lock);
 }
 #else
 static inline void cma_debug_show_areas(struct cma *cma) { }
@@ -441,12 +444,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		return NULL;
 
 	for (;;) {
-		mutex_lock(&cma->lock);
+		spin_lock(&cma->lock);
 		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
 				bitmap_maxno, start, bitmap_count, mask,
 				offset);
 		if (bitmap_no >= bitmap_maxno) {
-			mutex_unlock(&cma->lock);
+			spin_unlock(&cma->lock);
 			break;
 		}
 		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
@@ -455,7 +458,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 		 * our exclusive use. If the migration fails we will take the
 		 * lock again and unmark it.
 		 */
-		mutex_unlock(&cma->lock);
+		spin_unlock(&cma->lock);
 
 		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
 		mutex_lock(&cma_mutex);
diff --git a/mm/cma.h b/mm/cma.h
index 33c0b517733c..7f5985b11439 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -7,7 +7,7 @@ struct cma {
 	unsigned long   count;
 	unsigned long   *bitmap;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
-	struct mutex    lock;
+	spinlock_t lock;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct hlist_head mem_head;
 	spinlock_t mem_head_lock;
-- 
2.25.1


