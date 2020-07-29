Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C161C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755E62083E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596028953;
	bh=Phtwyl6TA4Aztd1IQmv6O6oOJmp4MMAckE8fKe9Vl4c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iAq1DN3wpitrjX1FwlaZiM7bZ/Z4pNjmJrBMzAEbZjpNMv6IGl5EH5Wa7NTntawO1
	 Wzr3LpyIVktnnCFLN9Gq1tFr0j2QG7QpMbwnHjWoUBZK4C3KdKOxRxiJhOYnTB/g5s
	 nDwQdbW9CDIDVe7gprnw0g0SNpa1fCK+0lag0lkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgG2NWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG2NWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:22:32 -0400
Received: from localhost.localdomain (unknown [49.65.247.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C049220809;
        Wed, 29 Jul 2020 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596028951;
        bh=Phtwyl6TA4Aztd1IQmv6O6oOJmp4MMAckE8fKe9Vl4c=;
        h=From:To:Cc:Subject:Date:From;
        b=af4M7BI8cvABf6YStyR4IEEdIi13eHIZKeSO+OKlT/9ruFDgnJSDbOllN2rNmmv3F
         FdChXRnsBzTyi/XG+/sEL36+WzHvv0X0jaccvErdJYyk0gCCgzDnNoqBSvqbSFnXU0
         o70FoKmaXZ+BvX5jkjWiKaqfIJTAohNLVlXqsFBo=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: compress: add sanity check during compressed cluster read
Date:   Wed, 29 Jul 2020 21:21:35 +0800
Message-Id: <20200729132136.11134-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

In f2fs_read_multi_pages(), we don't have to check cluster's type
again, since overwrite or partial truncation need page lock in
cluster which has already been held by reader, so cluster's type
is stable, let's change check condition to sanity check.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bc89bc987513..c1b676be67b9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2170,9 +2170,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	if (ret)
 		goto out;
 
-	/* cluster was overwritten as normal cluster */
-	if (dn.data_blkaddr != COMPRESS_ADDR)
-		goto out;
+	f2fs_bug_on(sbi, dn.data_blkaddr != COMPRESS_ADDR);
 
 	for (i = 1; i < cc->cluster_size; i++) {
 		block_t blkaddr;
-- 
2.22.0

