Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F89C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB3C2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUudr8te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgFPH4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:56:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE6C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:56:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so1165860pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oQ1io/qQi+y3itntJsBYA2dRhXjx47tAO/g5lp+Xfc=;
        b=dUudr8tehj5H24uL5Ho0iwb+sZ5G6JJdKuZ/zEFCnEYnP0ATralz+E+Z8at+Z8YTJh
         ROT3Vnf0VnaKvwVQY2AdbYf9YmGavQkooUekLQkRuZykW0uHVxr4fC+R8O9NAHTympvy
         C1zyK5SJO9VhTxh5y3BLeq0yb3AnXqjj0dJmSvT+gpdYtVoXxG2fA6ZQRjyZ57VMhIWK
         6kLdGdvV2+vyWs5VUAJ3tYdVeKju9EG1K4rQnQF+O3/8Vp+kSc5lm9z7SEnarZZohFIt
         DWl0nIOa7kJ/aODibBgLCCK2xJ1JWkFjqA3hQ1nmIWRwU2B0k1dwPECsOyq4/KcfSjJM
         +BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oQ1io/qQi+y3itntJsBYA2dRhXjx47tAO/g5lp+Xfc=;
        b=K3i3JzQBhZRVe1i8Pcp4hE6Dn528DCmLchJo9SbkYPZfgj+jtAgf231C3frwT4oAR4
         EKFSn7EZ/0hwzpXoi9oVMP6DLVaoUuXrtib1zz4PNBuEDrL0jGNbZT694+UANeYbxoEH
         FqILGxk1utBMIhkcHE5GL8ZVIgFRWw6/hcbasbLZnyZ4F5xX+kmtIfLER840EN+D26cg
         QJaXCkoiu3/s51KXdpe7T9DI9m6YVeBsp2KtqVb2sgtxX8zoiYy/hVjPFnWFfsa0say3
         cLB8orWq1uaevP4u1P/E0wMOBTZJ0zpK4qfjlgb/wXG/o2Bb1f9fRbXIFnMvex88xBxX
         k7vw==
X-Gm-Message-State: AOAM530ISBqkh4r5xpUiGaGbb3g1ox4sX0zm422MYrOy8d49GhkNGWnZ
        w/UzAqU+KT25MKP9ei+wAJ0=
X-Google-Smtp-Source: ABdhPJyBbHCAFPTNgi+mnpbvSvrE+TrECh5PjtavYN/bmJ9l5eb5ApOgY5NzKWJ5Wy7Yqg/KjNDG+A==
X-Received: by 2002:a17:90b:23c6:: with SMTP id md6mr1884893pjb.122.1592294159866;
        Tue, 16 Jun 2020 00:55:59 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id g6sm16168984pfb.164.2020.06.16.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:55:59 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 4/6] arm64/vdso: Handle faults on timens page
Date:   Tue, 16 Jun 2020 00:55:43 -0700
Message-Id: <20200616075545.312684-5-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200616075545.312684-1-avagin@gmail.com>
References: <20200616075545.312684-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 57 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 14d5b7642b62..21bdd0d74f40 100644
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
@@ -166,15 +167,63 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	mmap_write_unlock(mm);
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
 
 static int __setup_additional_pages(enum vdso_abi abi,
-- 
2.24.1

