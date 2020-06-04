Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40481C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9B5206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z5o/s2Yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFDKZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgFDKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BCBC03E97D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4xLbMzeVbeH3u0A7zApTQ56UOcpBzDKP0lu5oB5vj54=; b=Z5o/s2YqD+Hajif6i7LzbvnlbE
        2VmnwDzt/Pttk67YmQ9EW1GF4nbsjsOxFgbvCImWCwwmQqM8t7gJ0zNucKzHO3Hfk16+mgztWrBoi
        kMRCf0WjKLeWGVvdrutj/g7ccWPVndUDOPxfRm3bi97c4RAGIm8HHN4pH6vtqSrMHCpe0JUcIZ7QZ
        ccvDlWzzzowLnzKhaCOtZRGgARsnZqcrur6CAoLFcbZqInOp9vbDWgUH1xMl0WYHJiZ63gTJFh0F1
        HVDl/uuDiU0tVhZtppKngLDa1H4K6D1bFkEH9EszneNgQZCVCKbet1nhwyN+MlzU9BHDUaeHXoyVG
        DIUtoD6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgn3d-0003tZ-4T; Thu, 04 Jun 2020 10:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAF0830280D;
        Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D64912007CDE8; Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Message-ID: <20200604102427.963062528@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Jun 2020 12:22:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 1/8] x86, kcsan: Remove __no_kcsan_or_inline usage
References: <20200604102241.466509982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that KCSAN relies on -tsan-distinguish-volatile we no longer need
the annotation for constant_test_bit(). Remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bitops.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,12 +201,8 @@ arch_test_and_change_bit(long nr, volati
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
-static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
+static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
-	/*
-	 * Because this is a plain access, we need to disable KCSAN here to
-	 * avoid double instrumentation via instrumented bitops.
-	 */
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }


