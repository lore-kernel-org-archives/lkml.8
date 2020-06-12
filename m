Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6676C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C88820801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgdWAc52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFLKSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLKSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:18:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5411C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:18:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so3681332pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I8rcc4Fi5o7Uwn4jFlTohkI2W1jA0XdMVsx4JTKvInA=;
        b=DgdWAc52qUHW0QO2vQRkS5OK0eZcrcZwTv+jc300q9Lm3/vVigkrhLZhFaf4rXCxLl
         Fw4SxoCpclxc0xjhdFrYWSEdFjTy6Y9uhr5xLlA/2nx9PC7nHq0obY2ToIRtRxLG5qom
         0jiFLMjyiBbkW+F6urrzVsbTXJxhJYEoHZvxG7TUeU+mKwCj5+Hg4xy+rGSxZEJiqMfK
         KeveYpeOrUlpVGFT0is8Mbon5aHtSv9VrXTYmiebtktm3Fy52+UXoHvHdF74W6VE7ZtK
         5AyxD9+e2ui8mBne/qaO7I1I+bjr0lR8oSSGB7ad29dkqEeDLRaIhyTHnWZbI/89Cd7S
         D/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8rcc4Fi5o7Uwn4jFlTohkI2W1jA0XdMVsx4JTKvInA=;
        b=NNupwqouo5fwqvDXPDJ7RbceAGO2OJcMgih1RBLblspvNis/k+Sehh3fFmyqZe8yRo
         dfS9bR1viPlQ4kc2LQluzO3PX38Hzlf7Ak/qPF2FUARlJqG7FPp7QN7OBDmRoL8qNNtp
         VuSTbEsefXHX+8Q656L6n5IQV9VHgI2LAUhFh118nQh6utjqlRHFNJfrl0sMd+GBTd8/
         enx2+fRKDzCJmq+av/n2JUetunWA2OG8aC9mzmX0xlLLW8hm0DpRRaxmuqnccg75goIF
         uWV8WQfGgjWl8SfATPDeswTb/Gj7i7bOXat8HSZ168pvRqScjTWn9X4hIwlJF1VnpVHQ
         wPyA==
X-Gm-Message-State: AOAM5328/jsjt/rWdt9TRgdqNw9gZSQ38LS2pd6/SqW2dB86q3MAzmnf
        ExaYP31CMCJR38drR6qMywQbEx4E
X-Google-Smtp-Source: ABdhPJxDcxIaQFRYqu4WrCUanxXZ6fYRpyraUeJVKyDwoLUJ9yotK1sxA3W4BJpkbF4PmEw24AYJ0A==
X-Received: by 2002:a17:90a:8c14:: with SMTP id a20mr12203650pjo.83.1591957079031;
        Fri, 12 Jun 2020 03:17:59 -0700 (PDT)
Received: from localhost ([49.205.222.116])
        by smtp.gmail.com with ESMTPSA id p30sm3146966pfq.59.2020.06.12.03.17.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 03:17:58 -0700 (PDT)
Date:   Fri, 12 Jun 2020 15:47:56 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_{from,to}_user() uaccess helpers are implemented by user page
pinning, followed by temporary kernel mapping & then memcpy(). This
helps to achieve user page copy when current virtual address mapping
of the CPU excludes user pages.

Performance wise, results are not encouraging, 'dd' on tmpfs results,

ARM Cortex-A8, BeagleBone White (256MiB RAM):
w/o series - ~29.5 MB/s
w/ series - ~20.5 MB/s
w/ series & highmem disabled - ~21.2 MB/s

On Cortex-A15(2GiB RAM) in QEMU:
w/o series - ~4 MB/s
w/ series - ~2.6 MB/s

Roughly a one-third drop in performance. Disabling highmem improves
performance only slightly.

'hackbench' also showed a similar pattern.

uaccess routines using page pinning & temporary kernel mapping is not
something new, it has been done long long ago by Ingo [1] as part of
4G/4G user/kernel mapping implementation on x86, though not merged in
mainline.

[1] https://lore.kernel.org/lkml/Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain/

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 lib/Kconfig                   |   4 +
 lib/Makefile                  |   3 +
 lib/uaccess_gup_kmap_memcpy.c | 162 ++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 lib/uaccess_gup_kmap_memcpy.c

diff --git a/lib/Kconfig b/lib/Kconfig
index 5d53f9609c252..dadf4f6cc391d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -622,6 +622,10 @@ config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
 config UACCESS_MEMCPY
 	bool
 
