Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5447C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E912074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261256;
	bh=uWAVItaEtN1KbR+X2t+2V6dYQWvx+SdeH4DwBSc9XsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kmlkxmuOxYDm53hLE8jNMI5m3D+S7DLToERI+2eD8zVBqhcUDUL0owl0FuCrC1XVP
	 1le6TFkYZ1pEAteO1//KXLlxT2bJufyP74nptnqFvROixv9+SxqnQfxcZ3G6GcR22n
	 1ncgxcI9/3p8hLEyYxCAUi9xItuSvLf1cvtwFJKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgHXIwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730039AbgHXIwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:52:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076B92075B;
        Mon, 24 Aug 2020 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259124;
        bh=uWAVItaEtN1KbR+X2t+2V6dYQWvx+SdeH4DwBSc9XsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rC0tJ4XyniN45EvVCsZveOk9+9J+ewcU2LCQoufTuO0Ju3eghmgXvAIWFrA+95Z1e
         K93VY4N8dV+rgHxfQl3S3yrqkQSeBydOv2CSb2FhXJj/gp1YhBLjfrv4YVw1Ji9bae
         hnjzHof05Yz2PGLFZgsaASJ0b2W8ptdLNwE7UuuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <chris@colorremedies.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 10/39] btrfs: dont show full path of bind mounts in subvol=
Date:   Mon, 24 Aug 2020 10:31:09 +0200
Message-Id: <20200824082348.996775982@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082348.445866152@linuxfoundation.org>
References: <20200824082348.445866152@linuxfoundation.org>
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
index af5be060c651f..3a0cb745164f8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1225,6 +1225,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
 	struct btrfs_root *root = info->tree_root;
 	char *compress_type;
+	const char *subvol_name;
 
 	if (btrfs_test_opt(info, DEGRADED))
 		seq_puts(seq, ",degraded");
@@ -1311,8 +1312,13 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
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



