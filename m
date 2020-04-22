Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B185BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4332073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551654;
	bh=nkzQYljAqqsLT0KyQ1yxVxy4hdkqt9fzHI0OYpbHm4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PGuxD03EkereA5VnKmCHprj9X4XlxsTpP/iPKY4crJi1ICYw8asNwAX56l1mWt64F
	 p4vx5lBPokehTqeNsO3pZJymHg+ym2kqjxJbrqFoxe+IKeHvhH0HuJLcT/HB8IS8bw
	 ZXFi+MlEidruO0c6nIbOCprilPz5rcSJnLgULieo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgDVKeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbgDVKY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:24:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39CED2071E;
        Wed, 22 Apr 2020 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551066;
        bh=nkzQYljAqqsLT0KyQ1yxVxy4hdkqt9fzHI0OYpbHm4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLoQA0gH+RiORewGmVXUkfXE8uhmsvefVDoHA9BiK6vnisQ1+2U9HaQB+65ru06JS
         Kc+sQ+nlWF05vlCoo6HdfQnBFOszo2zn0AvGUow+vbhj8D9MPGI4Sc5blibxZyx9ka
         HkFPvinB5Juv5XpUv3hHS6YTU7QjmlYeM/nVO8HY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Marian Klein <mkleinsoft@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 087/166] hibernate: Allow uswsusp to write to swap
Date:   Wed, 22 Apr 2020 11:56:54 +0200
Message-Id: <20200422095058.017363119@linuxfoundation.org>
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
index 69bf2fb6f7cda..84fe0162ff13e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 #include "internal.h"
 
 struct bdev_inode {
@@ -2001,7 +2002,8 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
-	if (IS_SWAPFILE(bd_inode))
+	/* uswsusp needs write permission to the swap */
+	if (IS_SWAPFILE(bd_inode) && !hibernation_available())
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))
-- 
2.20.1



