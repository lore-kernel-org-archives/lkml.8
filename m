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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A4FC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D1122464
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZvdvgC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBDR70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:59:26 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55935 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbgBDR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:59:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so1706646pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nfh22yuIBMeQ3kvIydY8ilzEcSZOCdGdBZ/eBSsIN/Q=;
        b=cZvdvgC6JY1X2WLdvXp4m3GQ+VLpqwAwdJRWr3OHt+mDbjcYTLQTWTP5LOy0VNI2J9
         GsZ6G3+eROIlZRwhBOKiZei6C4Y24+XLK6CnTNAVCElkoqyA2ndnkIHuaKxR5/ropUFE
         xt/v49ir5Air6MKMQtxu4OQjBsAEyLuuoJ13Kqn2lLoqUsdLN06QPqAg6XtiWVju/5RL
         RNfC7XniMD6tlt3sN0WYRTWli2s1MXpEmWdYaM6cWc23RpF4AnDSJYjuDGMa7mr17ylN
         /cQ8tR7Ax4Ee2JmrlRO+Tu4hKx/Pb4zCeLXk+x3gUjQ26RcxPCXJDcDbRpqSqACDBw23
         1igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nfh22yuIBMeQ3kvIydY8ilzEcSZOCdGdBZ/eBSsIN/Q=;
        b=CyHJ1/MAKeqIokz1AzXGuwNldmB028nfqRPtGoEjxNeipmr3apNQMBN4Sofo68XBeo
         LurvHwj+r3N35u0YQYTXrlOHvtTYo7LjTAIB7PnruSiz8xNB+3HfDEAM7s81ia2LP8Aa
         ZHfX0gE+skhezJa+9pIKxgon1syZGYF0US6mQAwNK++M6amFvGk9+f6kk4tmw9Eo1oBo
         tl9UCq/+AlG4ya8s5m2O7qskObW6Fx8K8//iPpdyrdIU9FV7/gkjiT5vVRzM2fx6cWX4
         em5JtrW8inzllQ8VuAheG5RAujPsbf5PUQHNErqF99t0kPpWGbCkIIU7y/j/gmVZ+3Mv
         A7dQ==
X-Gm-Message-State: APjAAAVzDpnItU7/Qwg5k9B0aiDbctKJH7aXwfvNmb48PAMRYBJ6ajsL
        C4fP6AxwWFyrB6N9Q/PsXp0=
X-Google-Smtp-Source: APXvYqw9azuHvBSMLyzc/8cqmPByqTFaxmhbhNKiyzp8wI/JEy0MYOpijPSV6ICe+k2TNK2BwWVxAQ==
X-Received: by 2002:a17:90a:9c1:: with SMTP id 59mr305035pjo.65.1580839164471;
        Tue, 04 Feb 2020 09:59:24 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id d73sm25414465pfd.109.2020.02.04.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 09:59:23 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 1/5] arm64/vdso: use the fault callback to map vvar pages
Date:   Tue,  4 Feb 2020 09:59:09 -0800
Message-Id: <20200204175913.74901-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200204175913.74901-1-avagin@gmail.com>
References: <20200204175913.74901-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to support time namespaces where a time namespace data
page is different for each namespace.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 354b11e27c07..c4b4758eaf0b 100644
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
+		      struct vm_area_struct *vma, struct vm_fault *vmf)
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
@@ -206,6 +210,8 @@ static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
 #define C_SIGPAGE	1
 #define C_PAGES		(C_SIGPAGE + 1)
 #endif /* CONFIG_COMPAT_VDSO */
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+		      struct vm_area_struct *vma, struct vm_fault *vmf);
 static struct page *aarch32_vdso_pages[C_PAGES] __ro_after_init;
 static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
@@ -215,6 +221,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 #ifdef CONFIG_COMPAT_VDSO
 	{
 		.name = "[vvar]",
+		.fault = vvar_fault,
 	},
 	{
 		.name = "[vdso]",
@@ -396,6 +403,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
+		.fault = vvar_fault,
 	},
 	{
 		.name	= "[vdso]",
-- 
2.24.1

