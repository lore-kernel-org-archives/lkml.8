Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD5BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA0620723
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930562;
	bh=AiOlWcS4Nc4rzG2Flyr2zCMjKAcNKrD8KD3GG6vV3I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7AgpEkHXml9F6lA+f5t7eRw3c052fSKCt6o2BdT1wxHG2WXZWPIi59lnht733g3y
	 +qQPWv7xmgpL6c+VnfdPhPdmflsgbpVOwLvaBl1p5dKLLJ9NhoxOMz+bOPmxSj2gjy
	 V3gDe64crr9y/GwMAzGr5SOjo6jdTZHJlNUHKgB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgHHXtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgHHXhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:37:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96EE206E9;
        Sat,  8 Aug 2020 23:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929825;
        bh=AiOlWcS4Nc4rzG2Flyr2zCMjKAcNKrD8KD3GG6vV3I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3WQ4MPQ8x2mNgB65qSOE7LG44d1llo0Uj1t0a3S5T7tPnXhgTE9fGKVDrlRfgZy6
         5C65AHYz448IiBNg/bvUUd1U9c8lmKrEzskitvQqT5KY20EEAWsbltpeq/8I499qSS
         qu5cfk9E0YxMG8VoNlHPyceLHgO3Knn80mRANoDQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 58/72] md: raid0/linear: fix dereference before null check on pointer mddev
Date:   Sat,  8 Aug 2020 19:35:27 -0400
Message-Id: <20200808233542.3617339-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 9a5a85972c073f720d81a7ebd08bfe278e6e16db ]

Pointer mddev is being dereferenced with a test_bit call before mddev
is being null checked, this may cause a null pointer dereference. Fix
this by moving the null pointer checks to sanity check mddev before
it is dereferenced.

Addresses-Coverity: ("Dereference before null check")
Fixes: 62f7b1989c02 ("md raid0/linear: Mark array as 'broken' and fail BIOs if a member is gone")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index f567f536b529b..90756450b9588 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -470,17 +470,18 @@ static blk_qc_t md_make_request(struct request_queue *q, struct bio *bio)
 	struct mddev *mddev = bio->bi_disk->private_data;
 	unsigned int sectors;
 
-	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
+	if (mddev == NULL || mddev->pers == NULL) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-	blk_queue_split(q, &bio);
-
-	if (mddev == NULL || mddev->pers == NULL) {
+	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
+
+	blk_queue_split(q, &bio);
+
 	if (mddev->ro == 1 && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
 			bio->bi_status = BLK_STS_IOERR;
-- 
2.25.1

