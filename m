Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0C5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCBA24691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844098;
	bh=c2sUwvrLfC9woYN3O4u/Zt4jJL28LyMkY7qIRiNB7vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TqC1oGYmyrCtZkqxTpuNegStjR5aUe/xU99kQn6hx1bVaoUxN3PKBvdjrSB+stt8s
	 1Sa1g1mHVmuUjpGbRwqahZHDJyMDUdOxlyYQ8x0SFsqaWNQ0Jfxl5vdpPkhjH0C1cF
	 wlkViy7dUl7qICwg1ZfoK5/Rg8lMKEruh1yJ0KFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCJMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCJMle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:41:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 955D524686;
        Tue, 10 Mar 2020 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844094;
        bh=c2sUwvrLfC9woYN3O4u/Zt4jJL28LyMkY7qIRiNB7vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f9OvgcwF+H3nIZ/c9fBdqb1b3X4IGQpdxG3oFRagshrEYDM9hKWvdveMIDKFlduPw
         c9A7UOvYDlymn+8MRm5HJJoWA2OvYIozq57vtkp5iiXXIoTt64IoNiR1TlH2PBYA4+
         HG/EHHxKNRUBz4gLCoGZ9rb7ZNckvfXGZ9u6n3Sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 4.4 29/72] namei: only return -ECHILD from follow_dotdot_rcu()
Date:   Tue, 10 Mar 2020 13:38:42 +0100
Message-Id: <20200310123608.757408480@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksa Sarai <cyphar@cyphar.com>

commit 2b98149c2377bff12be5dd3ce02ae0506e2dd613 upstream.

It's over-zealous to return hard errors under RCU-walk here, given that
a REF-walk will be triggered for all other cases handling ".." under
RCU.

The original purpose of this check was to ensure that if a rename occurs
such that a directory is moved outside of the bind-mount which the
resolution started in, it would be detected and blocked to avoid being
able to mess with paths outside of the bind-mount. However, triggering a
new REF-walk is just as effective a solution.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Fixes: 397d425dc26d ("vfs: Test for and handle paths that are unreachable from their mnt_root")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1358,7 +1358,7 @@ static int follow_dotdot_rcu(struct name
 			nd->path.dentry = parent;
 			nd->seq = seq;
 			if (unlikely(!path_connected(&nd->path)))
-				return -ENOENT;
+				return -ECHILD;
 			break;
 		} else {
 			struct mount *mnt = real_mount(nd->path.mnt);


