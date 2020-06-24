Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8315EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD8120823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuLWGAHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390384AbgFXIdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390347AbgFXId2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50560C061755
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z5so1086422pgb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/8shzvkLZsRhF8EZiKwRb8IF1NpqovkVn3jBNb1PgYM=;
        b=LuLWGAHbvAtYucC3BWurHeM1ccLgXcqjPYvzH4nrLZhaqZNRwbLU+BAqXwo9nAZakQ
         OlnmNWE/wAi55BiWJJeFq8T3XTxJ0V1JMtYMEyV4Mhdyq8MOBGWPRdOw8JVg5Zs+vopT
         GVUnEjOm7YQHarNfqJrqIIishg88JZlRTVyuxyoifLWAdu8Gi3KUSIo2upbLSqkaBcFb
         v1h4TNUpp1IZh6RG2r9dPj3zrEJIIr+p5yO3UAE5J0bRVcVQbBQ4YtotNxhoIbqRIZy3
         bCODgJ360ezsnoQtu8zOABWR2lffiYDpMA8G+CRVGt8xYV+9X+tBQ253tAB8EaYvU6vY
         PiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/8shzvkLZsRhF8EZiKwRb8IF1NpqovkVn3jBNb1PgYM=;
        b=jHHMSF/X3u3JuDOyvqUW8f9yDrzkRdxXEIdlUtgWNr2np1V8BHJbr6ElIT8/YAvhvb
         677PcNGxR5LJHRty8Mog0/WMoYURkzdIkZkd758iLZPXNgU4VZ+gaFeHZ9LT2rt1+1RY
         WkViKLendQagy+ClLr1uLycZmIQdJQLk/yJtVudeUPrdc8oP0RNd6EpzDMzzEm0Oy46h
         +p1zW7r8fuM7CelmWz3ID6XF7aukogvtpkp4DZLE/A9OGHSZ0o5cV9915RKzt48h9wJn
         8aY95awadxMZPxi8DnYTO35tjQ3le/OrDi3aBEWmvITB0YgLbzPWqCpNnGmHe4AukPoB
         SeMg==
X-Gm-Message-State: AOAM532Zh677UIZUk3wrh5tt+8DriiqkJfbn6VAWoZn7qvbVzsKFBgR/
        FafPyedp+boTAuXSa9yRDI4=
X-Google-Smtp-Source: ABdhPJzYJoJE7U5Ie3r319LMCTJWxMmY7lcknEIGWp2J7pdOc0e/Zdap0hYIF7xt/sfeYsFxWwNAxg==
X-Received: by 2002:a05:6a00:14d4:: with SMTP id w20mr29268187pfu.279.1592987607681;
        Wed, 24 Jun 2020 01:33:27 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g17sm4558614pju.11.2020.06.24.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:33:27 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 4/6] arm64/vdso: Handle faults on timens page
Date:   Wed, 24 Jun 2020 01:33:19 -0700
Message-Id: <20200624083321.144975-5-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200624083321.144975-1-avagin@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
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
index 18854e6c1373..be9ca8c46cff 100644
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
@@ -164,15 +165,63 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	mmap_read_unlock(mm);
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

