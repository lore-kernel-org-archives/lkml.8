Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9E0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08672075F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072834;
	bh=58qp4gOupZaoLJO0q94LemFcLAKgWx1mlx/wmqqzCws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pw7TMCLunfIR/Axnae/e2xEKip3e69s0y2GaKirKVHtbSrKNBBoX0fVclzREcfdPm
	 n1zT47jarEeTHtQ4L90RJbVg8CUqMjWFY4N1nBI8+D1tBH3xetCIVcsh+bEb+cAdzA
	 ufLAfcylrBIObqUxjLoTH74XL6QZgBraLI0/afR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHJPUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgHJPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:20:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9316620656;
        Mon, 10 Aug 2020 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072828;
        bh=58qp4gOupZaoLJO0q94LemFcLAKgWx1mlx/wmqqzCws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6FTiznwZ4dkzUQWHeLLpoTmuZs7KfP5bXesdc124wBIWJfpvBY+oLFlgNdH9Vut0
         cZEnCQJEe9V6//CLxDE3UYJlwcSieUskqPESXZWVhAn8CESCc28eQIpV5brGGR7tkR
         43U+JA7BqT/YRkAVT4jCZdAG3TJPFYQbltaLOjMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.8 32/38] Revert "powerpc/kasan: Fix shadow pages allocation failure"
Date:   Mon, 10 Aug 2020 17:19:22 +0200
Message-Id: <20200810151805.497933109@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151803.920113428@linuxfoundation.org>
References: <20200810151803.920113428@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit b506923ee44ae87fc9f4de16b53feb313623e146 upstream.

This reverts commit d2a91cef9bbdeb87b7449fdab1a6be6000930210.

This commit moved too much work in kasan_init(). The allocation
of shadow pages has to be moved for the reason explained in that
patch, but the allocation of page tables still need to be done
before switching to the final hash table.

First revert the incorrect commit, following patch redoes it
properly.

Fixes: d2a91cef9bbd ("powerpc/kasan: Fix shadow pages allocation failure")
Cc: stable@vger.kernel.org
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208181
Link: https://lore.kernel.org/r/3667deb0911affbf999b99f87c31c77d5e870cd2.1593690707.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/kasan.h      |    2 ++
 arch/powerpc/mm/init_32.c             |    2 ++
 arch/powerpc/mm/kasan/kasan_init_32.c |    4 +---
 3 files changed, 5 insertions(+), 3 deletions(-)

--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -27,10 +27,12 @@
 
 #ifdef CONFIG_KASAN
 void kasan_early_init(void);
+void kasan_mmu_init(void);
 void kasan_init(void);
 void kasan_late_init(void);
 #else
 static inline void kasan_init(void) { }
+static inline void kasan_mmu_init(void) { }
 static inline void kasan_late_init(void) { }
 #endif
 
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -171,6 +171,8 @@ void __init MMU_init(void)
 	btext_unmap();
 #endif
 
+	kasan_mmu_init();
+
 	setup_kup();
 
 	/* Shortly after that, the entire linear mapping will be available */
--- a/arch/powerpc/mm/kasan/kasan_init_32.c
+++ b/arch/powerpc/mm/kasan/kasan_init_32.c
@@ -117,7 +117,7 @@ static void __init kasan_unmap_early_sha
 	kasan_update_early_region(k_start, k_end, __pte(0));
 }
 
-static void __init kasan_mmu_init(void)
+void __init kasan_mmu_init(void)
 {
 	int ret;
 	struct memblock_region *reg;
@@ -146,8 +146,6 @@ static void __init kasan_mmu_init(void)
 
 void __init kasan_init(void)
 {
-	kasan_mmu_init();
-
 	kasan_remap_early_shadow_ro();
 
 	clear_page(kasan_early_shadow_page);


