Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C4C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9452073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgEDQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgEDQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:52:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF7FC061A0E;
        Mon,  4 May 2020 09:52:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jVeK4-0001aU-F1; Mon, 04 May 2020 18:52:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E1A381C0084;
        Mon,  4 May 2020 18:52:03 +0200 (CEST)
Date:   Mon, 04 May 2020 16:52:03 -0000
From:   "tip-bot2 for Vamshi K Sthambamkadi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Fix -Wint-to-pointer-cast build warning
Cc:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1587645588-7130-3-git-send-email-vamshi.k.sthambamkadi@gmail.com>
References: <1587645588-7130-3-git-send-email-vamshi.k.sthambamkadi@gmail.com>
MIME-Version: 1.0
Message-ID: <158861112381.8414.8884633778038509569.tip-bot2@tip-bot2>
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

Commit-ID:     40ba9309c76f29d012a5cc0cf938f8ff7dc6fef2
Gitweb:        https://git.kernel.org/tip/40ba9309c76f29d012a5cc0cf938f8ff7dc6fef2
Author:        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
AuthorDate:    Thu, 23 Apr 2020 18:09:48 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 May 2020 15:22:16 +02:00

x86/boot: Fix -Wint-to-pointer-cast build warning

Fix this warning when building 32-bit with

CONFIG_RANDOMIZE_BASE=y
CONFIG_MEMORY_HOTREMOVE=y

  arch/x86/boot/compressed/acpi.c:316:9: warning: \
    cast to pointer from integer of different size [-Wint-to-pointer-cast]

Have get_cmdline_acpi_rsdp() return unsigned long which is the proper
type to convert to a pointer of the respective width.

 [ bp: Rewrite commit message, touch ups. ]

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1587645588-7130-3-git-send-email-vamshi.k.sthambamkadi@gmail.com
---
 arch/x86/boot/compressed/acpi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index ef2ad72..8bcbcee 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -280,9 +280,9 @@ acpi_physical_address get_rsdp_addr(void)
  */
 #define MAX_ADDR_LEN 19
 
-static acpi_physical_address get_cmdline_acpi_rsdp(void)
+static unsigned long get_cmdline_acpi_rsdp(void)
 {
-	acpi_physical_address addr = 0;
+	unsigned long addr = 0;
 
 #ifdef CONFIG_KEXEC
 	char val[MAX_ADDR_LEN] = { };
@@ -292,7 +292,7 @@ static acpi_physical_address get_cmdline_acpi_rsdp(void)
 	if (ret < 0)
 		return 0;
 
-	if (kstrtoull(val, 16, &addr))
+	if (boot_kstrtoul(val, 16, &addr))
 		return 0;
 #endif
 	return addr;
@@ -314,7 +314,6 @@ static unsigned long get_acpi_srat_table(void)
 	 * different ideas about whether to trust a command-line parameter.
 	 */
 	rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
-
 	if (!rsdp)
 		rsdp = (struct acpi_table_rsdp *)(long)
 			boot_params->acpi_rsdp_addr;
