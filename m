Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F2246BB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCBKzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:55:22 -0500
Received: from sym2.noone.org ([178.63.92.236]:42046 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbgCBKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:55:21 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2020 05:55:21 EST
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48WH370C3GzvjdQ; Mon,  2 Mar 2020 11:49:54 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tty: define and set show_fdinfo only if procfs is enabled
Date:   Mon,  2 Mar 2020 11:49:54 +0100
Message-Id: <20200302104954.2812-2-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200302104954.2812-1-tklauser@distanz.ch>
References: <20200302104954.2812-1-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the pattern used with other *_show_fdinfo functions and only
define and use tty_show_fdinfo if CONFIG_PROC_FS is set.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/tty_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index a1453fe10862..4a6b6116aa72 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -467,6 +467,7 @@ static int hung_up_tty_fasync(int fd, struct file *file, int on)
 	return -ENOTTY;
 }
 
+#ifdef CONFIG_PROC_FS
 static void tty_show_fdinfo(struct seq_file *m, struct file *file)
 {
 	struct tty_struct *tty = file_tty(file);
@@ -474,6 +475,7 @@ static void tty_show_fdinfo(struct seq_file *m, struct file *file)
 	if (tty && tty->ops && tty->ops->show_fdinfo)
 		tty->ops->show_fdinfo(tty, m);
 }
+#endif
 
 static const struct file_operations tty_fops = {
 	.llseek		= no_llseek,
@@ -485,7 +487,9 @@ static const struct file_operations tty_fops = {
 	.open		= tty_open,
 	.release	= tty_release,
 	.fasync		= tty_fasync,
+#ifdef CONFIG_PROC_FS
 	.show_fdinfo	= tty_show_fdinfo,
+#endif
 };
 
 static const struct file_operations console_fops = {
-- 
2.25.0

