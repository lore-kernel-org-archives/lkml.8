Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DD6C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A71F2465D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271588;
	bh=veonelLyHYVdZEaWEmcvfnbE3w0QTXWIx3ruw3NtQm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BWJnu2ofYu0LZZybzX5PCzVdwN/s6OP4iIzP0OEXsLkVvur+VS3dly/ke0zwElRSv
	 4pCws5uGf7OVz6myGvN53xfmjmJ5Bb9HlFduSvI+7RQ808Hc8Y3PfQCo6Lyfeei5J9
	 s+K0rxOcLVsMcTIDMYtsDtVGoiL4Z3C8JBVvzCj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgBUHxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgBUHxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:53:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113C924650;
        Fri, 21 Feb 2020 07:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271582;
        bh=veonelLyHYVdZEaWEmcvfnbE3w0QTXWIx3ruw3NtQm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmUdS9x7Ov0NbSfnUlFaWyEYg3/v80GoF2fQnS+1h1U0oJkd3AlLP/EI4xBBhQ1TX
         qs8BhTn7Q/c5LGy8eDIcni1vgrmSleAIGV/Q2aGDoPmT9fmU652k1HkFrLyOU0lmwe
         uD0MQ/JF1cEhULUHqmC6Kjp0UoBpvrm/e3tRwTzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 221/399] udf: Fix free space reporting for metadata and virtual partitions
Date:   Fri, 21 Feb 2020 08:39:06 +0100
Message-Id: <20200221072424.454614923@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
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
index 008bf96b1732d..4baa1ca91e9be 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2491,17 +2491,29 @@ static unsigned int udf_count_free_table(struct super_block *sb,
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
@@ -2510,7 +2522,7 @@ static unsigned int udf_count_free(struct super_block *sb)
 	if (accum)
 		return accum;
 
-	map = &sbi->s_partmaps[sbi->s_partition];
+	map = &sbi->s_partmaps[part];
 	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
 		accum += udf_count_free_bitmap(sb,
 					       map->s_uspace.s_bitmap);
-- 
2.20.1



