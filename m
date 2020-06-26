Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B26C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C90207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgFZH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:28:12 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37571 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728366AbgFZH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:28:10 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id DB8061F55E;
        Fri, 26 Jun 2020 09:22:46 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Fri, 26 Jun 2020 09:22:46 +0200
Date:   Fri, 26 Jun 2020 09:22:46 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v0 3/5] Check for SRG protocol and move bit masking
Message-ID: <e5f6e6f45416c51b1111e22c102c67d68b5ca9e8.1593155911.git.tammo.block@gmail.com>
References: <cover.1593155911.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593155911.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for the new SRG protocol bit and move masking of report to
report_mouse function (Otherwise all SRG information is lost ...)

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/selection.c | 6 +++---
 drivers/tty/vt/vt.c        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 31bb3647a99c..75e7995ddc70 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -331,9 +331,9 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
 	v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);
 	v->ye = min_t(u16, v->ye - 1, vc->vc_rows - 1);
 
-	if (mouse_reporting() && (v->sel_mode & TIOCL_SELMOUSEREPORT)) {
-		mouse_report(tty, v->sel_mode & TIOCL_SELBUTTONMASK, v->xs,
-			     v->ys);
+	if (mouse_reporting() && (v->sel_mode &
+		(TIOCL_SELMOUSEREPORT | TIOCL_SELSRGREPORT))) {
+		mouse_report(tty, v->sel_mode, v->xs, v->ys);
 		return 0;
 	}
 
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index d52ac57034e0..5c9c449dc150 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1837,8 +1837,8 @@ void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 {
 	char buf[8];
 
-	sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt), (char)('!' + mrx),
-		(char)('!' + mry));
+	sprintf(buf, "\033[M%c%c%c", (char)(' ' + (butt & TIOCL_SELBUTTONMASK)),
+		(char)('!' + mrx), (char)('!' + mry));
 	respond_string(buf, tty->port);
 }
 
-- 
2.27.0

