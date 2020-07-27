Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15945C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27722070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="quscVl8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgG0Nk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:40:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45636 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgG0Nk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:40:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RDbZFg134485;
        Mon, 27 Jul 2020 13:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=nGLt9EKk198EdWzg50X+8wpdgF4yG6/fnWmLQefveYg=;
 b=quscVl8bRnt+qCDaIkTG68EKo9PfJ1XqbKCADq/Hwdn7Sksdp5G8xbkqZkip0S29Ov8K
 7r9utDNvWC5bWt+FxkmqCS4kwAGn2iF+SqIyJZ1plDycAeVbPHAmdpXF4s+8tvjDGEKT
 7aH2+1S8VqD1jPaJ+PvI7EcdGhHIAUF4qG1spH+2MsmbWm0NcgSsCOuwvqYfAO9COB/Q
 e9umszKYc7yRn7qL+v9NoEsVu6AHJGbIfJpOKCuxXlD+NpOIWrxbmz2Tts2o6MHWJfF6
 qmrwPV5qeQpl3VjJh08D9GUikT4KuUNGY8DgwMdqNB7XFtpeNOCHjoi+1D6HcDWnAhSv 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32hu1j1jm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 13:40:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RDdHpW178666;
        Mon, 27 Jul 2020 13:40:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32hu5qq3t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 13:40:52 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RDepFM022857;
        Mon, 27 Jul 2020 13:40:51 GMT
