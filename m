Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA3EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C0720719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443150;
	bh=+UBB+1hNmuQGnON9NCZSrMy5So0HNMpOQydiZAV8IAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CzNfGIYWK5wlVAnK2qtsM0Dl4r8dhGJC68biZQ1K1nDZwDTeYnp5EHPgz1alNZk8d
	 AADoIbiaA30cBicSe4ddfv1wlHg4eBhXM0z9FDFJ0YOa+ALTeBW7fdblYM1tKJIyAY
	 LXU8AQYhx6ZeZpazy2IrK5ODKs5ymVQWvtimzDqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgCQLFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgCQLFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:05:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DFB2206EC;
        Tue, 17 Mar 2020 11:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443146;
        bh=+UBB+1hNmuQGnON9NCZSrMy5So0HNMpOQydiZAV8IAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjJIqrYDJpHKG0tmh7v7gKTg6mZuGmBZbs5wHTDZimF9jciu7ozWB6HwyiWDFfRS6
         awrxPaBNfYICnYivomyrfITaPGzWtUZ5ANqzbiF3mi5EA3BeXWWbzg+XTMuRb8hJkD
         Nv6aZwTJ2yKv83L8KsH6kUSNpixvNy91oVWqCH38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@kernel.org
Subject: [PATCH 5.4 075/123] cifs_atomic_open(): fix double-put on late allocation failure
Date:   Tue, 17 Mar 2020 11:55:02 +0100
Message-Id: <20200317103315.147642018@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
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
 Documentation/filesystems/porting.rst |    8 ++++++++
 fs/cifs/dir.c                         |    1 -
 fs/open.c                             |    3 ---
 3 files changed, 8 insertions(+), 4 deletions(-)

--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -850,3 +850,11 @@ business doing so.
 d_alloc_pseudo() is internal-only; uses outside of alloc_file_pseudo() are
 very suspect (and won't work in modules).  Such uses are very likely to
 be misspelled d_alloc_anon().
+
+---
+
+**mandatory**
+
+[should've been added in 2016] stale comment in finish_open() nonwithstanding,
+failure exits in ->atomic_open() instances should *NOT* fput() the file,
+no matter what.  Everything is handled by the caller.
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -560,7 +560,6 @@ cifs_atomic_open(struct inode *inode, st
 		if (server->ops->close)
 			server->ops->close(xid, tcon, &fid);
 		cifs_del_pending_open(&open);
-		fput(file);
 		rc = -ENOMEM;
 	}
 
--- a/fs/open.c
+++ b/fs/open.c
@@ -860,9 +860,6 @@ cleanup_file:
  * the return value of d_splice_alias(), then the caller needs to perform dput()
  * on it after finish_open().
  *
- * On successful return @file is a fully instantiated open file.  After this, if
- * an error occurs in ->atomic_open(), it needs to clean up with fput().
- *
  * Returns zero on success or -errno if the open failed.
  */
 int finish_open(struct file *file, struct dentry *dentry,


