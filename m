Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49DEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D0822229
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444670;
	bh=1DjVf4x6Kv2CJYuM2vBCCnZyAX5U4axJg1eon0whqtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGnLBUccwDDLbE2r0oUZlhVynTPhN+vnrJjnGCHaQujjv2oYmCq8+rB7G7WgVFt9o
	 mL4OAkw2d9LipU3rhxReYH7H0YWgMsVkgpMCaOYTUzk27S2xZBiIypwc5thc+kHi/c
	 pQF41RplPKEIOzdfYQcc0+objkX8ohWPkMcXwKvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbgFRBo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732182AbgFRB2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:28:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099AF22203;
        Thu, 18 Jun 2020 01:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443734;
        bh=1DjVf4x6Kv2CJYuM2vBCCnZyAX5U4axJg1eon0whqtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yyeW3+E52wbu/k/KOED5G6WHyBWOAF+w9K4ILjPTuhCKGCd+oPSGAD5S6sKWm4SaR
         Rs+AoNB1L5Mi97l1sV+pJV5gPeKQ/LC+vd8+HBfgHXsyzjFmSV9jK8e6ITQNypUhkp
         lSb+AxVpqaurKYFRTYMmb7NIpfiqVLIiDGRdGS1Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 25/80] fat: don't allow to mount if the FAT length == 0
Date:   Wed, 17 Jun 2020 21:27:24 -0400
Message-Id: <20200618012819.609778-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

[ Upstream commit b1b65750b8db67834482f758fc385bfa7560d228 ]

If FAT length == 0, the image doesn't have any data. And it can be the
cause of overlapping the root dir and FAT entries.

Also Windows treats it as invalid format.

Reported-by: syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Link: http://lkml.kernel.org/r/87r1wz8mrd.fsf@mail.parknet.co.jp
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fat/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index f0387d040331..9af410142f78 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1512,6 +1512,12 @@ static int fat_read_bpb(struct super_block *sb, struct fat_boot_sector *b,
 		goto out;
 	}
 
+	if (bpb->fat_fat_length == 0 && bpb->fat32_length == 0) {
+		if (!silent)
+			fat_msg(sb, KERN_ERR, "bogus number of FAT sectors");
+		goto out;
+	}
+
 	error = 0;
 
 out:
-- 
2.25.1

