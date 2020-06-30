Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7C0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785082073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgF3HLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:11:34 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:41016 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730636AbgF3HLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:11:31 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 640D91F407;
        Tue, 30 Jun 2020 09:11:28 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Tue, 30 Jun 2020 09:11:28 +0200
Date:   Tue, 30 Jun 2020 09:11:28 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v1 4/6] vt/vt: Add SRG mouse reporting protocol
Message-ID: <d0435e5d32f1b14033d3c4ba22457356e8ae85b3.1593499846.git.tammo.block@gmail.com>
References: <cover.1593499846.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593499846.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRG protocol indicates a button release by appending a "m" to the
report. In this case the button number is not 3 ("release state") but
the number of the button that was released. As release event are only
reported for the first three buttons, we need to store the number on
click events because it is not sent to us from userspace.

We also need to check for the case where no button state change occurred
at all (bit 6 set), in this case a value of 3 is OK even in SRG.

Bitmasks for your convenience:
195 - All bits related to any button number
227 - All bits related to button number and "state not changed" bit
252 - All, except low button numbers (left, middle, right button)

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e2324d8e4e74..36520f7f0315 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -183,6 +183,9 @@ core_param(consoleblank, blankinterval, int, 0444);
 static DECLARE_WORK(console_work, console_callback);
 static DECLARE_WORK(con_driver_unregister_work, con_driver_unregister_callback);
 
+/* remember mouse state */
+unsigned char last_button_pressed = 3;
+
 /*
  * fg_console is the current virtual console,
  * last_console is the last used one,
@@ -1840,11 +1843,21 @@ static inline void respond_ID(struct tty_struct *tty)
 
 void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 {
-	char buf[8];
+	char buf[20];
+	bool rel;
 	int len;
 
-	len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
-			(char)('!' + mrx), (char)('!' + mry));
+	if (vc_cons[fg_console].d->vc_protocol_mouse == 1) {	/* SRG*/
+		/* For SRG release events, we send the last clicked button < 3 */
+		rel = ((butt & 195) == 3);
+		if ((butt & 195) < 3)
+			last_button_pressed = butt & 3;
+		if ((butt & 227) == 3)
+			butt = (butt & 252) | last_button_pressed;
+		len = sprintf(buf, "\033[<%d;%d;%d%c", butt, mrx + 1, mry + 1, rel ? 'm' : 'M');
+	} else							/* X10 */
+		len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
+				(char)('!' + mrx), (char)('!' + mry));
 	respond_string(buf, len, tty->port);
 }
 
-- 
2.27.0

