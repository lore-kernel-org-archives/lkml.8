Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F43EC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518612072B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221297;
	bh=ePMzA8G+GUVMHaLdyeNb6FpdBQ2qidUTn/hjMaGktEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hWhh6c5gE2hZ1BjOO0iCrb/RqGcnkUKns1Z2zZR+ZAQTx2Hp+5nFHtHed5XJUN+tk
	 /wfVC3b9BCh7tn0pnSAoUPhhAs6A4GvMPOG2o8UsYFZe751n2r/RkhJOE38ZP++RVc
	 7W3YGKvfOMER5dGC2RzeaX9qOb66RWiQWeCibaxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgDROsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728655AbgDROn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B448421D82;
        Sat, 18 Apr 2020 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221037;
        bh=ePMzA8G+GUVMHaLdyeNb6FpdBQ2qidUTn/hjMaGktEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Moq7d4O8hTUcCtnomXS/O17+EjRUH4juPD/Mfj8V8+UDvx3qKuIAHxQE5hanRSTsR
         ibzZ4hMqO1sBBpbh7zEqyV+JRimx9bmsuBDWMehY7rrqy7+Iz1VRPfkEPyH8MBRF70
         yU9e4cw8XMtlbuTSamIcz/nTapNY2akn1B5WsdlU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Gander <simon@tuxera.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 22/28] hfsplus: fix crash and filesystem corruption when deleting files
Date:   Sat, 18 Apr 2020 10:43:22 -0400
Message-Id: <20200418144328.10265-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144328.10265-1-sashal@kernel.org>
References: <20200418144328.10265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Gander <simon@tuxera.com>

[ Upstream commit 25efb2ffdf991177e740b2f63e92b4ec7d310a92 ]

When removing files containing extended attributes, the hfsplus driver may
remove the wrong entries from the attributes b-tree, causing major
filesystem damage and in some cases even kernel crashes.

To remove a file, all its extended attributes have to be removed as well.
The driver does this by looking up all keys in the attributes b-tree with
the cnid of the file.  Each of these entries then gets deleted using the
key used for searching, which doesn't contain the attribute's name when it
should.  Since the key doesn't contain the name, the deletion routine will
not find the correct entry and instead remove the one in front of it.  If
parent nodes have to be modified, these become corrupt as well.  This
causes invalid links and unsorted entries that not even macOS's fsck_hfs
is able to fix.

To fix this, modify the search key before an entry is deleted from the
attributes b-tree by copying the found entry's key into the search key,
therefore ensuring that the correct entry gets removed from the tree.

Signed-off-by: Simon Gander <simon@tuxera.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Anton Altaparmakov <anton@tuxera.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200327155541.1521-1-simon@tuxera.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/attributes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index e6d554476db41..eeebe80c6be4a 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -292,6 +292,10 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 		return -ENOENT;
 	}
 
+	/* Avoid btree corruption */
+	hfs_bnode_read(fd->bnode, fd->search_key,
+			fd->keyoffset, fd->keylength);
+
 	err = hfs_brec_remove(fd);
 	if (err)
 		return err;
-- 
2.20.1

