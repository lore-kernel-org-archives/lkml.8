Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DAFC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9DB20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgDQUe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbgDQUeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:34:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B47C061A0C;
        Fri, 17 Apr 2020 13:34:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPXgq-0006nS-8J; Fri, 17 Apr 2020 22:34:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 741F01C0072;
        Fri, 17 Apr 2020 22:34:19 +0200 (CEST)
Date:   Fri, 17 Apr 2020 20:34:19 -0000
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/early_printk: Remove unused includes
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200326175415.8618-1-andriy.shevchenko@linux.intel.com>
References: <20200326175415.8618-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158715565902.28353.709569206993326415.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     968e6147fcc5862096863980298f3ec4ae5742eb
Gitweb:        https://git.kernel.org/tip/968e6147fcc5862096863980298f3ec4ae5742eb
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Thu, 26 Mar 2020 19:54:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 17 Apr 2020 19:54:35 +02:00

x86/early_printk: Remove unused includes

After

  1bd187de5364 ("x86, intel-mid: remove Intel MID specific serial support")

the Intel MID header is not needed anymore.

After

  69c1f396f25b ("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")

the EFI headers are not needed anymore.

Remove the respective includes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200326175415.8618-1-andriy.shevchenko@linux.intel.com
---
 arch/x86/kernel/early_printk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 9b33904..93fbdff 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -15,12 +15,9 @@
 #include <xen/hvc-console.h>
 #include <asm/pci-direct.h>
 #include <asm/fixmap.h>
-#include <asm/intel-mid.h>
 #include <asm/pgtable.h>
 #include <linux/usb/ehci_def.h>
 #include <linux/usb/xhci-dbgp.h>
-#include <linux/efi.h>
-#include <asm/efi.h>
 #include <asm/pci_x86.h>
 
 /* Simple VGA output */
