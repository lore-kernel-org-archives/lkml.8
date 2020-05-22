Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CCD204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgEVSaV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbgEVSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:30:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B1C061A0E;
        Fri, 22 May 2020 11:30:19 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcCQy-0002ko-7S; Fri, 22 May 2020 20:30:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB63C1C0475;
        Fri, 22 May 2020 20:30:15 +0200 (CEST)
Date:   Fri, 22 May 2020 18:30:15 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Pull up arch-specific prototype efi_systab_show_arch()
Cc:     Benjamin Thiel <b.thiel@posteo.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200516132647.14568-1-b.thiel@posteo.de>
References: <20200516132647.14568-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <159017221567.17951.10635719192322244264.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     e8da08a088236aff4b51d4ec97c750051f9fe417
Gitweb:        https://git.kernel.org/tip/e8da08a088236aff4b51d4ec97c750051f9fe417
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Sat, 16 May 2020 15:26:47 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sun, 17 May 2020 11:46:50 +02:00

efi: Pull up arch-specific prototype efi_systab_show_arch()

Pull up arch-specific prototype efi_systab_show_arch() in order to
fix a -Wmissing-prototypes warning:

arch/x86/platform/efi/efi.c:957:7: warning: no previous prototype for
‘efi_systab_show_arch’ [-Wmissing-prototypes]
char *efi_systab_show_arch(char *str)

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Link: https://lore.kernel.org/r/20200516132647.14568-1-b.thiel@posteo.de
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 5 +----
 include/linux/efi.h        | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 911a2bd..4e30552 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -130,11 +130,8 @@ static ssize_t systab_show(struct kobject *kobj,
 	if (efi.smbios != EFI_INVALID_TABLE_ADDR)
 		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
 
-	if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86)) {
-		extern char *efi_systab_show_arch(char *str);
-
+	if (IS_ENABLED(CONFIG_IA64) || IS_ENABLED(CONFIG_X86))
 		str = efi_systab_show_arch(str);
-	}
 
 	return str - buf;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 251f1f7..9430d01 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1245,4 +1245,6 @@ struct linux_efi_memreserve {
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
+char *efi_systab_show_arch(char *str);
+
 #endif /* _LINUX_EFI_H */
