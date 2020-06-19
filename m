Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2D0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6A8217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583888;
	bh=0oNcNc9hT9NHNmqFo9Yl2g9cYskk6nm4YWvxvxd6L0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8RnHyssGYsJ9rwYuw6XzK+BZ43a+NExN9WCMC6xicadePC4aiLUV7AFg2zEMIUUR
	 RfF4Wqr8VGxB/QeQOuPHTY5mUpmdazJzqYkn//qOAYihVsbKtwq6fcRFlhwL7ph3wb
	 gJ7eForAKNOoN8qjoQeNg2/n9Vhrk+joM0/pzKUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbgFSQYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389915AbgFSO54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:57:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDF721D7F;
        Fri, 19 Jun 2020 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578676;
        bh=0oNcNc9hT9NHNmqFo9Yl2g9cYskk6nm4YWvxvxd6L0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFJlrmQXoORYAXgU+okoZ8qMJJq/4y927FiVRbxW5Q5DgjLwUVrEV5znl73Ry+A2c
         p0frcPWfT2soC8osmjTPhPk7fIlq9uNggX22QZmseleNKOeN77LwtOdfAGgPBJMlFZ
         iIHNLzkdPL/ihqaWHJDmIVvcHrTb4I02/Z1qTL/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 113/267] btrfs: do not ignore error from btrfs_next_leaf() when inserting checksums
Date:   Fri, 19 Jun 2020 16:31:38 +0200
Message-Id: <20200619141654.268561185@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 7e4a3f7ed5d54926ec671bbb13e171cfe179cc50 ]

We are currently treating any non-zero return value from btrfs_next_leaf()
the same way, by going to the code that inserts a new checksum item in the
tree. However if btrfs_next_leaf() returns an error (a value < 0), we
should just stop and return the error, and not behave as if nothing has
happened, since in that case we do not have a way to know if there is a
next leaf or we are currently at the last leaf already.

So fix that by returning the error from btrfs_next_leaf().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file-item.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index f9e280d0b44f..1b8a04b767ff 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -785,10 +785,12 @@ again:
 		nritems = btrfs_header_nritems(path->nodes[0]);
 		if (!nritems || (path->slots[0] >= nritems - 1)) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret == 1)
+			if (ret < 0) {
+				goto out;
+			} else if (ret > 0) {
 				found_next = 1;
-			if (ret != 0)
 				goto insert;
+			}
 			slot = path->slots[0];
 		}
 		btrfs_item_key_to_cpu(path->nodes[0], &found_key, slot);
-- 
2.25.1



