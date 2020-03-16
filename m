Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF97EC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C62206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326344;
	bh=iCt96E5njMMs6CflvXMtwjnWTr+mVz36Lx+Fo+/SpXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHcDxMkIx6RDjhFiwaen3mSzpoDVEmvDCZF6m4A00audOTVSfliDwQYvJCIFg6+QA
	 06WnAPzYkZZ3o/Vuhgsx1Taa1ZVXg66RjcBlWJg5mJOZLhFWZyzVlpYB6uLY50jQlv
	 DwU1gZ5aeJhQDaOPQYNweHQfSOZpwfqZzXjBSLfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgCPCjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbgCPCej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:34:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914A420754;
        Mon, 16 Mar 2020 02:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326078;
        bh=iCt96E5njMMs6CflvXMtwjnWTr+mVz36Lx+Fo+/SpXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w4CPwQf3c54kQhxXQRVghhf2yl0xaVw1D1fTTQZYedMzpokyO6v3vdHQnp3WUGtWR
         f5guVfyqeZqMqi/xCaacFOG0BxJfnpyltbBvLZxXboADQVuaaEoXQL1+DVKb+VaZWd
         b26zmsNw014qvM48KzNTD9JviopyKyDyXpBjPykw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Snitzer <snitzer@redhat.com>,
        =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 5.4 23/35] dm integrity: use dm_bio_record and dm_bio_restore
Date:   Sun, 15 Mar 2020 22:33:59 -0400
Message-Id: <20200316023411.1263-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023411.1263-1-sashal@kernel.org>
References: <20200316023411.1263-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

[ Upstream commit 248aa2645aa7fc9175d1107c2593cc90d4af5a4e ]

In cases where dec_in_flight() has to requeue the integrity_bio_wait
work to transfer the rest of the data, the bio's __bi_remaining might
already have been decremented to 0, e.g.: if bio passed to underlying
data device was split via blk_queue_split().

Use dm_bio_{record,restore} rather than effectively open-coding them in
dm-integrity -- these methods now manage __bi_remaining too.

Depends-on: f7f0b057a9c1 ("dm bio record: save/restore bi_end_io and bi_integrity")
Reported-by: Daniel Glöckner <dg@emlix.com>
Suggested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 57ac603f37410..145bc2e7eaf01 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -6,6 +6,8 @@
  * This file is released under the GPL.
  */
 
+#include "dm-bio-record.h"
+
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/device-mapper.h>
@@ -292,11 +294,7 @@ struct dm_integrity_io {
 
 	struct completion *completion;
 
-	struct gendisk *orig_bi_disk;
-	u8 orig_bi_partno;
-	bio_end_io_t *orig_bi_end_io;
-	struct bio_integrity_payload *orig_bi_integrity;
-	struct bvec_iter orig_bi_iter;
+	struct dm_bio_details bio_details;
 };
 
 struct journal_completion {
@@ -1447,14 +1445,9 @@ static void integrity_end_io(struct bio *bio)
 {
 	struct dm_integrity_io *dio = dm_per_bio_data(bio, sizeof(struct dm_integrity_io));
 
-	bio->bi_iter = dio->orig_bi_iter;
-	bio->bi_disk = dio->orig_bi_disk;
-	bio->bi_partno = dio->orig_bi_partno;
-	if (dio->orig_bi_integrity) {
-		bio->bi_integrity = dio->orig_bi_integrity;
+	dm_bio_restore(&dio->bio_details, bio);
+	if (bio->bi_integrity)
 		bio->bi_opf |= REQ_INTEGRITY;
-	}
-	bio->bi_end_io = dio->orig_bi_end_io;
 
 	if (dio->completion)
 		complete(dio->completion);
@@ -1539,7 +1532,7 @@ static void integrity_metadata(struct work_struct *w)
 			}
 		}
 
-		__bio_for_each_segment(bv, bio, iter, dio->orig_bi_iter) {
+		__bio_for_each_segment(bv, bio, iter, dio->bio_details.bi_iter) {
 			unsigned pos;
 			char *mem, *checksums_ptr;
 
@@ -1583,7 +1576,7 @@ static void integrity_metadata(struct work_struct *w)
 		if (likely(checksums != checksums_onstack))
 			kfree(checksums);
 	} else {
-		struct bio_integrity_payload *bip = dio->orig_bi_integrity;
+		struct bio_integrity_payload *bip = dio->bio_details.bi_integrity;
 
 		if (bip) {
 			struct bio_vec biv;
@@ -2002,20 +1995,13 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 	} else
 		dio->completion = NULL;
 
-	dio->orig_bi_iter = bio->bi_iter;
-
-	dio->orig_bi_disk = bio->bi_disk;
-	dio->orig_bi_partno = bio->bi_partno;
+	dm_bio_record(&dio->bio_details, bio);
 	bio_set_dev(bio, ic->dev->bdev);
-
-	dio->orig_bi_integrity = bio_integrity(bio);
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
-
-	dio->orig_bi_end_io = bio->bi_end_io;
 	bio->bi_end_io = integrity_end_io;
-
 	bio->bi_iter.bi_size = dio->range.n_sectors << SECTOR_SHIFT;
+
 	generic_make_request(bio);
 
 	if (need_sync_io) {
-- 
2.20.1

