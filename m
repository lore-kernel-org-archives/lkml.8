Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F88C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648F9206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261708;
	bh=Umw0qQZ9A4r2/DbuUka5YKnWlE1/51GOA2v+b7VIqYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rwgsf9aWMQy8RAI8KssgMc/XN/0D/0d1I3pNgqFysyYHZSaH3JlLcNYUTa1L35YUV
	 soN9vy+pLn73SKCq63X2YBoZk05ry8NM9oxN2ei+JjE6ZW/eStPJPtk2JSL6ICqTJ4
	 CKoRXvK9QZcOsggMXYs943D7LO2pNZbaOwEHeO5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbgGTQPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388353AbgGTQPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:15:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47AF822D2C;
        Mon, 20 Jul 2020 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261702;
        bh=Umw0qQZ9A4r2/DbuUka5YKnWlE1/51GOA2v+b7VIqYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOcDOvNAZi+NyCPo4xLkUnvYYG8gVq9czAzK9zvlrc3EBn8fjwdHfM84GJHduovyT
         gM1J8yjNOWUbfaHwHbr5E9uWoEbrKdsz2InFks6+wFWATvNky4/Mjxj9f2xQeBdhp4
         /XdBFAG2f2/Y/WXPSZSsO3P46hScQzReCATj7TjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.7 181/244] ovl: fix unneeded call to ovl_change_flags()
Date:   Mon, 20 Jul 2020 17:37:32 +0200
Message-Id: <20200720152834.455914160@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 81a33c1ee941c3bb9ffc6bac8f676be13351344e upstream.

The check if user has changed the overlay file was wrong, causing unneeded
call to ovl_change_flags() including taking f_lock on every file access.

Fixes: d989903058a8 ("ovl: do not generate duplicate fsnotify events for "fake" path")
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/file.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -32,13 +32,16 @@ static char ovl_whatisit(struct inode *i
 		return 'm';
 }
 
+/* No atime modificaton nor notify on underlying */
+#define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
+
 static struct file *ovl_open_realfile(const struct file *file,
 				      struct inode *realinode)
 {
 	struct inode *inode = file_inode(file);
 	struct file *realfile;
 	const struct cred *old_cred;
-	int flags = file->f_flags | O_NOATIME | FMODE_NONOTIFY;
+	int flags = file->f_flags | OVL_OPEN_FLAGS;
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	realfile = open_with_fake_path(&file->f_path, flags, realinode,
@@ -59,8 +62,7 @@ static int ovl_change_flags(struct file
 	struct inode *inode = file_inode(file);
 	int err;
 
-	/* No atime modificaton on underlying */
-	flags |= O_NOATIME | FMODE_NONOTIFY;
+	flags |= OVL_OPEN_FLAGS;
 
 	/* If some flag changed that cannot be changed then something's amiss */
 	if (WARN_ON((file->f_flags ^ flags) & ~OVL_SETFL_MASK))
@@ -113,7 +115,7 @@ static int ovl_real_fdget_meta(const str
 	}
 
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ real->file->f_flags) & ~O_NOATIME))
+	if (unlikely((file->f_flags ^ real->file->f_flags) & ~OVL_OPEN_FLAGS))
 		return ovl_change_flags(real->file, file->f_flags);
 
 	return 0;


