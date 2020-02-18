Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC7FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69655207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBRPHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:07:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36326 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgBRPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:07:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j44T7-0006Db-N0; Tue, 18 Feb 2020 16:07:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5887D1C20BD;
        Tue, 18 Feb 2020 16:07:25 +0100 (CET)
Date:   Tue, 18 Feb 2020 15:07:24 -0000
From:   "tip-bot2 for H.J. Lu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/compressed: Don't declare __force_order in
 kaslr_64.c
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200124181811.4780-1-hjl.tools@gmail.com>
References: <20200124181811.4780-1-hjl.tools@gmail.com>
MIME-Version: 1.0
Message-ID: <158203844496.13786.14610614257521764500.tip-bot2@tip-bot2>
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

Commit-ID:     970b41399925e34fdf5783a53fe8cc73f04fec37
Gitweb:        https://git.kernel.org/tip/970b41399925e34fdf5783a53fe8cc73f04fec37
Author:        H.J. Lu <hjl.tools@gmail.com>
AuthorDate:    Thu, 16 Jan 2020 12:46:51 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Feb 2020 14:40:53 +01:00

x86/boot/compressed: Don't declare __force_order in kaslr_64.c

GCC 10 changed the default to -fno-common, which leads to

    LD      arch/x86/boot/compressed/vmlinux
  ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; \
    arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
  make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1

Since __force_order is already provided in pgtable_64.c, there is no
need to declare __force_order in kaslr_64.c.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200124181811.4780-1-hjl.tools@gmail.com
---
 arch/x86/boot/compressed/kaslr_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index 748456c..9557c5a 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -29,9 +29,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-/* Used by pgtable.h asm code to force instruction serialization. */
-unsigned long __force_order;
-
 /* Used to track our page table allocation area. */
 struct alloc_pgt_data {
 	unsigned char *pgt_buf;
