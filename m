Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE36C54FD2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F7A20735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386781;
	bh=5Xy1zSPQ+mdSo3B1aRXGosoRE7Xufwwvy2PkysIsSp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYNPYAJlyEhJLa1fFWtDRw+8tEzuo3pwo8escuEzq788D9aRll/wuH5ewbE2h3Y4T
	 akI8Vcv+Tt5EjcUfrPZFShgrMMz9wk+vV+Uw3NGYjuZv7XiIeNfDm1j/bsfagXdFOb
	 fzFTNNv2MQBg/VQsJTZrdQfl2v51fccqZGwdrI0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgDTMqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbgDTMqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:46:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB59206DD;
        Mon, 20 Apr 2020 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386767;
        bh=5Xy1zSPQ+mdSo3B1aRXGosoRE7Xufwwvy2PkysIsSp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+irm6Rbj/U0t2BHzR8RwHgFgX95QxhkwtysipXLtYOnulj+WMJ9gSAr0fjPAKT2E
         FJidnvCYAroNgxF6bOV464UeDXtDz7t0t+2MD0pHqiTtB2yFxWpGOVr9D5Qv012kPB
         dJHsS6Cl2Q0FwBPTTjOmZ4K39GKkFZa9Jxo7kGVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.4 19/60] ovl: fix value of i_ino for lower hardlink corner case
Date:   Mon, 20 Apr 2020 14:38:57 +0200
Message-Id: <20200420121506.968500059@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
References: <20200420121500.490651540@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 300b124fcf6ad2cd99a7b721e0f096785e0a3134 upstream.

Commit 6dde1e42f497 ("ovl: make i_ino consistent with st_ino in more
cases"), relaxed the condition nfs_export=on in order to set the value of
i_ino to xino map of real ino.

Specifically, it also relaxed the pre-condition that index=on for
consistent i_ino. This opened the corner case of lower hardlink in
ovl_get_inode(), which calls ovl_fill_inode() with ino=0 and then
ovl_init_inode() is called to set i_ino to lower real ino without the xino
mapping.

Pass the correct values of ino;fsid in this case to ovl_fill_inode(), so it
can initialize i_ino correctly.

Fixes: 6dde1e42f497 ("ovl: make i_ino consistent with st_ino in more ...")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -881,7 +881,7 @@ struct inode *ovl_get_inode(struct super
 	struct dentry *lowerdentry = lowerpath ? lowerpath->dentry : NULL;
 	bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry,
 					oip->index);
-	int fsid = bylower ? oip->lowerpath->layer->fsid : 0;
+	int fsid = bylower ? lowerpath->layer->fsid : 0;
 	bool is_dir, metacopy = false;
 	unsigned long ino = 0;
 	int err = oip->newinode ? -EEXIST : -ENOMEM;
@@ -931,6 +931,8 @@ struct inode *ovl_get_inode(struct super
 			err = -ENOMEM;
 			goto out_err;
 		}
+		ino = realinode->i_ino;
+		fsid = lowerpath->layer->fsid;
 	}
 	ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev, ino, fsid);
 	ovl_inode_init(inode, upperdentry, lowerdentry, oip->lowerdata);


