Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68897C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C13822B40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929041;
	bh=f9rXPAQaNcbv4cfIA5Asq/mz1mnROIrze4c9fJmGeOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RWtzDnwWfDVK9hlrFQ3os6obxRxE/BQ4KKRcbkOqqJyyTIMUFJUVlaKiUs4gCNlHm
	 A7j0eUxNykki69UbSQazv4HVyd629U41PQK5v7FYJW8AcTXtEzO7QJ5ZicUyv3bH5o
	 5LGkcV/PZvJ52RJt3EaYIix8Z7nHpr72LHDlSzjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgHTNKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgHTJh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:37:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B01E208E4;
        Thu, 20 Aug 2020 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916249;
        bh=f9rXPAQaNcbv4cfIA5Asq/mz1mnROIrze4c9fJmGeOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ol3iLldBZSqoNX7ZrzD62FbtvQOlfxnyjZU22H+6QC9t4nXWllhcakgQ3aPUARmAg
         xB/AVw2dd601Tj76xPTJL9vVtQHoIlffZ3FsFDE5c8zYtnAWUkjjgwOoadLqsUZmWi
         Y1bnLofTXDc/dBD7B+LYot947KozkHDp/6csreiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.7 033/204] btrfs: fix memory leaks after failure to lookup checksums during inode logging
Date:   Thu, 20 Aug 2020 11:18:50 +0200
Message-Id: <20200820091607.918890265@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 4f26433e9b3eb7a55ed70d8f882ae9cd48ba448b upstream.

While logging an inode, at copy_items(), if we fail to lookup the checksums
for an extent we release the destination path, free the ins_data array and
then return immediately. However a previous iteration of the for loop may
have added checksums to the ordered_sums list, in which case we leak the
memory used by them.

So fix this by making sure we iterate the ordered_sums list and free all
its checksums before returning.

Fixes: 3650860b90cc2a ("Btrfs: remove almost all of the BUG()'s from tree-log.c")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4040,11 +4040,8 @@ static noinline int copy_items(struct bt
 						fs_info->csum_root,
 						ds + cs, ds + cs + cl - 1,
 						&ordered_sums, 0);
-				if (ret) {
-					btrfs_release_path(dst_path);
-					kfree(ins_data);
-					return ret;
-				}
+				if (ret)
+					break;
 			}
 		}
 	}
@@ -4057,7 +4054,6 @@ static noinline int copy_items(struct bt
 	 * we have to do this after the loop above to avoid changing the
 	 * log tree while trying to change the log tree.
 	 */
-	ret = 0;
 	while (!list_empty(&ordered_sums)) {
 		struct btrfs_ordered_sum *sums = list_entry(ordered_sums.next,
 						   struct btrfs_ordered_sum,


