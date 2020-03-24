Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105BCC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE27B208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055771;
	bh=iCt96E5njMMs6CflvXMtwjnWTr+mVz36Lx+Fo+/SpXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qpu+/kaw5rnnzr06IXSf2relfkmhlkZ32XQgQa3/gH7q9xW/CF/n5FpPkoXQg9OVj
	 tr75bip1TOSW0s0FAZri9lshDG4pcmEGoF0UmM3bUEZ4vShx/RKb43G2fzd5lFjS7l
	 ZmOPKs4HRUxjLmgQiRHf4vuLPDMTce5uM7HFKKYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgCXNQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgCXNQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:16:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B148214DB;
        Tue, 24 Mar 2020 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055767;
        bh=iCt96E5njMMs6CflvXMtwjnWTr+mVz36Lx+Fo+/SpXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5x10USM2EgRCALBOXmdS8ITe21iOhSgPylgUNbK5f0ARcGV8z1UBNabN9IcM6tDl
         sTPvIAGoWcdOvYfTIHdEj4OBITKUG1N3hZdS0RRv43yFqTpdYy8MJW8Vv1NQHEmFDI
         T4AIJvxs/EoelgDxhLfwaf0lk77bnADHBbMaJMSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 022/102] dm integrity: use dm_bio_record and dm_bio_restore
Date:   Tue, 24 Mar 2020 14:10:14 +0100
Message-Id: <20200324130808.776466816@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



