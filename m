Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3584BC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A720767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979272;
	bh=otWkLV9AE7p/mLHlRBKBh6b3nTllnZikxbDu+4RwkJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2TNQO0X8rgSsXLZ86bL8h44Cdb/V/lUPIB4YTU6fup2GMYV3a6OHw4L82U+uawcq8
	 Hd0vTDPUHkt1ZmT9IW7Rmb3UVaZjJ49Y/b8VM4jwGwj62Kb8IgE/vnE4NjNUc8n/D3
	 +IrcDqxD+E3YhxUYTJemwqUGkYoKGaE51LbqnCbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgIAQya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbgIAPYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E5C21548;
        Tue,  1 Sep 2020 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973871;
        bh=otWkLV9AE7p/mLHlRBKBh6b3nTllnZikxbDu+4RwkJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrK/qY1tKYk0Y2lRXqutGKpWLYyMN2nDZ93ugVnmmq28XjOKepnFuW9gnSKBGX/Vg
         JrcVSSmhzrbprtSORd4+F9CmEPSSKnr9EuBI29oVwcKU3O8je6OUfLN8NTje3v4JbQ
         Kn8g1lZ7ZAaqds1E6/2pykd9HwX3z/A4/PBWiK5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/125] ext4: handle option set by mount flags correctly
Date:   Tue,  1 Sep 2020 17:10:18 +0200
Message-Id: <20200901150937.666002286@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Czerner <lczerner@redhat.com>

[ Upstream commit f25391ebb475d3ffb3aa61bb90e3594c841749ef ]

Currently there is a problem with mount options that can be both set by
vfs using mount flags or by a string parsing in ext4.

i_version/iversion options gets lost after remount, for example

$ mount -o i_version /dev/pmem0 /mnt
$ grep pmem0 /proc/self/mountinfo | grep i_version
310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,seclabel,i_version
$ mount -o remount,ro /mnt
$ grep pmem0 /proc/self/mountinfo | grep i_version

nolazytime gets ignored by ext4 on remount, for example

$ mount -o lazytime /dev/pmem0 /mnt
$ grep pmem0 /proc/self/mountinfo | grep lazytime
310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel
$ mount -o remount,nolazytime /mnt
$ grep pmem0 /proc/self/mountinfo | grep lazytime
310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel

Fix it by applying the SB_LAZYTIME and SB_I_VERSION flags from *flags to
s_flags before we parse the option and use the resulting state of the
same flags in *flags at the end of successful remount.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Link: https://lore.kernel.org/r/20200723150526.19931-1-lczerner@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 23ef8fbdb582f..03ebb0b385467 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5249,7 +5249,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct ext4_super_block *es;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	unsigned long old_sb_flags;
+	unsigned long old_sb_flags, vfs_flags;
 	struct ext4_mount_options old_opts;
 	int enable_quota = 0;
 	ext4_group_t g;
@@ -5292,6 +5292,14 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
 		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
 
+	/*
+	 * Some options can be enabled by ext4 and/or by VFS mount flag
+	 * either way we need to make sure it matches in both *flags and
+	 * s_flags. Copy those selected flags from *flags to s_flags
+	 */
+	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
+	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
+
 	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
 		err = -EINVAL;
 		goto restore_opts;
@@ -5345,9 +5353,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
 	}
 
-	if (*flags & SB_LAZYTIME)
-		sb->s_flags |= SB_LAZYTIME;
-
 	if ((bool)(*flags & SB_RDONLY) != sb_rdonly(sb)) {
 		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED) {
 			err = -EROFS;
@@ -5487,7 +5492,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 #endif
 
-	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
+	/*
+	 * Some options can be enabled by ext4 and/or by VFS mount flag
+	 * either way we need to make sure it matches in both *flags and
+	 * s_flags. Copy those selected flags from s_flags to *flags
+	 */
+	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
+
 	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
 	kfree(orig_data);
 	return 0;
-- 
2.25.1



