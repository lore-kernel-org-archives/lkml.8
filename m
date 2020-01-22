Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D96EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169BA24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgAVORj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:17:39 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:55797 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgAVORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:17:39 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id 48763102AAF1B;
        Wed, 22 Jan 2020 15:17:36 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id E182A60FC0CE;
        Wed, 22 Jan 2020 15:17:35 +0100 (CET)
X-Mailbox-Line: From 575cb82102aa59a7a8e34248821b78e1dd844777 Mon Sep 17 00:00:00 2001
Message-Id: <575cb82102aa59a7a8e34248821b78e1dd844777.1579701673.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 22 Jan 2020 15:17:30 +0100
Subject: [PATCH] vt: Fix non-blinking cursor regression
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Nicolas Pitre <nico@fluxnic.net>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Matthew Whitehead <tedheadster@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a6dbe4427559 ("vt: perform safe console erase in the right
order"), when userspace clears both the scrollback buffer and the screen
by writing "\e[3J" to an fbdev virtual console, the cursor stops blinking
if that virtual console is not in the foreground.  I'm witnessing this
on every boot of Raspbian since updating to v4.19.37+ because agetty
writes the sequence to /dev/tty6 while the console is still switched to
/dev/tty1.  Switching consoles once makes the cursor blink again.

The commit added an invocation of ->con_switch() to flush_scrollback().
Normally this is only invoked from switch_screen() to switch consoles.
switch_screen() updates *vc->vc_display_fg to the new console and
fbcon_switch() updates ops->currcon.  Because the commit only invokes
fbcon_switch() but doesn't update *vc->vc_display_fg, it performs an
incomplete console switch.

When fb_flashcursor() subsequently blinks the cursor, it retrieves the
foreground console from ops->currcon.  Because *vc->vc_display_fg wasn't
updated, con_is_visible() incorrectly returns false and as a result,
fb_flashcursor() bails out without blinking the cursor.

The invocation of ->con_switch() appears to have been erroneous.  After
all, why should a console switch be performed when clearing the screen?
The commit message doesn't provide a rationale either.  So delete it.

Fixes: a6dbe4427559 ("vt: perform safe console erase in the right order")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.1+
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Matthew Whitehead <tedheadster@gmail.com>
---
 drivers/tty/vt/vt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 35d21cdb60d0..eb25fb4ca05f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -938,8 +938,6 @@ static void flush_scrollback(struct vc_data *vc)
 	set_origin(vc);
 	if (vc->vc_sw->con_flush_scrollback)
 		vc->vc_sw->con_flush_scrollback(vc);
-	else
-		vc->vc_sw->con_switch(vc);
 }
 
 /*
-- 
2.24.0

