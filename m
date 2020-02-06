Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94AC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF5D21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgBFPUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:20:07 -0500
Received: from david.siemens.de ([192.35.17.14]:41368 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbgBFPUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:20:07 -0500
X-Greylist: delayed 1443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 10:20:06 EST
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 016EtMPK029030
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 15:55:22 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 016EtJ6p029933;
        Thu, 6 Feb 2020 15:55:19 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: pat: Do not compile stubbed functions when X86_PAT is
 off
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
Date:   Thu, 6 Feb 2020 15:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Those are already provided by linux/io.h as stubs.

The conflict remains invisible until someone would pull {linux,asm}/io.h
into memtype.c.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/mm/pat/memtype.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 394be8611748..a695e17bd4c7 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -801,6 +801,7 @@ void memtype_free_io(resource_size_t start, resource_size_t end)
 	memtype_free(start, end);
 }
 
+#ifdef CONFIG_X86_PAT
 int arch_io_reserve_memtype_wc(resource_size_t start, resource_size_t size)
 {
 	enum page_cache_mode type = _PAGE_CACHE_MODE_WC;
@@ -814,6 +815,7 @@ void arch_io_free_memtype_wc(resource_size_t start, resource_size_t size)
 	memtype_free_io(start, start + size);
 }
 EXPORT_SYMBOL(arch_io_free_memtype_wc);
+#endif
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				unsigned long size, pgprot_t vma_prot)
-- 
2.16.4
