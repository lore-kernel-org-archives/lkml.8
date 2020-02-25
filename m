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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A20BC35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D9221744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+Ml/upn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgBYHhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:37:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36783 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgBYHhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:37:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so5142758plm.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fTm63vWBfzb1BdQ6B/CmE6SJCijkNB09UHlH94Y5uzA=;
        b=K+Ml/upn0oxvTo+3gRr3MfXbq8amghsNv5GktyPa1Bz9dIl4nWMHbaBhQYNQ6aszrz
         zm8G7MUyUXlzA1GvJ/5600wGmPeJXbjNXy/8mpDOuGJugnA7guDIbK8h/76jQQDmuUI8
         i6hbT8QosV3VkssGwCBeHYXolDg6ws+D9G7fX2VcSSOa4ITxIhhs5mxnjXCiD3HrjS4s
         mzGmmR0k0trfs8P3tZhMTBXB2o/Z+A8BC1jt/KfCY8ATrXdkQaNTPAcxtY1ZkGmaUtKY
         mFqk7ByJPLfAelkxnmvMvKy6IUbUMWgCf0+YqNGTdve3w12izGIve8+fAIUrtppB8Xec
         audQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fTm63vWBfzb1BdQ6B/CmE6SJCijkNB09UHlH94Y5uzA=;
        b=Gok2w5PyIduMi6RNt1BQQ2MKEAqzbr1tmqQCj9pnwQ3AN8fzlGlvvPN4rbboqoA+GF
         f3ZpUm2YH9WALbeRdjq3i3LJE15WYO2JsAORI4R9lUAqlaeI8z2bvbvlYxwiTrxYZo/I
         h2qfAUHjhXdj49XOh2bj7uIoAnAazQaOwBv8DqjgjXLVj9UjE+TWl1YRD1wTRvDgHSoz
         eR/X6GqTZKDS/dRwB8gZLo5GhhpAacpgpaQg5AytTP9jQ1qmySEUK/ooyWtfpX3YD0dO
         B8uYH03OU1WouLMdBrSu7xq/F3ErDtfUkTA0ofQ2ltt9+v4fW2nWlKiHkEjw9wVG9+iD
         MKoQ==
X-Gm-Message-State: APjAAAX3SU+f3pfplNS91TikBSHRVBu2bA2r1qCWDm/hmwra6Ndm2UCy
        y/4m4S0kvWr4vEh1s2+I+i4=
X-Google-Smtp-Source: APXvYqxqGvlZHIvXAmalhDezZDCnSGjb/EEDWYMB9RmGsUbBfPun/pC4HedAaHvGDMV4hAB9Smnhhw==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr3595342pjq.47.1582616260726;
        Mon, 24 Feb 2020 23:37:40 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id m128sm15979390pfm.183.2020.02.24.23.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:37:40 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 1/6] arm64/vdso: use the fault callback to map vvar pages
Date:   Mon, 24 Feb 2020 23:37:26 -0800
Message-Id: <20200225073731.465270-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
References: <20200225073731.465270-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to support time namespaces where a time namespace data
page is different for each namespace.

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

