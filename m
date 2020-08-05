Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE62CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E68208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z9LkveQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgHEAJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:09:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41196 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgHEAJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:09:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075023on039636
        for <linux-kernel@vger.kernel.org>; Wed, 5 Aug 2020 00:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=cmUh+HFEch2Q0bmJXzqRX2Xx7MA6Tv/sL3+zVK34Q9w=;
 b=z9LkveQWElntD9+ueJWkRVjdNEQNvpHFePurm6u6rstogKsg5F44S+KTyjByMkrD+50T
 jsQlkjyRId7JkLKSTZMPmDNNx2PVHkctrdH/f+PLwJxRkv//QkPWY9WcCdlEnBkO1B5H
 LyyYw3aE3ZI3ejnEn4TE2EoajIvjQrVpb6nauZHAg+ioxQLTRba6GhGTsZaDKBEeJ1t3
 p7t7cUhj0q5rC+g+dgO6cUS1OROE7EixKrCDfoharcObFtAh+zKUejnqv4ifNOVBHl7E
 VPe8Us8QdbB/HLBFZl0ns+xEiueXEt2GUidKCjhpT/q3B+bt+v5Zlyqs4DLxtJkpKlMg mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32n11n760j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:09:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07502wMh137646
        for <linux-kernel@vger.kernel.org>; Wed, 5 Aug 2020 00:07:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.147.25.63])
        by userp3020.oracle.com with ESMTP id 32pdhd3knf-1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:07:46 +0000
From:   john.p.donnelly@oracle.com
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v4: {linux-4.14.y} ] dm cache: submit writethrough writes in parallel to origin and cache
Date:   Tue,  4 Aug 2020 17:07:46 -0700
Message-Id: <20200805000746.53112-1-john.p.donnelly@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=712 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040167
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=3 mlxlogscore=786 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

Discontinue issuing writethrough write IO in series to the origin and
then cache.

Use bio_clone_fast() to create a new origin clone bio that will be
mapped to the origin device and then bio_chain() it to the bio that gets
remapped to the cache device.  The origin clone bio does _not_ have a
copy of the per_bio_data -- as such check_if_tick_bio_needed() will not
be called.

The cache bio (parent bio) will not complete until the origin bio has
completed -- this fulfills bio_clone_fast()'s requirements as well as
the requirement to not complete the original IO until the write IO has
completed to both the origin and cache device.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>

(cherry picked from commit 2df3bae9a6543e90042291707b8db0cbfbae9ee9)

Fixes: 4ec34f2196d125ff781170ddc6c3058c08ec5e73 (dm bio record:
save/restore bi_end_io and bi_integrity )

4ec34f21 introduced a mkfs.ext4 hang on a LVM device that has been
modified with lvconvert --cachemode=writethrough.

CC:stable@vger.kernel.org for 4.14.y

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Reviewed-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
---
 drivers/md/dm-cache-target.c | 92 ++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 55 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 69cdb29ef6be..2732d1df05fa 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -450,6 +450,7 @@ struct cache {
 	struct work_struct migration_worker;
 	struct delayed_work waker;
 	struct dm_bio_prison_v2 *prison;
+	struct bio_set *bs;
 
 	mempool_t *migration_pool;
 
@@ -537,11 +538,6 @@ static void wake_deferred_bio_worker(struct cache *cache)
 	queue_work(cache->wq, &cache->deferred_bio_worker);
 }
 
-static void wake_deferred_writethrough_worker(struct cache *cache)
-{
-	queue_work(cache->wq, &cache->deferred_writethrough_worker);
-}
-
 static void wake_migration_worker(struct cache *cache)
 {
 	if (passthrough_mode(&cache->features))
@@ -868,16 +864,23 @@ static void check_if_tick_bio_needed(struct cache *cache, struct bio *bio)
 	spin_unlock_irqrestore(&cache->lock, flags);
 }
 
-static void remap_to_origin_clear_discard(struct cache *cache, struct bio *bio,
-					  dm_oblock_t oblock)
+static void __remap_to_origin_clear_discard(struct cache *cache, struct bio *bio,
+					    dm_oblock_t oblock, bool bio_has_pbd)
 {
-	// FIXME: this is called way too much.
-	check_if_tick_bio_needed(cache, bio);
+	if (bio_has_pbd)
+		check_if_tick_bio_needed(cache, bio);
 	remap_to_origin(cache, bio);
 	if (bio_data_dir(bio) == WRITE)
 		clear_discard(cache, oblock_to_dblock(cache, oblock));
 }
 
