Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F87C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA62821974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSHpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgDSHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:45:23 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174C8C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 00:45:23 -0700 (PDT)
Received: from pabs by master.debian.org with local (Exim 4.92)
        (envelope-from <pabs@master.debian.org>)
        id 1jQ4Q9-00040e-4Q; Sun, 19 Apr 2020 07:31:17 +0000
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Paul Wise <pabs3@bonedaddy.net>
Subject: [PATCH 2/3] dm raid: only check for RAID 4/5/6 once during discard support setup
Date:   Sun, 19 Apr 2020 15:30:25 +0800
Message-Id: <20200419073026.197967-3-pabs3@bonedaddy.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419073026.197967-1-pabs3@bonedaddy.net>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RAID level 4/5/6 check no longer looks at the devices in the array,
so it isn't necessary for it to be checked once for each device,
so check it before the loop over the devices.

This makes the code cleaner and easier to understand since it
disentangles whole-array checks from per-device checks.

Commit 48920ff2a5a9 ("block: remove the discard_zeroes_data flag") removed
the per-device discard_zeroes_data check since REQ_OP_WRITE_ZEROES
operation was used everywhere and commit 48cf06bc5f50 ("dm raid: add
discard support for RAID levels 4, 5 and 6") introduced the RAID 4/5/6
check.

Signed-off-by: Paul Wise <pabs3@bonedaddy.net>
---
 drivers/md/dm-raid.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9a18bef0a5ff..0f95e50e62a8 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2944,13 +2944,16 @@ static int rs_setup_reshape(struct raid_set *rs)
 static void configure_discard_support(struct raid_set *rs)
 {
 	int i;
-	bool raid456;
 	struct dm_target *ti = rs->ti;
 
 	/*
 	 * XXX: RAID level 4,5,6 require zeroing for safety.
 	 */
-	raid456 = rs_is_raid456(rs);
+	if (rs_is_raid456(rs) && !devices_handle_discard_safely) {
+		DMERR("raid456 discard support disabled due to discard_zeroes_data uncertainty.");
+		DMERR("Set dm-raid.devices_handle_discard_safely=Y to override.");
+		return;
+	}
 
 	for (i = 0; i < rs->raid_disks; i++) {
 		struct request_queue *q;
@@ -2961,14 +2964,6 @@ static void configure_discard_support(struct raid_set *rs)
 		q = bdev_get_queue(rs->dev[i].rdev.bdev);
 		if (!q || !blk_queue_discard(q))
 			return;
-
-		if (raid456) {
-			if (!devices_handle_discard_safely) {
-				DMERR("raid456 discard support disabled due to discard_zeroes_data uncertainty.");
-				DMERR("Set dm-raid.devices_handle_discard_safely=Y to override.");
-				return;
-			}
-		}
 	}
 
 	ti->num_discard_bios = 1;
-- 
2.26.1

