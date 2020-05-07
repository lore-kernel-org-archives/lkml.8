Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE6CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3A82184D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877254;
	bh=hsB9n2INTWN1VmYgZ/WGzwPJ/1oZaJjCRnmNcalKWHY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FhO8g9r06V8mS4VL1N8KR+oMiYh4nwrD6cv/6vRjk+KbwfukSP4aLR0oPkp12Qz1Y
	 2Z//KreZ5H6CNzgu8sFafuzkjzM9PbwNGoSaoFTBt0IC6blaEvZ3/CnHGRNIjQL8VF
	 cEtoluFS2v4s0lGqeg0J7EqrbV51+PZp81N0WKWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgEGSrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGSrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:47:33 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03278216FD;
        Thu,  7 May 2020 18:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877252;
        bh=hsB9n2INTWN1VmYgZ/WGzwPJ/1oZaJjCRnmNcalKWHY=;
        h=Date:From:To:Cc:Subject:From;
        b=yIzpoyybS4DGE5hiqc7ckFaZ/DNl1r0ZpzgR0N+ecuWeBSI2pTxBFV7UzyDiAwOo1
         HPIzQtZhazgltNSIsCjp+mokRDrbk7dXBP6Ybx4LQZdL37S1cBIxwknQch3pUW1RYR
         QtX2A2NmKGThYpcjCO4vXbe4Y7RrGJDbRVbKNJAw=
Date:   Thu, 7 May 2020 13:51:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dm integrity: Replace zero-length array with flexible-array
Message-ID: <20200507185158.GA14116@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/md/dm-crypt.c                          |    2 +-
 drivers/md/dm-integrity.c                      |    2 +-
 drivers/md/dm-log-writes.c                     |    2 +-
 drivers/md/dm-raid.c                           |    2 +-
 drivers/md/dm-raid1.c                          |    2 +-
 drivers/md/dm-stats.c                          |    2 +-
 drivers/md/dm-stripe.c                         |    2 +-
 drivers/md/dm-switch.c                         |    2 +-
 drivers/md/persistent-data/dm-btree-internal.h |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3df90daba89e..bac110987a65 100644
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
index 4094c47eca7f..fe39ed31b20d 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -92,7 +92,7 @@ struct journal_entry {
 		} s;
 		__u64 sector;
 	} u;
-	commit_id_t last_bytes[0];
+	commit_id_t last_bytes[];
 	/* __u8 tag[0]; */
 };
 
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 8ea20b56b4d6..e3d35c6c9f71 100644
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
index fa813c0f993d..151d022b032d 100644
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
 
 

