Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE9C3B185
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB322465D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBIOHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 09:07:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42471 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgBIOHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 09:07:00 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j0nEa-0004VG-6G; Sun, 09 Feb 2020 15:06:52 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 83373FFB71;
        Sun,  9 Feb 2020 15:06:51 +0100 (CET)
Date:   Sun, 09 Feb 2020 14:02:37 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] EFI fix for 5.6-rc1
Message-ID: <158125695731.26104.949647922067525745.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-02-09

up to:  59365cadfbcd: efi/x86: Fix boot regression on systems with invalid memmap entries


A single fix for a EFI boot regression on X86 which was caused by the
recent rework of the EFI memory map parsing. On systems with invalid memmap
entries the cleanup function uses an value which cannot be relied on in
this stage. Use the actual EFI memmap entry instead.


Thanks,

	tglx

------------------>
Ard Biesheuvel (1):
      efi/x86: Fix boot regression on systems with invalid memmap entries


 arch/x86/platform/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 59f7f6d60cf6..ae923ee8e2b4 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -308,7 +308,7 @@ static void __init efi_clean_memmap(void)
 			.phys_map = efi.memmap.phys_map,
 			.desc_version = efi.memmap.desc_version,
 			.desc_size = efi.memmap.desc_size,
-			.size = data.desc_size * (efi.memmap.nr_map - n_removal),
+			.size = efi.memmap.desc_size * (efi.memmap.nr_map - n_removal),
 			.flags = 0,
 		};
 

