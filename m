Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F54208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858991;
	bh=sb+qhjXNVsv1VroXUvyjtb9SKNPAk6rOAa9tprQ65x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rscLEv4ThJYV+2KSNOvz/kaH8eprL+aI/rnFYPZ4I6LjIQHvc0nI/ncYSTUwvk1TQ
	 qNth+3y1rR1ht5XoF0p9vWn4U7sf1kaWwcslQfGAhwGMxPQpyRa5PeQiR7AnI6ZAeE
	 u0ACczB2oSCkMuAc7tvQm2hq/rHdck/Wxgk+g2H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbgAXJnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:43:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbgAXJnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:43:05 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC9420718;
        Fri, 24 Jan 2020 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858985;
        bh=sb+qhjXNVsv1VroXUvyjtb9SKNPAk6rOAa9tprQ65x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrfnmdKULY4l6h9M8TynaS05AqWcqiCOgetZc3mgrxPmPhsgPbzeOQrP8RZYpHLiy
         8/Yb07A7myQl5DmhPPCnksOGaR+8ZSIhRFYpxT3DVVKvt6MmRpmi+JFREMmQGLQzGL
         8YD+/ni1h/5dbnBlLskNLuSqfqHrZPmGoyHM/GOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 097/102] block: fix memleak of bio integrity data
Date:   Fri, 24 Jan 2020 10:31:38 +0100
Message-Id: <20200124092821.351356454@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit ece841abbed2da71fa10710c687c9ce9efb6bf69 ]

7c20f11680a4 ("bio-integrity: stop abusing bi_end_io") moves
bio_integrity_free from bio_uninit() to bio_integrity_verify_fn()
and bio_endio(). This way looks wrong because bio may be freed
without calling bio_endio(), for example, blk_rq_unprep_clone() is
called from dm_mq_queue_rq() when the underlying queue of dm-mpath
is busy.

So memory leak of bio integrity data is caused by commit 7c20f11680a4.

Fixes this issue by re-adding bio_integrity_free() to bio_uninit().

Fixes: 7c20f11680a4 ("bio-integrity: stop abusing bi_end_io")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by Justin Tee <justin.tee@broadcom.com>

Add commit log, and simplify/fix the original patch wroten by Justin.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio-integrity.c | 2 +-
 block/bio.c           | 3 +++
 block/blk.h           | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index fb95dbb21dd88..bf62c25cde8f4 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -87,7 +87,7 @@ EXPORT_SYMBOL(bio_integrity_alloc);
  * Description: Used to free the integrity portion of a bio. Usually
  * called from bio_free().
  */
-static void bio_integrity_free(struct bio *bio)
+void bio_integrity_free(struct bio *bio)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	struct bio_set *bs = bio->bi_pool;
diff --git a/block/bio.c b/block/bio.c
index 906da3581a3e8..94d697217887a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -233,6 +233,9 @@ fallback:
 void bio_uninit(struct bio *bio)
 {
 	bio_disassociate_blkg(bio);
+
+	if (bio_integrity(bio))
+		bio_integrity_free(bio);
 }
 EXPORT_SYMBOL(bio_uninit);
 
diff --git a/block/blk.h b/block/blk.h
index ffea1691470e6..ee3d5664d9627 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -122,6 +122,7 @@ static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
+void bio_integrity_free(struct bio *bio);
 static inline bool bio_integrity_endio(struct bio *bio)
 {
 	if (bio_integrity(bio))
@@ -167,6 +168,9 @@ static inline bool bio_integrity_endio(struct bio *bio)
 {
 	return true;
 }
+static inline void bio_integrity_free(struct bio *bio)
+{
+}
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 unsigned long blk_rq_timeout(unsigned long timeout);
-- 
2.20.1



