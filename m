Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A0C433FB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B083E2256D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594737559;
	bh=l/VtbEGeb+bicVO2CQY68RHob5ElCgDqThNbsc7BPVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qsyyZWBs8F42/pAh5txAYWv+P0smszg0fwWIXG6xAI3P3asM5ZrwPeAP4PhkaSCYI
	 hZR/Yaw08o/UWz6j8eNvGIL8Lpw5/FWjUWj4AVoZOTLan1dKeBungN3JQhZM0vMRAC
	 cEIBx53sce23A+3arRl9tl+XfbbI8DZ9a6n69KfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgGNOjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbgGNOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:39:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0202253D;
        Tue, 14 Jul 2020 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594737552;
        bh=l/VtbEGeb+bicVO2CQY68RHob5ElCgDqThNbsc7BPVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8sXc5fNQruRi2smrIpo11Qb9qDl7xu0WMsAdpMXIiYPga84C40BWf7RJmwrEY4E2
         4UamP9qvbyKco0Ub2Po6iEFfo+0LHUbT2GnHqXipI8nLszuhjqrR10FbBQ/ICDx2V0
         1ff8GjMZa7/VfCuMhb679HKX9ZMO8aO00WyIIyks=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 5.7 18/19] dm: use bio_uninit instead of bio_disassociate_blkg
Date:   Tue, 14 Jul 2020 10:38:48 -0400
Message-Id: <20200714143849.4035283-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714143849.4035283-1-sashal@kernel.org>
References: <20200714143849.4035283-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 382761dc6312965a11f82f2217e16ec421bf17ae ]

bio_uninit is the proper API to clean up a BIO that has been allocated
on stack or inside a structure that doesn't come from the BIO allocator.
Switch dm to use that instead of bio_disassociate_blkg, which really is
an implementation detail.  Note that the bio_uninit calls are also moved
to the two callers of __send_empty_flush, so that they better pair with
the bio_init calls used to initialize them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index db9e461146531..c33aaf29f1379 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1445,9 +1445,6 @@ static int __send_empty_flush(struct clone_info *ci)
 	BUG_ON(bio_has_data(ci->bio));
 	while ((ti = dm_table_get_target(ci->map, target_nr++)))
 		__send_duplicate_bios(ci, ti, ti->num_flush_bios, NULL);
-
-	bio_disassociate_blkg(ci->bio);
-
 	return 0;
 }
 
@@ -1635,6 +1632,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 		ci.bio = &flush_bio;
 		ci.sector_count = 0;
 		error = __send_empty_flush(&ci);
+		bio_uninit(ci.bio);
 		/* dec_pending submits any data associated with flush */
 	} else if (op_is_zone_mgmt(bio_op(bio))) {
 		ci.bio = bio;
@@ -1709,6 +1707,7 @@ static blk_qc_t __process_bio(struct mapped_device *md, struct dm_table *map,
 		ci.bio = &flush_bio;
 		ci.sector_count = 0;
 		error = __send_empty_flush(&ci);
+		bio_uninit(ci.bio);
 		/* dec_pending submits any data associated with flush */
 	} else {
 		struct dm_target_io *tio;
-- 
2.25.1

