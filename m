Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B3AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F42075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fjjScxoK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bO3AoaFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgETVA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:00:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7134 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727839AbgETVAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:00:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04KKvf7Q021594;
        Wed, 20 May 2020 14:00:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uk5tuKTRIDBtX3xgFPADVMP/MBipRvUuHXe6mq7F5bo=;
 b=fjjScxoK0ASs1PgzpKn3ilz6a8dQAApsmMr1x1XYWJ1uFsUQtVpKtTsSpYtM4SY/qHOv
 OXDqX6GJfgnXvXSQxEvYBaS3olMQwTnU2weI8UJLTyrwf2dAIS6qxw93gxpkVgcv6gru
 cgRpNjm7s5O4PgDIUk7dxo+CgbxlqL9W5v0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 314rt7b5yb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 14:00:46 -0700
Received: from snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 20 May 2020 14:00:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 May 2020 14:00:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfT2en+bVavVTFSq0Es3ksi0YWkXrCt707p0gxfF25COOw5jDMSJtlPyZnKRdnstXRV+uZBMZNTmifaoRYG2DYSfw+FfdIZlcH1JTOaXt+FEh1HpE/c1nuzJjX13JNiBs0Rkdrejyj1G+Lu3N3UwnfVfweNOOrPO7NtYTrQh6RopSZ324AwqnxrWnDW1KJG17fZEG8BLRRfTt65vypSa5iA4hfrL9RJfCfnRqZyDQqu8R7iAl5/PBfwzWbtN7FeunsCgsHQiPb0+oIZkiTLq/wPOLCLarjP1s6dDRA6vt6DfU7MK9qhCUtyE1wE1iYC7TGFBnDAl+bV2Y67clqLUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk5tuKTRIDBtX3xgFPADVMP/MBipRvUuHXe6mq7F5bo=;
 b=n6EKuBYDZhcIO5Qgni9pbJmK91uScmObZ/YK+EJYFG5oDFOlAg8O70UwCSjNzb0W3luDnUF8omqyNk2tCQcsJKkwl9IqzWiD4xc2bEO0qPNlNrxPCYm525ws+Ui6+YA8GE8HqOAjzRgWnsrsdTViEnt0XU0ZSGfEXj0pUxng2NGMdii/QiYEN8Db86GSrxPwnOu+lVOV3YKcqqDXy8zgPOCuy89s/aI4hxnt0/5hM9LfKiGIKVsJWqxYIyL57qiNvQ3RISA1IN7qqka7AYK41SlD0cdgyjxZN6M7hXwiNRDBsLeLaoUCMGdSq3+tUJNycCVwYXcHcDPcj/DgkS3W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk5tuKTRIDBtX3xgFPADVMP/MBipRvUuHXe6mq7F5bo=;
 b=bO3AoaFYpE1clhbTVw6RCCeRPzpMhMbauoXcoX8BZIzU/Yj5CDXZqyFvt6xEodfnDS6padjvLSHGh7XC7Zek4/rS8F0k4HKK8IQGWqWY0sariqrnkRd7J9IMv3in63p3EZiarSyIoHNeqHfDn0pddFA/QSXEQ4dc6q3XQw6/jpA=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2263.namprd15.prod.outlook.com (2603:10b6:a02:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 21:00:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 21:00:43 +0000
Date:   Wed, 20 May 2020 14:00:40 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200520210040.GC278395@carbon.dhcp.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <0e0616f2-6c5a-8911-7d37-6f2027c2930b@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0616f2-6c5a-8911-7d37-6f2027c2930b@suse.cz>
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e80) by BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 21:00:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:e80]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce47d3b3-3428-48ee-8ff4-08d7fd00dc4a
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB226337017F8381BEFEBC7768BEB60@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfCoY9whZaunQ110232F1aFWJ72uC0IlItLmyiIUjhoI27fe3vbruqIC1IeB9AT9n/QU/rpGAXyBFuRe3tfKSKfcL263rXh5twWF0mFyLlg9UFapHEoqzt6mtpAqvIl/xw3mm9R6mLIPbMbZm7M8rKfjfunauf/atXdaHfzWY8MfAt1C7Vw+eVO0tdYAAR8zvuQYU2McZMGgFjwx3cEYmj91ZEnZxOWLmjz6jzys2jXk7rfegKqFQTqdJpo+sczEZ5hl8RhkShnDaegkRHuO4GOsv3X2nDLWHbOi6IWzqjd1YMPEyZSO1yQrDAoDkAgKHRBJ3Mt7xEomEayyPMH7Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(86362001)(5660300002)(8676002)(316002)(2906002)(478600001)(8936002)(6916009)(54906003)(6506007)(7696005)(52116002)(55016002)(9686003)(53546011)(33656002)(4326008)(66476007)(66946007)(1076003)(16526019)(186003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vmhwFfcvo/T0uwxepHbX4ZEKgqacooq4pl3UK+CXKadYusjW0p5HpAuCKrU0TOQTEN4WxFovVtP3aykEM0aDfyqlq35x5GSbg/A0QNFsvxERiK4Gbyrg/rYjQjQpiexJf3o8slUBbOr94xZqE64JLn6A2AA34CwNKyAwKC5QfiWtfSO5s70B+13E2d52iviXcpf8N9q7ib3oOlR+Yw2XIuwZWeaJjaUyaFNljZASo4N5okAHP1YJ21uKSXwHBweVJNK1AkS+jROZBPtlCYuqbvAYZhY1fRRpVzaZRSD7BLiOCvjK/SF5bDJgIQ8IE5N8n0jwWo6s2KDpefdJ3lmfjca9pZ8+MOR7qumw4lSRGp7GoeFBMEbV8mXxTExtXmL/nmlyuXB0/KGcbCBUUbBUce2hYlgBO8/GYlxDMxqRAk02Nh1JrOpbOYzDANOIyzmV4ei99mJ2eIuwXb1LNlQJTspICrNDhKFO13Km0s6O42mH81M+DzFxix0ffP5j8xn7LC3lnoDtd/nIu1Nx2xu0DQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce47d3b3-3428-48ee-8ff4-08d7fd00dc4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 21:00:43.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5xBxZKo3X++pP/7t9PnfTRQDebgOwrVKX2uwSQwEdCocW7vhlVxy14PcBk29VhB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_16:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=5 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 cotscore=-2147483648 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200167
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:51:45PM +0200, Vlastimil Babka wrote:
> On 4/22/20 10:46 PM, Roman Gushchin wrote:
> > This commit implements SLUB version of the obj_to_index() function,
> > which will be required to calculate the offset of obj_cgroup in the
> > obj_cgroups vector to store/obtain the objcg ownership data.
> > 
> > To make it faster, let's repeat the SLAB's trick introduced by
> > commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
> > divide in obj_to_index()") and avoid an expensive division.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Christoph Lameter <cl@linux.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> There's already a slab_index() doing the same without the trick, with only
> SLUB_DEBUG callers. Maybe just improve it and perhaps rename? (obj_to_index()
> seems more descriptive). The difference is that it takes the result of
> page_addr() instead of doing that, as it's being called in a loop on objects
> from a single page, so you'd have to perhaps split to obj_to_index(page) and
> __obj_to_index(addr) or something.

Good point! How about this one?

--

From beeaecdac85c3a395dcfb99944dc8c858b541cbf Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Mon, 29 Jul 2019 18:18:42 -0700
Subject: [PATCH v3.2 04/19] mm: slub: implement SLUB version of obj_to_index()

This commit implements SLUB version of the obj_to_index() function,
which will be required to calculate the offset of obj_cgroup in the
obj_cgroups vector to store/obtain the objcg ownership data.

To make it faster, let's repeat the SLAB's trick introduced by
commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
divide in obj_to_index()") and avoid an expensive division.

Vlastimil Babka noticed, that SLUB does have already a similar
function called slab_index(), which is defined only if SLUB_DEBUG
is enabled. The function does a similar math, but with a division,
and it also takes a page address instead of a page pointer.

Let's remove slab_index() and replace it with the new helper
__obj_to_index(), which takes a page address. obj_to_index()
will be a simple wrapper taking a page pointer and passing
page_address(page) into __obj_to_index().

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/slub_def.h | 16 ++++++++++++++++
 mm/slub.c                | 15 +++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index d2153789bd9f..30e91c83d401 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -8,6 +8,7 @@
  * (C) 2007 SGI, Christoph Lameter
  */
 #include <linux/kobject.h>
+#include <linux/reciprocal_div.h>
 
 enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
@@ -86,6 +87,7 @@ struct kmem_cache {
 	unsigned long min_partial;
 	unsigned int size;	/* The size of an object including metadata */
 	unsigned int object_size;/* The size of an object without metadata */
+	struct reciprocal_value reciprocal_size;
 	unsigned int offset;	/* Free pointer offset */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
@@ -182,4 +184,18 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
 	return result;
 }
 
+/* Determine object index from a given position */
+static inline unsigned int __obj_to_index(const struct kmem_cache *cache,
+					  void *addr, void *obj)
+{
+	return reciprocal_divide(kasan_reset_tag(obj) - addr,
+				 cache->reciprocal_size);
+}
+
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct page *page, void *obj)
+{
+	return __obj_to_index(cache, page_address(page), obj);
+}
+
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/slub.c b/mm/slub.c
index 2df4d4a420d1..d605d18b3c1b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -313,12 +313,6 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 		__p < (__addr) + (__objects) * (__s)->size; \
 		__p += (__s)->size)
 