+static void remap_to_origin_clear_discard(struct cache *cache, struct bio *bio,
+					  dm_oblock_t oblock)
+{
+	// FIXME: check_if_tick_bio_needed() is called way too much through this interface
+	__remap_to_origin_clear_discard(cache, bio, oblock, true);
+}
+
 static void remap_to_cache_dirty(struct cache *cache, struct bio *bio,
 				 dm_oblock_t oblock, dm_cblock_t cblock)
 {
@@ -937,57 +940,26 @@ static void issue_op(struct bio *bio, void *context)
 	accounted_request(cache, bio);
 }
 
-static void defer_writethrough_bio(struct cache *cache, struct bio *bio)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cache->lock, flags);
-	bio_list_add(&cache->deferred_writethrough_bios, bio);
-	spin_unlock_irqrestore(&cache->lock, flags);
-
-	wake_deferred_writethrough_worker(cache);
-}
-
-static void writethrough_endio(struct bio *bio)
-{
-	struct per_bio_data *pb = get_per_bio_data(bio, PB_DATA_SIZE_WT);
-
-	dm_unhook_bio(&pb->hook_info, bio);
-
-	if (bio->bi_status) {
-		bio_endio(bio);
-		return;
-	}
-
-	dm_bio_restore(&pb->bio_details, bio);
-	remap_to_cache(pb->cache, bio, pb->cblock);
-
-	/*
-	 * We can't issue this bio directly, since we're in interrupt
-	 * context.  So it gets put on a bio list for processing by the
-	 * worker thread.
-	 */
-	defer_writethrough_bio(pb->cache, bio);
-}
-
 /*
- * FIXME: send in parallel, huge latency as is.
  * When running in writethrough mode we need to send writes to clean blocks
- * to both the cache and origin devices.  In future we'd like to clone the
- * bio and send them in parallel, but for now we're doing them in
- * series as this is easier.
+ * to both the cache and origin devices.  Clone the bio and send them in parallel.
  */
-static void remap_to_origin_then_cache(struct cache *cache, struct bio *bio,
-				       dm_oblock_t oblock, dm_cblock_t cblock)
+static void remap_to_origin_and_cache(struct cache *cache, struct bio *bio,
+				      dm_oblock_t oblock, dm_cblock_t cblock)
 {
-	struct per_bio_data *pb = get_per_bio_data(bio, PB_DATA_SIZE_WT);
+	struct bio *origin_bio = bio_clone_fast(bio, GFP_NOIO, cache->bs);
+
+	BUG_ON(!origin_bio);
 
-	pb->cache = cache;
-	pb->cblock = cblock;
-	dm_hook_bio(&pb->hook_info, bio, writethrough_endio, NULL);
-	dm_bio_record(&pb->bio_details, bio);
+	bio_chain(origin_bio, bio);
+	/*
+	 * Passing false to __remap_to_origin_clear_discard() skips
+	 * all code that might use per_bio_data (since clone doesn't have it)
+	 */
+	__remap_to_origin_clear_discard(cache, origin_bio, oblock, false);
+	submit_bio(origin_bio);
 
-	remap_to_origin_clear_discard(pb->cache, bio, oblock);
+	remap_to_cache(cache, bio, cblock);
 }
 
 /*----------------------------------------------------------------
@@ -1873,7 +1845,7 @@ static int map_bio(struct cache *cache, struct bio *bio, dm_oblock_t block,
 		} else {
 			if (bio_data_dir(bio) == WRITE && writethrough_mode(&cache->features) &&
 			    !is_dirty(cache, cblock)) {
-				remap_to_origin_then_cache(cache, bio, block, cblock);
+				remap_to_origin_and_cache(cache, bio, block, cblock);
 				accounted_begin(cache, bio);
 			} else
 				remap_to_cache_dirty(cache, bio, block, cblock);
@@ -2132,6 +2104,9 @@ static void destroy(struct cache *cache)
 		kfree(cache->ctr_args[i]);
 	kfree(cache->ctr_args);
 
+	if (cache->bs)
+		bioset_free(cache->bs);
+
 	kfree(cache);
 }
 
@@ -2589,6 +2564,13 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 	cache->features = ca->features;
 	ti->per_io_data_size = get_per_bio_data_size(cache);
 
+	if (writethrough_mode(&cache->features)) {
+		/* Create bioset for writethrough bios issued to origin */
+		cache->bs = bioset_create(BIO_POOL_SIZE, 0, 0);
+		if (!cache->bs)
+			goto bad;
+	}
+
 	cache->callbacks.congested_fn = cache_is_congested;
 	dm_table_add_target_callbacks(ti->table, &cache->callbacks);
 
-- 
1.8.3.1

