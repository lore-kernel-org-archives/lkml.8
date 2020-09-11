Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B88C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3686C223BD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599836338;
	bh=yWd7Xk6i6VoYeFBQ9j2bjYn6LP4GVgLuBx2gKw8zksQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u8u56Tb6sv4LGdg2/FIbRm7A7Su1Mg9Wcnj1pIHbJlA0hX13jdKEojE+BQkkroN10
	 87pmvq/AylODiLkyY6eNVMmWpdrXZxKW2YOUD1/xvF/AxZAwN955ybawWEIgEhvTsc
	 +1ozuQDExedm0kzqXF3VQGqA0whkEZS3/siNLU1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgIKO6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgIKNCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:02:20 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25ACB222B6;
        Fri, 11 Sep 2020 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829030;
        bh=yWd7Xk6i6VoYeFBQ9j2bjYn6LP4GVgLuBx2gKw8zksQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOPopwwK0r7BvMm7qB0S67FR9pK8f/89S7RR+bR06GH7ggkJ1XSj4dFtcjIcE/dFY
         UEXxaAuIq1K0JEVJOKU6cHXzxfQQ4iekEr5SyoICadRhTvfHysdFyVBtddfEPiN3t2
         3/Jd3+YqhHyq2wgcw42iuXQw7d4/X2phEUJOaebc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 31/71] btrfs: Remove extraneous extent_buffer_get from tree_mod_log_rewind
Date:   Fri, 11 Sep 2020 14:46:15 +0200
Message-Id: <20200911122506.483895838@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911122504.928931589@linuxfoundation.org>
References: <20200911122504.928931589@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

[ Upstream commit 24cee18a1c1d7c731ea5987e0c99daea22ae7f4a ]

When a rewound buffer is created it already has a ref count of 1 and the
dummy flag set. Then another ref is taken bumping the count to 2.
Finally when this buffer is released from btrfs_release_path the extra
reference is decremented by the special handling code in
free_extent_buffer.

However, this special code is in fact redundant sinca ref count of 1 is
still correct since the buffer is only accessed via btrfs_path struct.
This paves the way forward of removing the special handling in
free_extent_buffer.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 78d4c8c22b4ac..406ae49baa076 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1360,7 +1360,6 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	btrfs_tree_read_unlock_blocking(eb);
 	free_extent_buffer(eb);
 
-	extent_buffer_get(eb_rewin);
 	btrfs_tree_read_lock(eb_rewin);
 	__tree_mod_log_rewind(fs_info, eb_rewin, time_seq, tm);
 	WARN_ON(btrfs_header_nritems(eb_rewin) >
-- 
2.25.1



