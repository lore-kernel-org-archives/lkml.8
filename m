Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DFFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9AF2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217010;
	bh=+p1YLwzGBH163D86Ax4uYWKPreijFjfAo+qlgz/VETI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FEl1b7Zjx4rXkcchFHTfKid/xlXdOQ9Fl1SRekUqxbl8ufphlX2vxjptjBjxHpwHo
	 hjGFtR80EUCoYauiADxDEJGAm8Gul4CAF9UQz8mmz0ksLEeSIloJROW16wUefzFhuO
	 GxDvsXsNVWgZp001AVuKBt3SDzjuxROrWuoHeEOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbgAPXX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733076AbgAPXX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFBD2077C;
        Thu, 16 Jan 2020 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217005;
        bh=+p1YLwzGBH163D86Ax4uYWKPreijFjfAo+qlgz/VETI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcanvigVRdQZitTfdXSG4zBpZQs+/lv1SjwpecTPPlo3xu3yUfseppsKuGCenIaOS
         yNszDSYV/F4QloXf2ZBVWlccQdJV7CfYw6CsL0LptD7PX50pQyNBcpdtWucI4yTxqY
         iz5Lpu5UjCTqM9/KoSo28aMZNIRBVttDO+yRCHX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 083/203] afs: Fix afs_lookup() to not clobber the version on a new dentry
Date:   Fri, 17 Jan 2020 00:16:40 +0100
Message-Id: <20200116231752.393959400@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit f52b83b0b1c40ada38df917973ab719a4a753951 upstream.

Fix afs_lookup() to not clobber the version set on a new dentry by
afs_do_lookup() - especially as it's using the wrong version of the
version (we need to use the one given to us by whatever op the dir
contents correspond to rather than what's in the afs_vnode).

Fixes: 9dd0b82ef530 ("afs: Fix missing dentry data version updating")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/dir.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -952,12 +952,8 @@ static struct dentry *afs_lookup(struct
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry, key);
 	key_put(key);
-	if (inode == ERR_PTR(-ENOENT)) {
+	if (inode == ERR_PTR(-ENOENT))
 		inode = afs_try_auto_mntpt(dentry, dir);
-	} else {
-		dentry->d_fsdata =
-			(void *)(unsigned long)dvnode->status.data_version;
-	}
 
 	if (!IS_ERR_OR_NULL(inode))
 		fid = AFS_FS_I(inode)->fid;


