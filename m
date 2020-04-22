Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59628C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44BCF20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgDVRBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:01:20 -0400
Received: from verein.lst.de ([213.95.11.211]:53665 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgDVRBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:01:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 485BF68C4E; Wed, 22 Apr 2020 19:01:16 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:01:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
Message-ID: <20200422170116.GA28345@lst.de>
References: <1ED37D02-125F-4919-861A-371981581D9E@lca.pw>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ED37D02-125F-4919-861A-371981581D9E@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 22, 2020 at 11:55:54AM -0400, Qian Cai wrote:
> Reverted the linux-next commit and its dependency,
> 
> a85573f7e741 ("x86/mm: Unexport __cachemode2pte_tbl”)
> 9e294786c89a (“x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()”)
> 
> fixed crashes or hard reset on AMD machines during boot that have been flagged by
> KASAN in different forms indicating some sort of memory corruption with this config,

Interesting.  Your config seems to boot fine in my VM until the point
where the lack of virtio-blk support stops it from mounting the root
file system.

Looking at the patch I found one bug, although that should not affect
your config (it should use the pgprotval_t type), and one difference
that could affect code generation, although I prefer the new version
(use of __pgprot vs a local variable + pgprot_val()).

Two patches attached, can you try them?

--LQksG6bCIzRHxTLp
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-x86-Use-pgprotval_t-in-protval_4k_2_large-and-pgprot.patch"

From 71829ed28a4f3d616382e7a362d501eb9ea7dc13 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 22 Apr 2020 18:53:08 +0200
Subject: x86: Use pgprotval_t in protval_4k_2_large and pgprot_4k_2_large

Use the proper type for "raw" page table values.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pgtable_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 567abdbd64d3..7b6ddcf77d70 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -478,7 +478,7 @@ static inline pteval_t pte_flags(pte_t pte)
 
 unsigned long cachemode2protval(enum page_cache_mode pcm);
 
-static inline unsigned long protval_4k_2_large(unsigned long val)
+static inline pgprotval_t protval_4k_2_large(pgprotval_t val)
 {
 	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
 		((val & _PAGE_PAT) << (_PAGE_BIT_PAT_LARGE - _PAGE_BIT_PAT));
@@ -487,7 +487,7 @@ static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
 {
 	return __pgprot(protval_4k_2_large(pgprot_val(pgprot)));
 }
-static inline unsigned long protval_large_2_4k(unsigned long val)
+static inline pgprotval_t protval_large_2_4k(pgprotval_t val)
 {
 	return (val & ~(_PAGE_PAT | _PAGE_PAT_LARGE)) |
 		((val & _PAGE_PAT_LARGE) >>
-- 
2.26.1


--LQksG6bCIzRHxTLp
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-foo.patch"

From e5a6c2e84accad3d528c5c90c74071d10079db9a Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 22 Apr 2020 18:54:45 +0200
Subject: foo

---
 arch/x86/include/asm/pgtable_types.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 7b6ddcf77d70..c6d4725269bb 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -485,7 +485,10 @@ static inline pgprotval_t protval_4k_2_large(pgprotval_t val)
 }
 static inline pgprot_t pgprot_4k_2_large(pgprot_t pgprot)
 {
-	return __pgprot(protval_4k_2_large(pgprot_val(pgprot)));
+	pgprot_t new;
+
+	pgprot_val(new) = protval_4k_2_large(pgprot_val(pgprot));
+	return new;
 }
 static inline pgprotval_t protval_large_2_4k(pgprotval_t val)
 {
@@ -495,9 +498,11 @@ static inline pgprotval_t protval_large_2_4k(pgprotval_t val)
 }
 static inline pgprot_t pgprot_large_2_4k(pgprot_t pgprot)
 {
-	return __pgprot(protval_large_2_4k(pgprot_val(pgprot)));
-}
+	pgprot_t new;
 
+	pgprot_val(new) = protval_large_2_4k(pgprot_val(pgprot));
+	return new;
+}
 
 typedef struct page *pgtable_t;
 
-- 
2.26.1


--LQksG6bCIzRHxTLp--
