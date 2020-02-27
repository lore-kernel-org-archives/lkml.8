Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D0C52D20
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169512073D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811806;
	bh=6KFPRYNs9j7SGj61oncc2JMQtP4aYc1E5EHXmwPPavc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nyO1dJvF51jnGuZiX26fdJWwx6j4Y1dHFoBwddd/narFMIt7z1SvG8TX+M5ArCfh5
	 WOnMH4+Wr9CKpD3rhnPQ8ydmMCFMRaRg/rGJu3/awgjZvohmVGOV4E8MrXu0amWgPU
	 lr2WK4CDefjNdk4LibO1mLJ9Ky89wFv+3K0f2eLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbgB0N4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731904AbgB0N4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:56:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DA320578;
        Thu, 27 Feb 2020 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811796;
        bh=6KFPRYNs9j7SGj61oncc2JMQtP4aYc1E5EHXmwPPavc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXA8RcfIdp/MUVvE+1Jp0xr+saZK6UWL3w3eepo1Tyk3dmO9boPH56DUIHv0ivyOn
         bX5kFdWH4J25f16GyYuB6WnVwO9cyS8nGmENHkDWGoPtZs2+iy6NevdZYw/Ur+0EXE
         a+7T3ZzdLDYIpgs5OD50bOzSz/8jyC6uBONlMOek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 103/237] udf: Fix free space reporting for metadata and virtual partitions
Date:   Thu, 27 Feb 2020 14:35:17 +0100
Message-Id: <20200227132304.519145890@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit a4a8b99ec819ca60b49dc582a4287ef03411f117 ]

Free space on filesystems with metadata or virtual partition maps
currently gets misreported. This is because these partitions are just
remapped onto underlying real partitions from which keep track of free
blocks. Take this remapping into account when counting free blocks as
well.

Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
Reported-by: Pali Rohár <pali.rohar@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/super.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 242d960df9a17..51de27685e185 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2467,17 +2467,29 @@ static unsigned int udf_count_free_table(struct super_block *sb,
 static unsigned int udf_count_free(struct super_block *sb)
 {
 	unsigned int accum = 0;
-	struct udf_sb_info *sbi;
+	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct udf_part_map *map;
+	unsigned int part = sbi->s_partition;
+	int ptype = sbi->s_partmaps[part].s_partition_type;
+
+	if (ptype == UDF_METADATA_MAP25) {
+		part = sbi->s_partmaps[part].s_type_specific.s_metadata.
+							s_phys_partition_ref;
+	} else if (ptype == UDF_VIRTUAL_MAP15 || ptype == UDF_VIRTUAL_MAP20) {
+		/*
+		 * Filesystems with VAT are append-only and we cannot write to
+ 		 * them. Let's just report 0 here.
+		 */
+		return 0;
+	}
 
-	sbi = UDF_SB(sb);
 	if (sbi->s_lvid_bh) {
 		struct logicalVolIntegrityDesc *lvid =
 			(struct logicalVolIntegrityDesc *)
 			sbi->s_lvid_bh->b_data;
-		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
+		if (le32_to_cpu(lvid->numOfPartitions) > part) {
 			accum = le32_to_cpu(
-					lvid->freeSpaceTable[sbi->s_partition]);
+					lvid->freeSpaceTable[part]);
 			if (accum == 0xFFFFFFFF)
 				accum = 0;
 		}
@@ -2486,7 +2498,7 @@ static unsigned int udf_count_free(struct super_block *sb)
 	if (accum)
 		return accum;
 
-	map = &sbi->s_partmaps[sbi->s_partition];
+	map = &sbi->s_partmaps[part];
 	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
 		accum += udf_count_free_bitmap(sb,
 					       map->s_uspace.s_bitmap);
-- 
2.20.1



