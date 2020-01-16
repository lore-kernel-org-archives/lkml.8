Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DB62469D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194931;
	bh=CZoEm34k2yxC/ZLFQYNkpC/eieyvEaKqF77ghZX9gVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ckgOfx3zqeNqAMKOO7hmcwaTnfajFJzmZqLAWVMWIoxBCkXT1r+ODusATcjteCkqx
	 ApLUw2aELFCK/iBQ1P+48WIke7QhsJZYFVBFVDTHlmsgA0OqVMdHRzlfViUj+uMnrX
	 JU1T5hrDLS4g9X334fhZOHGgcOSrQIZ4rbJFA++M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbgAPROh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:14:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390974AbgAPROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112A12469C;
        Thu, 16 Jan 2020 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194861;
        bh=CZoEm34k2yxC/ZLFQYNkpC/eieyvEaKqF77ghZX9gVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fs26R41MoQh2V8sSsDVW+GEJaDDWdXLYrlmxFjc9zvqoOZia4SUEe8c7a3fLLPYx1
         RqnwwzO3tNHRjFkCA62n64gXDbnxg7m2xi62kml3bQdhnrlopqPcmxFBfqwje/PZr0
         ltIBYUfuaIFdTJ+2QkK8KkexqAAbzJz6Avp8zoSQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 656/671] afs: Remove set but not used variables 'before', 'after'
Date:   Thu, 16 Jan 2020 12:04:54 -0500
Message-Id: <20200116170509.12787-393-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 51590df4f3306cb1f43dca54e3ccdd121ab89594 ]

Fixes gcc '-Wunused-but-set-variable' warning:

fs/afs/dir_edit.c: In function afs_set_contig_bits:
fs/afs/dir_edit.c:75:20: warning: variable after set but not used [-Wunused-but-set-variable]
fs/afs/dir_edit.c: In function afs_set_contig_bits:
fs/afs/dir_edit.c:75:12: warning: variable before set but not used [-Wunused-but-set-variable]
fs/afs/dir_edit.c: In function afs_clear_contig_bits:
fs/afs/dir_edit.c:100:20: warning: variable after set but not used [-Wunused-but-set-variable]
fs/afs/dir_edit.c: In function afs_clear_contig_bits:
fs/afs/dir_edit.c:100:12: warning: variable before set but not used [-Wunused-but-set-variable]

They are never used since commit 63a4681ff39c.

Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir_edit.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 8b400f5aead5..0e7162527db8 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -72,13 +72,11 @@ static int afs_find_contig_bits(union afs_xdr_dir_block *block, unsigned int nr_
 static void afs_set_contig_bits(union afs_xdr_dir_block *block,
 				int bit, unsigned int nr_slots)
 {
-	u64 mask, before, after;
+	u64 mask;
 
 	mask = (1 << nr_slots) - 1;
 	mask <<= bit;
 
-	before = *(u64 *)block->hdr.bitmap;
-
 	block->hdr.bitmap[0] |= (u8)(mask >> 0 * 8);
 	block->hdr.bitmap[1] |= (u8)(mask >> 1 * 8);
 	block->hdr.bitmap[2] |= (u8)(mask >> 2 * 8);
@@ -87,8 +85,6 @@ static void afs_set_contig_bits(union afs_xdr_dir_block *block,
 	block->hdr.bitmap[5] |= (u8)(mask >> 5 * 8);
 	block->hdr.bitmap[6] |= (u8)(mask >> 6 * 8);
 	block->hdr.bitmap[7] |= (u8)(mask >> 7 * 8);
-
-	after = *(u64 *)block->hdr.bitmap;
 }
 
 /*
@@ -97,13 +93,11 @@ static void afs_set_contig_bits(union afs_xdr_dir_block *block,
 static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
 				  int bit, unsigned int nr_slots)
 {
-	u64 mask, before, after;
+	u64 mask;
 
 	mask = (1 << nr_slots) - 1;
 	mask <<= bit;
 
-	before = *(u64 *)block->hdr.bitmap;
-
 	block->hdr.bitmap[0] &= ~(u8)(mask >> 0 * 8);
 	block->hdr.bitmap[1] &= ~(u8)(mask >> 1 * 8);
 	block->hdr.bitmap[2] &= ~(u8)(mask >> 2 * 8);
@@ -112,8 +106,6 @@ static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
 	block->hdr.bitmap[5] &= ~(u8)(mask >> 5 * 8);
 	block->hdr.bitmap[6] &= ~(u8)(mask >> 6 * 8);
 	block->hdr.bitmap[7] &= ~(u8)(mask >> 7 * 8);
-
-	after = *(u64 *)block->hdr.bitmap;
 }
 
 /*
-- 
2.20.1

