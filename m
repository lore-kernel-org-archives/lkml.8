Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E17C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397C821974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 07:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDSHp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgDSHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 03:45:26 -0400
Received: from master.debian.org (master.debian.org [IPv6:2001:41b8:202:deb:216:36ff:fe40:4001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC5C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 00:45:26 -0700 (PDT)
Received: from pabs by master.debian.org with local (Exim 4.92)
        (envelope-from <pabs@master.debian.org>)
        id 1jQ4QD-00040m-1R; Sun, 19 Apr 2020 07:31:21 +0000
From:   Paul Wise <pabs3@bonedaddy.net>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Paul Wise <pabs3@bonedaddy.net>
Subject: [PATCH 3/3] dm raid/raid1: enable discard support when any devices support discard
Date:   Sun, 19 Apr 2020 15:30:26 +0800
Message-Id: <20200419073026.197967-4-pabs3@bonedaddy.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419073026.197967-1-pabs3@bonedaddy.net>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow fstrim to work on filesystems on dm RAID arrays with
both HDDs and SSDs or dm raid SSD arrays with varying discard support,
which should increase the lifetime of the SSDs that support discard.

This makes dm raid and dm raid1 (mirroring) consistent with md raid,
which supports discard when only some of the devices support discard.

The existing code prevents this from being enabled with RAID 4/5/6,
which require more certainty about the behaviour of underlying devices
after a discard has been issued and processed.

Simply enable discard and return from the configure_discard_support
function when any of the underlying devices has support for discards,
since there are now no other checks in the device check loop.

Mixed discard support for md RAID types was added in these commits:

commit c83057a1f4f9 ("md: raid 0 supports TRIM")
commit 2ff8cc2c6d4e ("md: raid 1 supports TRIM")
commit 532a2a3fba8d ("md: raid 10 supports TRIM")
commit f1cad2b68ed1 ("md: linear supports TRIM")

Signed-off-by: Paul Wise <pabs3@bonedaddy.net>
---
 drivers/md/dm-raid.c  | 8 ++++++--
 drivers/md/dm-raid1.c | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 0f95e50e62a8..63f5d05021a9 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2962,11 +2962,15 @@ static void configure_discard_support(struct raid_set *rs)
 			continue;
 
 		q = bdev_get_queue(rs->dev[i].rdev.bdev);
-		if (!q || !blk_queue_discard(q))
+		if (q && blk_queue_discard(q)) {
+			ti->discard_support = DM_DISCARD_ANY_DEVS;
+			ti->num_discard_bios = 1;
 			return;
+		}
 	}
 
-	ti->num_discard_bios = 1;
+	ti->discard_support = DM_DISCARD_ALL_DEVS;
+	ti->num_discard_bios = 0;
 }
 
 /*
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 089aed57e083..2bfed681dd3f 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -1114,6 +1114,7 @@ static int mirror_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto err_free_context;
 
 	ti->num_flush_bios = 1;
+	ti->discard_support = DM_DISCARD_ANY_DEVS;
 	ti->num_discard_bios = 1;
 	ti->per_io_data_size = sizeof(struct dm_raid1_bio_record);
 
-- 
2.26.1

