Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC7C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B3520772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="f49DFHwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCZDYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46061 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgCZDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so5059891qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ze3FGBZb0nSlBTYQ3vDSCVsFtbgdtnnRlj5C751EbXw=;
        b=f49DFHwQ6bD5X4T6UQG6qlTqIEvg3jahXGHW4JpCoTMg2jEaJI6BxNqCBdECJgFfK3
         4TI/epxBM6OVNuRhLYFo4jmICLO5LM/VcYhlagkyOCPXmvQqG/tUrcW4UrajjCAg3J/i
         nu7t0GPzghw7vKGqT3E0eKZZeIjB4VojCzJnaIgkNWWAZRv4BINCOVe4mktc2HxfAPAe
         d45QCBnsMTjafOfsfWeFhzYbdxSqDyDUiATTddFL1b8T7FNgG01/VsZ9jk/wxRoHr4+P
         9TVuZAZ9WR4x9gl4ppCWZP8/njPwv+C03K7zIiScDSoiqbgSeE1NpbS4WGKA4syFVN0f
         NWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ze3FGBZb0nSlBTYQ3vDSCVsFtbgdtnnRlj5C751EbXw=;
        b=RyXoLug8MSBQYhDPS+ontEhchrxqx1amH/G1ENRF2evhbSlqMwzDrLMBR42a8I9/up
         MOcg+BzWzed8ttnXZ/w1DGtyTuD+pFJag+M74/T9HQL2Nqu5VAoHJZQWSqN8qp0FbIqJ
         ibQtCR8tm4a8hI0ZiTdCLjRCF+NJev+Uwm4qUgPj/9l4eoARrmrN/fDaAwQctXkdW3pj
         O21VB2Op2OTnSuddf224aVc2v4n2A8hWMqW7yaQMpVlOYzsLa3+mquBb7+jwgDNGH/uF
         cZgBPzoeOZnjAGTn7qrdY3i6jXD8cjsg5zsCDVUj4cVfpULR9XqkOZ1fmnOJ2iM8l5Oh
         HAGQ==
X-Gm-Message-State: ANhLgQ1khF6n9rGp7az3lwjbv1+3ROgFgReUvNpshwtNM11824zG4OWx
        miFrrPYo4ZdkmsdIHnIUxUh8YQ==
X-Google-Smtp-Source: ADFU+vtdrLXfDGYEC5WyjNqxKQP1AFgGN296Vf8D65tgrkwFasA1en9oG0QpvaU+6qDqbwwX7VAE7Q==
X-Received: by 2002:a37:63c5:: with SMTP id x188mr6282164qkb.276.1585193070601;
        Wed, 25 Mar 2020 20:24:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:30 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 05/18] arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
Date:   Wed, 25 Mar 2020 23:24:07 -0400
Message-Id: <20200326032420.27220-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trans_pgd_* should be independent from mm context because the tables that
are created by this code are used when there are no mm context around, as
it is between kernels. Simply replace mm_init's with NULL.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/mm/trans_pgd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index c16ae4e2b496..37d7d1c60f65 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -67,7 +67,7 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 	dst_ptep = trans_alloc(info);
 	if (!dst_ptep)
 		return -ENOMEM;
-	pmd_populate_kernel(&init_mm, dst_pmdp, dst_ptep);
+	pmd_populate_kernel(NULL, dst_pmdp, dst_ptep);
 	dst_ptep = pte_offset_kernel(dst_pmdp, start);
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
@@ -90,7 +90,7 @@ static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
 		dst_pmdp = trans_alloc(info);
 		if (!dst_pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, dst_pudp, dst_pmdp);
+		pud_populate(NULL, dst_pudp, dst_pmdp);
 	}
 	dst_pmdp = pmd_offset(dst_pudp, start);
 
@@ -126,7 +126,7 @@ static int copy_pud(struct trans_pgd_info *info, pgd_t *dst_pgdp,
 		dst_pudp = trans_alloc(info);
 		if (!dst_pudp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, dst_pgdp, dst_pudp);
+		pgd_populate(NULL, dst_pgdp, dst_pudp);
 	}
 	dst_pudp = pud_offset(dst_pgdp, start);
 
@@ -218,7 +218,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
-		pgd_populate(&init_mm, pgdp, pudp);
+		pgd_populate(NULL, pgdp, pudp);
 	}
 
 	pudp = pud_offset(pgdp, dst_addr);
@@ -226,7 +226,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
-		pud_populate(&init_mm, pudp, pmdp);
+		pud_populate(NULL, pudp, pmdp);
 	}
 
 	pmdp = pmd_offset(pudp, dst_addr);
@@ -234,7 +234,7 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
-		pmd_populate_kernel(&init_mm, pmdp, ptep);
+		pmd_populate_kernel(NULL, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-- 
2.17.1

