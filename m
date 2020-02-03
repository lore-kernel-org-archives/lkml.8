Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D6C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EDC2051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748372;
	bh=o8qXUuVMgURdjU9RXTf11ZkJaY0aPqvSHrfr4hZ1FSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GJ5n+UNAQLdppigd3RfQ7YfI9iuqwtkTV43vnbH9OWcwkN8GS3ELHm+kApuiFXsC5
	 G/VZRLwPYQz6azWUbMnXJIVbs65RFlIP3Nv2AD5KgA4aeNxLPoBL4OGiQ4y2wf/KGm
	 R41nWZl8C42FbRGbLnrmnVnbVFxxHvfYuqLU8aMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgBCQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbgBCQ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:29:04 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB7620838;
        Mon,  3 Feb 2020 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747344;
        bh=o8qXUuVMgURdjU9RXTf11ZkJaY0aPqvSHrfr4hZ1FSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9VIIBY1pPwsLus/WZoRGVND2SVnmIUmlTFsrNVJ2aMpcKsBVAErkPeW2JyICKQP7
         fA38RvSsfcI25jk6smiwSLOTxHxgSeAgP75oPVriOFc6Hxs+oHK/MJ4hgb+Kvp6wAU
         HnH8rPPv3VSGE5ehd595g8di0umKY3li0j1NTPtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1c6756baf4b16b94d2a6@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.14 44/89] reiserfs: Fix memory leak of journal device string
Date:   Mon,  3 Feb 2020 16:19:29 +0000
Message-Id: <20200203161922.889518159@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 5474ca7da6f34fa95e82edc747d5faa19cbdfb5c upstream.

When a filesystem is mounted with jdev mount option, we store the
journal device name in an allocated string in superblock. However we
fail to ever free that string. Fix it.

Reported-by: syzbot+1c6756baf4b16b94d2a6@syzkaller.appspotmail.com
Fixes: c3aa077648e1 ("reiserfs: Properly display mount options in /proc/mounts")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/super.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -629,6 +629,7 @@ static void reiserfs_put_super(struct su
 	reiserfs_write_unlock(s);
 	mutex_destroy(&REISERFS_SB(s)->lock);
 	destroy_workqueue(REISERFS_SB(s)->commit_wq);
+	kfree(REISERFS_SB(s)->s_jdev);
 	kfree(s->s_fs_info);
 	s->s_fs_info = NULL;
 }
@@ -2243,6 +2244,7 @@ error_unlocked:
 			kfree(qf_names[j]);
 	}
 #endif
+	kfree(sbi->s_jdev);
 	kfree(sbi);
 
 	s->s_fs_info = NULL;


