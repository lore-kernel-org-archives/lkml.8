Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63976CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB962240B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="G/AjTLfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgEMNji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388079AbgEMNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:39:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBEC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g185so17285190qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFXyl8bLGTgB36EioVmpcCnHThDdGncqsiu7Ha+l9Ck=;
        b=G/AjTLfR29lUROPs7vr/JubE1o3ERsvq3GIxpEXg/6FSWKOZGnX/UGQQcX/n8lVw0B
         fHGsnL+Lfm7YVzme+LYrVHFLtxPpW5P/nC3Rcun7ro/HuZw9IA1ThTI9Cv0Bd3XaPaOb
         hfxs7LJ5S7XexlyfuZQe8kq9jQnT/x41r/7ch+b7VfEeWsJmq006VVWtqNHFgncF5Qsn
         l13nizIigZl/8GX2AGztE44wnPM4n4lxORVaaiq0VfqtQnW5fgp3Rr5T/Oa+4yEjB0fx
         yISMxpHi7KbbbtbliLwsmTHBlbLfVtA7Gxjz/N7tmyVxsp86FSmvO2ndcDF5wsna/ks2
         h/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XFXyl8bLGTgB36EioVmpcCnHThDdGncqsiu7Ha+l9Ck=;
        b=NX4AOFhZ62CqFdC2P8VaBTILDGJQCz05fLriyrVn/MCLahFj436VJdtzjYLt6YZq2Y
         UPU54nkgLWLxWE/tYhVL0xlmNH1FK6o7KSAgu8XOOSrxh/NR5wRljWkMEJ2Nfn9ZpuPf
         Ix0nWs4RJLA99HKCBxa/nVI8LU0m81nKV29tdIxdESX7+QiVKpINtG0Weqvpnn144nHk
         NFiyqSfo1ED99SkR/mbkYsmWkV+AvlfqggIkC3qG1Hk7AhIUmYR9ThG2aQMhbE6+zeiX
         Uo3FZzaagGopGfPrSwlTZq52ZpFXMXVgkcN9jQ7PjGYcWKufdzwY9GHaWNfKr6AZ0kG/
         FdKQ==
X-Gm-Message-State: AGi0PuabOjoW2sHyFuuxj2aCVKoruHnEIKRKyazDBSMrwNnHtJuQbxij
        a9JivThdSeaGdza2fD4wn6vYFw==
X-Google-Smtp-Source: APiQypJIQ7dwxyjjoiFv01S4nCAvfLANCzyEfKoU8HTELxdOu2uR63fRzhoB7b8epU3HG++PT2s7MA==
X-Received: by 2002:a37:b4c7:: with SMTP id d190mr24934971qkf.432.1589377171712;
        Wed, 13 May 2020 06:39:31 -0700 (PDT)
Received: from ovpn-66-156.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h9sm4292783qtu.28.2020.05.13.06.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 06:39:31 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     paulus@ozlabs.org, mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, catalin.marinas@arm.com,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/kvm/radix: ignore kmemleak false positives
Date:   Wed, 13 May 2020 09:39:15 -0400
Message-Id: <20200513133915.1040-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmppc_pmd_alloc() and kvmppc_pte_alloc() allocate some memory but then
pud_populate() and pmd_populate() will use __pa() to reference the newly
allocated memory.

Since kmemleak is unable to track the physical memory resulting in false
positives, silence those by using kmemleak_ignore().

