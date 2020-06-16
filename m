Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BCCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20615206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp8t/bjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgFPHz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:55:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A8C03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:55:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so1062459pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3w3acXY0ruvQ2cOAk5Y6lKlS5LzTqXqZJuB6w0EA294=;
        b=Cp8t/bjOY0qFMLYTzt16FoouVp9eINWmU8mmUpHX+AsFrDKIXkcT19z0suqBLghibO
         OsWPTbNQ78wf/cMk9oUek30lb6kngbCTL91Ip4B4OBjsGHxi5xA/ijlrqrQlNLoGn/bn
         l/7vyPUklqJG1Baun2pVxMHTasoW42ICl3Es6lVrZb83u6aebgtl+kJzIuZw8wkSuD5y
         eWg48lc4rfg+C2iE2LQQqoBLqeCS++0+HVWVXWygJpkK1vDfoep1tzRrEdYp2cVb/jvQ
         JC/cob986QCwZA/FpwkUZqZkbS85NacBJV0l0OpFKfn0vQWwu3XC3bjPcGWjDJb+aU5E
         KZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3w3acXY0ruvQ2cOAk5Y6lKlS5LzTqXqZJuB6w0EA294=;
        b=awoV5ovljTrTIw/eKb059iZqhWStC2E81kPhGILyqTct543fDw/rNo3r9si3LUWKnz
         TTGzPMCVWm6o48fx+9uhm53VUgi5ZdVt66pbzf4UfpVEEST/+WY4EUbn0KLJ0DC71tS8
         QKMMD3cqCf9LXhZF6ooLfVU8aSqNZZH6jnjFkPGY5varfTaAIBtZhqayXTy4UJfY9OPf
         7o9ne+Yy69mhC8LbWfaxKhzAwBDESzkvrVNkBadUzQ7/sNBb7VL0ga0B4CsarMWj8kfZ
         Lo3yIx6XKHNpQzEXLHSYTFKyuq2Ylz4pYM4+nu2U7EqPN9oGYeNJH03wk5Hre8mC+UAC
         ytog==
X-Gm-Message-State: AOAM530zmowY6krtW+uzjwvhS2YTLSjAA3CURX2Oigcr1afI0vvpvD5F
        1ySw8hZ0Oz2ybXqMiTC9low=
X-Google-Smtp-Source: ABdhPJxhqk6SDQGJkU/TNYIJx17AQr2syQ5Y+J3NJhmvTDGSm/ZNzAFmXitcdYEV3AsxC8vPnrV8xw==
X-Received: by 2002:a17:90a:356a:: with SMTP id q97mr1861201pjb.110.1592294155840;
        Tue, 16 Jun 2020 00:55:55 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id g6sm16168984pfb.164.2020.06.16.00.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:55:55 -0700 (PDT)
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
Date:   Tue, 16 Jun 2020 00:55:40 -0700
Message-Id: <20200616075545.312684-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200616075545.312684-1-avagin@gmail.com>
References: <20200616075545.312684-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to support time namespaces where a time namespace data
page is different for each namespace.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 4e016574bd91..b0aec4e8c9b4 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -108,28 +108,32 @@ static int __vdso_init(enum vdso_abi abi)
 			PAGE_SHIFT;
 
 	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_info[abi].vdso_pages + 1,
+	vdso_pagelist = kcalloc(vdso_info[abi].vdso_pages,
 				sizeof(struct page *),
 				GFP_KERNEL);
 	if (vdso_pagelist == NULL)
 		return -ENOMEM;
 
-	/* Grab the vDSO data page. */
-	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
-
-
 	/* Grab the vDSO code pages. */
 	pfn = sym_to_pfn(vdso_info[abi].vdso_code_start);
 
 	for (i = 0; i < vdso_info[abi].vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
+		vdso_pagelist[i] = pfn_to_page(pfn + i);
 
-	vdso_info[abi].dm->pages = &vdso_pagelist[0];
-	vdso_info[abi].cm->pages = &vdso_pagelist[1];
+	vdso_info[abi].cm->pages = vdso_pagelist;
 
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
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -150,7 +154,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	}
 
 	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-				       VM_READ|VM_MAYREAD,
+				       VM_READ|VM_MAYREAD|VM_PFNMAP,
 				       vdso_info[abi].dm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -209,6 +213,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 #ifdef CONFIG_COMPAT_VDSO
 	[AA32_MAP_VVAR] = {
 		.name = "[vvar]",
+		.fault = vvar_fault,
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
@@ -376,6 +381,7 @@ enum aarch64_map {
 static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	[AA64_MAP_VVAR] = {
 		.name	= "[vvar]",
+		.fault = vvar_fault,
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
-- 
2.24.1

