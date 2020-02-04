Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476E0C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9E02084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/jQpv2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgBDR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:59:29 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33772 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbgBDR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:59:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id m7so1060002pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/tatmAbPqQvnbldAouTM/R8vE/FozyyVbJhnSwJXGA=;
        b=m/jQpv2JIjMmYb0com4+E9ygLdFliyeNs30azzuB5uZxmGdg2Z6m6ZNxWcUsWuV/58
         a/IYICceuBaOBCgC5vHB1M3Jd8ov0ZRQT07oApqu7FdsVSYpwcxaE7bmxkWzs1URLwwk
         OwaD4YOFmg4eX2KSoNfwnkbvyGlH4m9IfKZ/75I3RkdIbKGQOz8Vkr3RbNDIgyNugFeX
         4ubvJkQ2YxE9geC4va10CzZfuDAe5NXvu5zbP1vIrNorrYvodKAKH04QZ5nPkGJ0v0A2
         IZiSap0cjNjQ7ZwaeUo3lB1kD7GRcAn9Q7ywK3zOwnE5nNbWCy76F70T1AFe2UZ0qvIt
         cDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/tatmAbPqQvnbldAouTM/R8vE/FozyyVbJhnSwJXGA=;
        b=h99fc/NrscsrVI/2y2J+8I6rvgswszSY91nUC10ucKdE8pKVLg0hT5ZjWiZ97qoC4Z
         LeGX2NbrajDmF7aCDnuRavNcY6g9IkSrPYMhXvgx08chJFbXaA365nJmnqvKiMAoFCag
         UcCkTIPfxPo+eW7t51rOEltCQ5RsKVvFkbWhwZc3E7anbrhb8MUL0UlR6WkdI99CsPzJ
         ww7GL1UgF+2N2xXXDE1ucHUVOWSavBDaPOuHsZ0B8vkCvGRDFeVj9Cm3iQqbVogVbhyi
         idcPMQ5C/6YCk73J6+SH3MSNL7x6SNaXKSM+JLfBCwJTEdQodXGZTl3pCId63whbt3Ft
         5bwQ==
X-Gm-Message-State: APjAAAU6ZhPwA+sYJWNyz9NWohRdE9Qwl1WSOTJyIzrc0sL4XVnWDwcK
        adEE5Xp2TEXZAshi/GUE0vq+D4vv1FM=
X-Google-Smtp-Source: APXvYqz/wsrLImmXNuI6MmUGKvGiwMhcKuUinmHKrZOCjZ8lY4eaVm8L+1GK00GJH3It8luUkRKQ+Q==
X-Received: by 2002:a17:90b:4015:: with SMTP id ie21mr334038pjb.1.1580839168199;
        Tue, 04 Feb 2020 09:59:28 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id d73sm25414465pfd.109.2020.02.04.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 09:59:27 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 4/5] arm64/vdso: Handle faults on timens page
Date:   Tue,  4 Feb 2020 09:59:12 -0800
Message-Id: <20200204175913.74901-5-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200204175913.74901-1-avagin@gmail.com>
References: <20200204175913.74901-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 55 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index bc93e26ae485..2e553468b183 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -23,6 +23,7 @@
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
+#include <linux/time_namespace.h>
 
 #include <asm/cacheflush.h>
 #include <asm/signal32.h>
@@ -171,15 +172,61 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
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
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
 static int __setup_additional_pages(enum arch_vdso_type arch_index,
-- 
2.24.1

