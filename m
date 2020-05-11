Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B0EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C50620714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbgEKQjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:39:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53316 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgEKQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:39:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 85BB32A0945
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org,
        breeves@redhat.com, mpatocka@redhat.com, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 1/2] md: mpath: Pass IO start time to path selector
Date:   Mon, 11 May 2020 12:39:09 -0400
Message-Id: <20200511163910.3778467-2-krisman@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511163910.3778467-1-krisman@collabora.com>
References: <20200511163910.3778467-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HST is going to need this information to perform path prediction. For
request-based mpath, we use the struct request io_start_time, while for
bio based, use the DM layer start_time.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 drivers/md/dm-mpath.c         | 12 +++++++++---
 drivers/md/dm-path-selector.h |  2 +-
 drivers/md/dm-queue-length.c  |  2 +-
 drivers/md/dm-service-time.c  |  2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index f5e7f8e88767..deb6ae5ad35b 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -105,6 +105,7 @@ struct multipath {
 struct dm_mpath_io {
 	struct pgpath *pgpath;
 	size_t nr_bytes;
+	u64 start_time_ns;
 };
 
 typedef int (*action_fn) (struct pgpath *pgpath);
@@ -519,6 +520,7 @@ static int multipath_clone_and_map(struct dm_target *ti, struct request *rq,
 
 	mpio->pgpath = pgpath;
 	mpio->nr_bytes = nr_bytes;
+	mpio->start_time_ns = rq->io_start_time_ns;
 
 	bdev = pgpath->path.dev->bdev;
 	q = bdev_get_queue(bdev);
@@ -567,7 +569,8 @@ static void multipath_release_clone(struct request *clone,
 		if (pgpath && pgpath->pg->ps.type->end_io)
 			pgpath->pg->ps.type->end_io(&pgpath->pg->ps,
 						    &pgpath->path,
-						    mpio->nr_bytes);
+						    mpio->nr_bytes,
+						    mpio->start_time_ns);
 	}
 
 	blk_put_request(clone);
@@ -629,6 +632,7 @@ static int __multipath_map_bio(struct multipath *m, struct bio *bio,
 	}
 
 	mpio->pgpath = pgpath;
+	mpio->start_time_ns = ktime_get_ns();
 
 	bio->bi_status = 0;
 	bio_set_dev(bio, pgpath->path.dev->bdev);
@@ -1620,7 +1624,8 @@ static int multipath_end_io(struct dm_target *ti, struct request *clone,
 		struct path_selector *ps = &pgpath->pg->ps;
 
 		if (ps->type->end_io)
-			ps->type->end_io(ps, &pgpath->path, mpio->nr_bytes);
+			ps->type->end_io(ps, &pgpath->path, mpio->nr_bytes,
+					 mpio->start_time_ns);
 	}
 
 	return r;
@@ -1664,7 +1669,8 @@ static int multipath_end_io_bio(struct dm_target *ti, struct bio *clone,
 		struct path_selector *ps = &pgpath->pg->ps;
 
 		if (ps->type->end_io)
-			ps->type->end_io(ps, &pgpath->path, mpio->nr_bytes);
+			ps->type->end_io(ps, &pgpath->path, mpio->nr_bytes,
+					 mpio->start_time_ns);
 	}
 
 	return r;
diff --git a/drivers/md/dm-path-selector.h b/drivers/md/dm-path-selector.h
index b6eb5365b1a4..c47bc0e20275 100644
--- a/drivers/md/dm-path-selector.h
+++ b/drivers/md/dm-path-selector.h
@@ -74,7 +74,7 @@ struct path_selector_type {
 	int (*start_io) (struct path_selector *ps, struct dm_path *path,
 			 size_t nr_bytes);
 	int (*end_io) (struct path_selector *ps, struct dm_path *path,
-		       size_t nr_bytes);
+		       size_t nr_bytes, u64 start_time);
 };
 
 /* Register a path selector */
diff --git a/drivers/md/dm-queue-length.c b/drivers/md/dm-queue-length.c
index 969c4f1a3633..5fd018d18418 100644
--- a/drivers/md/dm-queue-length.c
+++ b/drivers/md/dm-queue-length.c
@@ -227,7 +227,7 @@ static int ql_start_io(struct path_selector *ps, struct dm_path *path,
 }
 
 static int ql_end_io(struct path_selector *ps, struct dm_path *path,
-		     size_t nr_bytes)
+		     size_t nr_bytes, u64 start_time)
 {
 	struct path_info *pi = path->pscontext;
 
diff --git a/drivers/md/dm-service-time.c b/drivers/md/dm-service-time.c
index f006a9005593..9cfda665e9eb 100644
--- a/drivers/md/dm-service-time.c
+++ b/drivers/md/dm-service-time.c
@@ -309,7 +309,7 @@ static int st_start_io(struct path_selector *ps, struct dm_path *path,
 }
 
 static int st_end_io(struct path_selector *ps, struct dm_path *path,
-		     size_t nr_bytes)
+		     size_t nr_bytes, u64 start_time)
 {
 	struct path_info *pi = path->pscontext;
 
-- 
2.26.2

