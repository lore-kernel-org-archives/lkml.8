Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9878CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED2E20674
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgF3HK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:10:28 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:40962 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730600AbgF3HK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:10:28 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 92C421F3FC;
        Tue, 30 Jun 2020 09:10:24 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Tue, 30 Jun 2020 09:10:24 +0200
Date:   Tue, 30 Jun 2020 09:10:24 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v1 1/6] tiocl.h: Change/Add defines for mouse report
Message-ID: <159375ce8dcdbcada6fa079f0a120765b10a84a7.1593499846.git.tammo.block@gmail.com>
References: <cover.1593499846.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593499846.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional defines for mouse event types. The change of the value
of TIOCL_SELBUTTONMASK deserves a bit more explanation :

The old value of 15 uses the first 4 bits and sends them unchanged back
to userspace if requested by an application. But in fact only the first
two bits have ever been used by any daemon or useful at all, as the
kernel already knows the status of the shift and alt keys encoded in
bits 3 and 4. On the other hand we *do* want to know the status of bits
6-8, encoding button values >3 and mouse move and drag operations.

This change is up- and downwards compatible by masking all spourious
bits and leaving only the undisputed parts (bits 1 and 2) untouched.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 include/uapi/linux/tiocl.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
index b32acc229024..c862053041e4 100644
--- a/include/uapi/linux/tiocl.h
+++ b/include/uapi/linux/tiocl.h
@@ -9,7 +9,7 @@
 #define 	TIOCL_SELPOINTER	3	/* show the pointer */
 #define 	TIOCL_SELCLEAR	4	/* clear visibility of selection */
 #define 	TIOCL_SELMOUSEREPORT	16	/* report beginning of selection */
-#define 	TIOCL_SELBUTTONMASK	15	/* button mask for report */
+#define 	TIOCL_SELBUTTONMASK	227	/* button mask for report */
 /* selection extent */
 struct tiocl_selection {
 	unsigned short xs;	/* X start */
@@ -28,7 +28,11 @@ struct tiocl_selection {
 
 /* these two don't return a value: they write it back in the type */
 #define TIOCL_GETSHIFTSTATE	6	/* write shift state */
-#define TIOCL_GETMOUSEREPORTING	7	/* write whether mouse event are reported */
+#define TIOCL_GETMOUSEREPORTING	7	/* write which mouse event are reported */
+#define		TIOCL_REPORTBTNPRESS	1	/* report button press only    "9" */
+#define		TIOCL_REPORTRELEASE	2	/* report press and release "1000" */
+#define		TIOCL_REPORTDRAG	3	/* report drag events       "1002" */
+#define		TIOCL_REPORTANYMOVE	4	/* report any movement      "1003" */
 #define TIOCL_SETVESABLANK	10	/* set vesa blanking mode */
 #define TIOCL_SETKMSGREDIRECT	11	/* restrict kernel messages to a vt */
 #define TIOCL_GETFGCONSOLE	12	/* get foreground vt */
-- 
2.27.0

