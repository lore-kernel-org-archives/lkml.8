Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEB8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436282076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgFZH2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:28:10 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37570 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbgFZH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:28:10 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 58D9A1F568;
        Fri, 26 Jun 2020 09:23:03 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Fri, 26 Jun 2020 09:23:03 +0200
Date:   Fri, 26 Jun 2020 09:23:03 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v0 4/5] Add support for SRG report output format
Message-ID: <f703a17a02475251e50071354977dca8544f969a.1593155911.git.tammo.block@gmail.com>
References: <cover.1593155911.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593155911.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SRG ("1005") style mouse reports. Always use them to create a report to
userspace if they are available because they may contain more information
(e.g. scroll wheel events).

Do not send reports at all if report information is not sufficient.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5c9c449dc150..af0c58a9b108 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1835,10 +1835,30 @@ static inline void respond_ID(struct tty_struct *tty)
 
 void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 {
-	char buf[8];
+	char buf[20];
+	char rel;
 
-	sprintf(buf, "\033[M%c%c%c", (char)(' ' + (butt & TIOCL_SELBUTTONMASK)),
-		(char)('!' + mrx), (char)('!' + mry));
+	if (butt & TIOCL_SELSRGREPORT) {
+		rel = (butt & TIOCL_SELSRGRELEASE) ? 1 : 0;
+		butt = butt >> 8;
+
+		if (vc_cons[fg_console].d->vc_proto_mouse) {
+			sprintf(buf, "\033[<%d;%d;%d%c", butt, mrx + 1, mry + 1, rel ? 'm' : 'M');
+		} else {
+			if (rel)
+				butt = (3 | butt);
+			sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
+				(char)('!' + mrx), (char)('!' + mry));
+		}
+	} else {
+		/* Compatibility for older protocol */
+		if (vc_cons[fg_console].d->vc_proto_mouse)
+			return;
+		if (vc_cons[fg_console].d->vc_report_mouse > 2)
+			return;
+		sprintf(buf, "\033[M%c%c%c", (char)(' ' + (butt & TIOCL_SELBUTTONMASK)),
+			(char)('!' + mrx), (char)('!' + mry));
+	}
 	respond_string(buf, tty->port);
 }
 
-- 
2.27.0

