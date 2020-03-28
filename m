Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8097FC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594BA20732
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC1LXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:23:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55661 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1LXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:23:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9YZ-00048t-Dr; Sat, 28 Mar 2020 12:23:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 01D221C03A9;
        Sat, 28 Mar 2020 12:23:15 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:23:14 -0000
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Fix debug_puthex() parameter type
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200319091407.1481-11-joro@8bytes.org>
References: <20200319091407.1481-11-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <158539459459.28353.12622409151371734072.tip-bot2@tip-bot2>
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

Commit-ID:     c90beea22a2bece4b0bbb39789bf835504421594
Gitweb:        https://git.kernel.org/tip/c90beea22a2bece4b0bbb39789bf835504421594
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Thu, 19 Mar 2020 10:13:07 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 28 Mar 2020 12:14:26 +01:00

x86/boot/compressed: Fix debug_puthex() parameter type

In the CONFIG_X86_VERBOSE_BOOTUP=Y case, the debug_puthex() macro just
turns into __puthex(), which takes 'unsigned long' as parameter.

But in the CONFIG_X86_VERBOSE_BOOTUP=N case, it is a function which
takes 'unsigned char *', causing compile warnings when the function is
used. Fix the parameter type to get rid of the warnings.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200319091407.1481-11-joro@8bytes.org
---
 arch/x86/boot/compressed/misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index c818139..726e264 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -59,7 +59,7 @@ void __puthex(unsigned long value);
 
 static inline void debug_putstr(const char *s)
 { }
-static inline void debug_puthex(const char *s)
+static inline void debug_puthex(unsigned long value)
 { }
 #define debug_putaddr(x) /* */
 
