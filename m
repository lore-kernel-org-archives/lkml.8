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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088F620823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inED/Qfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390351AbgFXId2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389050AbgFXIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:25 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19214C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so789691plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cTWQs0HlakIx1EXTUfvYi5OI/+C9xhCIK6shQ1G+dgY=;
        b=inED/QfocfJvVgmnsagLvNK5ZybNoQfR9wcp/QL5AKj1ixNZ692lqxPsJgkPlmVhCV
         RxHfNyutt843L3+W25uaXmcm6QemN6vSqsKCYNMUd2tFxW+7GQxyxuUOt1kE4WgQXVCy
         nTGRdiMPJKI6fo88SHtq7uundZwirhbHXYpXxBY+NjcVFnxQ/CfHfSDJ0h3j9pNhk+zo
         Ir5RFvfHLfm8yUw2fomRWlQjstUOYLzHu3k3nsB1njibfYVh/unKZPFHl9QEkTaX4WTi
         uqK05p2t51hl0+lJ1wA4PDTwr47mWKP86z4wuVT2o/MtAdQz6g108jzUHQ+FmBAA5oEn
         EOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cTWQs0HlakIx1EXTUfvYi5OI/+C9xhCIK6shQ1G+dgY=;
        b=IezQbkPtLPJuV+ctl3j2rqshkssSBJ5m/GjX7AxsA0FX7rs+TChmuZljUo3QIqi9Oq
         crmdwonKZSu9pzTiuZJf1rA5tFVi03kD+SWVV528fiNo8vKFNL6agTgO184GjffL6Z1u
         69jMFo6IvK5NI/iCSP0i//AGyWPKAYcvLkCuwno1wSmh0hLOLkt0tts6pMxgxqeO/auJ
         hmKpW1SyNJuN5ugvWd9x7FnF0ywRkcauKYD4hSQFc75rJz9Z0hV8LukZrdKkSB7tYi6K
         QszaUwR0G4Jvy5uAfmdtS3xpJowLzzVNWnyRm0UFlH7divKSWAYbKx6yDT5sROW650qb
         XIpg==
X-Gm-Message-State: AOAM532ZV9nzUNVIbUIVtoiDF/at4FfeHzzEYx0F6HMJuh9rbIxb82Wx
        ePjuxga256KXMb4YspFbbRY=
X-Google-Smtp-Source: ABdhPJyVDRj2hXj+Fjq+I7TAU5NAayzGzoSlFOSJqBtvHZV712+kCKfrf3ZS9ZQpU7i/+kjn7+hteA==
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr27089006pjr.181.1592987604529;
        Wed, 24 Jun 2020 01:33:24 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g17sm4558614pju.11.2020.06.24.01.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:33:24 -0700 (PDT)
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
Subject: [PATCH 1/6] arm64/vdso: use the fault callback to map vvar pages
Date:   Wed, 24 Jun 2020 01:33:16 -0700
Message-Id: <20200624083321.144975-2-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200624083321.144975-1-avagin@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the vdso has no awareness of time namespaces, which may
apply distinct offsets to processes in different namespaces. To handle
this within the vdso, we'll need to expose a per-namespace data page.

As a preparatory step, this patch separates the vdso data page from
the code pages, and has it faulted in via its own fault callback.
Subsquent patches will extend this to support distinct pages per time
namespace.

The vvar vma has to be installed with the VM_PFNMAP flag to handle
faults via its vma fault callback.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 4e016574bd91..7c4620451fa5 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -107,29 +107,32 @@ static int __vdso_init(enum vdso_abi abi)
 			vdso_info[abi].vdso_code_start) >>
 			PAGE_SHIFT;
 
-	/* Allocate the vDSO pagelist, plus a page for the data. */
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
@@ -150,7 +153,7 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	}
 
 	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-				       VM_READ|VM_MAYREAD,
+				       VM_READ|VM_MAYREAD|VM_PFNMAP,
 				       vdso_info[abi].dm);
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -209,6 +212,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 #ifdef CONFIG_COMPAT_VDSO
 	[AA32_MAP_VVAR] = {
 		.name = "[vvar]",
+		.fault = vvar_fault,
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
@@ -376,6 +380,7 @@ enum aarch64_map {
 static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	[AA64_MAP_VVAR] = {
 		.name	= "[vvar]",
+		.fault = vvar_fault,
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
-- 
2.24.1

