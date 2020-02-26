Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760CC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E114521D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hCADqENh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgBZWkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:40:11 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.82]:11041 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbgBZWkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:40:11 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 8F00715B35B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 16:16:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 74yKjH1JjXVkQ74yKjcEAu; Wed, 26 Feb 2020 16:16:04 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iwW0dApQ5yAnOnmF+6lbbYBgyBKaN9DrJebNM5E7uxM=; b=hCADqENhZTZqCnQTP3PsmAwVNY
        rvwOiAsyS6T8NB4XghKYvwgx3npERwE1jycy1p0TmR3J4P6jRVKafdPCCZw8osUjJMmsaH5VO/SWa
        iaigMiSIayZ//rBks9ziwLmpnMUqDe9OxTN8Pu5bfsBdEuj7nwsPbcdhvDiWpIqEG0T7SwF2RyCFi
        HOwM2CX8VNXISnSOVNAvWBGX4J2aUHDbgKgGFURy/8gnedh8Kv19JGpp8MzpXKsqNk5HYVD5cQpT2
        kbtwr0utytsezkhgyNyc3STVdh+UVLwXGeLhi07MoAasUJaJ5E+1kRY0nbi+Cquth0jlvOiUJRl/j
        aqePVpAg==;
Received: from [201.166.157.3] (port=49744 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j74xY-001FWg-98; Wed, 26 Feb 2020 16:15:23 -0600
Date:   Wed, 26 Feb 2020 16:18:04 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.comSong Liu" <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] md: Replace zero-length array with flexible-array
 member
Message-ID: <20200226221804.GA8564@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.166.157.3
X-Source-L: No
X-Exim-ID: 1j74xY-001FWg-98
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.166.157.3]:49744
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/md/dm-crypt.c                          | 2 +-
 drivers/md/dm-integrity.c                      | 2 +-
 drivers/md/dm-log-writes.c                     | 2 +-
 drivers/md/dm-raid.c                           | 2 +-
 drivers/md/dm-raid1.c                          | 2 +-
 drivers/md/dm-stats.c                          | 2 +-
 drivers/md/dm-stripe.c                         | 2 +-
 drivers/md/dm-switch.c                         | 2 +-
 drivers/md/md-linear.h                         | 2 +-
 drivers/md/persistent-data/dm-btree-internal.h | 2 +-
 drivers/md/raid1.h                             | 2 +-
 drivers/md/raid10.h                            | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1c641efeeca7..bea260a82a2a 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -212,7 +212,7 @@ struct crypt_config {
 	struct mutex bio_alloc_lock;
 
 	u8 *authenc_key; /* space for keys in authenc() format (if used) */
-	u8 key[0];
+	u8 key[];
 };
 
 #define MIN_IOS		64
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b225b3e445fa..e22e6d65862a 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -89,7 +89,7 @@ struct journal_entry {
 		} s;
 		__u64 sector;
 	} u;
-	commit_id_t last_bytes[0];
+	commit_id_t last_bytes[];
 	/* __u8 tag[0]; */
 };
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 99721c76225d..9e21df5bb998 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -127,7 +127,7 @@ struct pending_block {
 	char *data;
 	u32 datalen;
 	struct list_head list;
-	struct bio_vec vecs[0];
+	struct bio_vec vecs[];
 };
 
 struct per_bio_data {
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9a18bef0a5ff..10e8b2fe787b 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -254,7 +254,7 @@ struct raid_set {
 		int mode;
 	} journal_dev;
 
-	struct raid_dev dev[0];
+	struct raid_dev dev[];
 };
 
 static void rs_config_backup(struct raid_set *rs, struct rs_layout *l)
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index 089aed57e083..2f655d9f4200 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -83,7 +83,7 @@ struct mirror_set {
 	struct work_struct trigger_event;
 
 	unsigned nr_mirrors;
-	struct mirror mirror[0];
+	struct mirror mirror[];
 };
 
 DECLARE_DM_KCOPYD_THROTTLE_WITH_MODULE_PARM(raid1_resync_throttle,
diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index 71417048256a..35d368c418d0 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -56,7 +56,7 @@ struct dm_stat {
 	size_t percpu_alloc_size;
 	size_t histogram_alloc_size;
 	struct dm_stat_percpu *stat_percpu[NR_CPUS];
-	struct dm_stat_shared stat_shared[0];
+	struct dm_stat_shared stat_shared[];
 };
 
 #define STAT_PRECISE_TIMESTAMPS		1
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 63bbcc20f49a..51fbfcf8efa1 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -41,7 +41,7 @@ struct stripe_c {
 	/* Work struct used for triggering events*/
 	struct work_struct trigger_event;
 
-	struct stripe stripe[0];
+	struct stripe stripe[];
 };
 
 /*
diff --git a/drivers/md/dm-switch.c b/drivers/md/dm-switch.c
index 8a0f057b8122..bff4c7fa1cd2 100644
--- a/drivers/md/dm-switch.c
+++ b/drivers/md/dm-switch.c
@@ -53,7 +53,7 @@ struct switch_ctx {
 	/*
 	 * Array of dm devices to switch between.
 	 */
-	struct switch_path path_list[0];
+	struct switch_path path_list[];
 };
 
 static struct switch_ctx *alloc_switch_ctx(struct dm_target *ti, unsigned nr_paths,
diff --git a/drivers/md/md-linear.h b/drivers/md/md-linear.h
index 8381d651d4ed..24e97db50ebb 100644
--- a/drivers/md/md-linear.h
+++ b/drivers/md/md-linear.h
@@ -12,6 +12,6 @@ struct linear_conf
 	struct rcu_head		rcu;
 	sector_t		array_sectors;
 	int			raid_disks; /* a copy of mddev->raid_disks */
-	struct dev_info		disks[0];
+	struct dev_info		disks[];
 };
 #endif
diff --git a/drivers/md/persistent-data/dm-btree-internal.h b/drivers/md/persistent-data/dm-btree-internal.h
index a240990a7f33..f4e644dd8101 100644
--- a/drivers/md/persistent-data/dm-btree-internal.h
+++ b/drivers/md/persistent-data/dm-btree-internal.h
@@ -38,7 +38,7 @@ struct node_header {
 
 struct btree_node {
 	struct node_header header;
-	__le64 keys[0];
+	__le64 keys[];
 } __packed;
 
 
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index e7ccad898736..b7eb09e8c025 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -180,7 +180,7 @@ struct r1bio {
 	 * if the IO is in WRITE direction, then multiple bios are used.
 	 * We choose the number when they are allocated.
 	 */
-	struct bio		*bios[0];
+	struct bio		*bios[];
 	/* DO NOT PUT ANY NEW FIELDS HERE - bios array is contiguously alloced*/
 };
 
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index d3eaaf3eb1bc..79cd2b7d3128 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -153,7 +153,7 @@ struct r10bio {
 		};
 		sector_t	addr;
 		int		devnum;
-	} devs[0];
+	} devs[];
 };
 
 /* bits for r10bio.state */
-- 
2.25.0

