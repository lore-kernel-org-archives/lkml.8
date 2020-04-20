Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8278DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6604C20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgDTNak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728080AbgDTNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:30:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF01C061A0C;
        Mon, 20 Apr 2020 06:30:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQWVJ-0005MO-DX; Mon, 20 Apr 2020 15:30:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 151621C0475;
        Mon, 20 Apr 2020 15:30:29 +0200 (CEST)
Date:   Mon, 20 Apr 2020 13:30:28 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add a x86_has_pat_wp() helper
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200408152745.1565832-2-hch@lst.de>
References: <20200408152745.1565832-2-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158738942857.28353.5477632889684051929.tip-bot2@tip-bot2>
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

Commit-ID:     1f6f655e01adebf5bd5e6c3da2e843c104ded051
Gitweb:        https://git.kernel.org/tip/1f6f655e01adebf5bd5e6c3da2e843c104ded051
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Wed, 08 Apr 2020 17:27:42 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Apr 2020 12:39:11 +02:00

x86/mm: Add a x86_has_pat_wp() helper

Abstract the ioremap code away from the caching mode internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200408152745.1565832-2-hch@lst.de
---
 arch/x86/include/asm/memtype.h | 2 ++
 arch/x86/mm/init.c             | 6 ++++++
 arch/x86/mm/ioremap.c          | 8 ++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
index 9c2447b..1e4e99b 100644
--- a/arch/x86/include/asm/memtype.h
+++ b/arch/x86/include/asm/memtype.h
@@ -24,4 +24,6 @@ extern void memtype_free_io(resource_size_t start, resource_size_t end);
 
 extern bool pat_pfn_immune_to_uc_mtrr(unsigned long pfn);
 
+bool x86_has_pat_wp(void);
+
 #endif /* _ASM_X86_MEMTYPE_H */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1bba16c..6005f83 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -71,6 +71,12 @@ uint8_t __pte2cachemode_tbl[8] = {
 };
 EXPORT_SYMBOL(__pte2cachemode_tbl);
 
+/* Check that the write-protect PAT entry is set for write-protect */
+bool x86_has_pat_wp(void)
+{
+	return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] == _PAGE_CACHE_MODE_WP;
+}
+
 static unsigned long __initdata pgt_buf_start;
 static unsigned long __initdata pgt_buf_end;
 static unsigned long __initdata pgt_buf_top;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 18c637c..41536f5 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -778,10 +778,8 @@ void __init *early_memremap_encrypted(resource_size_t phys_addr,
 void __init *early_memremap_encrypted_wp(resource_size_t phys_addr,
 					 unsigned long size)
 {
-	/* Be sure the write-protect PAT entry is set for write-protect */
-	if (__pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] != _PAGE_CACHE_MODE_WP)
+	if (!x86_has_pat_wp())
 		return NULL;
-
 	return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_ENC_WP);
 }
 
@@ -799,10 +797,8 @@ void __init *early_memremap_decrypted(resource_size_t phys_addr,
 void __init *early_memremap_decrypted_wp(resource_size_t phys_addr,
 					 unsigned long size)
 {
-	/* Be sure the write-protect PAT entry is set for write-protect */
-	if (__pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] != _PAGE_CACHE_MODE_WP)
+	if (!x86_has_pat_wp())
 		return NULL;
-
 	return early_memremap_prot(phys_addr, size, __PAGE_KERNEL_NOENC_WP);
 }
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
