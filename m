Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF9FC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F237324694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845191;
	bh=MXln7nZqWGaCBLy6dtD8fUgYZiJwCNGm/S6MIDZKz0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TyIDckJKAWvTojOBL+cKp39eiun57lsJuX6aUN8uQ3COlDECR/X9QNakNmJGYzor8
	 o6H41S0q/OrgI0nciGo+EDAt+CK0HhEMuqN0SM+rkHt/n1MrOuCNAjf9PA0TeJEY9T
	 R5vpYMkivHanqGYeKqd4m23q9wEyRcZe/VWs5Qr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgCJM7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbgCJM7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:59:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AC32467D;
        Tue, 10 Mar 2020 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845187;
        bh=MXln7nZqWGaCBLy6dtD8fUgYZiJwCNGm/S6MIDZKz0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MB4yEg/jG2a36gCjYWb5SFr1TVEsdakOD5KRM7j2b9m3or+DPsTCl3z36B8NUK3X0
         o2r+XtBqmNsJcxtbxvWZ73QiGVGhJ3KnPszNb5BOP3uPSZOgjH0/M/bvrS5zCfF8PY
         sIRvxdLX+nDKN4gj9YaG26H2xFDXuRkWeW4Lj0kk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5.5 093/189] vt: selection, push console lock down
Date:   Tue, 10 Mar 2020 13:38:50 +0100
Message-Id: <20200310123649.111221683@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit 4b70dd57a15d2f4685ac6e38056bad93e81e982f upstream.

We need to nest the console lock in sel_lock, so we have to push it down
a bit. Fortunately, the callers of set_selection_* just lock the console
lock around the function call. So moving it down is easy.

In the next patch, we switch the order.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: 07e6124a1a46 ("vt: selection, close sel_buffer race")
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200228115406.5735-1-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/speakup/selection.c |    2 --
 drivers/tty/vt/selection.c          |   13 ++++++++++++-
 drivers/tty/vt/vt.c                 |    2 --
 3 files changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/staging/speakup/selection.c
+++ b/drivers/staging/speakup/selection.c
@@ -51,9 +51,7 @@ static void __speakup_set_selection(stru
 		goto unref;
 	}
 
-	console_lock();
 	set_selection_kernel(&sel, tty);
-	console_unlock();
 
 unref:
 	tty_kref_put(tty);
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -181,7 +181,7 @@ int set_selection_user(const struct tioc
 	return set_selection_kernel(&v, tty);
 }
 
-int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
+static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int new_sel_start, new_sel_end, spc;
@@ -343,6 +343,17 @@ unlock:
 	mutex_unlock(&sel_lock);
 	return ret;
 }
+
+int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
+{
+	int ret;
+
+	console_lock();
+	ret = __set_selection_kernel(v, tty);
+	console_unlock();
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(set_selection_kernel);
 
 /* Insert the contents of the selection buffer into the
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3046,10 +3046,8 @@ int tioclinux(struct tty_struct *tty, un
 	switch (type)
 	{
 		case TIOCL_SETSEL:
-			console_lock();
 			ret = set_selection_user((struct tiocl_selection
 						 __user *)(p+1), tty);
-			console_unlock();
 			break;
 		case TIOCL_PASTESEL:
 			ret = paste_selection(tty);


