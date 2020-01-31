Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1DEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDEB20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="D16EjVD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAaNe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:34:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34808 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgAaNe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:34:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 488J9n3llLzB09ZH;
        Fri, 31 Jan 2020 14:34:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=D16EjVD/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Oim7FYvWxMRI; Fri, 31 Jan 2020 14:34:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 488J9n2hB5zB09ZG;
        Fri, 31 Jan 2020 14:34:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580477693; bh=+Y0PaYkFrqDzJi1Ln3AX9oehwDcMeZVtP5iNC1ylbdQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=D16EjVD/UOY6pt3bc3ip97cp5iPn/mhD+7hxinHXQrnRcP6MrSCuwsHC2D6wxa7y9
         dTp8vL/OoP/VgemS0TtUX/zg7gzmCnN3gjV21zWuBP20lu2YHWtJSUQWO0+bqfWJwr
         vyECgDzpRUah6Xt/NMOirTRCAJHfXmHIzm/5Coa0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AEE908B8AC;
        Fri, 31 Jan 2020 14:34:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ko0s9s0Lw_7w; Fri, 31 Jan 2020 14:34:54 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 792E48B8A2;
        Fri, 31 Jan 2020 14:34:54 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 71AF165288; Fri, 31 Jan 2020 13:34:54 +0000 (UTC)
Message-Id: <d559ca8418c56920670c7bc31a300c05ae13e967.1580477672.git.christophe.leroy@c-s.fr>
In-Reply-To: <84be5ad6a996adf5693260749dcb4d8c69182073.1580477672.git.christophe.leroy@c-s.fr>
References: <84be5ad6a996adf5693260749dcb4d8c69182073.1580477672.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 6/7] powerpc/mm: implement set_memory_attr()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 31 Jan 2020 13:34:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the set_memory_xx() functions which allows to change
the memory attributes of not (yet) used memory regions, implement a
set_memory_attr() function to:
- set the final memory protection after init on currently used
kernel regions.
- enable/disable kernel memory regions in the scope of DEBUG_PAGEALLOC.

Unlike the set_memory_xx() which can act in three step as the regions
are unused, this function must modify 'on the fly' as the kernel is
executing from them. At the moment only PPC32 will use it and changing
page attributes on the fly is not an issue.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: new
---
 arch/powerpc/include/asm/set_memory.h |  2 ++
 arch/powerpc/mm/pageattr.c            | 33 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/powerpc/include/asm/set_memory.h b/arch/powerpc/include/asm/set_memory.h
index c3621030a3fb..4dadff67e265 100644
--- a/arch/powerpc/include/asm/set_memory.h
+++ b/arch/powerpc/include/asm/set_memory.h
@@ -29,4 +29,6 @@ static inline int set_memory_x(unsigned long addr, int numpages)
 	return change_memory_attr(addr, numpages, SET_MEMORY_X);
 }
 
+int set_memory_attr(unsigned long addr, int numpages, pgprot_t prot);
+
 #endif
diff --git a/arch/powerpc/mm/pageattr.c b/arch/powerpc/mm/pageattr.c
index 0cb5294732b7..dff6c92cd09b 100644
--- a/arch/powerpc/mm/pageattr.c
+++ b/arch/powerpc/mm/pageattr.c
@@ -72,3 +72,36 @@ int change_memory_attr(unsigned long addr, int numpages, int action)
 
 	return apply_to_page_range(&init_mm, start, sz, change_page_attr, (void *)action);
 }
+
+/*
+ * Set the attributes of a page:
+ *
+ * This function is used by PPC32 at the end of init to set final kernel memory
+ * protection. It includes changing the maping of the page it is executing from
+ * and data pages it is using.
+ */
+static int set_page_attr(pte_t *ptep, unsigned long addr, void *data)
+{
+	pgprot_t prot = __pgprot((int)data);
+
+	spin_lock(&init_mm.page_table_lock);
+
+	set_pte_at(&init_mm, addr, ptep, pte_modify(*ptep, prot));
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+	spin_unlock(&init_mm.page_table_lock);
+
+	return 0;
+}
+
+int set_memory_attr(unsigned long addr, int numpages, pgprot_t prot)
+{
+	unsigned long start = ALIGN_DOWN(addr, PAGE_SIZE);
+	unsigned long sz = numpages * PAGE_SIZE;
+
+	if (!numpages)
+		return 0;
+
+	return apply_to_page_range(&init_mm, start, sz, set_page_attr,
+				   (void *)pgprot_val(prot));
+}
-- 
2.25.0

