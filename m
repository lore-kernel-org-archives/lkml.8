Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B53C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 01:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C64206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 01:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGMv+XNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCGBEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 20:04:00 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:54615 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCGBEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 20:04:00 -0500
Received: by mail-pj1-f74.google.com with SMTP id p3so2253782pjo.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 17:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k5PT9JxXBQpJJ/C+GDUX6jmWCcLXzOHs3ae3IdX3WEA=;
        b=sGMv+XNGTDlZ6FFrxPT9k1fNcQ7yH1R47bkY7h+ZdX2oLVSEpzVb82XJJKsZpuOLBr
         3XWBoUv4Cd+TSerOyyV2W+cJUZUCVds+NnD4TGu4dGNdXOZUQJh4Le3IWSNX2JIaNgMj
         yAqhO69Na7nSUOarO+5WrB8RNE8k4e1g8oZh/8oiORq60a/igK/nF/7Hpf4NnKFDXnsb
         SCS7kylOeEpQdWySpXtj58F+IS927YQZXeJq5/0LsrBkPSr0W8q5B7265BTWUNhGA5vH
         d5npvPYhCaQfB2y3MLr3BMjN4NUGZOARdQmPwovvMATvop+M9DdjvS34jQdYVBgU4ryF
         nndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k5PT9JxXBQpJJ/C+GDUX6jmWCcLXzOHs3ae3IdX3WEA=;
        b=NFeot+8h92Ywbu/12YTa8m1LOcLO2A/uCuXKYv1yfhN7Sa9sfyD/EELBz/Y6EsKrCj
         4Asd01enGvgAIN9pC3rh1QzWzSYYiiYIUStofKayrohfNbZSdSFLCOzeStwzJJ+4lSWO
         v9xgtJdMV809rey8QUCTGoOiIX60oudxl58wjTVHEi27TuEN65VBM/tjJvSDFgBYRQdC
         zbe4e91W5tXFoP2KfhkCKIE3+UOynds7O1cQ82InJP0bmpv4V/h+EP7FpsuXUDPTrZNj
         bfx+SIeR60qWZ1P0qF7idGwZAZLFZjIHQZn8juPfAyCx2wGupcZiLludDnfm0aruhWfW
         NHEQ==
X-Gm-Message-State: ANhLgQ2mkqT8dsF87mfMSV9+yWPX2JbXrzhy4SPkJOShDk5zor5toXS7
        D7xAq1B3H0HzcOfQvFoZNLIoyRhP0//zBVm+tTri+Q==
X-Google-Smtp-Source: ADFU+vvUOr966MeOJZYRYgzhAZ75k+n47egEVLnv6WjuAOclWUGWEQ9SauBzgRdPPwfykGBiVmc6LtU0PW/z0Mv/er0g5w==
X-Received: by 2002:a63:1862:: with SMTP id 34mr2622428pgy.191.1583543037600;
 Fri, 06 Mar 2020 17:03:57 -0800 (PST)
Date:   Fri,  6 Mar 2020 17:03:53 -0800
Message-Id: <20200307010353.172991-1-cannonmatthews@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] mm: clear 1G pages with streaming stores on x86
From:   Cannon Matthews <cannonmatthews@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement clear_gigantic_page() to clear gigabytes pages using the
non-temporal streaming store instructions that bypass the cache
(movnti), since an entire 1GiB region will not fit in the cache anyway.

Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
and optimizing the control flow over the constituent small pages, this
can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
taking only 34 seconds on average, or 67ms/GiB.

The assembly code for the __clear_page_nt routine is more or less
taken directly from the output of gcc with -O3 for this function with
some tweaks to support arbitrary sizes and moving memory barriers:

void clear_page_nt_64i (void *page)
{
  for (int i = 0; i < GiB /sizeof(long long int); ++i)
    {
      _mm_stream_si64 (((long long int*)page) + i, 0);
    }
  sfence();
}

Tested:
	Time to `mlock()` a 512GiB region on broadwell CPU
				AVG time (s)	% imp.	ms/page
	clear_page_erms		133.584		-	261
	clear_page_nt		34.154		74.43%	67

An earlier version of this code was sent as an RFC patch ~July 2018
https://patchwork.kernel.org/patch/10543193/ but never merged.

Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
---
 MAINTAINERS                        |  1 +
 arch/x86/Kconfig                   |  4 ++++
 arch/x86/include/asm/page_64.h     |  1 +
 arch/x86/lib/Makefile              |  2 +-
 arch/x86/lib/clear_gigantic_page.c | 28 ++++++++++++++++++++++++++++
 arch/x86/lib/clear_page_64.S       | 19 +++++++++++++++++++
 include/linux/mm.h                 |  2 ++
 mm/memory.c                        |  2 ++
 8 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/lib/clear_gigantic_page.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68eebf3650ac..efe84f085404 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7702,6 +7702,7 @@ S:	Maintained
 F:	fs/hugetlbfs/
 F:	mm/hugetlb.c
 F:	include/linux/hugetlb.h
