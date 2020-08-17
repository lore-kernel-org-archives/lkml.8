Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8757C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D2E2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686906;
	bh=pfviu27H9hD2OYEl1DDN8ZQ7SZqNjtL9YSu3pGx/A6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cw7vZgCsaQUV+/WMX27m8D0Jm1NtiSdCslZi7ZJJbmyImd8PwaTCgmYXsL/BWO/5k
	 5pYTMsPtuQNeNcZZID7TymGkS7S4SwWD3sp6VZJbngl9S1FWv5GMJbWC1OWKkf6bqo
	 zak3wkXDWHQt6G2sDk6Mz7VZUipiBJZKbWnRMODo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbgHQRzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388248AbgHQQK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:10:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9796F207FB;
        Mon, 17 Aug 2020 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680657;
        bh=pfviu27H9hD2OYEl1DDN8ZQ7SZqNjtL9YSu3pGx/A6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/XS7fl1X8/R/F+BIGK1Q+49YObbeeG/DETo/05f64pqBdJ+1nnA24qeogVOPMpsP
         lo6uLDnTKcP+iHGAuFhN3Cmkj60sIprq4Uvit1Pqqc5hMnonL6al+RJC9Yw0J1ApwU
         2By+pJ/+wou/LSl0KzsUd/TfMo2az3PQ0rAJbJKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a9ac3de1b5de5fb10efc@syzkaller.appspotmail.com,
        syzbot+df958cf5688a96ad3287@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Qiujun Huang <anenbupt@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 263/270] fs/minix: dont allow getting deleted inodes
Date:   Mon, 17 Aug 2020 17:17:44 +0200
Message-Id: <20200817143808.916886201@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit facb03dddec04e4aac1bb2139accdceb04deb1f3 upstream.

If an inode has no links, we need to mark it bad rather than allowing it
to be accessed.  This avoids WARNINGs in inc_nlink() and drop_nlink() when
doing directory operations on a fuzzed filesystem.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+a9ac3de1b5de5fb10efc@syzkaller.appspotmail.com
Reported-by: syzbot+df958cf5688a96ad3287@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Qiujun Huang <anenbupt@gmail.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200628060846.682158-3-ebiggers@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/minix/inode.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -468,6 +468,13 @@ static struct inode *V1_minix_iget(struc
 		iget_failed(inode);
 		return ERR_PTR(-EIO);
 	}
+	if (raw_inode->i_nlinks == 0) {
+		printk("MINIX-fs: deleted inode referenced: %lu\n",
+		       inode->i_ino);
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-ESTALE);
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
@@ -501,6 +508,13 @@ static struct inode *V2_minix_iget(struc
 		iget_failed(inode);
 		return ERR_PTR(-EIO);
 	}
+	if (raw_inode->i_nlinks == 0) {
+		printk("MINIX-fs: deleted inode referenced: %lu\n",
+		       inode->i_ino);
+		brelse(bh);
+		iget_failed(inode);
+		return ERR_PTR(-ESTALE);
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);


