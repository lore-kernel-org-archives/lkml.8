Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC811C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A453D2467E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JcJvFnOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgAJKqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:46:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37030 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgAJKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:46:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so711826plz.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=LhPJp+PAwva7bPHMH862TV/8J9fNaEOj4YyHAq59Kg8=;
        b=JcJvFnOkAVeVV9XrhUVdhbhf5yYoi7T7LuWmU1eyQuEIS8cjao55ztp8J2hmKsZERu
         7ySGrS8OoHgH0Aw5tYKzVadcXyLU2DVpBAMKYuF0TTn1BFOSbg8vdTs9/3iqdDc65XQs
         c6IjGBNIzk8C7jGJoIKOKNqfpuNH2po2onG67zoY2sT7UhFn3elCxWo0HZBvadCoTFju
         c8Sc12UpEskHnz74klkv9hrvvPkl2rDeatvyWYcMC5p1ySBjVa3DKhA/1ieYK0RZZ3O2
         jP2RjSE9Ib8CJCB9rgZxE8OfMsetjRgBjGzorTj6U7vi4i8D2ucgJd/K7Ec9B0L5fA86
         8T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LhPJp+PAwva7bPHMH862TV/8J9fNaEOj4YyHAq59Kg8=;
        b=eQI7UfhiBdafNwexozl+X4AWJ6MYzUNQmEbgL+wFDMmA8lfCLr7DKYmuiXWbbU8W2w
         GWs0wd5mR1QGQKohT7k46QeNsILnzoK/7p3fVhdnbxBJWLTelbKPj1j7pZW8r1Ope0pc
         pj7nVvzM9wH4gG2m8BGsse6xuFsmRWxDlKjfo7FisbU6nnSxK7nO7VuOLlVjPEIwdY93
         Sdw+MLTzcRJArLbjRQRYBTpw1fU4nLjGAfMtV5prnydva18qZdsMvOo6WeoWzjQWtUmX
         gUbZxMiSDkfj78LlNTdxYz3/2g5NRZXvzcTKS+iJesnnq+rtUDpi1yNJ6UgqKpKO9LYA
         YG7w==
X-Gm-Message-State: APjAAAXmQ7ZSoaLz7c3cQd9EwVfAgo/FjpfCU2QRb7A2lO1pG82MhLkF
        IxB4O6OhcZmk+C0Z0hUK8yJ+2w==
X-Google-Smtp-Source: APXvYqxvFezduVV4IwfVnEBIdXpJcuKRSwEUMeh6oea69WBD3hgikon+ZODyeGzzks3V+W+ht/b4MQ==
X-Received: by 2002:a17:90a:ac0f:: with SMTP id o15mr3859733pjq.133.1578653198083;
        Fri, 10 Jan 2020 02:46:38 -0800 (PST)
Received: from greentime-VirtualBox.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id e10sm2590901pfj.7.2020.01.10.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 02:46:37 -0800 (PST)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, greentime@kernel.org, anup@brainfault.org,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        gkulkarni@marvell.com, will@kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, paul.walmsley@sifive.com, hch@lst.de
Subject: [RFC PATCH v2 1/4] riscv: Add support pte_protnone and pmd_protnone if CONFIG_NUMA_BALANCING
Date:   Fri, 10 Jan 2020 18:46:24 +0800
Message-Id: <1ff7e57f16cb43c8816b90716a872b8f0f101c42.1577694824.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1577694824.git.greentime.hu@sifive.com>
References: <cover.1577694824.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1577694824.git.greentime.hu@sifive.com>
References: <cover.1577694824.git.greentime.hu@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are used to distinguish between PROT_NONENUMA
protections and hinting fault protections.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 36ae01761352..9650a4ce073e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -166,6 +166,11 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
 }
 
+static inline pte_t pmd_pte(pmd_t pmd)
+{
+	return __pte(pmd_val(pmd));
+}
+
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
@@ -279,6 +284,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+/*
+ * See the comment in include/asm-generic/pgtable.h
+ */
+static inline int pte_protnone(pte_t pte)
+{
+	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
+}
+
+static inline int pmd_protnone(pmd_t pmd)
+{
+	return pte_protnone(pmd_pte(pmd));
+}
+#endif
+
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-- 
2.17.1

