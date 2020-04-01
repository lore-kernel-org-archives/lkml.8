Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A00C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD5120705
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759616;
	bh=9/GVYEdPPBR2AV0UCFVKcd7QD1qTeXd0Zbj4nmO0Pls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qrau2SifjsAzc3k6+KmLu52WmYCXhYeh3u3NxyzH5l3Yv/jHpkpLsd468At/WrquY
	 wWz47qyTnH8v7O4v4auPYPUtH4A3eG8C5PHbwex3LZ5+V99ZSmAGKKlbJ5TSc3fEKy
	 2qjFCPcLfGd4/D8OKKij8BUhrAIyMPvIG9KBe4lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbgDAQqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389993AbgDAQqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:46:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE44620784;
        Wed,  1 Apr 2020 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759610;
        bh=9/GVYEdPPBR2AV0UCFVKcd7QD1qTeXd0Zbj4nmO0Pls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIKVgK74JXblWiN+wYo7wNNS+ZkACleesRvtZXEm28Uvs8LIOEpT+48dkia6+YjNn
         ARP11naS9XhVnM50UDjKPSeM95JN6kak55Gkk52tMqlLhfxWjhBjxzUxY1iSp4CwpU
         2WJJEZLoAb08RHDZhyOWLaRxMYwXYdMGoU5LHvzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.14 135/148] vt: vt_ioctl: remove unnecessary console allocation checks
Date:   Wed,  1 Apr 2020 18:18:47 +0200
Message-Id: <20200401161605.247003463@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 1aa6e058dd6cd04471b1f21298270014daf48ac9 upstream.

The vc_cons_allocated() checks in vt_ioctl() and vt_compat_ioctl() are
unnecessary because they can only be reached by calling ioctl() on an
open tty, which implies the corresponding virtual console is allocated.

And even if the virtual console *could* be freed concurrently, then
these checks would be broken since they aren't done under console_lock,
and the vc_data is dereferenced before them anyway.

So, remove these unneeded checks to avoid confusion.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20200224080326.295046-1-ebiggers@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt_ioctl.c |   21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -350,22 +350,13 @@ int vt_ioctl(struct tty_struct *tty,
 {
 	struct vc_data *vc = tty->driver_data;
 	struct console_font_op op;	/* used in multiple places here */
-	unsigned int console;
+	unsigned int console = vc->vc_num;
 	unsigned char ucval;
 	unsigned int uival;
 	void __user *up = (void __user *)arg;
 	int i, perm;
 	int ret = 0;
 
-	console = vc->vc_num;
-
-
-	if (!vc_cons_allocated(console)) { 	/* impossible? */
-		ret = -ENOIOCTLCMD;
-		goto out;
-	}
-
-
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
@@ -1195,18 +1186,10 @@ long vt_compat_ioctl(struct tty_struct *
 {
 	struct vc_data *vc = tty->driver_data;
 	struct console_font_op op;	/* used in multiple places here */
-	unsigned int console;
 	void __user *up = (void __user *)arg;
 	int perm;
 	int ret = 0;
 
-	console = vc->vc_num;
-
-	if (!vc_cons_allocated(console)) { 	/* impossible? */
-		ret = -ENOIOCTLCMD;
-		goto out;
-	}
-
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
@@ -1266,7 +1249,7 @@ long vt_compat_ioctl(struct tty_struct *
 		arg = (unsigned long)compat_ptr(arg);
 		goto fallback;
 	}
-out:
+
 	return ret;
 
 fallback:


