Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D7DC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC5324125
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865779;
	bh=1g51mCM576KXk7ji3ixXcf9nDw3EQhTrDO8ED8Rl4u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2GKFZE0ov6zLpg5b/5ZUUx2fcTh4K14O9Qv/BlQVwR1+scFm67WoJO1+u6d6KkKYb
	 zr/InjJQiKqzP352LKd3UhIliBcGhidt2g55+chLBrqaKYt3jyWjuzpXb16s9RXuPq
	 bdHO6F2SMIz+5oxeTcqGdP+MZ719dq++mKA2Dc94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404921AbgAXLgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:36:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404551AbgAXLgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:36:15 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 569E3206F0;
        Fri, 24 Jan 2020 11:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865774;
        bh=1g51mCM576KXk7ji3ixXcf9nDw3EQhTrDO8ED8Rl4u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/6WRaXqDwscb1cPcoz2kO6B+R1tQKxGgoNtgCcU7PF0raRrTCdysNXFbUpknkVZ1
         ugbEJ7i9EKvWavFBAejsRpI9IpfVkdnPemu+UCbmuYpvoqM8cPnauGH2W8i9SXsgh6
         CsTALPHTP//h1xQY3AymeCxGA12U/eilQM0hHIj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 617/639] afs: Fix large file support
Date:   Fri, 24 Jan 2020 10:33:07 +0100
Message-Id: <20200124093206.900172997@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 18b9b7ca20c92..4961d32ccd1e0 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -393,6 +393,7 @@ static int afs_fill_super(struct super_block *sb,
 	/* fill in the superblock */
 	sb->s_blocksize		= PAGE_SIZE;
 	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_magic		= AFS_FS_MAGIC;
 	sb->s_op		= &afs_super_ops;
 	if (!as->dyn_root)
-- 
2.20.1



