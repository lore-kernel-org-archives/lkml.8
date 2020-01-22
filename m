Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04CCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6724684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685976;
	bh=e5CRW54dsq2bYqXNwFy3jRK3OjNNRYCjwFha6ZoH1FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYd+ae6ultp7sii32YbefwRPimz8+XVursmRu4XlAljh8eLZA9AL5YJcPYMf7X0K3
	 AEZvX7Wp29dlIteEkXqEHcSeBhkl6IEIkluf+6SAjS5c6XAXq6SW1uYuIxdcUe4YZb
	 9bXxS9W627HxoCDJvWOPFCnz8oi3EyZ5M73vM3r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbgAVJjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733229AbgAVJjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F22F24685;
        Wed, 22 Jan 2020 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685972;
        bh=e5CRW54dsq2bYqXNwFy3jRK3OjNNRYCjwFha6ZoH1FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYdiF3yBx8N0SMvuu3mQE1KFjaIbhdWiljuqJ2dwlHu24BZSViJYfLqxFhvSLjpkb
         2F6Wq6Ty7lWhnObpmWGUfVNOIggbUeG0QHINjHUniEQRicj6UUMfwGX7FRAQ8FIGm/
         vYfOQoiG5l7IU+aSq53SPU47IclvapctOvDYcTw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Brunnbauer <brunni@netestate.de>,
        Jeff Mahoney <jeffm@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.14 56/65] reiserfs: fix handling of -EOPNOTSUPP in reiserfs_for_each_xattr
Date:   Wed, 22 Jan 2020 10:29:41 +0100
Message-Id: <20200122092759.623911907@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

commit 394440d469413fa9b74f88a11f144d76017221f2 upstream.

Commit 60e4cf67a58 (reiserfs: fix extended attributes on the root
directory) introduced a regression open_xa_root started returning
-EOPNOTSUPP but it was not handled properly in reiserfs_for_each_xattr.

When the reiserfs module is built without CONFIG_REISERFS_FS_XATTR,
deleting an inode would result in a warning and chowning an inode
would also result in a warning and then fail to complete.

With CONFIG_REISERFS_FS_XATTR enabled, the xattr root would always be
present for read-write operations.

This commit handles -EOPNOSUPP in the same way -ENODATA is handled.

Fixes: 60e4cf67a582 ("reiserfs: fix extended attributes on the root directory")
CC: stable@vger.kernel.org	# Commit 60e4cf67a58 was picked up by stable
Link: https://lore.kernel.org/r/20200115180059.6935-1-jeffm@suse.com
Reported-by: Michael Brunnbauer <brunni@netestate.de>
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/reiserfs/xattr.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -319,8 +319,12 @@ static int reiserfs_for_each_xattr(struc
 out_dir:
 	dput(dir);
 out:
-	/* -ENODATA isn't an error */
-	if (err == -ENODATA)
+	/*
+	 * -ENODATA: this object doesn't have any xattrs
+	 * -EOPNOTSUPP: this file system doesn't have xattrs enabled on disk.
+	 * Neither are errors
+	 */
+	if (err == -ENODATA || err == -EOPNOTSUPP)
 		err = 0;
 	return err;
 }


