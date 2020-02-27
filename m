Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04383C3F34B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66FB20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811387;
	bh=NaNTqxtuUOQsOFP1anj/pHzM3OOymIE5IdFmt/ogCK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fGtrsBJru8yP8MP93bNKltkJx5+PUJhKa8b8WeGcGvFNYK9DY3Wb1tZXZrmh9r4id
	 aH30uGIr7W8FSvt+igULyegGb6Zme5iUvCPKYe1m3K3JlAJciomrrhf4T2Ql/2eQXl
	 CKwBTPe554wRYluMmQWQAbS/X/+r+Grw5WCIAZfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgB0Ntq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731050AbgB0Ntf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:49:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D992469F;
        Thu, 27 Feb 2020 13:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811375;
        bh=NaNTqxtuUOQsOFP1anj/pHzM3OOymIE5IdFmt/ogCK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uil1+/EayHTtQm3d3b1Hk7HoxONqUX1PZTaMXcFp1MLWaoWORIDaTlDrggUUZVllx
         FIknTuzzMPPVekReVZy+97ovl9mFJkvq170Fu/vfVA37FoI0LXxuQZ87Dd1ygEa1ac
         blBBCiYGKpuh1/5IxfRJ+Gtmm3Nfl27DXVqlB+HE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Hu Shiyuan <hushiyuan@huawei.com>,
        Feilong Lin <linfeilong@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 108/165] reiserfs: prevent NULL pointer dereference in reiserfs_insert_item()
Date:   Thu, 27 Feb 2020 14:36:22 +0100
Message-Id: <20200227132246.941130796@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit aacee5446a2a1aa35d0a49dab289552578657fb4 ]

The variable inode may be NULL in reiserfs_insert_item(), but there is
no check before accessing the member of inode.

Fix this by adding NULL pointer check before calling reiserfs_debug().

Link: http://lkml.kernel.org/r/79c5135d-ff25-1cc9-4e99-9f572b88cc00@huawei.com
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: zhengbin <zhengbin13@huawei.com>
Cc: Hu Shiyuan <hushiyuan@huawei.com>
Cc: Feilong Lin <linfeilong@huawei.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/reiserfs/stree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index a97e352d05d3b..5f5fff0688776 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -2249,7 +2249,8 @@ error_out:
 	/* also releases the path */
 	unfix_nodes(&s_ins_balance);
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug(th->t_super, REISERFS_DEBUG_CODE,
+	if (inode)
+		reiserfs_debug(th->t_super, REISERFS_DEBUG_CODE,
 		       "reiserquota insert_item(): freeing %u id=%u type=%c",
 		       quota_bytes, inode->i_uid, head2type(ih));
 #endif
-- 
2.20.1



