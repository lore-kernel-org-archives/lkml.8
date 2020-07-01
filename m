Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898D0206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgGAPNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:13:24 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37027 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730883AbgGAPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:13:23 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 695861F42D;
        Wed,  1 Jul 2020 17:13:20 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Wed, 01 Jul 2020 17:13:20 +0200
Date:   Wed, 1 Jul 2020 17:13:20 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 4/6] vt/vt: Add SRG mouse reporting protocol
Message-ID: <167e1d106125e5401fd907d6febdec4273cfdd3e.1593615440.git.tammo.block@gmail.com>
References: <cover.1593615440.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593615440.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRG protocol indicates a button release by appending a "m" to the
report. In this case the button number is not 3 (RELEASEEVENT) but
the number of the button that was released. As release event are only
reported for the first three buttons (LOWBUTTONMASK), we need to store
the number on click events because it is not sent to us from userspace.

We also need to check for the case where no button state change occurred
at all (bit 6 set), in this case a value of 3 is OK even in SRG.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9abf2829b1d3..9aae3eac7989 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1838,15 +1838,34 @@ static inline void respond_ID(struct tty_struct *tty)
 	respond_string(vt102_id, strlen(vt102_id), tty->port);
 }
 
+#define ANYBUTTONMASK	0xc3
+#define LOWBUTTONMASK	0x03
+#define RELEASEEVENT	0x03
+
 enum { Mouse_X10 = 0, Mouse_SRG, Mouse_URXVT};
 
 void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 {
-	char buf[8];
+	static char last_btn = RELEASEEVENT;
+	char buf[20];
+	bool rel;
 	int len;
 
-	len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
-			(char)('!' + mrx), (char)('!' + mry));
+	switch (vc_cons[fg_console].d->vc_protocol_mouse) {
+		case Mouse_SRG:
+			rel = (butt & ANYBUTTONMASK) == RELEASEEVENT;
+			if ((butt & ANYBUTTONMASK) < RELEASEEVENT)
+				last_btn = butt & LOWBUTTONMASK;
+			if ((butt & TIOCL_SELBUTTONMASK) == RELEASEEVENT)
+				butt = (butt & ~LOWBUTTONMASK) | last_btn;
+			len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
+					mrx + 1, mry + 1, rel ? 'm' : 'M');
+			break;
+		default:
+			len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
+					(char)('!' + mrx), (char)('!' + mry));
+			break;
+	}
 	respond_string(buf, len, tty->port);
 }
 
-- 
2.27.0

