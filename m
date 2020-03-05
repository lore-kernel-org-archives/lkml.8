Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A3DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D672073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCEPIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:08:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41493 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCEPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:08:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so4340377qtr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1v7KEH8H8EEgDnDnnlGNlXFsnNQAqOhZZNudokQ2Po=;
        b=mfoETpWWds7ePSzqjESKiAvEl/+kjaCgdug7r1ir9LYBmm1A3RcL+t6lcdy3ZqHjcD
         lUxSdXwilih+5r1vUT1NKGO668Agn/GONl0MSUir1ZlvtMRBebDY3yNk+joSkc4fkmpD
         sIYS8EZUon/+ahjpaNx70vmJbnc5QQi1L8WCsNhr5rOuY0/a3iUeMaBLcvjHyEXfCghx
         dl1Akt9P4KsPYXBIjtOL/o6Xb+D8xocPW8FQ+9mPYC9Zhp6rfjru75URPxNX9LxiVeWC
         vRmOzuCoMIlJfu7wjBlvOEOpQeXsNA+UJVJUjdZjgVhSQEZm4mC7GLZfoWkG+HliLaH9
         AJfA==
X-Gm-Message-State: ANhLgQ2mEJOziBNYkNpfSIsWCD3HqUqsDGWDjgmXXW9wiSOJzTDfNuoG
        A1gbKwheMP5j+EPig5nIyfA=
X-Google-Smtp-Source: ADFU+vuOS2xZwbWZs6qEQtovSh6AUFl9WlSPml+IgYmIWtqCd0kt/sKG334d9lzu+FpmW4dkIw7TEw==
X-Received: by 2002:ac8:4408:: with SMTP id j8mr7637069qtn.3.1583420918447;
        Thu, 05 Mar 2020 07:08:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n46sm266850qtb.48.2020.03.05.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:08:37 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/32: Stop printing the virtual memory layout
Date:   Thu,  5 Mar 2020 10:08:37 -0500
Message-Id: <20200305150837.835083-1-nivedita@alum.mit.edu>
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
 arch/powerpc/mm/mem.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index ef7b1119b2e2..df2c143b6bf7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -331,23 +331,6 @@ void __init mem_init(void)
 #endif
 
 	mem_init_print_info(NULL);
-#ifdef CONFIG_PPC32
-	pr_info("Kernel virtual memory layout:\n");
-#ifdef CONFIG_KASAN
-	pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
-		KASAN_SHADOW_START, KASAN_SHADOW_END);
-#endif
-	pr_info("  * 0x%08lx..0x%08lx  : fixmap\n", FIXADDR_START, FIXADDR_TOP);
-#ifdef CONFIG_HIGHMEM
-	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
-		PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
-#endif /* CONFIG_HIGHMEM */
-	if (ioremap_bot != IOREMAP_TOP)
-		pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
-			ioremap_bot, IOREMAP_TOP);
-	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
-		VMALLOC_START, VMALLOC_END);
-#endif /* CONFIG_PPC32 */
 }
 
 void free_initmem(void)
-- 
2.24.1

