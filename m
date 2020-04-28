Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB5C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518C020661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgD1LGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD1LGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:06:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454FC03C1A9;
        Tue, 28 Apr 2020 04:06:38 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jTO4Q-0007uN-9e; Tue, 28 Apr 2020 13:06:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DA53E1C010B;
        Tue, 28 Apr 2020 13:06:33 +0200 (CEST)
Date:   Tue, 28 Apr 2020 11:06:33 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/tboot: Mark tboot static
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200428051703.1625952-1-hch@lst.de>
References: <20200428051703.1625952-1-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158807199339.28353.3171896201372652846.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     767dea211cd0c68d8116d8c3b5104e82454fb44b
Gitweb:        https://git.kernel.org/tip/767dea211cd0c68d8116d8c3b5104e82454fb44b
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Tue, 28 Apr 2020 07:17:03 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 28 Apr 2020 11:05:44 +02:00

x86/tboot: Mark tboot static

This structure is only really used in tboot.c.  The only exception
is a single tboot_enabled check, but for that we don't need an inline
function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200428051703.1625952-1-hch@lst.de
---
 arch/x86/kernel/tboot.c | 8 ++++++--
 include/linux/tboot.h   | 8 +-------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index b89f6ac..b2942b2 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -35,8 +35,7 @@
 #include "../realmode/rm/wakeup.h"
 
 /* Global pointer to shared data; NULL means no measured launch. */
-struct tboot *tboot __read_mostly;
-EXPORT_SYMBOL(tboot);
+static struct tboot *tboot __read_mostly;
 
 /* timeout for APs (in secs) to enter wait-for-SIPI state during shutdown */
 #define AP_WAIT_TIMEOUT		1
@@ -46,6 +45,11 @@ EXPORT_SYMBOL(tboot);
 
 static u8 tboot_uuid[16] __initdata = TBOOT_UUID;
 
+bool tboot_enabled(void)
+{
+	return tboot != NULL;
+}
+
 void __init tboot_probe(void)
 {
 	/* Look for valid page-aligned address for shared page. */
diff --git a/include/linux/tboot.h b/include/linux/tboot.h
index 5424bc6..c7e4247 100644
--- a/include/linux/tboot.h
+++ b/include/linux/tboot.h
@@ -121,13 +121,7 @@ struct tboot {
 #define TBOOT_UUID	{0xff, 0x8d, 0x3c, 0x66, 0xb3, 0xe8, 0x82, 0x4b, 0xbf,\
 			 0xaa, 0x19, 0xea, 0x4d, 0x5, 0x7a, 0x8}
 
-extern struct tboot *tboot;
-
-static inline int tboot_enabled(void)
-{
-	return tboot != NULL;
-}
-
+bool tboot_enabled(void);
 extern void tboot_probe(void);
 extern void tboot_shutdown(u32 shutdown_type);
 extern struct acpi_table_header *tboot_get_dmar_table(
