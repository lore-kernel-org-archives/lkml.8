Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424F6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E802071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262097;
	bh=TkjjmI4vznJkdg4lBTfckMqQi81x67cY+0PbtkEHWus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pJcdP9iSKziTGScPisNXh3Q9FIlA9j8so7Djk9lpUe35rLlJNatntcG/94NcDCSFT
	 96NvbJDUCdByvsl+u/qNHcfG1QufKcwumHKbCfrwBw3PIvdWTvx0zTkfumkqZG/Yz/
	 60PRaskRDCryBHfzCMCDa1fFeZhWfIG9D2YR6uL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgHXJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgHXIpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D42920FC3;
        Mon, 24 Aug 2020 08:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258709;
        bh=TkjjmI4vznJkdg4lBTfckMqQi81x67cY+0PbtkEHWus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQ8mZKT7DKZfbO3w6s5fbjBoqzyy+icajwWVVlbItpahmQo1gJhZDY4/C+mPNgYkP
         WnHJAtUpc2bwiGMa6GUH1YhZYAdFQZmXcJGG6Q8Rxv4Mfppko79YVpIOhg5tq/NmCG
         dpJ6sZfo/6Qex/GiM5HZj5Xg7beqg6YnckjFbPtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <chris@colorremedies.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 018/107] btrfs: dont show full path of bind mounts in subvol=
Date:   Mon, 24 Aug 2020 10:29:44 +0200
Message-Id: <20200824082405.980681611@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 3ef3959b29c4a5bd65526ab310a1a18ae533172a ]

Chris Murphy reported a problem where rpm ostree will bind mount a bunch
of things for whatever voodoo it's doing.  But when it does this
/proc/mounts shows something like

  /dev/sda /mnt/test btrfs rw,relatime,subvolid=256,subvol=/foo 0 0
  /dev/sda /mnt/test/baz btrfs rw,relatime,subvolid=256,subvol=/foo/bar 0 0

Despite subvolid=256 being subvol=/foo.  This is because we're just
spitting out the dentry of the mount point, which in the case of bind
mounts is the source path for the mountpoint.  Instead we should spit
out the path to the actual subvol.  Fix this by looking up the name for
the subvolid we have mounted.  With this fix the same test looks like
this

  /dev/sda /mnt/test btrfs rw,relatime,subvolid=256,subvol=/foo 0 0
  /dev/sda /mnt/test/baz btrfs rw,relatime,subvolid=256,subvol=/foo 0 0

Reported-by: Chris Murphy <chris@colorremedies.com>
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 32c36821cc7b4..e21cae80c6d58 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1291,6 +1291,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 {
 	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
 	const char *compress_type;
+	const char *subvol_name;
 
 	if (btrfs_test_opt(info, DEGRADED))
 		seq_puts(seq, ",degraded");
@@ -1375,8 +1376,13 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",ref_verify");
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
-	seq_puts(seq, ",subvol=");
-	seq_dentry(seq, dentry, " \t\n\\");
+	subvol_name = btrfs_get_subvol_name_from_objectid(info,
+			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
+	if (!IS_ERR(subvol_name)) {
+		seq_puts(seq, ",subvol=");
+		seq_escape(seq, subvol_name, " \t\n\\");
+		kfree(subvol_name);
+	}
 	return 0;
 }
 
-- 
2.25.1



