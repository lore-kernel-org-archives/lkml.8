Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20442C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF6B20801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgCEPBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:01:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35116 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:01:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id 145so5566986qkl.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+99kCRYMzeEWVxPvUrg7nF1DV74zPu+cLQl+vuE6tE=;
        b=G/jeIy0iAn/fK9fqqOvAKBEuynpNzfpPvPjc2JDNeGOlRGFarZ6Gz72xf7WEsyI3SY
         yFCVaPdGuS42LMy59qn27qo/UlzxFkZYclYBqc2zWw/zHfhJ/4KmGJytnr3xdfgGKQuy
         6hr0eUMCULvQajSo36YYEIFXtsE1AzM0WQn8yLVkG+9mAPVnbncFhOrvazcu2Hyw33N6
         2/NKzt8Qvw504nz+aOlVNkPisQdca1pXBwxggl9kXqXy9RHqsHhyMgrjDQjyRNNW94YW
         hhNDzDBnu0RZMKusgJBB2BJmwefig0Nkox893MLAPzVuRTgZGikZ1rDxlzfoJXRmFU8a
         D2Yw==
X-Gm-Message-State: ANhLgQ0IFlPGybEmCYyh6xI1AqBxaucPcxX0rCcSbVIWzIPxgnwNLDFL
        aPal+1Hkt43WBIZrxNTUAv8=
X-Google-Smtp-Source: ADFU+vun+lE3H+kFlVWifa921exuOdYo+CsuSTA28nIHTavPtrQtBcLZ/jpFo/8YRdLeTKv6qbbgJg==
X-Received: by 2002:a37:a14a:: with SMTP id k71mr8329570qke.321.1583420513686;
        Thu, 05 Mar 2020 07:01:53 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n8sm15800581qke.37.2020.03.05.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:01:52 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/mm/init_32: Stop printing the virtual memory layout
Date:   Thu,  5 Mar 2020 10:01:52 -0500
Message-Id: <20200305150152.831697-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <202003021039.257258E1B@keescook>
References: <202003021039.257258E1B@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security, don't display the kernel's virtual memory layout.

Kees Cook points out:
"These have been entirely removed on other architectures, so let's
just do the same for ia32 and remove it unconditionally."

071929dbdd86 ("arm64: Stop printing the virtual memory layout")
1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/mm/init_32.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 23df4885bbed..8ae0272c1c51 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -788,44 +788,6 @@ void __init mem_init(void)
 	x86_init.hyper.init_after_bootmem();
 
 	mem_init_print_info(NULL);
-	printk(KERN_INFO "virtual kernel memory layout:\n"
-		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"  cpu_entry : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#ifdef CONFIG_HIGHMEM
-		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
-		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
-		FIXADDR_START, FIXADDR_TOP,
-		(FIXADDR_TOP - FIXADDR_START) >> 10,
-
-		CPU_ENTRY_AREA_BASE,
-		CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_MAP_SIZE,
-		CPU_ENTRY_AREA_MAP_SIZE >> 10,
-
-#ifdef CONFIG_HIGHMEM
-		PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
-		(LAST_PKMAP*PAGE_SIZE) >> 10,
-#endif
-
-		VMALLOC_START, VMALLOC_END,
-		(VMALLOC_END - VMALLOC_START) >> 20,
-
-		(unsigned long)__va(0), (unsigned long)high_memory,
-		((unsigned long)high_memory - (unsigned long)__va(0)) >> 20,
-
-		(unsigned long)&__init_begin, (unsigned long)&__init_end,
-		((unsigned long)&__init_end -
-		 (unsigned long)&__init_begin) >> 10,
-
-		(unsigned long)&_etext, (unsigned long)&_edata,
-		((unsigned long)&_edata - (unsigned long)&_etext) >> 10,
-
-		(unsigned long)&_text, (unsigned long)&_etext,
-		((unsigned long)&_etext - (unsigned long)&_text) >> 10);
 
 	/*
 	 * Check boundaries twice: Some fundamental inconsistencies can
-- 
2.24.1

