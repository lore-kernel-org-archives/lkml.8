Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E4CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC262076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgFZH1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:27:21 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37523 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgFZH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:27:21 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id E4FE61F55F;
        Fri, 26 Jun 2020 09:22:07 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Fri, 26 Jun 2020 09:22:07 +0200
Date:   Fri, 26 Jun 2020 09:22:07 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v0 1/5] Change/add data structures for SRG mouse reporting
Message-ID: <7e65f1f060c2b9b22a4a051d4afb605913dedf79.1593155911.git.tammo.block@gmail.com>
References: <cover.1593155911.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593155911.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the data structures and defines needed for additional
mouse reporting features. If URXVT and UTF8 reports should be supported
in the future, vc_proto_mouse would need another bit.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 include/linux/console_struct.h |  3 ++-
 include/uapi/linux/tiocl.h     | 24 ++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 24d4c16e3ae0..cfb581eb8b82 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -122,7 +122,8 @@ struct vc_data {
 	unsigned int	vc_priv		: 3;
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
-	unsigned int	vc_report_mouse : 2;
+	unsigned int	vc_report_mouse : 3;
+	unsigned int	vc_proto_mouse  : 1;
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
 		 int	vc_utf_char;
diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
index b32acc229024..df27608648f7 100644
--- a/include/uapi/linux/tiocl.h
+++ b/include/uapi/linux/tiocl.h
@@ -3,13 +3,17 @@
 #define _LINUX_TIOCL_H
 
 #define TIOCL_SETSEL	2	/* set a selection */
-#define 	TIOCL_SELCHAR	0	/* select characters */
-#define 	TIOCL_SELWORD	1	/* select whole words */
-#define 	TIOCL_SELLINE	2	/* select whole lines */
-#define 	TIOCL_SELPOINTER	3	/* show the pointer */
-#define 	TIOCL_SELCLEAR	4	/* clear visibility of selection */
-#define 	TIOCL_SELMOUSEREPORT	16	/* report beginning of selection */
-#define 	TIOCL_SELBUTTONMASK	15	/* button mask for report */
+#define		TIOCL_SELCHAR	0	/* select characters */
+#define		TIOCL_SELWORD	1	/* select whole words */
+#define		TIOCL_SELLINE	2	/* select whole lines */
+#define		TIOCL_SELPOINTER	3	/* show the pointer */
+#define		TIOCL_SELCLEAR	4	/* clear visibility of selection */
+#define		TIOCL_SELMOUSEREPORT	16	/* send X10 mouse report */
+#define		TIOCL_SELBUTTONMASK	15	/* button mask for X10 report */
+#define		TIOCL_SELSRGREPORT	32	/* send SRG mouse report */
+#define		TIOCL_SELSRGRELEASE	128	/* SRG report is release event */
+#define		TIOCL_SELSRGMASK	(255 << 8)	/* mask for SRG report */
+
 /* selection extent */
 struct tiocl_selection {
 	unsigned short xs;	/* X start */
@@ -28,7 +32,11 @@ struct tiocl_selection {
 
 /* these two don't return a value: they write it back in the type */
 #define TIOCL_GETSHIFTSTATE	6	/* write shift state */
-#define TIOCL_GETMOUSEREPORTING	7	/* write whether mouse event are reported */
+#define TIOCL_GETMOUSEREPORTING	7	/* write which mouse event to be reported */
+#define		TIOCL_REPORTBTNPRESS	1	/* report button press only    "9" */
+#define		TIOCL_REPORTRELEASE	2	/* report press and release "1000" */
+#define		TIOCL_REPORTDRAG	5	/* report drag events       "1002" */
+#define		TIOCL_REPORTANYMOVE	6	/* report any movement      "1003" */
 #define TIOCL_SETVESABLANK	10	/* set vesa blanking mode */
 #define TIOCL_SETKMSGREDIRECT	11	/* restrict kernel messages to a vt */
 #define TIOCL_GETFGCONSOLE	12	/* get foreground vt */
-- 
2.27.0

