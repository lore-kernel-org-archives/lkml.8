Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B125C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 23:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB2F208C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591314627;
	bh=ND4kZKs0ckKJG227yGmyY5tVeZis8uDKb/AjmQgSe5E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DDkS4kOMDWoeUk2s2BTtBNXBoLfu/vPyBsRIGJAMvwkniyLQgckKp0u3Y1/NOsRKJ
	 Pbb0yi6y5z1wMFTI/ph3/twceYqB3+/gKInXUsfhB4WEtG5ol8LK4w+U4vyF8PrhcL
	 jn9FzMNr6BL/zONhX0yN+VT48HC/N91TsmRhT9jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFDXu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgFDXuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 19:50:25 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D72D0206DC;
        Thu,  4 Jun 2020 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591314624;
        bh=ND4kZKs0ckKJG227yGmyY5tVeZis8uDKb/AjmQgSe5E=;
        h=From:To:Cc:Subject:Date:From;
        b=Z82FfCo8VpvMzN+Q5BfD+99zxNEKMEMVSMOucvDn3D7LsKheLfDHM06gKuJgjHBwg
         XdS8gjilKZzAHaOu5oZ5jKNANulbg7C0iUpF16jsULH/JwmO1SIhnfGaxxQCKO9AYA
         JXF0U6CXPd+dnnkGBh3RnFch02RNUqUlURDwr0t0=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: add node_io_flag for bio flags likewise data_io_flag
Date:   Thu,  4 Jun 2020 16:50:22 -0700
Message-Id: <20200604235023.1954-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds another way to attach bio flags to node writes.

Description:   Give a way to attach REQ_META|FUA to node writes
               given temperature-based bits. Now the bits indicate:
               *      REQ_META     |      REQ_FUA      |
               *    5 |    4 |   3 |    2 |    1 |   0 |
               * Cold | Warm | Hot | Cold | Warm | Hot |

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  9 ++++++
 fs/f2fs/data.c                          | 39 ++++++++++++++++++-------
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/sysfs.c                         |  2 ++
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 427f5b45c67f1..4bb93a06d8abc 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -333,6 +333,15 @@ Description:	Give a way to attach REQ_META|FUA to data writes
 		*    5 |    4 |   3 |    2 |    1 |   0 |
 		* Cold | Warm | Hot | Cold | Warm | Hot |
 
+What:		/sys/fs/f2fs/<disk>/node_io_flag
+Date:		June 2020
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Give a way to attach REQ_META|FUA to node writes
+		given temperature-based bits. Now the bits indicate:
+		*      REQ_META     |      REQ_FUA      |
+		*    5 |    4 |   3 |    2 |    1 |   0 |
+		* Cold | Warm | Hot | Cold | Warm | Hot |
+
 What:		/sys/fs/f2fs/<disk>/iostat_period_ms
 Date:		April 2020
 Contact:	"Daeho Jeong" <daehojeong@google.com>
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a65bfc07ddb97..2f5293eb5e52a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -514,26 +514,43 @@ void f2fs_submit_bio(struct f2fs_sb_info *sbi,
 	__submit_bio(sbi, bio, type);
 }
 
-static void __attach_data_io_flag(struct f2fs_io_info *fio)
+static void __attach_io_flag(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
 	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
-	unsigned int fua_flag = sbi->data_io_flag & temp_mask;
-	unsigned int meta_flag = (sbi->data_io_flag >> NR_TEMP_TYPE) &
-								temp_mask;
+
 	/*
 	 * data io flag bits per temp:
 	 *      REQ_META     |      REQ_FUA      |
 	 *    5 |    4 |   3 |    2 |    1 |   0 |
 	 * Cold | Warm | Hot | Cold | Warm | Hot |
 	 */
-	if (fio->type != DATA)
-		return;
+	if (fio->type == DATA) {
+		unsigned int fua_flag = sbi->data_io_flag & temp_mask;
+		unsigned int meta_flag = (sbi->data_io_flag >> NR_TEMP_TYPE) &
+								temp_mask;
 
-	if ((1 << fio->temp) & meta_flag)
-		fio->op_flags |= REQ_META;
-	if ((1 << fio->temp) & fua_flag)
-		fio->op_flags |= REQ_FUA;
+		if ((1 << fio->temp) & meta_flag)
+			fio->op_flags |= REQ_META;
+		if ((1 << fio->temp) & fua_flag)
+			fio->op_flags |= REQ_FUA;
+	}
+	/*
+	 * node io flag bits per temp:
+	 *      REQ_META     |      REQ_FUA      |
+	 *    5 |    4 |   3 |    2 |    1 |   0 |
+	 * Cold | Warm | Hot | Cold | Warm | Hot |
+	 */
+	if (fio->type == NODE) {
+		unsigned int fua_flag = sbi->node_io_flag & temp_mask;
+		unsigned int meta_flag = (sbi->node_io_flag >> NR_TEMP_TYPE) &
+								temp_mask;
+
+		if ((1 << fio->temp) & meta_flag)
+			fio->op_flags |= REQ_META;
+		if ((1 << fio->temp) & fua_flag)
+			fio->op_flags |= REQ_FUA;
+	}
 }
 
 static void __submit_merged_bio(struct f2fs_bio_info *io)
@@ -543,7 +560,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
-	__attach_data_io_flag(fio);
+	__attach_io_flag(fio);
 	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
 
 	if (is_read_io(fio->op))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fb180020e175c..50e6cdf20b733 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1568,6 +1568,7 @@ struct f2fs_sb_info {
 
 	/* to attach REQ_META|REQ_FUA flags */
 	unsigned int data_io_flag;
+	unsigned int node_io_flag;
 
 	/* For sysfs suppport */
 	struct kobject s_kobj;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index a117ae1f9d5f1..fc4a46b689040 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -554,6 +554,7 @@ F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
 F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
 #endif
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
@@ -635,6 +636,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(inject_type),
 #endif
 	ATTR_LIST(data_io_flag),
+	ATTR_LIST(node_io_flag),
 	ATTR_LIST(dirty_segments),
 	ATTR_LIST(free_segments),
 	ATTR_LIST(unusable),
-- 
2.27.0.278.ge193c7cf3a9-goog

