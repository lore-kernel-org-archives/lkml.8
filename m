Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7197CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFF92077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585930373;
	bh=0k2MhVAl7BfiHRcLT496jYlNBJ3HTTEz9j9hPiMYFu4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MUrNNIMCPY5uGTFxFz6AkotEKhL3qbK2Nq72aWiMzYbZQmBSDVwQNPWyi8Y0aeein
	 B6RBd2N57DpA0da0FvXdqfp6mNlXxAZiOJhOupA5m1mf7QxzfzsWTGRuGkmp/nVttN
	 WyG+X5eqNvWlA8YtmbD423b0ECOrx10Pob1bKN2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390974AbgDCQMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCQMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:12:51 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D393F206E9;
        Fri,  3 Apr 2020 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585930370;
        bh=0k2MhVAl7BfiHRcLT496jYlNBJ3HTTEz9j9hPiMYFu4=;
        h=From:To:Cc:Subject:Date:From;
        b=v5W9SOGUTZRjhj1LvnBeuvc7Je6tfQDhZnT8Lag2PH7J16OJGPh2vofcMXqdr9gfw
         JTg67RLcDGRWoWivsuCX3pjKSHDGp6Vp9pSjAqnSMIASWu5e2A8ivF70H3oPVJAESe
         11V11fRWdFwrPIpuLioi8/n0AFjuddbdB8ACSHaQ=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: introduce sysfs/data_io_flag to attach REQ_META/FUA
Date:   Fri,  3 Apr 2020 09:12:49 -0700
Message-Id: <20200403161249.68385-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a way to attach REQ_META/FUA explicitly
to all the data writes given temperature.

-> attach REQ_FUA to Hot Data writes

-> attach REQ_FUA to Hot|Warm Data writes

-> attach REQ_FUA to Hot|Warm|Cold Data writes

-> attach REQ_FUA to Hot|Warm|Cold Data writes as well as
          REQ_META to Hot Data writes

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
 fs/f2fs/data.c                          | 23 +++++++++++++++++++++++
 fs/f2fs/f2fs.h                          |  3 +++
 fs/f2fs/sysfs.c                         |  3 ++-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bd8a0d19abe67..c8620ea7022a7 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -323,3 +323,12 @@ What:		/sys/fs/f2fs/<disk>/mounted_time_sec
 Date:		February 2020
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Show the mounted time in secs of this partition.
+
+What:		/sys/fs/f2fs/<disk>/data_io_flag
+Date:		April 2020
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Give a way to attach REQ_META|FUA to data writes
+		given temperature-based bits. Now the bits indicate:
+		*      REQ_META     |      REQ_FUA      |
+		*    5 |    4 |   3 |    2 |    1 |   0 |
+		* Cold | Warm | Hot | Cold | Warm | Hot |
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0a829a89f596f..358c5f0bd6346 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -513,6 +513,28 @@ void f2fs_submit_bio(struct f2fs_sb_info *sbi,
 	__submit_bio(sbi, bio, type);
 }
 
+static void __attach_data_io_flag(struct f2fs_io_info *fio)
+{
+	struct f2fs_sb_info *sbi = fio->sbi;
+	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
+	unsigned int fua_flag = sbi->data_io_flag & temp_mask;
+	unsigned int meta_flag = (sbi->data_io_flag >> NR_TEMP_TYPE) &
+								temp_mask;
+	/*
+	 * data io flag bits per temp:
+	 *      REQ_META     |      REQ_FUA      |
+	 *    5 |    4 |   3 |    2 |    1 |   0 |
+	 * Cold | Warm | Hot | Cold | Warm | Hot |
+	 */
+	if (fio->type != DATA)
+		return;
+
+	if ((1 << fio->temp) & meta_flag)
+		fio->op_flags |= REQ_META;
+	if ((1 << fio->temp) & fua_flag)
+		fio->op_flags |= REQ_FUA;
+}
+
 static void __submit_merged_bio(struct f2fs_bio_info *io)
 {
 	struct f2fs_io_info *fio = &io->fio;
@@ -520,6 +542,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
+	__attach_data_io_flag(fio);
 	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
 
 	if (is_read_io(fio->op))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index da069d051982f..be02a5cadd944 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1510,6 +1510,9 @@ struct f2fs_sb_info {
 	unsigned long long write_iostat[NR_IO_TYPE];
 	bool iostat_enable;
 
+	/* to attach REQ_META|REQ_FUA flags */
+	unsigned int data_io_flag;
+
 	/* For sysfs suppport */
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index cb81680d18f7e..d58935eed2cf7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -373,7 +373,6 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
-
 	if (!strcmp(a->attr.name, "iostat_enable")) {
 		sbi->iostat_enable = !!t;
 		if (!sbi->iostat_enable)
@@ -544,6 +543,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_super_block, extension_list, extension_list);
 F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
 F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
 #endif
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
 F2FS_GENERAL_RO_ATTR(dirty_segments);
 F2FS_GENERAL_RO_ATTR(free_segments);
 F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
@@ -623,6 +623,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(inject_rate),
 	ATTR_LIST(inject_type),
 #endif
+	ATTR_LIST(data_io_flag),
 	ATTR_LIST(dirty_segments),
 	ATTR_LIST(free_segments),
 	ATTR_LIST(unusable),
-- 
2.26.0.292.g33ef6b2f38-goog