+F:	arch/x86/lib/clear_gigantic_page.c
 F:	Documentation/admin-guide/mm/hugetlbpage.rst
 F:	Documentation/vm/hugetlbfs_reserv.rst
 F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index beea77046f9b..f49e7b6f6851 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -70,6 +70,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_CLEAR_GIGANTIC_PAGE	if X86_64
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
@@ -290,6 +291,9 @@ config ARCH_MAY_HAVE_PC_FDC
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
+config ARCH_HAS_CLEAR_GIGANTIC_PAGE
+	bool
+
 config ARCH_HAS_CPU_RELAX
 	def_bool y
 
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 939b1cff4a7b..6ea60883b6d6 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -55,6 +55,7 @@ static inline void clear_page(void *page)
 }
 
 void copy_page(void *to, void *from);
+void clear_page_nt(void *page, u64 page_size);
 
 #endif	/* !__ASSEMBLY__ */
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 5246db42de45..a620c6636210 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -56,7 +56,7 @@ endif
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
-        lib-y += clear_page_64.o copy_page_64.o
+        lib-y += clear_page_64.o copy_page_64.o clear_gigantic_page.o
         lib-y += memmove_64.o memset_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
diff --git a/arch/x86/lib/clear_gigantic_page.c b/arch/x86/lib/clear_gigantic_page.c
new file mode 100644
index 000000000000..6fcb494ec9bc
--- /dev/null
+++ b/arch/x86/lib/clear_gigantic_page.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/page.h>
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+
+void clear_gigantic_page(struct page *page, unsigned long addr,
+			 unsigned int pages)
+{
+	int i;
+	void *dest = page_to_virt(page);
+
+	/*
+	 * cond_resched() every 2M. Hypothetical page sizes not divisible by
+	 * this are not supported.
+	 */
+	BUG_ON(pages % HPAGE_PMD_NR != 0);
+	for (i = 0; i < pages; i += HPAGE_PMD_NR) {
+		clear_page_nt(dest + (i * PAGE_SIZE), HPAGE_PMD_NR * PAGE_SIZE);
+		cond_resched();
+	}
+	/* clear_page_nt requires an `sfence` barrier. */
+	wmb();
+}
+#endif /* defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS) */
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index c4c7dd115953..1224094fd863 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -50,3 +50,22 @@ SYM_FUNC_START(clear_page_erms)
 	ret
 SYM_FUNC_END(clear_page_erms)
 EXPORT_SYMBOL_GPL(clear_page_erms)
+
+/*
+ * Zero memory using non temporal stores, bypassing the cache.
+ * Requires an `sfence` (wmb()) afterwards.
+ * %rdi - destination.
+ * %rsi - page size. Must be 64 bit aligned.
+*/
+SYM_FUNC_START(clear_page_nt)
+	leaq	(%rdi,%rsi), %rdx
+	xorl	%eax, %eax
+	.p2align 4,,10
+	.p2align 3
+.L2:
+	movnti	%rax, (%rdi)
+	addq	$8, %rdi
+	cmpq	%rdx, %rdi
+	jne	.L2
+	ret
+SYM_FUNC_END(clear_page_nt)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..a57f9007374b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2856,6 +2856,8 @@ enum mf_action_page_type {
 };
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
+extern void clear_gigantic_page(struct page *page, unsigned long addr,
+				unsigned int pages);
 extern void clear_huge_page(struct page *page,
 			    unsigned long addr_hint,
 			    unsigned int pages_per_huge_page);
diff --git a/mm/memory.c b/mm/memory.c
index e8bfdf0d9d1d..2a13bf102890 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4706,6 +4706,7 @@ static inline void process_huge_page(
 	}
 }
 
+#ifndef CONFIG_ARCH_HAS_CLEAR_GIGANTIC_PAGE
 static void clear_gigantic_page(struct page *page,
 				unsigned long addr,
 				unsigned int pages_per_huge_page)
@@ -4720,6 +4721,7 @@ static void clear_gigantic_page(struct page *page,
 		clear_user_highpage(p, addr + i * PAGE_SIZE);
 	}
 }
+#endif  /* CONFIG_ARCH_HAS_CLEAR_GIGANTIC_PAGE */
 
 static void clear_subpage(unsigned long addr, int idx, void *arg)
 {
-- 
2.25.1.481.gfbce0eb801-goog

