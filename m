Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED85F20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKOKs1xD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mL97vSbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGQXtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGQXs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:48:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE01C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:48:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595029736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjpwciZo3LSQYQqiU8DqDzWXFe6RTrMay7eVNDCtzLw=;
        b=RKOKs1xDhyTMe3lu5UVApFtQeojJ7EifeSizfWXo+O9JlfJa7Y13FcaVT/4U65T++B3vYH
        7IlLqrZjzmwMd/3wFRkM/QAarLfaiHASMs7zduQrrnGrTacTT8q9J7EpdYiMmViHsr/R7n
        57Ecf3BVy5jLu2y+zkMfVfXSbww24Ne3eKHLyky3AlDrFPL3KlAgQ9nol/HiA9ja0Vyx3c
        DBwbpxRJEIoLineh7JiZnM0WunWFegNFopLCD1SVNg4MH5VTmBo2dQEAUvLIgfxz3Rsfnx
        Na5ukTERuJM3VxJGsAPSFvG4pfMpR+aUztYQSxPjQ7D22PNYhN953owLfI7giQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595029736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjpwciZo3LSQYQqiU8DqDzWXFe6RTrMay7eVNDCtzLw=;
        b=mL97vSbuiuRkYt6C+igw2o+YzQbpXZD0/JwRSrdAOt1JKWPKU2grXMwOO2vydOFLY/B10n
        spn73+fNbT01asAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ipconfig: cleanup printk usage
Date:   Sat, 18 Jul 2020 01:54:18 +0206
Message-Id: <20200717234818.8622-5-john.ogness@linutronix.de>
In-Reply-To: <20200717234818.8622-1-john.ogness@linutronix.de>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of pr_info() and pr_cont() was not ordered correctly for
all cases. Order it so that all cases provide the expected output.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 net/ipv4/ipconfig.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 561f15b5a944..0f4bd7a59310 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1442,6 +1442,9 @@ static int __init ip_auto_config(void)
 #endif
 	int err;
 	unsigned int i;
+#ifndef IPCONFIG_SILENT
+	bool pr0;
+#endif
 
 	/* Initialise all name servers and NTP servers to NONE (but only if the
 	 * "ip=" or "nfsaddrs=" kernel command line parameters weren't decoded,
@@ -1575,31 +1578,37 @@ static int __init ip_auto_config(void)
 	if (ic_dev_mtu)
 		pr_cont(", mtu=%d", ic_dev_mtu);
 	/* Name servers (if any): */
+	pr0 = false;
 	for (i = 0; i < CONF_NAMESERVERS_MAX; i++) {
 		if (ic_nameservers[i] != NONE) {
-			if (i == 0)
+			if (!pr0) {
 				pr_info("     nameserver%u=%pI4",
 					i, &ic_nameservers[i]);
-			else
+				pr0 = true;
+			} else {
 				pr_cont(", nameserver%u=%pI4",
 					i, &ic_nameservers[i]);
+			}
 		}
-		if (i + 1 == CONF_NAMESERVERS_MAX)
-			pr_cont("\n");
 	}
+	if (pr0)
+		pr_cont("\n");
 	/* NTP servers (if any): */
+	pr0 = false;
 	for (i = 0; i < CONF_NTP_SERVERS_MAX; i++) {
 		if (ic_ntp_servers[i] != NONE) {
-			if (i == 0)
+			if (!pr0) {
 				pr_info("     ntpserver%u=%pI4",
 					i, &ic_ntp_servers[i]);
-			else
+				pr0 = true;
+			} else {
 				pr_cont(", ntpserver%u=%pI4",
 					i, &ic_ntp_servers[i]);
+			}
 		}
-		if (i + 1 == CONF_NTP_SERVERS_MAX)
-			pr_cont("\n");
 	}
+	if (pr0)
+		pr_cont("\n");
 #endif /* !SILENT */
 
 	/*
-- 
2.20.1

