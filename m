Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35075C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A0F2467C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686488;
	bh=AkLuwjehgQMV0NZu73AEcKFSv7+rcuwhSHUnoRBjyls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBLiXUsljys4KKO3vCYOjI3gCyoFajKxCExceBgWr5QszcMFqExx8c/xFoqc3PhPg
	 UC3q/WmfdGFraUH5W/dFSdiB1grBROELT/nneuyia1hcFQ/Fm8yD9qkEngORFq9hZp
	 CHUZtzzo3FrooUi4hn4RFUGrWy2P/pEwaNNvMWbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAVJsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbgAVJlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E27F2467B;
        Wed, 22 Jan 2020 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686099;
        bh=AkLuwjehgQMV0NZu73AEcKFSv7+rcuwhSHUnoRBjyls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wxP2+j+t3M2aR0Jc1PyJNtXM2QY2zP0nDhPwDUHxUZLCA1AmNcA6qv26nc0OIctip
         86ehSxQeA6iKchyNf15cC28qowGkxXFRjQlineinR6o6L4QYQAh5jWca4/9CXUvbbd
         BNSakbysiGYj18WiGQjWd9rIwOnwhuWC68T7zyEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 043/103] btrfs: fix invalid removal of root ref
Date:   Wed, 22 Jan 2020 10:28:59 +0100
Message-Id: <20200122092810.346582942@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit d49d3287e74ffe55ae7430d1e795e5f9bf7359ea upstream.

If we have the following sequence of events

  btrfs sub create A
  btrfs sub create A/B
  btrfs sub snap A C
  mkdir C/foo
  mv A/B C/foo
  rm -rf *

We will end up with a transaction abort.

The reason for this is because we create a root ref for B pointing to A.
When we create a snapshot of C we still have B in our tree, but because
the root ref points to A and not C we will make it appear to be empty.

The problem happens when we move B into C.  This removes the root ref
for B pointing to A and adds a ref of B pointing to C.  When we rmdir C
we'll see that we have a ref to our root and remove the root ref,
despite not actually matching our reference name.

Now btrfs_del_root_ref() allowing this to work is a bug as well, however
we know that this inode does not actually point to a root ref in the
first place, so we shouldn't be calling btrfs_del_root_ref() in the
first place and instead simply look up our dir index for this item and
do the rest of the removal.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4168,13 +4168,16 @@ static int btrfs_unlink_subvol(struct bt
 	}
 	btrfs_release_path(path);
 
-	ret = btrfs_del_root_ref(trans, objectid, root->root_key.objectid,
-				 dir_ino, &index, name, name_len);
-	if (ret < 0) {
-		if (ret != -ENOENT) {
-			btrfs_abort_transaction(trans, ret);
-			goto out;
-		}
+	/*
+	 * This is a placeholder inode for a subvolume we didn't have a
+	 * reference to at the time of the snapshot creation.  In the meantime
+	 * we could have renamed the real subvol link into our snapshot, so
+	 * depending on btrfs_del_root_ref to return -ENOENT here is incorret.
+	 * Instead simply lookup the dir_index_item for this entry so we can
+	 * remove it.  Otherwise we know we have a ref to the root and we can
+	 * call btrfs_del_root_ref, and it _shouldn't_ fail.
+	 */
+	if (btrfs_ino(inode) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID) {
 		di = btrfs_search_dir_index_item(root, path, dir_ino,
 						 name, name_len);
 		if (IS_ERR_OR_NULL(di)) {
@@ -4189,8 +4192,16 @@ static int btrfs_unlink_subvol(struct bt
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		index = key.offset;
+		btrfs_release_path(path);
+	} else {
+		ret = btrfs_del_root_ref(trans, objectid,
+					 root->root_key.objectid, dir_ino,
+					 &index, name, name_len);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 	}
-	btrfs_release_path(path);
 
 	ret = btrfs_delete_delayed_dir_index(trans, BTRFS_I(dir), index);
 	if (ret) {


