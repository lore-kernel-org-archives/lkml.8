Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C65C35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0CA21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG7g6CDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgBYHhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:37:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46674 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgBYHhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:37:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id k29so6700171pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sg/RdX3cnApG8KxqkYoz0JziOI+7hxQWlWjP9QA0+OY=;
        b=bG7g6CDSIPw+Dm3VI7iFviDISIYyxvfWj9Pl0agk37XSxmqnG5rCsKwBuWfymVraGU
         ssayjkKy90mnHv3wWpqR83zu96CHiZ+mWnq2iNOwaLTsqEW42Xp09oSLJ81Eh8i0mKLF
         fnEgZBf9486TV3tvM0zhksBqUE6skHGPmHY/7a5odVG/1w6Iw1IZMuPQgfblaq3iTLJ7
         x+VPSOq8x2HtpbZkWbFJ4ObJz/8hp5HwNRf6u4IU8feZhQOx194ntqH37grqvXpAE8PX
         Coj8g8QfWtcOF5ES/1p+ZzXeFkLbfR/9tBD+8/RbgFYWdzZPjjLK02GlcEuP0XcvqKHY
         z8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sg/RdX3cnApG8KxqkYoz0JziOI+7hxQWlWjP9QA0+OY=;
        b=b0P8xmgOF4PRfcN7YO+BZPd5Gv0jXGC8E/sv7Duq9PgjI7aUGPGhr3bv2DTrHoslp7
         1FGCoSSN4ZmhqaH0Oo5X6LPfwXeaEM4uWRI0OTELxC37GC7tQf+l5ho5iJiajBTZFjwG
         QRj7ztuNP/zQHkMVDzJdAMrS7bfV5PAJKk507GL082/KEoSQdClOGT/3AqFIDmkjX1v9
         r0Hxbgy7/w28XClXM4/7SFYvSA7jjGLqtkYM7hjI4aD1qUCADwNfY0/USqWJ5ynla6GW
         H8FA6HmROmii5g+66wwd9O7WDpQtqcXNlPzmwt2lvFSVPGdQI/3FIS0WbpabFFBbS/7Y
         Jwvw==
X-Gm-Message-State: APjAAAXpVNLUWKgOOrEUrqh71w4lmDLzI+l3ZI6zoEpkxy66NfhSirCF
        SiAfIZiPO24/j+DCBzn9nuA=
X-Google-Smtp-Source: APXvYqxIsjWOLBzTKLNKC3BCo8OjuyQYteq3bx+WPxxZJOKSjwatxv3mV1yfko8OVrPQEAf5RqkS6A==
X-Received: by 2002:a63:fe4f:: with SMTP id x15mr58115551pgj.30.1582616264731;
        Mon, 24 Feb 2020 23:37:44 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id m128sm15979390pfm.183.2020.02.24.23.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:37:44 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 4/6] arm64/vdso: Handle faults on timens page
Date:   Mon, 24 Feb 2020 23:37:29 -0800
Message-Id: <20200225073731.465270-5-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
References: <20200225073731.465270-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 57 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index b3e7ce24e59b..fb32c6f76078 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/time_namespace.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
@@ -175,15 +176,63 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	up_write(&mm->mmap_sem);
 	return 0;
 }
+
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm == current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops().
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+#else
+static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
 #endif
 
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	if (vmf->pgoff == 0)
-		return vmf_insert_pfn(vma, vmf->address,
-				sym_to_pfn(vdso_data));
-	return VM_FAULT_SIGBUS;
+	struct page *timens_page = find_timens_vvar_page(vma);
+	unsigned long pfn;
+
+	switch (vmf->pgoff) {
+	case VVAR_DATA_PAGE_OFFSET:
+		if (timens_page)
+			pfn = page_to_pfn(timens_page);
+		else
+			pfn = sym_to_pfn(vdso_data);
+		break;
+#ifdef CONFIG_TIME_NS
+	case VVAR_TIMENS_PAGE_OFFSET:
+		/*
+		 * If a task belongs to a time namespace then a namespace
+		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
+		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
+		 * offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (!timens_page)
+			return VM_FAULT_SIGBUS;
+		pfn = sym_to_pfn(vdso_data);
+		break;
+#endif /* CONFIG_TIME_NS */
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
 static int __setup_additional_pages(enum arch_vdso_type arch_index,
-- 
2.24.1

