Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A5C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5462A2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551192;
	bh=5Ci5tuTv9+UalY7YeLpOUErdM7aSS+N8D1vX52ppM9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRF+fEHVXdbUzhJNpmpsLG5h8KphfaQxYsCCgRstdoMa9BLH5MJrkX6VARREX6fQ1
	 FuouOBgWwVVv/evsA74MuL2veN9eeS7uj6T1Ldabg1VAGvmpKgDNRCnXSJQ4VvIIC/
	 8O90Mfs4KnQGcbhzYI1k5IBQnmEM5ktwAH2B1B28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgDVK0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbgDVK02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:26:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35EC32071E;
        Wed, 22 Apr 2020 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551187;
        bh=5Ci5tuTv9+UalY7YeLpOUErdM7aSS+N8D1vX52ppM9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXTE01N/SH2u7BORnPqqYBCXzhZQVfV+hdrHh6ILaVRqbDJTKxQaIilYzyK0EY4fM
         AxRQSGXt9Zjs2Qw/+W+bBGKIt/o+gXBfOZTBqPEh+rWYn1B958a0JgW+7ps6B0m021
         yMM3vnSP0yLQ5auo6/uhdJIIHDx1JOp+cfHgLLHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 136/166] ext2: fix debug reference to ext2_xattr_cache
Date:   Wed, 22 Apr 2020 11:57:43 +0200
Message-Id: <20200422095103.180768662@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 32302085a8d90859c40cf1a5e8313f575d06ec75 ]

Fix a debug-only build error in ext2/xattr.c:

When building without extra debugging, (and with another patch that uses
no_printk() instead of <empty> for the ext2-xattr debug-print macros,
this build error happens:

../fs/ext2/xattr.c: In function ‘ext2_xattr_cache_insert’:
../fs/ext2/xattr.c:869:18: error: ‘ext2_xattr_cache’ undeclared (first use in
this function); did you mean ‘ext2_xattr_list’?
     atomic_read(&ext2_xattr_cache->c_entry_count));

Fix the problem by removing cached entry count from the debug message
since otherwise we'd have to export the mbcache structure just for that.

Fixes: be0726d33cb8 ("ext2: convert to mbcache2")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext2/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index b91f99d9482e9..62acbe27d8bf4 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -865,8 +865,7 @@ ext2_xattr_cache_insert(struct mb_cache *cache, struct buffer_head *bh)
 				      true);
 	if (error) {
 		if (error == -EBUSY) {
-			ea_bdebug(bh, "already in cache (%d cache entries)",
-				atomic_read(&ext2_xattr_cache->c_entry_count));
+			ea_bdebug(bh, "already in cache");
 			error = 0;
 		}
 	} else
-- 
2.20.1



