Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EADC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CAE20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586950660;
	bh=LAlumWBbhcpTjkD/toI7vK0NLtLMCH6P3F0H4xaGuv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aErpouP+6M5iPMH7vchZQr4qNl6pXwwAhGu1xdEnf4o8WJDMeSCAa/geY1RNwkrM0
	 IKAlp63p+tXs33LcUOMqJ7ADktIaYiqKyABkBKEKL3xgrx7qe9XY2wDpAjDD+jYCPY
	 n/n71wwxLV0Nq/2I/e2t+EvO4menH9iAG2H9wOAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897231AbgDOLhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408872AbgDOLe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:34:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10D720775;
        Wed, 15 Apr 2020 11:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950496;
        bh=LAlumWBbhcpTjkD/toI7vK0NLtLMCH6P3F0H4xaGuv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oam/UDOW6vbCldWDmSSIfr7NggccawTJORCMuGi+iF5J8NSWtUocKzhl/ywo2RXqC
         O5ppnlEcKMqVXGjRCGvTeT7m+DAuCTWKwJHSRNU5Kz69rwOcPqROE9ZMGxw0YSPtMl
         WShrRV9b9odEZD6tQgckwpvF5yCeXarugx6/vaOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.6 009/129] f2fs: fix to avoid potential deadlock
Date:   Wed, 15 Apr 2020 07:32:44 -0400
Message-Id: <20200415113445.11881-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit df77fbd8c5b222c680444801ffd20e8bbc90a56e ]

Using f2fs_trylock_op() in f2fs_write_compressed_pages() to avoid potential
deadlock like we did in f2fs_write_single_data_page().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d8a64be90a501..c847523ab4a2e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -772,7 +772,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.encrypted_page = NULL,
 		.compressed_page = NULL,
 		.submitted = false,
-		.need_lock = LOCK_RETRY,
 		.io_type = io_type,
 		.io_wbc = wbc,
 		.encrypted = f2fs_encrypted_file(cc->inode),
@@ -785,9 +784,10 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
+	if (!f2fs_trylock_op(sbi))
+		return -EAGAIN;
 
-	f2fs_lock_op(sbi);
+	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
 
 	err = f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
 	if (err)
-- 
2.20.1

