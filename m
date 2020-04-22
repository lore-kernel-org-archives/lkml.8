Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92853C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E582084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552906;
	bh=KGU6C6N58so4o6O0x1bSGsf14WQu11/9X6MOACQv8CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dr7DxI3n9Br1nYnZGNVSqKiAQhje2SF2wG695GfHDcUIW97rb2+PYGuOBrK2BTIgJ
	 n7uw7l1CvYmFyoVUS1YNExryu5s+37dCMIHQbaUj1I9Voom9YIchInj7YFHQJ0jY6X
	 OhvCuZj3MQf7LbpnxG6k1W3ivKpBbVEqACqOFrlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgDVKHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgDVKHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:07:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB8E2076C;
        Wed, 22 Apr 2020 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550035;
        bh=KGU6C6N58so4o6O0x1bSGsf14WQu11/9X6MOACQv8CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uK9lQZAZ2ESH6axJ1BshkjeTvIsiq2xECwH3+NwC9n2vDDB5ryVVBc6YYxiqwoDde
         BIevZ5OpZwOkk8N5HaVV/bOicMvcb7bOKrDPB8Jk4qnbK8pUm3d6TSa/NtozAJUrQS
         2fNOSpSDSL5U4APf8AWNnEjYRvvMmBb0KhfoQut4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 109/125] ext4: do not commit super on read-only bdev
Date:   Wed, 22 Apr 2020 11:57:06 +0200
Message-Id: <20200422095050.403414559@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit c96e2b8564adfb8ac14469ebc51ddc1bfecb3ae2 ]

Under some circumstances we may encounter a filesystem error on a
read-only block device, and if we try to save the error info to the
superblock and commit it, we'll wind up with a noisy error and
backtrace, i.e.:

[ 3337.146838] EXT4-fs error (device pmem1p2): ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: illegal inode #
------------[ cut here ]------------
generic_make_request: Trying to write to read-only block-device pmem1p2 (partno 2)
WARNING: CPU: 107 PID: 115347 at block/blk-core.c:788 generic_make_request_checks+0x6b4/0x7d0
...

To avoid this, commit the error info in the superblock only if the
block device is writable.

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Link: https://lore.kernel.org/r/4b6e774d-cc00-3469-7abb-108eb151071a@sandeen.net
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a5edc5c0882f4..ed0520fe4dad6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -344,7 +344,8 @@ static void save_error_info(struct super_block *sb, const char *func,
 			    unsigned int line)
 {
 	__save_error_info(sb, func, line);
-	ext4_commit_super(sb, 1);
+	if (!bdev_read_only(sb->s_bdev))
+		ext4_commit_super(sb, 1);
 }
 
 /*
-- 
2.20.1



