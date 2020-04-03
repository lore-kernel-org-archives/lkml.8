Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0028207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy9jR0Sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403984AbgDCNoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:44:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40146 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403787AbgDCNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so7732031wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NCYXezwaWdljDp3oAyXj9mbgsYGl6ydf1damIpAZhn8=;
        b=Uy9jR0Svoe0WlJ+9o2ixi1n2H6zX4VvI8t4B7nimpDCl7nPhTZom7XpkOBEqopNNrd
         aS5S+MZmYaSr70jwAAqC7o8ZaSZTDE22bKTcE4bs5WCrYn5KIinKydGoXfDEg9Oz8PSR
         9/18190fP4p/gc7Q203NGyDPMXrwdxcgV2h8DKnXHgyPlR4ejRoNlcuO2snJgeuzK1e9
         aW38t4WTVpl9R9Xn88chKyCX2K7zPO4hVEEWveS7vQ6kilvsidjTi/6908NJXEXHLeMB
         8akPonv7rOKIQtUDXd+kHOed3OyjETgzO1f82cRgtvt8Z8LGeUKkHZ1DJcqADcnyTTi7
         HHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NCYXezwaWdljDp3oAyXj9mbgsYGl6ydf1damIpAZhn8=;
        b=t+mZ8HJy43idxK9/i4e+V/7sUaJ++Q5zlcuM8AoWmCA7knO1aSdXVcJR1vdBoG39Lz
         eiUulNAYg2zLyQ1P4XQSiyKG7F6pKw061XWiVv2I8ghTkiucBwi/xgPfl+z2H4o1OzkT
         GWofOP0yLudZWhT80qQ0ZzLQtUtIQ3Dmz2csedb3wub327wEjuH0txJZyhZRuwMCOEyf
         2OBFmfK5z+wqpqSfmbfpU4ur8dJa7tr1Caq24D/UkEpsjL9mWodVLqzBrWOs7Lwp6ekT
         zzHMfMkP7r8pZbu6zjOeGiVXOFdj+wHRKnTfS+fI5yKyZn+eKyQhHL4QHsx9JYwnNxBV
         ZRfA==
X-Gm-Message-State: AGi0PuaCnjvzWRyxEh01FmYtXBftCR4EThBhscUdrBUEg4vvlgPNHQ1v
        GE03uD6A5QjaHjIvXZ7wgaQ=
X-Google-Smtp-Source: APiQypLm1z0CwJPXQfvGEEdAvmy9WYcCTjT9dJcOQ1WDqn05Ldiu9YR8RG+NZXxkS2X8So2Ay4Vb5g==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr8548827wmc.44.1585921422464;
        Fri, 03 Apr 2020 06:43:42 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:41 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 08/11] parport: Standardize use of printmode
Date:   Fri,  3 Apr 2020 14:43:22 +0100
Message-Id: <20200403134325.11523-8-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
References: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Standardize the define and the uses of printmode.

Miscellanea:

o Add missing statement termination ; where necessary

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_gsc.c |  8 ++++++--
 drivers/parport/parport_pc.c  | 14 ++++++--------
 drivers/parport/procfs.c      |  6 +++++-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index cb6a08bee3c7..9228e8f90309 100644
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
index aae03b59564f..77e37e3cb3a0 100644
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
index 48804049d697..e957beb94f14 100644
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
2.11.0

