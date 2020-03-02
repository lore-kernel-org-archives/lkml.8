Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69632C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4490C2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgCBKzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:55:22 -0500
Received: from sym2.noone.org ([178.63.92.236]:42044 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgCBKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:55:21 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48WH366PCBzvjc1; Mon,  2 Mar 2020 11:49:54 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pty: define and set show_fdinfo only if procfs is enabled
Date:   Mon,  2 Mar 2020 11:49:53 +0100
Message-Id: <20200302104954.2812-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the pattern used with other *_show_fdinfo functions and only
define and use pty_show_fdinfo if CONFIG_PROC_FS is set.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/pty.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 00099a8439d2..dceaff332ca5 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -756,10 +756,12 @@ static void pty_unix98_remove(struct tty_driver *driver, struct tty_struct *tty)
 	}
 }
 
+#ifdef CONFIG_PROC_FS
 static void pty_show_fdinfo(struct tty_struct *tty, struct seq_file *m)
 {
 	seq_printf(m, "tty-index:\t%d\n", tty->index);
 }
+#endif
 
 static const struct tty_operations ptm_unix98_ops = {
 	.lookup = ptm_unix98_lookup,
@@ -776,7 +778,9 @@ static const struct tty_operations ptm_unix98_ops = {
 	.compat_ioctl = pty_unix98_compat_ioctl,
 	.resize = pty_resize,
 	.cleanup = pty_cleanup,
+#ifdef CONFIG_PROC_FS
 	.show_fdinfo = pty_show_fdinfo,
+#endif
 };
 
 static const struct tty_operations pty_unix98_ops = {
-- 
2.25.0

