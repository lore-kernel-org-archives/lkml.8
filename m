Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FCDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281E3221F0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444318;
	bh=e658WW0G7WsgvPdyzF5n7r+BBwoIhr2bx6TZgKtrdw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qad8QZ6+lsQIYu/G1TTj/OLk+X72DO4jN5G8lhOS8h5Bo0OpsOCe3OuLGMAVuBGdU
	 GMeQzCM0YnTMT2v9H0FppLyTrK+5KXeX+6cjK7xP4+SmoOq1vU9QL4VvShq6kUcZEj
	 bAw0u9DJCqU7VIddluRNbzdG9/Dl2UR/1vPNFRHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgFRBig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732544AbgFRBaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72FB721D82;
        Thu, 18 Jun 2020 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443830;
        bh=e658WW0G7WsgvPdyzF5n7r+BBwoIhr2bx6TZgKtrdw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fG6dmrsTHkBSVQjGUX3Z5KDKUAsbvQ4s3oz0fSqR0nTMiXOUH69+lNb27phbZTZG
         Fto8ta3Ww/0rOrq3OXMDSg2VtSTYhhBwoXyGNsEHqx/hjgXSVpxjvLzZDPv9iLZo3M
         92kNKu15toC1UEpuymILPC1y4BWL9EQUQG3AZ6+4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 18/60] fat: don't allow to mount if the FAT length == 0
Date:   Wed, 17 Jun 2020 21:29:22 -0400
Message-Id: <20200618013004.610532-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
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
index 5e87b9aa7ba6..944fff1ef536 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1422,6 +1422,12 @@ static int fat_read_bpb(struct super_block *sb, struct fat_boot_sector *b,
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

