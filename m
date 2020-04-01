Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE746C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3B6212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758055;
	bh=m420AOICvNG6kQPA0c4TY47PJyTyKW5zOTETfdRw3hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rf7UYFe9OHtYEEVxbm+u9M8TRwB/2GhkCVuXit7Fz77oqByqmqwImOfLcF8XdAy74
	 PleVHI3WI80TBVuDiPODrcwQcjLjHmqXODW8jwVcjI/m5HlZOm4blz002jWumK1z8T
	 XQvllK+Iga18YR+BpB92iW9u+sWx4IvvNBfziuYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgDAQUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732286AbgDAQUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A102320658;
        Wed,  1 Apr 2020 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758050;
        bh=m420AOICvNG6kQPA0c4TY47PJyTyKW5zOTETfdRw3hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hf0JAP89A6z9zbcsqu6Zy6m47CoG1E2XwxMik1M+J5a5Cg88n6ZAmG1GNz3zNtb5W
         avWrwpJo/a9IwGoLp9v7jZHd4zUEyKZNjkaQCnHeymwSMKGuX8xv/02XDqtq00voAZ
         bf3Ag8i0lk3zpKXMfV8vNZUOufOIs419u+KGIqHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5.5 05/30] vt: selection, introduce vc_is_sel
Date:   Wed,  1 Apr 2020 18:17:09 +0200
Message-Id: <20200401161418.589480385@linuxfoundation.org>
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

From: Jiri Slaby <jslaby@suse.cz>

commit dce05aa6eec977f1472abed95ccd71276b9a3864 upstream.

Avoid global variables (namely sel_cons) by introducing vc_is_sel. It
checks whether the parameter is the current selection console. This will
help putting sel_cons to a struct later.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20200219073951.16151-1-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/selection.c |    5 +++++
 drivers/tty/vt/vt.c        |    7 ++++---
 drivers/tty/vt/vt_ioctl.c  |    2 +-
 include/linux/selection.h  |    4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -88,6 +88,11 @@ void clear_selection(void)
 }
 EXPORT_SYMBOL_GPL(clear_selection);
 
+bool vc_is_sel(struct vc_data *vc)
+{
+	return vc == sel_cons;
+}
+
 /*
  * User settable table: what characters are to be considered alphabetic?
  * 128 bits. Locked by the console lock.
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -890,8 +890,9 @@ static void hide_softcursor(struct vc_da
 
 static void hide_cursor(struct vc_data *vc)
 {
-	if (vc == sel_cons)
+	if (vc_is_sel(vc))
 		clear_selection();
+
 	vc->vc_sw->con_cursor(vc, CM_ERASE);
 	hide_softcursor(vc);
 }
@@ -901,7 +902,7 @@ static void set_cursor(struct vc_data *v
 	if (!con_is_fg(vc) || console_blanked || vc->vc_mode == KD_GRAPHICS)
 		return;
 	if (vc->vc_deccm) {
-		if (vc == sel_cons)
+		if (vc_is_sel(vc))
 			clear_selection();
 		add_softcursor(vc);
 		if ((vc->vc_cursor_type & 0x0f) != 1)
@@ -1207,7 +1208,7 @@ static int vc_do_resize(struct tty_struc
 		}
 	}
 
-	if (vc == sel_cons)
+	if (vc_is_sel(vc))
 		clear_selection();
 
 	old_rows = vc->vc_rows;
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -43,7 +43,7 @@ char vt_dont_switch;
 extern struct tty_driver *console_driver;
 
 #define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
-#define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_cons[i].d == sel_cons)
+#define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_is_sel(vc_cons[i].d))
 
 /*
  * Console (vt and kd) routines, as defined by USL SVR4 manual, and by
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -11,8 +11,8 @@
 #include <linux/tiocl.h>
 #include <linux/vt_buffer.h>
 
-extern struct vc_data *sel_cons;
 struct tty_struct;
+struct vc_data;
 
 extern void clear_selection(void);
 extern int set_selection_user(const struct tiocl_selection __user *sel,
@@ -24,6 +24,8 @@ extern int sel_loadlut(char __user *p);
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
+bool vc_is_sel(struct vc_data *vc);
+
 extern int console_blanked;
 
 extern const unsigned char color_table[];