+# pin page + kmap_atomic + memcpy for user copies, intended for vmsplit 4g/4g
+config UACCESS_GUP_KMAP_MEMCPY
+	bool
+
 config ARCH_HAS_UACCESS_FLUSHCACHE
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 685aee60de1d5..bc457f85e391a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -309,3 +309,6 @@ obj-$(CONFIG_OBJAGG) += objagg.o
 
 # KUnit tests
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
+
+# uaccess
+obj-$(CONFIG_UACCESS_GUP_KMAP_MEMCPY) += uaccess_gup_kmap_memcpy.o
diff --git a/lib/uaccess_gup_kmap_memcpy.c b/lib/uaccess_gup_kmap_memcpy.c
new file mode 100644
index 0000000000000..1536762df1fd5
--- /dev/null
+++ b/lib/uaccess_gup_kmap_memcpy.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+// Started from arch/um/kernel/skas/uaccess.c
+
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+static int do_op_one_page(unsigned long addr, int len,
+		 int (*op)(unsigned long addr, int len, void *arg), void *arg,
+		 struct page *page)
+{
+	int n;
+
+	addr = (unsigned long) kmap_atomic(page) + (addr & ~PAGE_MASK);
+	n = (*op)(addr, len, arg);
+	kunmap_atomic((void *)addr);
+
+	return n;
+}
+
+static long buffer_op(unsigned long addr, int len,
+		      int (*op)(unsigned long, int, void *), void *arg,
+		      struct page **pages)
+{
+	long size, remain, n;
+
+	size = min(PAGE_ALIGN(addr) - addr, (unsigned long) len);
+	remain = len;
+	if (size == 0)
+		goto page_boundary;
+
+	n = do_op_one_page(addr, size, op, arg, *pages);
+	if (n != 0) {
+		remain = (n < 0 ? remain : 0);
+		goto out;
+	}
+
+	pages++;
+	addr += size;
+	remain -= size;
+
+page_boundary:
+	if (remain == 0)
+		goto out;
+	while (addr < ((addr + remain) & PAGE_MASK)) {
+		n = do_op_one_page(addr, PAGE_SIZE, op, arg, *pages);
+		if (n != 0) {
+			remain = (n < 0 ? remain : 0);
+			goto out;
+		}
+
+		pages++;
+		addr += PAGE_SIZE;
+		remain -= PAGE_SIZE;
+	}
+	if (remain == 0)
+		goto out;
+
+	n = do_op_one_page(addr, remain, op, arg, *pages);
+	if (n != 0) {
+		remain = (n < 0 ? remain : 0);
+		goto out;
+	}
+
+	return 0;
+out:
+	return remain;
+}
+
+static int copy_chunk_from_user(unsigned long from, int len, void *arg)
+{
+	unsigned long *to_ptr = arg, to = *to_ptr;
+
+	memcpy((void *) to, (void *) from, len);
+	*to_ptr += len;
+	return 0;
+}
+
+static int copy_chunk_to_user(unsigned long to, int len, void *arg)
+{
+	unsigned long *from_ptr = arg, from = *from_ptr;
+
+	memcpy((void *) to, (void *) from, len);
+	*from_ptr += len;
+	return 0;
+}
+
+unsigned long gup_kmap_copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	struct page **pages;
+	int num_pages, ret, i;
+
+	if (uaccess_kernel()) {
+		memcpy(to, (__force void *)from, n);
+		return 0;
+	}
+
+	num_pages = DIV_ROUND_UP((unsigned long)from + n, PAGE_SIZE) -
+				 (unsigned long)from / PAGE_SIZE;
+	pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL | __GFP_ZERO);
+	if (!pages)
+		goto end;
+
+	ret = get_user_pages_fast((unsigned long)from, num_pages, 0, pages);
+	if (ret < 0)
+		goto free_pages;
+
+	if (ret != num_pages) {
+		num_pages = ret;
+		goto put_pages;
+	}
+
+	n = buffer_op((unsigned long) from, n, copy_chunk_from_user, &to, pages);
+
+put_pages:
+	for (i = 0; i < num_pages; i++)
+		put_page(pages[i]);
+free_pages:
+	kfree(pages);
+end:
+	return n;
+}
+
+unsigned long gup_kmap_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	struct page **pages;
+	int num_pages, ret, i;
+
+	if (uaccess_kernel()) {
+		memcpy((__force void *) to, from, n);
+		return 0;
+	}
+
+	num_pages = DIV_ROUND_UP((unsigned long)to + n, PAGE_SIZE) - (unsigned long)to / PAGE_SIZE;
+	pages = kmalloc_array(num_pages, sizeof(*pages), GFP_KERNEL | __GFP_ZERO);
+	if (!pages)
+		goto end;
+
+	ret = get_user_pages_fast((unsigned long)to, num_pages, FOLL_WRITE, pages);
+	if (ret < 0)
+		goto free_pages;
+
+	if (ret != num_pages) {
+		num_pages = ret;
+		goto put_pages;
+	}
+
+
+	n = buffer_op((unsigned long) to, n, copy_chunk_to_user, &from, pages);
+
+put_pages:
+	for (i = 0; i < num_pages; i++)
+		put_page(pages[i]);
+free_pages:
+	kfree(pages);
+end:
+	return n;
+}
-- 
2.26.2

