Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F42B207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927536;
	bh=L5/aIVK9OucMl9O80aIiHExcX4Jerz8nTzXEwXa3isY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=evixgcjy9OJekVzIt4hp0JLIecdRck10iZc8SlaZqs+SBm6mGbJHTE8UNUsL8AsTY
	 uClRQ4Sm9WmPT/t+bV7WvkZYLHEb9rXaYASOTp0KYUA18g10dvCbLGnmqbbP+RvAE2
	 E2PMX5n80YDzqcYDhCxdvjg4gkz4IYwLHVmy6H9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgHTMpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgHTJpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248DF22CAF;
        Thu, 20 Aug 2020 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916726;
        bh=L5/aIVK9OucMl9O80aIiHExcX4Jerz8nTzXEwXa3isY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=insirguK5CGs4V15m5K3DM99F9wUOgwPG6oE9qz6NJ/0Tej1vutaLL2Fi6yjADwrh
         isjmVy0CNCzFp8GYhuY4GvLwWNHmYYizbD7NpjVemHRQSrmRIm302OubeM4K4hMNjC
         ag/w1rynotnUwAWp8jwMSW9mhUmio1kB72s0Qb1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 025/152] btrfs: only search for left_info if there is no right_info in try_merge_free_space
Date:   Thu, 20 Aug 2020 11:19:52 +0200
Message-Id: <20200820091554.934269841@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit bf53d4687b8f3f6b752f091eb85f62369a515dfd upstream.

In try_to_merge_free_space we attempt to find entries to the left and
right of the entry we are adding to see if they can be merged.  We
search for an entry past our current info (saved into right_info), and
then if right_info exists and it has a rb_prev() we save the rb_prev()
into left_info.

However there's a slight problem in the case that we have a right_info,
but no entry previous to that entry.  At that point we will search for
an entry just before the info we're attempting to insert.  This will
simply find right_info again, and assign it to left_info, making them
both the same pointer.

Now if right_info _can_ be merged with the range we're inserting, we'll
add it to the info and free right_info.  However further down we'll
access left_info, which was right_info, and thus get a use-after-free.

Fix this by only searching for the left entry if we don't find a right
entry at all.

The CVE referenced had a specially crafted file system that could
trigger this use-after-free. However with the tree checker improvements
we no longer trigger the conditions for the UAF.  But the original
conditions still apply, hence this fix.

Reference: CVE-2019-19448
Fixes: 963030817060 ("Btrfs: use hybrid extents+bitmap rb tree for free space")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/free-space-cache.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2166,7 +2166,7 @@ out:
 static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 			  struct btrfs_free_space *info, bool update_stat)
 {
-	struct btrfs_free_space *left_info;
+	struct btrfs_free_space *left_info = NULL;
 	struct btrfs_free_space *right_info;
 	bool merged = false;
 	u64 offset = info->offset;
@@ -2181,7 +2181,7 @@ static bool try_merge_free_space(struct
 	if (right_info && rb_prev(&right_info->offset_index))
 		left_info = rb_entry(rb_prev(&right_info->offset_index),
 				     struct btrfs_free_space, offset_index);
-	else
+	else if (!right_info)
 		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
 
 	if (right_info && !right_info->bitmap) {


