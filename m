Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C609C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EBB2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916967;
	bh=Tf5OspUwzZ2R+wddJdL2KBf4XqhYahYinCZbvLPfKKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qqq5fDP0uNfJUV7YobkykeaKT0fTK2+4BwNDJ2D+bFPuJDAsdoIM33W7AW0zb4saH
	 8RM5zZLbG2oHdTK+W0AGQDb1CrZTqdQPBDjXScdIq1GkWLxRXV98l19BRjwgJgkMfr
	 9cxQxeJTGQJpTvfUZEg9ufNHotCgwl272O215Qi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgHTJrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbgHTJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:47:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35B822CAF;
        Thu, 20 Aug 2020 09:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916842;
        bh=Tf5OspUwzZ2R+wddJdL2KBf4XqhYahYinCZbvLPfKKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9T2uG+lGwutf+16mqrupGhPIh0IFT4ztirlLINQCJMBGrVGReURLWNOxZYQdAYsf
         uKFbe5jA8IN9VQ1mVipZMjnCQ45G9lyqmNYgZicxcbiRvCp8h0X8k9a1UZAW49xS7R
         0TFBvZUpfgpINrsxuHqvXJmuC9JnL7lrceHNBOoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.4 065/152] ceph: set sec_context xattr on symlink creation
Date:   Thu, 20 Aug 2020 11:20:32 +0200
Message-Id: <20200820091557.062576872@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit b748fc7a8763a5b3f8149f12c45711cd73ef8176 upstream.

Symlink inodes should have the security context set in their xattrs on
creation. We already set the context on creation, but we don't attach
the pagelist. The effect is that symlink inodes don't get an SELinux
context set on them at creation, so they end up unlabeled instead of
inheriting the proper context. Make it do so.

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/dir.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -920,6 +920,10 @@ static int ceph_symlink(struct inode *di
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	if (as_ctx.pagelist) {
+		req->r_pagelist = as_ctx.pagelist;
+		as_ctx.pagelist = NULL;
+	}
 	err = ceph_mdsc_do_request(mdsc, dir, req);
 	if (!err && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);


