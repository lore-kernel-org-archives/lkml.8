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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE614C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C564A2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI3nq/p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBDR7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:59:35 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45215 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgBDR7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:59:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so10004163pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JyMzGy1x0Bon4+AzM/Sj0HNrbhuXPMQCx6Z9N3h13AI=;
        b=UI3nq/p9II8ri8gMr7xe4jx5TsTT5VWWhbBR7v+ihCbko9aZN9SZ1sO8nro5JpLhNI
         EK48Cl3ywcSaRhchOJXm1FYtGAJFWf8rKE1of5WvcC1GPSpYi2MAowQyiHBwkhbFJbfv
         6ns+r7NVnz/0MX1TwyA7zFwrIRmqfiAMNOc3R0/VBdH+p1zKGvql9LZ2yZCRjml/vXGj
         TBsu7RPFMwRMm/WTz3k9ZzWdtVrAJp1YVe/Ha9nPQKj33UPVFNqO7txSOBrzN60lTGQ8
         Zr5EpXwvVtutXXkTyQh9O/bprChPTWnAMhKvx671mDx9/Ye0P/brBW39AT4A7iMZLcOU
         FYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JyMzGy1x0Bon4+AzM/Sj0HNrbhuXPMQCx6Z9N3h13AI=;
        b=ipwL7EZ0Qm+GVAhE7G+NTCMm1gIVtHGJOSzHzl8Z/vzKf7BVr39nRl+GLhqHoupBJK
         9qCkJ8yMdSvMw0iox2mws+OPzxgFQPfGMgYG0T9LbTARI9JXFQ/8YDs/Ptkt/V+QMvMJ
         Ve3O5VyML/zVGD2DpWImhezYXW0JiJHbZJWCz9USsbk/TWvigbTZ3VBSjHsKK85XC3tz
         BvkF99lrJWQ85mYhwHikT1dDBxwtgoiTIDckAj5R+fOWDqlNR+Qke9jOyGgO9VrNlMd5
         zoRxmEo7g7gfyLuultlNh/iqa1IOxYb+FHGGSd8QYMTbdPST4J458uQoprz5/gBvyFdw
         ipwA==
X-Gm-Message-State: APjAAAUmJxDj0ZGY5e4H2NngePMkWkquIUx4RGfslGC3+sevB7+TUoqg
        0P+M7qqFu0bWoOUrHCQ2A9g=
X-Google-Smtp-Source: APXvYqwVVGMbq4U6Mx/8kHYp68Lm5UDq8ejfa6s44BKqQGNs00hDz/L86IOvGdVpIQoM+QmiUsAd+Q==
X-Received: by 2002:a62:f243:: with SMTP id y3mr32842181pfl.146.1580839169558;
        Tue, 04 Feb 2020 09:59:29 -0800 (PST)
Received: from localhost.localdomain ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id d73sm25414465pfd.109.2020.02.04.09.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 09:59:28 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 5/5] arm64/vdso: Restrict splitting VVAR VMA
Date:   Tue,  4 Feb 2020 09:59:13 -0800
Message-Id: <20200204175913.74901-6-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200204175913.74901-1-avagin@gmail.com>
References: <20200204175913.74901-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
amount of corner-cases to consider while working further on VDSO time
namespace support.

As the offset from timens to VVAR page is computed compile-time, the pages
in VVAR should stay together and not being partically mremap()'ed.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2e553468b183..e6ebdc184c1e 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -229,6 +229,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
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
@@ -311,6 +322,7 @@ static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
 		.name = "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name = "[vdso]",
@@ -493,6 +505,7 @@ static struct vm_special_mapping vdso_spec[A_PAGES] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	{
 		.name	= "[vdso]",
-- 
2.24.1

