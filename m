Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F7C4345B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2972121D90
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579950;
	bh=BMwQ/I/EzCiYY1exzqKiW4buRsydzJwRZlgQRqiVsO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cQQKTuMFQBUhYfVHnaGiOuo1vaWLDFJTEvY9Ktb9oZq849rr2qMNKtSm5QfjvwE77
	 y9TBkl0cQUyaNLE4t4E8lpl3DMzp5w2TpcyxyKo1b9YVh987cAEIm4xD13dNgrmhZY
	 C0bqiofRjlAFE36Z0aCRMpxub6bvRevtLn0uzFj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392387AbgFSPPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391800AbgFSPO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:14:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7474206FA;
        Fri, 19 Jun 2020 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579698;
        bh=BMwQ/I/EzCiYY1exzqKiW4buRsydzJwRZlgQRqiVsO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nxq+uOvePpH84vJHtg0gWI5OOxDH+6QUYKqoEgJcYiGProxQthOzP2OmCxyvgz1Ho
         aDu/J6ppXo1+3aZyFijWPTmu/1esPl6Um5aDApzu62JSbWjDRf/c8OTV28RbQjuOii
         GuJ9f6/0msELt7uxR1XdG5wh68uxRUab8Rt1jNe8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 233/261] powerpc/kasan: Fix shadow pages allocation failure
Date:   Fri, 19 Jun 2020 16:34:04 +0200
Message-Id: <20200619141701.046413635@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit d2a91cef9bbdeb87b7449fdab1a6be6000930210 upstream.

Doing kasan pages allocation in MMU_init is too early, kernel doesn't
have access yet to the entire memory space and memblock_alloc() fails
when the kernel is a bit big.

Do it from kasan_init() instead.

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/c24163ee5d5f8cdf52fefa45055ceb35435b8f15.1589866984.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/kasan.h      |    2 --
 arch/powerpc/mm/init_32.c             |    2 --
 arch/powerpc/mm/kasan/kasan_init_32.c |    4 +++-
 3 files changed, 3 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -27,11 +27,9 @@
 
 #ifdef CONFIG_KASAN
 void kasan_early_init(void);
-void kasan_mmu_init(void);
 void kasan_init(void);
 #else
 static inline void kasan_init(void) { }
-static inline void kasan_mmu_init(void) { }
 #endif
 
 #endif /* __ASSEMBLY */
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -175,8 +175,6 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
-	kasan_mmu_init();
-
 	setup_kup();
 
 	/* Shortly after that, the entire linear mapping will be available */
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -129,7 +129,7 @@ static void __init kasan_remap_early_sha
 	flush_tlb_kernel_range(KASAN_SHADOW_START, KASAN_SHADOW_END);
 }
 
-void __init kasan_mmu_init(void)
+static void __init kasan_mmu_init(void)
 {
 	int ret;
 	struct memblock_region *reg;
@@ -156,6 +156,8 @@ void __init kasan_mmu_init(void)
 
 void __init kasan_init(void)
 {
+	kasan_mmu_init();
+
 	kasan_remap_early_shadow_ro();
 
 	clear_page(kasan_early_shadow_page);


