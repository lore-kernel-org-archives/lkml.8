Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA34C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB3320828
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 00:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCAAWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 19:22:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44643 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgCAAWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:22:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id j23so4904234qtr.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 16:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qshFldRB8YPASr29CwNccF5JOuFD0I3kQPBmVUj9i3E=;
        b=GWVGiA1NOcOTxW2B5WjKk53IeP6t6HfEgRjgHUclHwO+ZfsJ008R0aBBZ5uWd9RCmZ
         0Jy7wnJLCakuIZu/P//HMBcN8ft05K80RbGN0yAwZk18FUVY8Wvakvcl7rnXu9DnNzyC
         g8fIhhXlwtqDRwEvy1ffs7kpPTLE3bnsbifotChBEY5cCsw3TRfFFN7NFN2jQUxgm362
         qc0dzJu4fdKBaeldCL3M7bk3nzkyHCBJ3rxniivNOewMHKpqiRss6C2qfAi+0pCPYuW7
         RZdo/VtNpM2ROyK/4/j8gU7GMBzH8oM/0z5nbYiDEMCbvO4B/lkOzEslSYA7QpgTSN1/
         0xkQ==
X-Gm-Message-State: APjAAAVj7Wz/2TNhsjSWeqSRMV34b1Woq3XuLG/ZlqcqGA4y2vWkjBYx
        ZZy318IfWdB+rWtxVF4TMCqMW4eL7M0=
X-Google-Smtp-Source: APXvYqy3Vwc9teClEAbXOadl2PZOUAAd2uQthzN2aseTpywQ2ge+HlEu+sb5gkYPpSps4VMPEx1Yog==
X-Received: by 2002:aed:218f:: with SMTP id l15mr9944317qtc.247.1583022130405;
        Sat, 29 Feb 2020 16:22:10 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p16sm7602951qkp.12.2020.02.29.16.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 16:22:10 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Cc:     kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/mm/init_32: Stop printing the virtual memory layout
Date:   Sat, 29 Feb 2020 19:22:09 -0500
Message-Id: <20200301002209.1304982-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <202002291534.ED372CC@keescook>
References: <202002291534.ED372CC@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security, don't display the kernel's virtual memory layout.

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

