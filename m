Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CBC204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405709AbgFSQrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbgFSQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD78BC0613EE;
        Fri, 19 Jun 2020 09:46:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9O-00042x-PS; Fri, 19 Jun 2020 18:45:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 686C31C032F;
        Fri, 19 Jun 2020 18:45:58 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:45:58 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: arm: Omit arch specific config table
 matching array on arm64
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Leif Lindholm <leif@nuviainc.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159258515816.16989.12245229105901098597.tip-bot2@tip-bot2>
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

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     62956be8f95b93e9f91ffe2e5aa9c0e411af5a14
Gitweb:        https://git.kernel.org/tip/62956be8f95b93e9f91ffe2e5aa9c0e411af5a14
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 12:53:30 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 17 Jun 2020 15:29:11 +02:00

efi/libstub: arm: Omit arch specific config table matching array on arm64

On arm64, the EFI stub is built into the kernel proper, and so the stub
can refer to its symbols directly. Therefore, the practice of using EFI
configuration tables to pass information between them is never needed,
so we can omit any code consuming such tables when building for arm64.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
---
 drivers/firmware/efi/arm-init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index c697e70..6f4baf7 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -62,7 +62,8 @@ static void __init init_screen_info(void)
 {
 	struct screen_info *si;
 
-	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
+	if (IS_ENABLED(CONFIG_ARM) &&
+	    screen_info_table != EFI_INVALID_TABLE_ADDR) {
 		si = early_memremap_ro(screen_info_table, sizeof(*si));
 		if (!si) {
 			pr_err("Could not map screen_info config table\n");
@@ -116,7 +117,8 @@ static int __init uefi_init(u64 efi_system_table)
 		goto out;
 	}
 	retval = efi_config_parse_tables(config_tables, systab->nr_tables,
-					 arch_tables);
+					 IS_ENABLED(CONFIG_ARM) ? arch_tables
+								: NULL);
 
 	early_memunmap(config_tables, table_size);
 out:
