Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89923C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1CC20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758815;
	bh=u7OLazOSlSIWCsLffa6IuGDxnh9pPXQR+T/jnWj3Frw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SU1OppLZ6h9MCJkUXJcpcnnorj6DUmxBJmxmktIs8XWiylyV62++37yT6mvVQZIqj
	 IC0WTsvr/3x5+4f5yd6xmSKXg0uHM9AwespWqD0zEaihv8BTVSDC1f9UplqQ4pM5XF
	 YJKFUt50iZxZoHqXoUX+yLp+0XPcJxzISVLoc/kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbgDAQdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbgDAQdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:33:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E1520658;
        Wed,  1 Apr 2020 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758810;
        bh=u7OLazOSlSIWCsLffa6IuGDxnh9pPXQR+T/jnWj3Frw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x/GWLfbGmqs8t5sZ44UwhD2t7Z7yrku2UkrU20jot/wsOVV8JxwnWI0kfODU7IPio
         QDKLEC8yxRptyHjcjoZ/a/Q0DjqFw2UvqflLk0wD0rnYrE1l7vyye1Ysv1v49XYj5x
         u2wEEWDgCkeG1GImoIhpCqh6G9P9gv3b7D3aRy/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4.4 82/91] vt: selection, introduce vc_is_sel
Date:   Wed,  1 Apr 2020 18:18:18 +0200
Message-Id: <20200401161539.007738954@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
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

---
 drivers/tty/vt/selection.c |    5 +++++
 drivers/tty/vt/vt.c        |    7 ++++---
 drivers/tty/vt/vt_ioctl.c  |    2 +-
 include/linux/selection.h  |    4 +++-
 4 files changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -80,6 +80,11 @@ void clear_selection(void)
 	}
 }
 
+bool vc_is_sel(struct vc_data *vc)
+{
+	return vc == sel_cons;
+}
+
 /*
  * User settable table: what characters are to be considered alphabetic?
  * 256 bits. Locked by the console lock.
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -600,8 +600,9 @@ static void hide_softcursor(struct vc_da
 
 static void hide_cursor(struct vc_data *vc)
 {
-	if (vc == sel_cons)
+	if (vc_is_sel(vc))
 		clear_selection();
+
 	vc->vc_sw->con_cursor(vc, CM_ERASE);
 	hide_softcursor(vc);
 }
@@ -612,7 +613,7 @@ static void set_cursor(struct vc_data *v
 	    vc->vc_mode == KD_GRAPHICS)
 		return;
 	if (vc->vc_deccm) {
-		if (vc == sel_cons)
+		if (vc_is_sel(vc))
 			clear_selection();
 		add_softcursor(vc);
 		if ((vc->vc_cursor_type & 0x0f) != 1)
@@ -878,7 +879,7 @@ static int vc_do_resize(struct tty_struc
 	if (!newscreen)
 		return -ENOMEM;
 
-	if (vc == sel_cons)
+	if (vc_is_sel(vc))
 		clear_selection();
 
 	old_rows = vc->vc_rows;
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -42,7 +42,7 @@ char vt_dont_switch;
 extern struct tty_driver *console_driver;
 
 #define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
-#define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_cons[i].d == sel_cons)
+#define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_is_sel(vc_cons[i].d))
 
 /*
  * Console (vt and kd) routines, as defined by USL SVR4 manual, and by
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -12,8 +12,8 @@
 
 struct tty_struct;
 
-extern struct vc_data *sel_cons;
 struct tty_struct;
+struct vc_data;
 
 extern void clear_selection(void);
 extern int set_selection(const struct tiocl_selection __user *sel, struct tty_struct *tty);
@@ -22,6 +22,8 @@ extern int sel_loadlut(char __user *p);
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
+bool vc_is_sel(struct vc_data *vc);
+
 extern int console_blanked;
 
 extern unsigned char color_table[];


