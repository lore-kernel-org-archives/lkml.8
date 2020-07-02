Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58454C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB9C20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgGBLfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:35:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41054 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:35:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jqxUc-00059m-Fw; Thu, 02 Jul 2020 11:35:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Song Liu <song@kernel.org>, NeilBrown <neilb@suse.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        linux-raid@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md: raid0/linear: fix dereference before null check on pointer mddev
Date:   Thu,  2 Jul 2020 12:35:02 +0100
Message-Id: <20200702113502.37408-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer mddev is being dereferenced with a test_bit call before mddev
is being null checked, this may cause a null pointer dereference. Fix
this by moving the null pointer checks to sanity check mddev before
it is dereferenced.

Addresses-Coverity: ("Dereference before null check")
Fixes: 62f7b1989c02 ("md raid0/linear: Mark array as 'broken' and fail BIOs if a member is gone")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/md.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8bb69c61afe0..49452149ac72 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -470,17 +470,18 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 	struct mddev *mddev = bio->bi_disk->private_data;
 	unsigned int sectors;
 
-	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
+	if (mddev == NULL || mddev->pers == NULL) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-	blk_queue_split(&bio);
-
-	if (mddev == NULL || mddev->pers == NULL) {
+	if (unlikely(test_bit(MD_BROKEN, &mddev->flags)) && (rw == WRITE)) {
 		bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
+
+	blk_queue_split(&bio);
+
 	if (mddev->ro == 1 && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
 			bio->bi_status = BLK_STS_IOERR;
-- 
2.27.0

