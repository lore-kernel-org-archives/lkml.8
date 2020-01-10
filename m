Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07578C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32F02469F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAJSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:00:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgAJR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ5-00029M-MA; Fri, 10 Jan 2020 18:59:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5170B1C2D6C;
        Fri, 10 Jan 2020 18:59:19 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:19 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Clean up <asm/memtype.h> externs
Cc:     Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157867915916.30329.12379827930607399319.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     533d49b37a2b532354d3841a142173b8321818df
Gitweb:        https://git.kernel.org/tip/533d49b37a2b532354d3841a142173b8321818df
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 20 Nov 2019 15:45:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Clean up <asm/memtype.h> externs

Half of the declarations have an 'extern', half of them not,
use 'extern' consistently.

This makes grepping for APIs easier, such as:

  dagon:~/tip> git grep -E '\<memtype_.*\(' arch/x86/ | grep extern
  arch/x86/include/asm/memtype.h:extern int memtype_reserve(u64 start, u64 end,
  arch/x86/include/asm/memtype.h:extern int memtype_free(u64 start, u64 end);
  arch/x86/include/asm/memtype.h:extern int memtype_kernel_map_sync(u64 base, unsigned long size,
  arch/x86/include/asm/memtype.h:extern int memtype_reserve_io(resource_size_t start, resource_size_t end,
  arch/x86/include/asm/memtype.h:extern void memtype_free_io(resource_size_t start, resource_size_t end);
  arch/x86/mm/pat/memtype.h:extern int memtype_check_insert(struct memtype *entry_new,
  arch/x86/mm/pat/memtype.h:extern struct memtype *memtype_erase(u64 start, u64 end);
  arch/x86/mm/pat/memtype.h:extern struct memtype *memtype_lookup(u64 addr);
  arch/x86/mm/pat/memtype.h:extern int memtype_copy_nth_element(struct memtype *entry_out, loff_t pos);

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/memtype.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
index ec18e38..9c2447b 100644
--- a/arch/x86/include/asm/memtype.h
+++ b/arch/x86/include/asm/memtype.h
@@ -5,8 +5,8 @@
 #include <linux/types.h>
 #include <asm/pgtable_types.h>
 
-bool pat_enabled(void);
-void pat_disable(const char *reason);
+extern bool pat_enabled(void);
+extern void pat_disable(const char *reason);
 extern void pat_init(void);
 extern void init_cache_modes(void);
 
@@ -17,11 +17,11 @@ extern int memtype_free(u64 start, u64 end);
 extern int memtype_kernel_map_sync(u64 base, unsigned long size,
 		enum page_cache_mode pcm);
 
-int memtype_reserve_io(resource_size_t start, resource_size_t end,
+extern int memtype_reserve_io(resource_size_t start, resource_size_t end,
 			enum page_cache_mode *pcm);
 
-void memtype_free_io(resource_size_t start, resource_size_t end);
+extern void memtype_free_io(resource_size_t start, resource_size_t end);
 
-bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
+extern bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
 
 #endif /* _ASM_X86_MEMTYPE_H */