Received: from [192.168.1.106] (/47.220.71.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 06:40:51 -0700
From:   John Donnelly <John.P.donnelly@oracle.com>
Subject: (resend) [PATCH [linux-4.14.y]] dm cache: submit writethrough writes
 in parallel to origin and cache
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     john.p.donnelly@oracle.com, snitzer@redhat.com
Message-ID: <37c5a615-655d-c106-afd0-54e03f3c0eef@oracle.com>
Date:   Mon, 27 Jul 2020 08:40:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=823 mlxscore=0
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=815
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=2 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

Discontinue issuing writethrough write IO in series to the origin and
then cache.

Use bio_clone_fast() to create a new origin clone bio that will be
mapped to the origin device and then bio_chain() it to the bio that gets
remapped to the cache device. The origin clone bio does _not_ have a
copy of the per_bio_data -- as such check_if_tick_bio_needed() will not
be called.

The cache bio (parent bio) will not complete until the origin bio has
completed -- this fulfills bio_clone_fast()'s requirements as well as
the requirement to not complete the original IO until the write IO has
completed to both the origin and cache device.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>

(cherry picked from commit 2df3bae9a6543e90042291707b8db0cbfbae9ee9)

Fixes: 705559706d62038b74c5088114c1799cf2c9dce8 (dm bio record:
save/restore bi_end_io and bi_integrity, version 4.14.188)

70555970 introduced a mkfs.ext4 hang on a LVM device that has been
modified with lvconvert --cachemode=writethrough.

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Tested-by: John Donnelly <john.p.donnelly@oracle.com>
Reviewed-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>

conflict: drivers/md/dm-cache-target.c - Corrected syntax of
writethrough_mode(&cache->feature) that was caught by
arm compiler.

cc: stable@vger.kernel.org
cc: snitzer@redhat.com
---
drivers/md/dm-cache-target.c | 54 ++++++++++++++++++++++++------------
1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 69cdb29ef6be..8241b7c36655 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -450,6 +450,7 @@ struct cache {
struct work_struct migration_worker;
struct delayed_work waker;
struct dm_bio_prison_v2 *prison;
+ struct bio_set *bs;
mempool_t *migration_pool;
@@ -868,16 +869,23 @@ static void check_if_tick_bio_needed(struct cache 
*cache, struct bio *bio)
spin_unlock_irqrestore(&cache->lock, flags);
}
-static void remap_to_origin_clear_discard(struct cache *cache, struct 
bio *bio,
- dm_oblock_t oblock)
+static void __remap_to_origin_clear_discard(struct cache *cache, struct 
bio *bio,
+ dm_oblock_t oblock, bool bio_has_pbd)
{
- // FIXME: this is called way too much.
- check_if_tick_bio_needed(cache, bio);
+ if (bio_has_pbd)
+ check_if_tick_bio_needed(cache, bio);
remap_to_origin(cache, bio);
if (bio_data_dir(bio) == WRITE)
clear_discard(cache, oblock_to_dblock(cache, oblock));
}
+static void remap_to_origin_clear_discard(struct cache *cache, struct 
bio *bio,
+ dm_oblock_t oblock)
+{
+ // FIXME: check_if_tick_bio_needed() is called way too much through 
this interface
+ __remap_to_origin_clear_discard(cache, bio, oblock, true);
+}
+
static void remap_to_cache_dirty(struct cache *cache, struct bio *bio,
dm_oblock_t oblock, dm_cblock_t cblock)
{
@@ -971,23 +979,25 @@ static void writethrough_endio(struct bio *bio)
}
/*
- * FIXME: send in parallel, huge latency as is.
* When running in writethrough mode we need to send writes to clean blocks
- * to both the cache and origin devices. In future we'd like to clone the
- * bio and send them in parallel, but for now we're doing them in
- * series as this is easier.
+ * to both the cache and origin devices. Clone the bio and send them in 
parallel.
*/
-static void remap_to_origin_then_cache(struct cache *cache, struct bio 
*bio,
- dm_oblock_t oblock, dm_cblock_t cblock)
+static void remap_to_origin_and_cache(struct cache *cache, struct bio *bio,
+ dm_oblock_t oblock, dm_cblock_t cblock)
{
- struct per_bio_data *pb = get_per_bio_data(bio, PB_DATA_SIZE_WT);
+ struct bio *origin_bio = bio_clone_fast(bio, GFP_NOIO, cache->bs);
- pb->cache = cache;
- pb->cblock = cblock;
- dm_hook_bio(&pb->hook_info, bio, writethrough_endio, NULL);
- dm_bio_record(&pb->bio_details, bio);
+ BUG_ON(!origin_bio);
- remap_to_origin_clear_discard(pb->cache, bio, oblock);
+ bio_chain(origin_bio, bio);
+ /*
+ * Passing false to __remap_to_origin_clear_discard() skips
+ * all code that might use per_bio_data (since clone doesn't have it)
+ */
+ __remap_to_origin_clear_discard(cache, origin_bio, oblock, false);
+ submit_bio(origin_bio);
+
+ remap_to_cache(cache, bio, cblock);
}
/*----------------------------------------------------------------
@@ -1873,7 +1883,7 @@ static int map_bio(struct cache *cache, struct bio 
*bio, dm_oblock_t block,
} else {
if (bio_data_dir(bio) == WRITE && writethrough_mode(&cache->features) &&
!is_dirty(cache, cblock)) {
- remap_to_origin_then_cache(cache, bio, block, cblock);
+ remap_to_origin_and_cache(cache, bio, block, cblock);
accounted_begin(cache, bio);
} else
remap_to_cache_dirty(cache, bio, block, cblock);
@@ -2132,6 +2142,9 @@ static void destroy(struct cache *cache)
kfree(cache->ctr_args[i]);
kfree(cache->ctr_args);
+ if (cache->bs)
+ bioset_free(cache->bs);
+
kfree(cache);
}
@@ -2589,6 +2602,13 @@ static int cache_create(struct cache_args *ca, 
struct cache **result)
cache->features = ca->features;
ti->per_io_data_size = get_per_bio_data_size(cache);
+ if (writethrough_mode(&cache->features)) {
+ /* Create bioset for writethrough bios issued to origin */
+ cache->bs = bioset_create(BIO_POOL_SIZE, 0, 0);
+ if (!cache->bs)
+ goto bad;
+ }
+
cache->callbacks.congested_fn = cache_is_congested;
dm_table_add_target_callbacks(ti->table, &cache->callbacks);

-- 
2.26.2

