Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309A3C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1150F246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgB1IeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:34:13 -0500
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:52676 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726907AbgB1IeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1E292181D3025;
        Fri, 28 Feb 2020 08:34:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bat74_7b8fc09646c23
X-Filterd-Recvd-Size: 3343
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:09 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] parport: Standardize use of printmode
Date:   Fri, 28 Feb 2020 00:32:18 -0800
Message-Id: <7cf26906db4976a5455de5776c8a220fb37d37cb.1582878394.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582878393.git.joe@perches.com>
References: <cover.1582878393.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the define and the uses of printmode.

Miscellanea:

o Add missing statement termination ; where necessary

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/parport/parport_gsc.c |  8 ++++++--
 drivers/parport/parport_pc.c  | 14 ++++++--------
 drivers/parport/procfs.c      |  6 +++++-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index cb6a08..9228e8 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -299,12 +299,16 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 		p->dma = PARPORT_DMA_NONE;
 
 	pr_cont(" [");
-#define printmode(x) {if(p->modes&PARPORT_MODE_##x){pr_cont("%s%s",f?",":"",#x);f++;}}
+#define printmode(x)							\
+do {									\
+	if (p->modes & PARPORT_MODE_##x)				\
+		pr_cont("%s%s", f++ ? "," : "", #x);			\
+} while (0)
 	{
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-		printmode(COMPAT)
+		printmode(COMPAT);
 		printmode(EPP);
 //		printmode(ECP);
 //		printmode(DMA);
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index aae03b..77e37e3 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2134,19 +2134,17 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 
 	pr_cont(" [");
 
-#define printmode(x) \
-	{\
-		if (p->modes & PARPORT_MODE_##x) {\
-			pr_cont("%s%s", f ? "," : "", #x);	\
-			f++;\
-		} \
-	}
+#define printmode(x)							\
+do {									\
+	if (p->modes & PARPORT_MODE_##x)				\
+		pr_cont("%s%s", f++ ? "," : "", #x);			\
+} while (0)
 
 	{
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-		printmode(COMPAT)
+		printmode(COMPAT);
 		printmode(EPP);
 		printmode(ECP);
 		printmode(DMA);
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 488040..e957be 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -213,7 +213,11 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 		return -EACCES;
 
 	{
-#define printmode(x) {if(port->modes&PARPORT_MODE_##x){len+=sprintf(buffer+len,"%s%s",f?",":"",#x);f++;}}
+#define printmode(x)							\
+do {									\
+	if (port->modes & PARPORT_MODE_##x)				\
+		len += sprintf(buffer + len, "%s%s", f++ ? "," : "", #x); \
+} while (0)
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-- 
2.24.0

