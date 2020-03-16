Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB37C10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D13206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326453;
	bh=H7rAtrMnqgIiYVkTvo3D9J9a+AW7cz6/k54xWmBkSSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s2EfjQrL4uwxqJCMlqw9KJ0igUcTa+z24jn5v47YGWjbMZGi6I5b6ZC7r6hAWY8+N
	 cNMD3Gb1vl7fF99D4MTuS6lRtw2NSznArhb3G9dkUjfLJMHBpZhtShF2uTfCEfsdD9
	 rS7L8Uudyr8dWPpfaxxEnDITc0ZUV8gS6rX27QTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgCPCkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbgCPCdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C838206EB;
        Mon, 16 Mar 2020 02:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326032;
        bh=H7rAtrMnqgIiYVkTvo3D9J9a+AW7cz6/k54xWmBkSSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1yxclHPNiP4xQFxmjXVHc3O3RgEA3O1HQrTLmmXtW9WVSUKHtFEICJ+fnq2dLkJmD
         E68RhdjSig+Rq/kfH2JLtdTkHJ+Yfq+XHenVJRJljBciQI2zinB6xFQsBmODOYVkKa
         X0aRn/wUZ/ynHv+ew9LJbw69pDb9owQsmPn5UxcE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Snitzer <snitzer@redhat.com>,
        =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 5.5 27/41] dm integrity: use dm_bio_record and dm_bio_restore
Date:   Sun, 15 Mar 2020 22:33:05 -0400
Message-Id: <20200316023319.749-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
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
index e1ad0b53f681a..a82a9c2577443 100644
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
@@ -295,11 +297,7 @@ struct dm_integrity_io {
 
 	struct completion *completion;
 
-	struct gendisk *orig_bi_disk;
-	u8 orig_bi_partno;
-	bio_end_io_t *orig_bi_end_io;
-	struct bio_integrity_payload *orig_bi_integrity;
-	struct bvec_iter orig_bi_iter;
+	struct dm_bio_details bio_details;
 };
 
 struct journal_completion {
@@ -1452,14 +1450,9 @@ static void integrity_end_io(struct bio *bio)
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
@@ -1544,7 +1537,7 @@ static void integrity_metadata(struct work_struct *w)
 			}
 		}
 
-		__bio_for_each_segment(bv, bio, iter, dio->orig_bi_iter) {
+		__bio_for_each_segment(bv, bio, iter, dio->bio_details.bi_iter) {
 			unsigned pos;
 			char *mem, *checksums_ptr;
 
@@ -1588,7 +1581,7 @@ static void integrity_metadata(struct work_struct *w)
 		if (likely(checksums != checksums_onstack))
 			kfree(checksums);
 	} else {
-		struct bio_integrity_payload *bip = dio->orig_bi_integrity;
+		struct bio_integrity_payload *bip = dio->bio_details.bi_integrity;
 
 		if (bip) {
 			struct bio_vec biv;
@@ -2007,20 +2000,13 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
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

