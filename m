Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E29C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87613206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597932058;
	bh=VNURiwepPfOHCYWSBAiSVCnkHz/Eyq1gIpHIveQMb1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEV5CdFlw3VoTsYYUarzfwdVzDCc5/qHSQTFPhYpwPIYBm97cY94lY8b+dY8vNFP2
	 lX5atcn2I9sOKT2H5h57OXIoM64sRx0SfxFlvDkmp/rciPWD+dcxQQnTUMs9OmiVNr
	 zCMITy+d1orR5ovyUfHYCFtHHiXDL4hP+vVJvDjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHTOAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgHTJ0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B12CD2075E;
        Thu, 20 Aug 2020 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915577;
        bh=VNURiwepPfOHCYWSBAiSVCnkHz/Eyq1gIpHIveQMb1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HU0SPkfsizh2u0hM1Tm1vAwPdFgWJhieaUtecygOmP4WtFimBVVbwE4aXb5qqdr2L
         a69lvBU7suEVQT5qdNXhc3GcDyhXvOnwgrep1CwTiAMzxTkEpmeixhUzR21xE6XfJ1
         6aQxRydM/7m5vqqPrCTKbFdZ1zEfJ/tWU+gEkCzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Murphy <chris@colorremedies.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.8 033/232] btrfs: dont show full path of bind mounts in subvol=
Date:   Thu, 20 Aug 2020 11:18:04 +0200
Message-Id: <20200820091614.367868253@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 3ef3959b29c4a5bd65526ab310a1a18ae533172a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/super.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1312,6 +1312,7 @@ static int btrfs_show_options(struct seq
 {
 	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
 	const char *compress_type;
+	const char *subvol_name;
 
 	if (btrfs_test_opt(info, DEGRADED))
 		seq_puts(seq, ",degraded");
@@ -1398,8 +1399,13 @@ static int btrfs_show_options(struct seq
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
 


