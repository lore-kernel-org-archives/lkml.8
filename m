Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32576C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF82074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuUGPGEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFBSDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:03:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F5C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:03:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p21so5434928pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QGD1nesqWyjyIgD1rTMvSAFAGLyEEfpYf/1KB187E2U=;
        b=VuUGPGEoUPTURf3RYtx8Z5AxOLk+4ls2cqG0NCwDdNNrLuavo7E/67YQMT5DYSBitj
         DcxdX+4jvlaoTt9LHsCu9HGbMyZHqQ6bVCSFaB8adeIRJm4fYzmR31+I5r3RCSP+amp9
         Pk9bR/KKzgVT3IRovnElkSO1N87zEp8wXAQZNx1nk54spjwa7E50kcADlKGaec7JO5BU
         2ltsrKE+wN67Y4f+JCgLF3gJ8QtqQfDUZNJSqnZvmO+DgSRj/YF6/iyS8GIczHHE0RJj
         ZFCYC0aiCiiKNi5M5a43bEI7CwXFp6IEhnQlUwkt7XtDd9GX3rQhMsJer4wWS70asgJA
         iANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QGD1nesqWyjyIgD1rTMvSAFAGLyEEfpYf/1KB187E2U=;
        b=ia643B6+kmRBkX0DmUjusu1B7z9S4QPCO4aDtAo15MrkJTe/bpJZ+E9V8KTgEbcHTg
         B9mteyDMfUvAIUcYW8v2GV7BQgX2XgGIC//NsTJp015MMvPUTshOe0mjdHvPVfFoStpv
         wsTqqvaxCx0oUn9ZPwlIQypTrgCgftKy57Ks5un7XnehrzSYvaC1fiO8a1ce0jrpTYpM
         8zpaO2AC5jXLzvNR196S6ElypWl/XI8DMkJH+OdwyE3NiYcz0vN+Y/JDP4wZQ8Qbgi5R
         IwjqQOr1MFW6T77UUBufIO0cmGLuKtYYME/zjAK6o5ri/+aPozezOqndAww24tyr8m1o
         1uNw==
X-Gm-Message-State: AOAM531xVJaFHsM++JMsbu+ifzWJjiPxq575xSSk5fUx/0k/kScF1rL6
        MxdS8Iw7fcXRLSuT6g9+AgY=
X-Google-Smtp-Source: ABdhPJxi9crDyNOlXl/+7uBWebXj2rltTHVnLx2F894AlFvwI/cNoCm8+fb6Ps/1YNhITdbvtnMY9Q==
X-Received: by 2002:a63:e549:: with SMTP id z9mr26130165pgj.213.1591120985545;
        Tue, 02 Jun 2020 11:03:05 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id p8sm2740053pgs.29.2020.06.02.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:03:04 -0700 (PDT)
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
Subject: [PATCH 1/6] arm64/vdso: use the fault callback to map vvar pages
Date:   Tue,  2 Jun 2020 11:02:54 -0700
Message-Id: <20200602180259.76361-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200602180259.76361-1-avagin@gmail.com>
References: <20200602180259.76361-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to support time namespaces where a time namespace data
page is different for each namespace.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 033a48f30dbb..031ee1a8d4a8 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -114,28 +114,32 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 			PAGE_SHIFT;
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages + 1,
+	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages,
 				sizeof(struct page *),
 				GFP_KERNEL);
 	if (vdso_pagelist == NULL)
 		return -ENOMEM;
 
-	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
-
-
 	/* Grab the vDSO code pages. */
 	pfn = sym_to_pfn(vdso_lookup[arch_index].vdso_code_start);
 
 	for (i = 0; i < vdso_lookup[arch_index].vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
+		vdso_pagelist[i] = pfn_to_page(pfn + i);
 
-	vdso_lookup[arch_index].dm->pages = &vdso_pagelist[0];
-	vdso_lookup[arch_index].cm->pages = &vdso_pagelist[1];
+	vdso_lookup[arch_index].cm->pages = vdso_pagelist;
 
 	return 0;
 }
 
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+			     struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	if (vmf->pgoff == 0)
+		return vmf_insert_pfn(vma, vmf->address,
+				sym_to_pfn(vdso_data));
+	return VM_FAULT_SIGBUS;
+}
+
 static int __setup_additional_pages(enum arch_vdso_type arch_index,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -155,7 +159,7 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 	}
 
 	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-				       VM_READ|VM_MAYREAD,
+				       VM_READ|VM_MAYREAD|VM_PFNMAP,
 				       vdso_lookup[arch_index].dm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -215,6 +219,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 #ifdef CONFIG_COMPAT_VDSO
 	{
 		.name = "[vvar]",
+		.fault = vvar_fault,
 	},
 	{
 		.name = "[vdso]",
@@ -385,6 +390,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
+		.fault = vvar_fault,
 	},
 	{
 		.name	= "[vdso]",
-- 
2.24.1

