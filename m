Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E999EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9607020857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758062;
	bh=mR+5OGoU1pNR0jhdMMwChIxKedYFniCIAotdRFpImVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ej54KJb7d0me+et29+SqyLv4LZjzqfSDEKOPqyfBZCQ+YWp5ooYEWc7utjN7Td51h
	 P3TXjPZoYoqC9EYhUrNF4VqU7jN0VV4eLVxlvDtwwGW0THaPlpQtonx/1dPPVzzV7D
	 i2qJnBswDv1XhJxvGJwy3rm37jtVt0T/u7Rve6Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbgDAQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733210AbgDAQU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65FA220658;
        Wed,  1 Apr 2020 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758057;
        bh=mR+5OGoU1pNR0jhdMMwChIxKedYFniCIAotdRFpImVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDhDdXqpHSSn2YlgY+HYr/u1tbguLiDsk2oX2PBwkahF9I39GksCudfSckiOoB9Dn
         SRzelZdu/+0SdzMhIx/zcDLzGc6lDT/XYvwhQMFngqjcCa2tK52VzOFthQVzpstOSM
         fZGA6lwyEk+8dZhw4PnP1oOtcfDo2MGWVaAeXosg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 5.5 08/30] vt: vt_ioctl: remove unnecessary console allocation checks
Date:   Wed,  1 Apr 2020 18:17:12 +0200
Message-Id: <20200401161420.374733591@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.345528747@linuxfoundation.org>
References: <20200401161414.345528747@linuxfoundation.org>
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
 drivers/tty/vt/vt_ioctl.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

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
@@ -1195,14 +1186,9 @@ long vt_compat_ioctl(struct tty_struct *
 {
 	struct vc_data *vc = tty->driver_data;
 	struct console_font_op op;	/* used in multiple places here */
-	unsigned int console = vc->vc_num;
 	void __user *up = compat_ptr(arg);
 	int perm;
 
-
-	if (!vc_cons_allocated(console)) 	/* impossible? */
-		return -ENOIOCTLCMD;
-
 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
 	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.


