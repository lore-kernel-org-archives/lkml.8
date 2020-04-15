Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACA2C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DACE208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586953681;
	bh=ZwYuWogEoMguMqy8IBBG5/+pe0y6k0fPBiOgbUr18LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s6F1lVvMdwcY0dgC6yMWBxwrJXCqtDS4CjoQTaHheGLGywp6vjZHJ0iUQyf35V3Z2
	 K2y+SU0tPdWqR3sX+NO9t+T0cg4xMuiUk43CgqkyLsoiHTmlRzQJI1Q7wcjZm/8Wwj
	 9ZnZ/U31LP7FeukM3nkV5C13Af+3nX+hgudptXhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369305AbgDOM17 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409150AbgDOLpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B6820775;
        Wed, 15 Apr 2020 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951114;
        bh=ZwYuWogEoMguMqy8IBBG5/+pe0y6k0fPBiOgbUr18LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4DJmch7Iz5KctoINZizt+LPAQ9hj38oyY+xmFjoCVe1uKKS9uD6ik2caC6G/Xp9J
         rNx6lU+23e1XbkoaWb9x8dHVJdlxdoT7YVcwluyWMJmp9hmxwOgfaGYF7DNxdokM7r
         N4reVlPSpp7zgaDmPxecvcumWHekBoF4TehpH7RI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Marian Klein <mkleinsoft@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 28/84] hibernate: Allow uswsusp to write to swap
Date:   Wed, 15 Apr 2020 07:43:45 -0400
Message-Id: <20200415114442.14166-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

[ Upstream commit 56939e014a6c212b317414faa307029e2e80c3b9 ]

It turns out that there is one use case for programs being able to
write to swap devices, and that is the userspace hibernation code.

Quick fix: disable the S_SWAPFILE check if hibernation is configured.

Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
Reported-by: Marian Klein <mkleinsoft@gmail.com>
Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/block_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d612468ee66bf..34644ce4b5025 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -1975,7 +1976,8 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
-	if (IS_SWAPFILE(bd_inode))
+	/* uswsusp needs write permission to the swap */
+	if (IS_SWAPFILE(bd_inode) && !hibernation_available())
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))
-- 
2.20.1

