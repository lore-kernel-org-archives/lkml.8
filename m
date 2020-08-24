Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23974C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0294C207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258064;
	bh=23ucjoFeJ1M8m1lUFCqnbYUhv+4g9L4TflRGrF9xXrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUMaOtrq4ROJv1fHahuJPTPF8uf5R5uIw4n6zaf+4fmBz8XADGCXKcZz1S8+xBWSA
	 WiCCmzQKIDfMkBCzEgftLU/507GKd18tHlG9tTdYJwmRA1uUBGV/fndR37TZ9FDeW1
	 e975JWLWs2/+p3CDzHJyN+oW7o/hDT5Be9OaF13E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgHXIeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgHXIeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:34:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D022074D;
        Mon, 24 Aug 2020 08:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258047;
        bh=23ucjoFeJ1M8m1lUFCqnbYUhv+4g9L4TflRGrF9xXrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrYlIAO5b+JYywhBMZSO7Mf0Ts1kmQi9cksApgfGlNB+W0tlC5dA3aYLMFF+BCoBm
         pN2e/DwyWzXcD5HeUS72KlWYkEchsaW7kuwFqf7aQEH5FPauiWN4bn7DchvLL82wWi
         a/ADMqsmlznYNLZbUugMqegQk/4prlVFXnKfkGtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Filipe Manana <fdmanana@gmail.com>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.8 025/148] ext4: do not block RWF_NOWAIT dio write on unallocated space
Date:   Mon, 24 Aug 2020 10:28:43 +0200
Message-Id: <20200824082415.158803371@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 0b3171b6d195637f84ddf8b59bae818ea20bc8ac upstream.

Since commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
infrastructure") we don't properly bail out of RWF_NOWAIT direct IO
write if underlying blocks are not allocated. Also
ext4_dio_write_checks() does not honor RWF_NOWAIT when re-acquiring
i_rwsem. Fix both issues.

Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
Cc: stable@kernel.org
Reported-by: Filipe Manana <fdmanana@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/20200708153516.9507-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/file.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -428,6 +428,10 @@ restart:
 	 */
 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
 	     !ext4_overwrite_io(inode, offset, count))) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto out;
+		}
 		inode_unlock_shared(inode);
 		*ilock_shared = false;
 		inode_lock(inode);


