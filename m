Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA6020674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692971;
	bh=rByohBipMQD+Mr+NQEulKE7/oGD16WMXfdthdczdzhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1B6HVBpS3YZHB9fp5sAJIPIBQZGsv7XNyrZyoP6PZVvHDdqLwuEGNyF8Scf2zz/2
	 wtIYhqJce+Pex/JuIrzdvI9Wvk/0AEapiQXA0yk7/VgSCDoUWK2BGBVgPSEdiqWPt5
	 A+5okaqLfTrdWMOIryirf6ffdovSAkWKDwzraIM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgHQTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbgHQP2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:28:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FCB22395B;
        Mon, 17 Aug 2020 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678133;
        bh=rByohBipMQD+Mr+NQEulKE7/oGD16WMXfdthdczdzhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyysUvQBwypgpDe0TrRS8VF16NjNhz+8d73vjeL5qIxqhgpydEtCs9lE9zkoJvUOB
         NNRoCR/cmoBgEhdbr9S20TJixtm1wgHCDsiQ2jkaqjBSyGxAK5u0S+EnU2ghd8HWKS
         H/PB6MHN54zRzJ/lvNEqaV2L7l1NvPkRRGNKHoL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 230/464] kernfs: do not call fsnotify() with name without a parent
Date:   Mon, 17 Aug 2020 17:13:03 +0200
Message-Id: <20200817143844.818016395@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 9991bb84b27a2594187898f261866cfc50255454 ]

When creating an FS_MODIFY event on inode itself (not on parent)
the file_name argument should be NULL.

The change to send a non NULL name to inode itself was done on purpuse
as part of another commit, as Tejun writes: "...While at it, supply the
target file name to fsnotify() from kernfs_node->name.".

But this is wrong practice and inconsistent with inotify behavior when
watching a single file.  When a child is being watched (as opposed to the
parent directory) the inotify event should contain the watch descriptor,
but not the file name.

Fixes: df6a58c5c5aa ("kernfs: don't depend on d_find_any_alias()...")
Link: https://lore.kernel.org/r/20200708111156.24659-5-amir73il@gmail.com
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 06b342d8462bf..e23b3f62483c4 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -912,7 +912,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		}
 
 		fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
-			 &name, 0);
+			 NULL, 0);
 		iput(inode);
 	}
 
-- 
2.25.1



