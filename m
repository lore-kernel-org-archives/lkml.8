Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50930C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C69D2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWvjSCgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406722AbgDPF13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406511AbgDPF0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:26:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C12C061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so878747pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AEQhnnrMzAKTzUbyWrr7Pn4129iWSFF1XGDPYTPl2Oo=;
        b=sWvjSCgNi/pGxJ8po/5HgKguAxlQRy+wCBCGw8arJtEyunm27lNPBjARK9WhHOxtuN
         PCDJQbLfnmWLVk1MnPOlWVYUs97/Wy2E8cJHx8x/J01Ub27iy/U2s/wFJUeZQRgmeG6v
         nv6a2yjc5r19eVoqvfywnonahteeHbS/nJzY6SiJKvzAhSQXJxZaHeUUHOzp4rvfXg3o
         PhvP8YF87YuawnruPOYOd55HhIJc6LsLXSgAe3BY+WNbTr2TY+NJAmMfjbXZj3G8Fn3G
         u8lJSQ928A4dYFDNmfcwgxQJf16qA6B0PT+kT6jmI2cbwspu1P46Q26TJ6FqsuI8L+cW
         HfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AEQhnnrMzAKTzUbyWrr7Pn4129iWSFF1XGDPYTPl2Oo=;
        b=O/lwWuH9mH3S04OiSfua2sD1NRTJTpoobvTzWAt0+NBYRPJEsS6gCm++lVPluxnryC
         FJfKA997Z1FbCPfgWb3VHG1QI/DRFmN8zy2ofhNiDf5zZzoIfrf9o2a8dyH0aVkUr79B
         0+/VK/MuRIGNX3Kn5iunNRe5H+4n/If3z0qzgJno7C2i+EPe0vTXv1SffyfvJ/sK/T9f
         U+4Uk4mHS0y/ynP84NkWW3G4It1KXqgJMqoRKs51cFN6ex4MANnH8w2DtKGFcsew69s0
         gPLQLUquNmn+TZ5Yaf6mZGVzm26dbFdvnikHaAmZQL1j0cal9Epg0fBiXnjENd5ewwYK
         zkKg==
X-Gm-Message-State: AGi0PuYQJuK3tBa7fJEA96vl99PWUQyYwkiW0SjXuDjW1MDvraeGyEOX
        nFu7T08YvL8Lh20Fg2BSjHI=
X-Google-Smtp-Source: APiQypIgTAWtfPtyJjPPgrd+7oA27QM8CD3i2vxGeg9P6ikV7cBNyesXqbfzDxy45o2NIKtFDcNuEQ==
X-Received: by 2002:a17:90a:a402:: with SMTP id y2mr3199895pjp.55.1587014807867;
        Wed, 15 Apr 2020 22:26:47 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c21sm53699pjr.2.2020.04.15.22.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:26:47 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 5/6] arm64/vdso: Restrict splitting VVAR VMA
Date:   Wed, 15 Apr 2020 22:26:17 -0700
Message-Id: <20200416052618.804515-6-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200416052618.804515-1-avagin@gmail.com>
References: <20200416052618.804515-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
amount of corner-cases to consider while working further on VDSO time
namespace support.

As the offset from timens to VVAR page is computed compile-time, the pages
in VVAR should stay together and not being partically mremap()'ed.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index fb32c6f76078..c003f7ee383a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -235,6 +235,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		       struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+
+	if (new_size != VVAR_NR_PAGES * PAGE_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int __setup_additional_pages(enum arch_vdso_type arch_index,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -315,6 +326,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
 		.name = "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name = "[vdso]",
@@ -497,6 +509,7 @@ static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name	= "[vdso]",
-- 
2.24.1

