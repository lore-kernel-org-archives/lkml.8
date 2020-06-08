Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E212EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB302077D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591584688;
	bh=aj/roIt7ILETlasumkcLsDLIyP/E4ZfrsyKhGIt46nQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=lKojFy9PiXy1DyoggLjCnJeClcrYpfBVD3vrr9zo35Mj4VET+Avm4FQ2JYccYODaA
	 ODL+Kde+Trn8WBJE6HLZ5rEOxlC11Np0aBrCz0TzJEJDkix32UmUTQ5WWoWsHnAVsB
	 qs6b7LLogbqbAhNogA7vOKT5Fwn/YxgJsIy69Bl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgFHCv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgFHCv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:51:27 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7067E2075A;
        Mon,  8 Jun 2020 02:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591584686;
        bh=aj/roIt7ILETlasumkcLsDLIyP/E4ZfrsyKhGIt46nQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=FcciYpdzrNEmWJLzvTQB//kGOWst28RMVfb1VYedjE/zlyqyUjDhzwALGAUDRgcbu
         hxfWcktywsG/RNcw09R4CqLN61b58BNzM76jWzKRoartKB5w2JkHSbLEOpC/nfzTyX
         Xi4Uu04a5L9uEksQT6GXZ40GGi2rNRuTgzyOfwHE=
Date:   Sun, 7 Jun 2020 19:51:25 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [PATCH 2/2 v2] f2fs: attach IO flags to the missing cases
Message-ID: <20200608025125.GA127000@google.com>
References: <20200604235023.1954-1-jaegeuk@kernel.org>
 <20200604235023.1954-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604235023.1954-2-jaegeuk@kernel.org>
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

v2 log:
 - remove redundant code

 Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++++
 fs/f2fs/data.c                          | 24 +++++++++++++++---------
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/sysfs.c                         |  2 ++
 4 files changed, 27 insertions(+), 9 deletions(-)

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
index 703fcb2433269..267b5e76a02b5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -514,22 +514,28 @@ void f2fs_submit_bio(struct f2fs_sb_info *sbi,
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
+	unsigned int io_flag, fua_flag, meta_flag;
+
+	if (fio->type == DATA)
+		io_flag = sbi->data_io_flag;
+	else if (fio->type == NODE)
+		io_flag = sbi->node_io_flag;
+	else
+		return;
+
+	fua_flag = io_flag & temp_mask;
+	meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
+
 	/*
-	 * data io flag bits per temp:
+	 * data/node io flag bits per temp:
 	 *      REQ_META     |      REQ_FUA      |
 	 *    5 |    4 |   3 |    2 |    1 |   0 |
 	 * Cold | Warm | Hot | Cold | Warm | Hot |
 	 */
-	if (fio->type != DATA)
-		return;
-
 	if ((1 << fio->temp) & meta_flag)
 		fio->op_flags |= REQ_META;
 	if ((1 << fio->temp) & fua_flag)
@@ -543,7 +549,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
-	__attach_data_io_flag(fio);
+	__attach_io_flag(fio);
 	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
 
 	if (is_read_io(fio->op))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7794e2f0d6e8a..c812fb8e2d9c7 100644
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

