Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3879C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D454D2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki4VmJyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406672AbgDPF1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406491AbgDPF0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:26:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2BBC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so865656pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HkFB2IFB6eu4Qsibzpvaj5eV40S/BQoyfyZyOgKqRdU=;
        b=Ki4VmJyQMAakb5h1e5GCup2A4dLJWYNrW9MVsygLyscRN0NtUNWyro1UJ79U6GamhL
         wCx0wQUMRrNE+eoV514UXPJfpSWfXwd/3IHLfUk7UWgk8sO0sytG8qn9wMNCphu5wfoA
         j8s/9IqOnvtdc3P7CFy4kIIh1PUcLynMIEp7OJR0DVd8pp4f+MPRtnxtR5va94odSYpX
         yG+5UUBFUvYTREJAAkL8dHdRh4P+ezpXrpSV6EMhdTIK779brbdv0TyVZT7Xs0Zh7uA+
         e0GzurT7JqT08V+9p9slejCqK9EsZHcZH7RkNygBLU+Mw0QM+4veSdGqdPob9bxI2R0a
         feNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HkFB2IFB6eu4Qsibzpvaj5eV40S/BQoyfyZyOgKqRdU=;
        b=HaqnlZxIXHxOHW8w6m8Y2lhh01KDJ7raomKsXL6JJKugzv8aPWQ8BjUSNb06SqQvzq
         rij4d/lT9iefvhNQKR25pEofMV4GUKfFRMNApb4ZhTZ7DzTSS2dNnP3h8qyHLA8762um
         PPZfyoFxZZIh5nKuxg62CEugk3CJdyQA98oPM4/Q6gAqq74i1t14iXi/5JdoCY55ehAD
         5pJ2VtwhxGpSZarGo5zl/DWOhS027l02VHd3jBV2MSiZ363EsdYtKJSBe1UZicmc4+pu
         C27eZgnPsEWLQXrZpOIdX+4qDSgz+FnHohBzIcDmw1U0prmit8g6Ty+FIHc2S8gF9m3S
         qIxQ==
X-Gm-Message-State: AGi0PuZO0EsWuTvwQTF3tWvPuVxjRoxkEK+gnpC3hbZDXaKZOOX3tJXI
        ZZtiGzL3TAJATZdm49GKItQ=
X-Google-Smtp-Source: APiQypJl6jnFydHzld8Y6PdrjF3ChQCmvwCzlPXym6IsyBAFXmPGRV+0P3/LzKyTAxQ+iI6harv6Sw==
X-Received: by 2002:a17:90b:19c9:: with SMTP id nm9mr3171152pjb.86.1587014806945;
        Wed, 15 Apr 2020 22:26:46 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c21sm53699pjr.2.2020.04.15.22.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:26:46 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4/6] arm64/vdso: Handle faults on timens page
Date:   Wed, 15 Apr 2020 22:26:16 -0700
Message-Id: <20200416052618.804515-5-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200416052618.804515-1-avagin@gmail.com>
References: <20200416052618.804515-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
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

