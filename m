Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95735C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681A520663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594134669;
	bh=hl41CVJG9hoeCRvAAKp5hJ/Z4kaKOFNtDHOfAp+HlH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GnCrOP+58XjebjOaH6YBkDRKsJ0p0qQLUh21R+NoFYyiQrrJp8d1uPNQxJzzpSG/R
	 L38dqXn+RmLBb8UMcdgwnZ5mflFmM27inSTmJDe1xGqVgpm/hzmPh4nC6Kr1Q7FFQc
	 RhkkdHXnQtUuHzORnDWDhygUyJLhYn2fv++96zEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgGGPLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgGGPKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:10:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2A320663;
        Tue,  7 Jul 2020 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594134647;
        bh=hl41CVJG9hoeCRvAAKp5hJ/Z4kaKOFNtDHOfAp+HlH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXKywTUMDJFAyO83Fevqp5RTHYE3scCO5R6lYC/28Cob2LgMt6TleGHQHHjCJ8Bvi
         dUy01Wj3DR63H3MK4ygxD6RddvT5VJWZFCwspzqaL5c2VBE+O1HfLj5YvdcAGpMjLJ
         goSOO6YrJvvkXQ5Z6yI6hh2rYm99ReyeT0IEr5JA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.4 17/19] cifs: Fix the target file was deleted when rename failed.
Date:   Tue,  7 Jul 2020 17:10:20 +0200
Message-Id: <20200707145748.356954737@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145747.493710555@linuxfoundation.org>
References: <20200707145747.493710555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

commit 9ffad9263b467efd8f8dc7ae1941a0a655a2bab2 upstream.

When xfstest generic/035, we found the target file was deleted
if the rename return -EACESS.

In cifs_rename2, we unlink the positive target dentry if rename
failed with EACESS or EEXIST, even if the target dentry is positived
before rename. Then the existing file was deleted.

We should just delete the target file which created during the
rename.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/inode.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1737,6 +1737,7 @@ cifs_rename2(struct inode *source_dir, s
 	FILE_UNIX_BASIC_INFO *info_buf_target;
 	unsigned int xid;
 	int rc, tmprc;
+	bool new_target = d_really_is_negative(target_dentry);
 
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
@@ -1813,8 +1814,13 @@ cifs_rename2(struct inode *source_dir, s
 	 */
 
 unlink_target:
-	/* Try unlinking the target dentry if it's not negative */
-	if (d_really_is_positive(target_dentry) && (rc == -EACCES || rc == -EEXIST)) {
+	/*
+	 * If the target dentry was created during the rename, try
+	 * unlinking it if it's not negative
+	 */
+	if (new_target &&
+	    d_really_is_positive(target_dentry) &&
+	    (rc == -EACCES || rc == -EEXIST)) {
 		if (d_is_dir(target_dentry))
 			tmprc = cifs_rmdir(target_dir, target_dentry);
 		else


