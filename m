Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B57C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9963E20936
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUErtq3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406621AbgDPF1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406351AbgDPF0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:26:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216ABC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k18so949713pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYx3rFG6KM20BdDmNDmRew1PF1Kw/jTeIMBMcMn6Uag=;
        b=HUErtq3UvZ5uwOow+WJX2AdXLUZNH3EYTmjk1UnWAicVd/8Oq4rS+5iZT/pPWIgopr
         9vtmrNOLGfSrNontxw2/IvOKbuFu7qJJfOp4VFegTfW17BiCSbbuFDoxOZhIezEuq7ft
         w1VYv0JrqmzhoTrE4ru74gTH76FFMWJCCXRPIenWlCbIVXKKjC9m82YAZ2Xd1g0aVlSw
         LcpbVAKIdnCq23MpjjQGF3uHQqJDX1ebFQC6m06JL7NDw1aXI34fUprRI4+mhYHq6H+D
         GzDf7ykQ9EKJ7NkvyTfird2NPNLRVH6h6KmXbhygnHQ669kjabD1gkP7f/5QmNMgnrP5
         zWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYx3rFG6KM20BdDmNDmRew1PF1Kw/jTeIMBMcMn6Uag=;
        b=hDN/jdzntspRfXl5JJs0p9bzhoDga+Dbr/KUZZwsRJB5G6AzwtAfPtjfP3j1+EHlcf
         NzVMcoP6VJW/Re3Pr5GnCX8Nsal4RKJzJE08ihIUiBGHrf4kRdAPMjFgRTW2m2JNErqD
         PHlKBGkBB8yYWtoQ6V9/NlZZ1iiibMv+1MueT7xALpL+JiZY+QE5KtKgs3ABRtUTmzDs
         GbhIxmbPwhG3ggOWgX418Y3d3LJK/DYvZqexwAjmZeR9Yyy+pcml+wAWBdWyp7CgFcZG
         DsZN+/U+3wyIob8EWteB3QBOPY/d+hv1Zl53u54jT+nuNNMQGHQHFmdJlSYVprEb+d7V
         Ayng==
X-Gm-Message-State: AGi0PuZZwgSJuWUp94aefKbavfSBNb1oI8oFotQVknwAsRxspqKe9lsp
        ax8dKttiF1PzuUCylxDjCcQ=
X-Google-Smtp-Source: APiQypK/2FwQOgHFn/PlAUl6famODzCE4lTGQ6yxpTUvumbVbDZFXkExYLzU004YRAurasnvaR75mg==
X-Received: by 2002:a17:90a:cc2:: with SMTP id 2mr3160651pjt.33.1587014803490;
        Wed, 15 Apr 2020 22:26:43 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c21sm53699pjr.2.2020.04.15.22.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:26:43 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 1/6] arm64/vdso: use the fault callback to map vvar pages
Date:   Wed, 15 Apr 2020 22:26:13 -0700
Message-Id: <20200416052618.804515-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200416052618.804515-1-avagin@gmail.com>
References: <20200416052618.804515-1-avagin@gmail.com>
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
index 354b11e27c07..290c36d74e03 100644
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
@@ -396,6 +401,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
+		.fault = vvar_fault,
 	},
 	{
 		.name	= "[vdso]",
-- 
2.24.1

