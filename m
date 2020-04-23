Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D89C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F079920784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgDWXYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:24:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48284 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728136AbgDWXG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:29 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvJ-0004aM-Gs; Fri, 24 Apr 2020 00:06:25 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvI-00E6gW-IV; Fri, 24 Apr 2020 00:06:24 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Liu Bo" <bo.li.liu@oracle.com>, "David Sterba" <dsterba@suse.com>,
        "Chris Mason" <clm@fb.com>
Date:   Fri, 24 Apr 2020 00:04:17 +0100
Message-ID: <lsq.1587683028.206849923@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 030/245] Btrfs: check btree node's nritems
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 053ab70f0604224c7893b43f9d9d5efa283580d6 upstream.

When btree node (level = 1) has nritems which equals to zero,
we can end up with panic due to insert_ptr()'s

BUG_ON(slot > nritems);

where slot is 1 and nritems is 0, as copy_for_split() calls
insert_ptr(.., path->slots[1] + 1, ...);

A invalid value results in the whole mess, this adds the check
for btree's node nritems so that we stop reading block when
when something is wrong.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/disk-io.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -594,6 +594,19 @@ static noinline int check_leaf(struct bt
 	return 0;
 }
 
+static int check_node(struct btrfs_root *root, struct extent_buffer *node)
+{
+	unsigned long nr = btrfs_header_nritems(node);
+
+	if (nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(root)) {
+		btrfs_crit(root->fs_info,
+			   "corrupt node: block %llu root %llu nritems %lu",
+			   node->start, root->objectid, nr);
+		return -EIO;
+	}
+	return 0;
+}
+
 static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 				      u64 phy_offset, struct page *page,
 				      u64 start, u64 end, int mirror)
@@ -666,6 +679,9 @@ static int btree_readpage_end_io_hook(st
 		ret = -EIO;
 	}
 
+	if (found_level > 0 && check_node(root, eb))
+		ret = -EIO;
+
 	if (!ret)
 		set_extent_buffer_uptodate(eb);
 err:

