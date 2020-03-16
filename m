Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE141C5ACD6
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61B7206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326117;
	bh=6LKp/oRxKgmott8F39xSSbLgaXXdxdcuUA0dT6lBzm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7y4A80o59waBvbF30bByKTWNnoySpfZ5mC6AHK2JqLKCR3FmK80mIEIL/5JsAOFq
	 dNKUWeAK8HMlnRTAY6ihQiZFaoUZhTJKTGn405UCO0u+r7YU6Tf67s5apUj4zCPwZE
	 gU7c/dZI1p1o3CFnnvzGgLC5y+RPEq79ABINAkdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgCPCfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730090AbgCPCfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E663320724;
        Mon, 16 Mar 2020 02:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326108;
        bh=6LKp/oRxKgmott8F39xSSbLgaXXdxdcuUA0dT6lBzm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHPit7yHxs//CXe4P+zEe0FNDkt4fUJ6eOKuzWMinXBNAzUH7UIlBZ++z3XRRe0RM
         VvHFwnI/wS9FgoLRQUUXN7EJ7xXhU4ga34a/rILLqbKFDnN070t3qzVxEHQWoTxGjq
         Wcm8Iv2GYcyjU2acFXJoF1bJ+0hT5Uvy3D73c/UY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 4.19 12/20] dm bio record: save/restore bi_end_io and bi_integrity
Date:   Sun, 15 Mar 2020 22:34:45 -0400
Message-Id: <20200316023453.1800-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023453.1800-1-sashal@kernel.org>
References: <20200316023453.1800-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

[ Upstream commit 1b17159e52bb31f982f82a6278acd7fab1d3f67b ]

Also, save/restore __bi_remaining in case the bio was used in a
BIO_CHAIN (e.g. due to blk_queue_split).

Suggested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-bio-record.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/md/dm-bio-record.h b/drivers/md/dm-bio-record.h
index c82578af56a5b..2ea0360108e1d 100644
--- a/drivers/md/dm-bio-record.h
+++ b/drivers/md/dm-bio-record.h
@@ -20,8 +20,13 @@
 struct dm_bio_details {
 	struct gendisk *bi_disk;
 	u8 bi_partno;
+	int __bi_remaining;
 	unsigned long bi_flags;
 	struct bvec_iter bi_iter;
+	bio_end_io_t *bi_end_io;
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	struct bio_integrity_payload *bi_integrity;
+#endif
 };
 
 static inline void dm_bio_record(struct dm_bio_details *bd, struct bio *bio)
@@ -30,6 +35,11 @@ static inline void dm_bio_record(struct dm_bio_details *bd, struct bio *bio)
 	bd->bi_partno = bio->bi_partno;
 	bd->bi_flags = bio->bi_flags;
 	bd->bi_iter = bio->bi_iter;
+	bd->__bi_remaining = atomic_read(&bio->__bi_remaining);
+	bd->bi_end_io = bio->bi_end_io;
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	bd->bi_integrity = bio_integrity(bio);
+#endif
 }
 
 static inline void dm_bio_restore(struct dm_bio_details *bd, struct bio *bio)
@@ -38,6 +48,11 @@ static inline void dm_bio_restore(struct dm_bio_details *bd, struct bio *bio)
 	bio->bi_partno = bd->bi_partno;
 	bio->bi_flags = bd->bi_flags;
 	bio->bi_iter = bd->bi_iter;
+	atomic_set(&bio->__bi_remaining, bd->__bi_remaining);
+	bio->bi_end_io = bd->bi_end_io;
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	bio->bi_integrity = bd->bi_integrity;
+#endif
 }
 
 #endif
-- 
2.20.1

