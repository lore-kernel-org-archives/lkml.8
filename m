Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C189F2250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGTBqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:46:38 -0400
Received: from foss.arm.com ([217.140.110.172]:40810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgGTBqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:46:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAE8F12FC;
        Sun, 19 Jul 2020 18:46:37 -0700 (PDT)
Received: from entos-d05.shanghai.arm.com (entos-d05.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 79D6C3F66E;
        Sun, 19 Jul 2020 18:46:34 -0700 (PDT)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     ericvh@gmail.com, hch@lst.de, dhowells@redhat.com,
        lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Kaly.Xin@arm.com, justin.he@arm.com, jianyong.wu@arm.com,
        wei.chen@arm.com
Subject: [RFC PATCH 1/2] vfs: pass file down when getattr to avoid losing info.
Date:   Mon, 20 Jul 2020 09:46:21 +0800
Message-Id: <20200720014622.37364-2-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720014622.37364-1-jianyong.wu@arm.com>
References: <20200720014622.37364-1-jianyong.wu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, getting attribute for a file represented by fd is always
by inode or path which may lead to bug for a certain network file system.
Adding file struct into struct kstat and assigning file for it in
vfs_statx_fd can avoid this issue. This change refers to struct istat.

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---
 fs/stat.c            | 1 +
 include/linux/stat.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 44f8ad346db4..0dee5487f6d6 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -147,6 +147,7 @@ int vfs_statx_fd(unsigned int fd, struct kstat *stat,
 		return -EINVAL;
 
 	f = fdget_raw(fd);
+	stat->filp = f.file;
 	if (f.file) {
 		error = vfs_getattr(&f.file->f_path, stat,
 				    request_mask, query_flags);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 56614af83d4a..4755c528d49a 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -48,6 +48,12 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+
+	/*
+	 * Not an attribute, but an auxiliary info for filesystems wanting to
+	 * implement an fstat() like method.
+	 */
+	struct file	*filp;
 };
 
 #endif
-- 
2.17.1

