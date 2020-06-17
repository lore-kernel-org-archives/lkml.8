Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E04FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F31207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgFQJ7W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:59:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F7C061573;
        Wed, 17 Jun 2020 02:59:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlUqj-0006ED-Qa; Wed, 17 Jun 2020 11:59:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 60E621C0089;
        Wed, 17 Jun 2020 11:59:17 +0200 (CEST)
Date:   Wed, 17 Jun 2020 09:59:17 -0000
From:   "tip-bot2 for Benjamin Thiel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Fix -Wmissing-prototypes warnings for
 arch/x86/mm/init.c
Cc:     Benjamin Thiel <b.thiel@posteo.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200606122629.2720-1-b.thiel@posteo.de>
References: <20200606122629.2720-1-b.thiel@posteo.de>
MIME-Version: 1.0
Message-ID: <159238795712.16989.2186114908664268731.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d5249bc7a1a8869da90ba668b331b0b3f8996924
Gitweb:        https://git.kernel.org/tip/d5249bc7a1a8869da90ba668b331b0b3f8996924
Author:        Benjamin Thiel <b.thiel@posteo.de>
AuthorDate:    Sat, 06 Jun 2020 14:26:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 17 Jun 2020 10:45:46 +02:00

x86/mm: Fix -Wmissing-prototypes warnings for arch/x86/mm/init.c

Fix -Wmissing-prototypes warnings:

  arch/x86/mm/init.c:81:6:
  warning: no previous prototype for ‘x86_has_pat_wp’ [-Wmissing-prototypes]
  bool x86_has_pat_wp(void)

  arch/x86/mm/init.c:86:22:
  warning: no previous prototype for ‘pgprot2cachemode’ [-Wmissing-prototypes]
  enum page_cache_mode pgprot2cachemode(pgprot_t pgprot)

by including the respective header containing prototypes. Also fix:

  arch/x86/mm/init.c:893:13:
  warning: no previous prototype for ‘mem_encrypt_free_decrypted_mem’ [-Wmissing-prototypes]
  void __weak mem_encrypt_free_decrypted_mem(void) { }

by making it static inline for the !CONFIG_AMD_MEM_ENCRYPT case. This
warning happens when CONFIG_AMD_MEM_ENCRYPT is not enabled (defconfig
for example):

  ./arch/x86/include/asm/mem_encrypt.h:80:27:
  warning: inline function ‘mem_encrypt_free_decrypted_mem’ declared weak [-Wattributes]
  static inline void __weak mem_encrypt_free_decrypted_mem(void) { }
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It's ok to convert to static inline because the function is used only in
x86. Is not shared with other architectures so drop the __weak too.

 [ bp: Massage and adjust __weak comments while at it. ]

Signed-off-by: Benjamin Thiel <b.thiel@posteo.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200606122629.2720-1-b.thiel@posteo.de
---
 arch/x86/include/asm/mem_encrypt.h | 5 ++++-
 arch/x86/mm/init.c                 | 3 +--
 arch/x86/mm/mem_encrypt.c          | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 848ce43..5049f6c 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -43,9 +43,10 @@ void __init sme_enable(struct boot_params *bp);
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
+void __init mem_encrypt_free_decrypted_mem(void);
+
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
-void __init mem_encrypt_free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
@@ -77,6 +78,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; 
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+static inline void mem_encrypt_free_decrypted_mem(void) { }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 001dd7d..c7a4760 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -25,6 +25,7 @@
 #include <asm/cpufeature.h>
 #include <asm/pti.h>
 #include <asm/text-patching.h>
+#include <asm/memtype.h>
 
 /*
  * We need to define the tracepoints somewhere, and tlb.c
@@ -912,8 +913,6 @@ void free_kernel_image_pages(const char *what, void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
-void __weak mem_encrypt_free_decrypted_mem(void) { }
-
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 4a781cf..9f1177e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -376,7 +376,6 @@ bool force_dma_unencrypted(struct device *dev)
 	return false;
 }
 
-/* Architecture __weak replacement functions */
 void __init mem_encrypt_free_decrypted_mem(void)
 {
 	unsigned long vaddr, vaddr_end, npages;
@@ -401,6 +400,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	free_init_pages("unused decrypted", vaddr, vaddr_end);
 }
 
+/* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