unreferenced object 0xc000201c382a1000 (size 4096):
 comm "qemu-kvm", pid 124828, jiffies 4295733767 (age 341.250s)
 hex dump (first 32 bytes):
   c0 00 20 09 f4 60 03 87 c0 00 20 10 72 a0 03 87  .. ..`.... .r...
   c0 00 20 0e 13 a0 03 87 c0 00 20 1b dc c0 03 87  .. ....... .....
 backtrace:
   [<000000004cc2790f>] kvmppc_create_pte+0x838/0xd20 [kvm_hv]
   kvmppc_pmd_alloc at arch/powerpc/kvm/book3s_64_mmu_radix.c:366
   (inlined by) kvmppc_create_pte at arch/powerpc/kvm/book3s_64_mmu_radix.c:590
   [<00000000d123c49a>] kvmppc_book3s_instantiate_page+0x2e0/0x8c0 [kvm_hv]
   [<00000000bb549087>] kvmppc_book3s_radix_page_fault+0x1b4/0x2b0 [kvm_hv]
   [<0000000086dddc0e>] kvmppc_book3s_hv_page_fault+0x214/0x12a0 [kvm_hv]
   [<000000005ae9ccc2>] kvmppc_vcpu_run_hv+0xc5c/0x15f0 [kvm_hv]
   [<00000000d22162ff>] kvmppc_vcpu_run+0x34/0x48 [kvm]
   [<00000000d6953bc4>] kvm_arch_vcpu_ioctl_run+0x314/0x420 [kvm]
   [<000000002543dd54>] kvm_vcpu_ioctl+0x33c/0x950 [kvm]
   [<0000000048155cd6>] ksys_ioctl+0xd8/0x130
   [<0000000041ffeaa7>] sys_ioctl+0x28/0x40
   [<000000004afc4310>] system_call_exception+0x114/0x1e0
   [<00000000fb70a873>] system_call_common+0xf0/0x278
unreferenced object 0xc0002001f0c03900 (size 256):
 comm "qemu-kvm", pid 124830, jiffies 4295735235 (age 326.570s)
 hex dump (first 32 bytes):
   c0 00 20 10 fa a0 03 87 c0 00 20 10 fa a1 03 87  .. ....... .....
   c0 00 20 10 fa a2 03 87 c0 00 20 10 fa a3 03 87  .. ....... .....
 backtrace:
   [<0000000023f675b8>] kvmppc_create_pte+0x854/0xd20 [kvm_hv]
   kvmppc_pte_alloc at arch/powerpc/kvm/book3s_64_mmu_radix.c:356
   (inlined by) kvmppc_create_pte at arch/powerpc/kvm/book3s_64_mmu_radix.c:593
   [<00000000d123c49a>] kvmppc_book3s_instantiate_page+0x2e0/0x8c0 [kvm_hv]
   [<00000000bb549087>] kvmppc_book3s_radix_page_fault+0x1b4/0x2b0 [kvm_hv]
   [<0000000086dddc0e>] kvmppc_book3s_hv_page_fault+0x214/0x12a0 [kvm_hv]
   [<000000005ae9ccc2>] kvmppc_vcpu_run_hv+0xc5c/0x15f0 [kvm_hv]
   [<00000000d22162ff>] kvmppc_vcpu_run+0x34/0x48 [kvm]
   [<00000000d6953bc4>] kvm_arch_vcpu_ioctl_run+0x314/0x420 [kvm]
   [<000000002543dd54>] kvm_vcpu_ioctl+0x33c/0x950 [kvm]
   [<0000000048155cd6>] ksys_ioctl+0xd8/0x130
   [<0000000041ffeaa7>] sys_ioctl+0x28/0x40
   [<000000004afc4310>] system_call_exception+0x114/0x1e0
   [<00000000fb70a873>] system_call_common+0xf0/0x278

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index aa12cd4078b3..bc6c1aa3d0e9 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -353,7 +353,13 @@ static struct kmem_cache *kvm_pmd_cache;
 
 static pte_t *kvmppc_pte_alloc(void)
 {
-	return kmem_cache_alloc(kvm_pte_cache, GFP_KERNEL);
+	pte_t *pte;
+
+	pte = kmem_cache_alloc(kvm_pte_cache, GFP_KERNEL);
+	/* pmd_populate() will only reference _pa(pte). */
+	kmemleak_ignore(pte);
+
+	return pte;
 }
 
 static void kvmppc_pte_free(pte_t *ptep)
@@ -363,7 +369,13 @@ static void kvmppc_pte_free(pte_t *ptep)
 
 static pmd_t *kvmppc_pmd_alloc(void)
 {
-	return kmem_cache_alloc(kvm_pmd_cache, GFP_KERNEL);
+	pmd_t *pmd;
+
+	pmd = kmem_cache_alloc(kvm_pmd_cache, GFP_KERNEL);
+	/* pud_populate() will only reference _pa(pmd). */
+	kmemleak_ignore(pmd);
+
+	return pmd;
 }
 
 static void kvmppc_pmd_free(pmd_t *pmdp)
-- 
2.21.0 (Apple Git-122.2)

