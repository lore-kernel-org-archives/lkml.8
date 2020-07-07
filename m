Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25298C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063622078D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134987;
	bh=cDVNGd8ilXWq9pqQlcKEwS0JNsU1pdG77gmqf+Zy3XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HvU3eDy6tfk0Cn9dcwqqNg78ieRKxX14H4GPRCUoDh5Rx+ZtjjewjZaoixUWgXROx
	 CJz7RXtm9iS/M+RKoODjHzae7EnQQGgf814hqaWoaH8AbIrdMOJWKBL+thzc2kqDIc
	 DUSf3xCm1PbPmQLzG6Bd3d6R7ZDmHEYW+WezAKuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgGGPQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbgGGPQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:16:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9682C20674;
        Tue,  7 Jul 2020 15:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134982;
        bh=cDVNGd8ilXWq9pqQlcKEwS0JNsU1pdG77gmqf+Zy3XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQChIv2a5sgebfF59oZ45m0ajz2IIjKz40lL1m2cU+0RfyGHn/ygco8tY5ng6d+6p
         XYOuF1zq4H2SlbSPyQdepNShyb+1AhlMsSpnoKDWaoUzyUkskU/r6sL+p8eqvu1Y9R
         jcWvZ5l44bQ7xEtCyb5Brs1avpV19u++GBlCTPxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/27] btrfs: cow_file_range() num_bytes and disk_num_bytes are same
Date:   Tue,  7 Jul 2020 17:15:29 +0200
Message-Id: <20200707145749.068163785@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145748.944863698@linuxfoundation.org>
References: <20200707145748.944863698@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Jain <Anand.Jain@oracle.com>

[ Upstream commit 3752d22fcea160cc2493e34f5e0e41cdd7fdd921 ]

This patch deletes local variable disk_num_bytes as its value
is same as num_bytes in the function cow_file_range().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39ad582d72c4b..a8ae9a0704871 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -978,7 +978,6 @@ static noinline int cow_file_range(struct inode *inode,
 	u64 alloc_hint = 0;
 	u64 num_bytes;
 	unsigned long ram_size;
-	u64 disk_num_bytes;
 	u64 cur_alloc_size = 0;
 	u64 blocksize = fs_info->sectorsize;
 	struct btrfs_key ins;
@@ -996,7 +995,6 @@ static noinline int cow_file_range(struct inode *inode,
 
 	num_bytes = ALIGN(end - start + 1, blocksize);
 	num_bytes = max(blocksize,  num_bytes);
-	disk_num_bytes = num_bytes;
 
 	inode_should_defrag(BTRFS_I(inode), start, end, num_bytes, SZ_64K);
 
@@ -1023,15 +1021,14 @@ static noinline int cow_file_range(struct inode *inode,
 		}
 	}
 
-	BUG_ON(disk_num_bytes >
-	       btrfs_super_total_bytes(fs_info->super_copy));
+	BUG_ON(num_bytes > btrfs_super_total_bytes(fs_info->super_copy));
 
 	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);
 	btrfs_drop_extent_cache(BTRFS_I(inode), start,
 			start + num_bytes - 1, 0);
 
-	while (disk_num_bytes > 0) {
-		cur_alloc_size = disk_num_bytes;
+	while (num_bytes > 0) {
+		cur_alloc_size = num_bytes;
 		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
 					   fs_info->sectorsize, 0, alloc_hint,
 					   &ins, 1, 1);
@@ -1097,11 +1094,10 @@ static noinline int cow_file_range(struct inode *inode,
 					     delalloc_end, locked_page,
 					     EXTENT_LOCKED | EXTENT_DELALLOC,
 					     page_ops);
-		if (disk_num_bytes < cur_alloc_size)
-			disk_num_bytes = 0;
+		if (num_bytes < cur_alloc_size)
+			num_bytes = 0;
 		else
-			disk_num_bytes -= cur_alloc_size;
-		num_bytes -= cur_alloc_size;
+			num_bytes -= cur_alloc_size;
 		alloc_hint = ins.objectid + ins.offset;
 		start += cur_alloc_size;
 		extent_reserved = false;
-- 
2.25.1



