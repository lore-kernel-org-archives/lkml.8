Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CFBC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A06D20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejzHNZbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgAaM4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 07:56:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgAaM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 07:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gmy4IB9yY3Tb1BEcngwE71ugeFa/zavNLfcPY3t/sPw=; b=ejzHNZbCFp0vJk3V9A07jD9T0Y
        a+4CMFresbe9wCKs9s/AMftfK1FukjiAzqHfubfUNYlvu61xPpLZPJOr8AUKLrgLIvvKlrqL/Wcqu
        EcmzAQeYU0bWCQwCRXzU9V0c9LgGJC07FlJPOP7YUVWWmeLfgmWU2nGcER9dtHtMUQ3Mv6VcngY+b
        kS2LcRkC0U04uyRttTbHPTyhiqUGzBcxNIG/gQLfDmnstLy6tF2UqtdlsxDbjYq5bNks97mcVN2pZ
        tVhZv7ALpPhhMLoZxZ3DOB4hLCrDkes3ErhlfZpRQQ93yqQaOdSNsuVvV/sv2IDBEv3Oqn8jlu9Ti
        EBpMTeoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixVq7-0001Z9-1p; Fri, 31 Jan 2020 12:56:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3770E3011DD;
        Fri, 31 Jan 2020 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E06F42B4C4270; Fri, 31 Jan 2020 13:56:00 +0100 (CET)
Message-Id: <20200131125403.540057688@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 31 Jan 2020 13:45:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH -v2 02/10] m68k,mm: Fix ColdFire pgd_alloc()
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

I also notice that building for m5475evb_defconfig with vanilla v5.5
triggers this scary looking warning due to a mismatch between the pgd
size and the (8k!) page size:

 | In function 'pgd_alloc.isra.111',
 |     inlined from 'mm_alloc_pgd' at kernel/fork.c:634:12,
 |     inlined from 'mm_init.isra.112' at kernel/fork.c:1043:6:
 | ./arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' forming offset [4097, 8192] is out of the bounds [0, 4096] of object 'kernel_pg_dir' with type 'pgd_t[1024]' {aka 'struct <anonymous>[1024]'} [-Warray-bounds]
 |  #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
 |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
 | ./arch/m68k/include/asm/mcf_pgalloc.h:93:2: note: in expansion of macro 'memcpy'
 |   memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
 |   ^~~~~~

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/include/asm/mcf_pgalloc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -90,7 +90,7 @@ static inline pgd_t *pgd_alloc(struct mm
 	new_pgd = (pgd_t *)__get_free_page(GFP_DMA | __GFP_NOWARN);
 	if (!new_pgd)
 		return NULL;
-	memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
+	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
 	memset(new_pgd, 0, PAGE_OFFSET >> PGDIR_SHIFT);
 	return new_pgd;
 }


