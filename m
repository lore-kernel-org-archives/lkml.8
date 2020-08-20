Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5759EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3608620738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597932417;
	bh=avcBHyqrkzSdswKWmM8x1RCkJC0BbdbsDhQaxrT6diM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pjbjec8/iQ7+CGiHwi8xsBnrKTldTsQrEo0aCgEtcEn+BV1I5gDz1T85aj1kxD/sd
	 hOaA3JY/NUt+0eSXGQC7xt5JqfKdLxcMFKYUDpJUu2znWk6tATj7+1rSczMryQKG9b
	 SwnlHM0o3YaSho1JO4PLDxgKjy0oFYygUUwSH+xA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgHTN6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgHTJZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:25:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D17722D03;
        Thu, 20 Aug 2020 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915506;
        bh=avcBHyqrkzSdswKWmM8x1RCkJC0BbdbsDhQaxrT6diM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dphiwbMAF2/92NpIr2UkuBLM8ORktpUoXyidzbdKrII4BOJjbctXVt0q6HkZnkYYd
         LDhqsW+O9RoDxRBPmrozCsHbiF1c7YmurqXtlMxKdKYaMy2b03yPyRglK3gi4F2hRs
         de+3Xl7ITnlyJLOX2FW5jCKo2CXjL21xHCo1RcNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.8 038/232] btrfs: trim: fix underflow in trim length to prevent access beyond device boundary
Date:   Thu, 20 Aug 2020 11:18:09 +0200
Message-Id: <20200820091614.619601643@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit c57dd1f2f6a7cd1bb61802344f59ccdc5278c983 upstream.

[BUG]
The following script can lead to tons of beyond device boundary access:

  mkfs.btrfs -f $dev -b 10G
  mount $dev $mnt
  trimfs $mnt
  btrfs filesystem resize 1:-1G $mnt
  trimfs $mnt

[CAUSE]
Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
find_first_clear_extent_bit"), we try to avoid trimming ranges that's
already trimmed.

So we check device->alloc_state by finding the first range which doesn't
have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.

But if we shrunk the device, that bits are not cleared, thus we could
easily got a range starts beyond the shrunk device size.

This results the returned @start and @end are all beyond device size,
then we call "end = min(end, device->total_bytes -1);" making @end
smaller than device size.

Then finally we goes "len = end - start + 1", totally underflow the
result, and lead to the beyond-device-boundary access.

[FIX]
This patch will fix the problem in two ways:

- Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
  This is the root fix

- Add extra safety check when trimming free device extents
  We check and warn if the returned range is already beyond current
  device.

Link: https://github.com/kdave/btrfs-progs/issues/282
Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first_clear_extent_bit")
CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-io-tree.h |    2 ++
 fs/btrfs/extent-tree.c    |   14 ++++++++++++++
 fs/btrfs/volumes.c        |    4 ++++
 3 files changed, 20 insertions(+)

--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -34,6 +34,8 @@ struct io_failure_record;
  */
 #define CHUNK_ALLOCATED				EXTENT_DIRTY
 #define CHUNK_TRIMMED				EXTENT_DEFRAG
+#define CHUNK_STATE_MASK			(CHUNK_ALLOCATED |		\
+						 CHUNK_TRIMMED)
 
 enum {
 	IO_TREE_FS_PINNED_EXTENTS,
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -33,6 +33,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "discard.h"
+#include "rcu-string.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -5668,6 +5669,19 @@ static int btrfs_trim_free_extents(struc
 					    &start, &end,
 					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
+		/* Check if there are any CHUNK_* bits left */
+		if (start > device->total_bytes) {
+			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+			btrfs_warn_in_rcu(fs_info,
+"ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
+					  start, end - start + 1,
+					  rcu_str_deref(device->name),
+					  device->total_bytes);
+			mutex_unlock(&fs_info->chunk_mutex);
+			ret = 0;
+			break;
+		}
+
 		/* Ensure we skip the reserved area in the first 1M */
 		start = max_t(u64, start, SZ_1M);
 
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4720,6 +4720,10 @@ again:
 	}
 
 	mutex_lock(&fs_info->chunk_mutex);
+	/* Clear all state bits beyond the shrunk device size */
+	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
+			  CHUNK_STATE_MASK);
+
 	btrfs_device_set_disk_total_bytes(device, new_size);
 	if (list_empty(&device->post_commit_list))
 		list_add_tail(&device->post_commit_list,


