Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8622073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCEPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:10:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42772 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgCEPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:10:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id e11so5565750qkg.9;
        Thu, 05 Mar 2020 07:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjlqsulZ8K9prSopQV0I1fobX6NO06lX2v06DPlECEg=;
        b=foFNtqfr7y4gokHOziQZidILEolu/UP287zItw72f8Rybfc+Ytfw3o4S1qJwUPrvi2
         pb/yPQS7ZJygSBXyl0HJcPb59v8lfQ/4uhWMZ+xDmhfr2wnlUqHvBuLfYkG5qqiFyAu9
         eMvY5wMOauZcOVWcjwDV5NMxw0NSJG4OmAwmAltEHEHiOFIMe66T/OPgYxLJMJNPLVaT
         dl0YP3ItdL8ZvDwFARLCQ7Yrk3KPO1d8rDaDb5P73RkSQkP28/9X4MK4Fr7ECDXYWZJm
         84cczQ7VXBpqHszO4qxM+2ddcFWvnXV1julg5XOjTwdEa7zs+l+hZkLTS3XzmauP2riZ
         Agew==
X-Gm-Message-State: ANhLgQ3dziKYt9fNHW+61nFmtg58khlx7SGX8mGDzaGG5EhhKzUGtaiR
        hvcr7Ldt723zqEa79RfQ+hM=
X-Google-Smtp-Source: ADFU+vtlP7URSdOBinGRLUa/NfZvf3ez4vGHwQVZBV9W6KWtOQr25JZI77VoRkEQCD2epaYXZ5MIIg==
X-Received: by 2002:ae9:e812:: with SMTP id a18mr8535338qkg.455.1583421012246;
        Thu, 05 Mar 2020 07:10:12 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l6sm16004184qti.10.2020.03.05.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:10:11 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: Stop printing the virtual memory layout
Date:   Thu,  5 Mar 2020 10:10:10 -0500
Message-Id: <20200305151010.835954-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <202003021038.8F0369D907@keescook>
References: <202003021038.8F0369D907@keescook>
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
 arch/sh/mm/init.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index d1b1ff2be17a..e68a1106e99b 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -360,47 +360,6 @@ void __init mem_init(void)
 	vsyscall_init();
 
 	mem_init_print_info(NULL);
-	pr_info("virtual kernel memory layout:\n"
-		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#ifdef CONFIG_HIGHMEM
-		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
-		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB) (cached)\n"
-#ifdef CONFIG_UNCACHED_MAPPING
-		"            : 0x%08lx - 0x%08lx   (%4ld MB) (uncached)\n"
-#endif
-		"      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
-		FIXADDR_START, FIXADDR_TOP,
-		(FIXADDR_TOP - FIXADDR_START) >> 10,
-
-#ifdef CONFIG_HIGHMEM
-		PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
-		(LAST_PKMAP*PAGE_SIZE) >> 10,
-#endif
-
-		(unsigned long)VMALLOC_START, VMALLOC_END,
-		(VMALLOC_END - VMALLOC_START) >> 20,
-
-		(unsigned long)memory_start, (unsigned long)high_memory,
-		((unsigned long)high_memory - (unsigned long)memory_start) >> 20,
-
-#ifdef CONFIG_UNCACHED_MAPPING
-		uncached_start, uncached_end, uncached_size >> 20,
-#endif
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
-
 	mem_init_done = 1;
 }
 
-- 
2.24.1

