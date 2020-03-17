Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D85FC3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBEB20719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442732;
	bh=3ycDTyYxwd9o60qmSo4rqdbhWA24xLo12HZR6LR5HMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ra47QSWeLwq7vycCj+XsTsX9gkv+k69Db8C+KEfIYfbpka3He7L33A7FWRpqs73/4
	 rP3uvFKH8cfyqW5sPyHazBnoFaBuGI0GkKZnoNFTMMka4ylIY3lNPz6TutoLW66EsL
	 9KRvQeQQba8Mlm9g+J1HEIZJ0CpCA0AMJqtW1eUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCQK6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgCQK6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:58:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3228220658;
        Tue, 17 Mar 2020 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442723;
        bh=3ycDTyYxwd9o60qmSo4rqdbhWA24xLo12HZR6LR5HMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8wCwNOXLsBFoqJjzhyq9aKG6Eoz+a7oCTVLCzljNeAK9NydB5BRqm+ruCpvnpYnC
         vQf0QoO3WFOem9/GVuI+fZDFXtueZRRgF12nmJFZ8pplmoPCtes51VuwdnAuCkwkQz
         SMcItbG+iehng3r13ZH4sq8seP1UvnRJ+7UyYzng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@kernel.org
Subject: [PATCH 4.19 58/89] cifs_atomic_open(): fix double-put on late allocation failure
Date:   Tue, 17 Mar 2020 11:55:07 +0100
Message-Id: <20200317103306.570296679@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit d9a9f4849fe0c9d560851ab22a85a666cddfdd24 upstream.

several iterations of ->atomic_open() calling conventions ago, we
used to need fput() if ->atomic_open() failed at some point after
successful finish_open().  Now (since 2016) it's not needed -
struct file carries enough state to make fput() work regardless
of the point in struct file lifecycle and discarding it on
failure exits in open() got unified.  Unfortunately, I'd missed
the fact that we had an instance of ->atomic_open() (cifs one)
that used to need that fput(), as well as the stale comment in
finish_open() demanding such late failure handling.  Trivially
fixed...

Fixes: fe9ec8291fca "do_last(): take fput() on error after opening to out:"
Cc: stable@kernel.org # v4.7+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/filesystems/porting |    7 +++++++
 fs/cifs/dir.c                     |    1 -
 fs/open.c                         |    3 ---
 3 files changed, 7 insertions(+), 4 deletions(-)

--- a/Documentation/filesystems/porting
+++ b/Documentation/filesystems/porting
@@ -627,3 +627,10 @@ in your dentry operations instead.
 	DCACHE_RCUACCESS is gone; having an RCU delay on dentry freeing is the
 	default.  DCACHE_NORCU opts out, and only d_alloc_pseudo() has any
 	business doing so.
+--
+[mandatory]
+
+	[should've been added in 2016] stale comment in finish_open()
+	nonwithstanding, failure exits in ->atomic_open() instances should
+	*NOT* fput() the file, no matter what.  Everything is handled by the
+	caller.
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -561,7 +561,6 @@ cifs_atomic_open(struct inode *inode, st
 		if (server->ops->close)
 			server->ops->close(xid, tcon, &fid);
 		cifs_del_pending_open(&open);
-		fput(file);
 		rc = -ENOMEM;
 	}
 
--- a/fs/open.c
+++ b/fs/open.c
@@ -851,9 +851,6 @@ cleanup_file:
  * the return value of d_splice_alias(), then the caller needs to perform dput()
  * on it after finish_open().
  *
- * On successful return @file is a fully instantiated open file.  After this, if
- * an error occurs in ->atomic_open(), it needs to clean up with fput().
- *
  * Returns zero on success or -errno if the open failed.
  */
 int finish_open(struct file *file, struct dentry *dentry,


