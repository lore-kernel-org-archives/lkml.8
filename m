Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F3C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD902075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGNQM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:12:27 -0400
Received: from mail5.windriver.com ([192.103.53.11]:52440 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgGNQM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:12:26 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 06EGBTsF000671
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 14 Jul 2020 09:12:16 -0700
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 09:12:05 -0700
From:   <yanfei.xu@windriver.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] userfaultfd: avoid the duplicated release for userfaultfd_ctx
Date:   Wed, 15 Jul 2020 00:12:03 +0800
Message-ID: <20200714161203.31879-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

when get_unused_fd_flags gets failure, userfaultfd_ctx_cachep will
be freed by userfaultfd_fops's release function which is the
userfaultfd_release. So we could return directly after fput().

userfaultfd_release()->userfaultfd_ctx_put(ctx)

Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3a4d6ac5a81a..e98317c15530 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2049,7 +2049,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		fput(file);
-		goto out;
+		return fd;
 	}
 
 	ctx->owner = file_inode(file);
-- 
2.18.2