-/* Determine object index from a given position */
-static inline unsigned int slab_index(void *p, struct kmem_cache *s, void *addr)
-{
-	return (kasan_reset_tag(p) - addr) / s->size;
-}
-
 static inline unsigned int order_objects(unsigned int order, unsigned int size)
 {
 	return ((unsigned int)PAGE_SIZE << order) / size;
@@ -461,7 +455,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 	bitmap_zero(object_map, page->objects);
 
 	for (p = page->freelist; p; p = get_freepointer(s, p))
-		set_bit(slab_index(p, s, addr), object_map);
+		set_bit(__obj_to_index(s, addr, p), object_map);
 
 	return object_map;
 }
@@ -3682,6 +3676,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	 */
 	size = ALIGN(size, s->align);
 	s->size = size;
+	s->reciprocal_size = reciprocal_value(size);
 	if (forced_order >= 0)
 		order = forced_order;
 	else
@@ -3788,7 +3783,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
 
-		if (!test_bit(slab_index(p, s, addr), map)) {
+		if (!test_bit(__obj_to_index(s, addr, p), map)) {
 			pr_err("INFO: Object 0x%p @offset=%tu\n", p, p - addr);
 			print_tracking(s, p);
 		}
@@ -4513,7 +4508,7 @@ static void validate_slab(struct kmem_cache *s, struct page *page)
 	/* Now we know that a valid freelist exists */
 	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
-		u8 val = test_bit(slab_index(p, s, addr), map) ?
+		u8 val = test_bit(__obj_to_index(s, addr, p), map) ?
 			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
 
 		if (!check_object(s, page, p, val))
@@ -4704,7 +4699,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 
 	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects)
-		if (!test_bit(slab_index(p, s, addr), map))
+		if (!test_bit(__obj_to_index(s, addr, p), map))
 			add_location(t, s, get_track(s, p, alloc));
 	put_map(map);
 }
-- 
2.25.4

