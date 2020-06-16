Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E57C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720DF206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAeqV5Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgFPH4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgFPH4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:56:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BEC03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:56:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so8009249pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOFeWxf8l/srSoyQCmE9FGPNMQ1rcx/B9OKWA2Lr1tw=;
        b=jAeqV5HhZyYxsZ6KIgb17STQuBSzaVIfIkrSMQqXQaIfT/6CO29PLWJ41t8hnU2hZ6
         RRlwvDlZ762LVTmAA/TnYh8g2Qz9mmqGZP9VJOMhmuHLLDqAwzOYo5y0M2+PYMo6+Fd4
         hq9WbgYrztbgiLFbhTFTFgpUIaqSg8a1GhgBxFlTYgf/J/hHUnGx+2QqZlBY+J4ASr1T
         uRe9p0Tv+7dA8VR02tJ0/q8G1mKuUzhjB/I0us9MRRnC+D9ag7v8aB+Ylc6YSHSN19Ta
         6Mf3lUNDx5PL5k3VXxcFQcxY6zZfR3xNSHcXXXk373+q6KyZGheOSNoVEnY5aUukplNE
         7jWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOFeWxf8l/srSoyQCmE9FGPNMQ1rcx/B9OKWA2Lr1tw=;
        b=ew8N02aWadCHsmikyKzQghCd34W7AnBtn5ceEBjP7nlSbRjLDMJ6Wx9c3VOrHhzzxl
         i9nCuUq5JQAKBKoo6tbmUarli78dh7SlcQ3OZfGQFt6Dq6lek/7gxNsvD+WRxwGyhTVb
         p0WwPJ3B0yZkeDtl5qnxnYTAd8CSl1BAe4VdHFJlpFCbgQjcw+YMxdkJwkz3zEoV07lS
         op5GfuUlhbD0+zyndfOqHvVk9kbb3drE//fKJfsjd8CL/hUsbiQyLUPHa5c9CfKddHfu
         K9k2+jF2pkElHEKEYW6e37zVQsacBXb6QSTiPL2X/h/++/+bXaluB1097YYvgabDtpF4
         oMcg==
X-Gm-Message-State: AOAM533bqvHA7gWIIL4AttjcNFrkCfy0W3kCB75jjsj1jiaO38DiTQ9P
        +YH5JF6bV7DFqIlTwWSaUH0=
X-Google-Smtp-Source: ABdhPJwOLCQsaIcJ1fFhE4hHC2egwIAnM+ejAPlFCeoi+Hbz5kYsARxJoXcjq2ZGwtsHiTohUaG5vw==
X-Received: by 2002:a17:90b:3612:: with SMTP id ml18mr1671017pjb.153.1592294161414;
        Tue, 16 Jun 2020 00:56:01 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id g6sm16168984pfb.164.2020.06.16.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:56:00 -0700 (PDT)
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
Subject: [PATCH 5/6] arm64/vdso: Restrict splitting VVAR VMA
Date:   Tue, 16 Jun 2020 00:55:44 -0700
Message-Id: <20200616075545.312684-6-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200616075545.312684-1-avagin@gmail.com>
References: <20200616075545.312684-1-avagin@gmail.com>
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
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 21bdd0d74f40..68e021324113 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -226,6 +226,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
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
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -308,6 +319,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_VVAR] = {
 		.name = "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
@@ -476,6 +488,7 @@ static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	[AA64_MAP_VVAR] = {
 		.name	= "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
-- 
2.24.1

