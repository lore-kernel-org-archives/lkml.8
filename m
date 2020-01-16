Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA46CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C9F2464B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197620;
	bh=St/rATh14XAuZNQEpkdMnC6jqu7FSvG0LFgOxzRINec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gid1Z6pdyhTfSskMB4PUmZf5NZqUFCtdYfZbNm5yoKyq8YnFtlfk5cFCpjPrSyRS4
	 ad3QlotyJzyewDMHsIPMoiDplUUOpNG7cf39Xi/v0uGPIUKpajCAi1Bjm1BQrFe6tF
	 Xj2wplO0QsLFnXtBNpZSOoG4hoJdHX/qLZ0/LdzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405812AbgAPRlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgAPRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:41:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B312469B;
        Thu, 16 Jan 2020 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196472;
        bh=St/rATh14XAuZNQEpkdMnC6jqu7FSvG0LFgOxzRINec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPgC2lbjb6f4YxMQ0RBUzDJAp+p6s3nYFz1pNkileEKJcnLAUs//4PhUidMGSfRnH
         WW/goXDjdbvUM3yR7eLmLg1C7A3b8qW2P1rY6u6uRHxwJ9E3w8aFYYamYlzY01elrm
         Mg1TupKygHk3upUuqRrOlCEcE7s5xeZmPL12wR8o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 222/251] afs: Fix large file support
Date:   Thu, 16 Jan 2020 12:36:11 -0500
Message-Id: <20200116173641.22137-182-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit b485275f1aca8a9da37fd35e4fad673935e827da ]

By default s_maxbytes is set to MAX_NON_LFS, which limits the usable
file size to 2GB, enforced by the vfs.

Commit b9b1f8d5930a ("AFS: write support fixes") added support for the
64-bit fetch and store server operations, but did not change this value.
As a result, attempts to write past the 2G mark result in EFBIG errors:

 $ dd if=/dev/zero of=foo bs=1M count=1 seek=2048
 dd: error writing 'foo': File too large

Set s_maxbytes to MAX_LFS_FILESIZE.

Fixes: b9b1f8d5930a ("AFS: write support fixes")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index fbdb022b75a2..65389394e202 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -317,6 +317,7 @@ static int afs_fill_super(struct super_block *sb,
 	/* fill in the superblock */
 	sb->s_blocksize		= PAGE_SIZE;
 	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_magic		= AFS_FS_MAGIC;
 	sb->s_op		= &afs_super_ops;
 	sb->s_bdi		= &as->volume->bdi;
-- 
2.20.1

