Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BEAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA912071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gh2Aew0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHXKOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHXKOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:14:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GB9GfMVc5/rXiLAjmmHZ5veM/LFcowYM33cdlsmV/p0=; b=Gh2Aew0daIZO235XO0H01dAXs4
        +QXV4xWAgRc3J6asiUl7l/ZUQoXzV877XKa16hY9E5OBAZhZzv89rqC+No5G57Xla/g/8ywRWI7VL
        sKaoW1d21z0HMJuEu/E13/L9I9LZec+2QZ/+69bPpNMSbyWMcttby6uVUcmZ57PLgRtRmbcl0ieeB
        5EaKdHDS41ynIFXAEamOzrMbBXlAAbJ+DjZlVLAhc4ysMEm6LGoOiFvKy3KD9zq7vc1WPqzcKgl8u
        6gqFwKG2rlwqlJdiftZIxWTw0UsI3yhlmNc9z12tSSYaqQgXY491d+xb1ZKfNTmrJjXA1WpFY8ivp
        BKLV5Qgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kA9Ul-0004OO-Cn; Mon, 24 Aug 2020 10:14:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D877B30280E;
        Mon, 24 Aug 2020 12:14:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2A622BEC4859; Mon, 24 Aug 2020 12:14:28 +0200 (CEST)
Date:   Mon, 24 Aug 2020 12:14:28 +0200
From:   peterz@infradead.org
To:     x86@kernel.org
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/entry: Fix AC assertion
Message-ID: <20200824101428.GS1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The WARN added in commit 3c73b81a9164 ("x86/entry, selftests: Further
improve user entry sanity checks") unconditionally triggers on my IVB
machine because it does not support SMAP.

For !SMAP hardware we patch out CLAC/STAC instructions and thus if
userspace sets AC, we'll still have it set after entry.

Fixes: 3c73b81a9164 ("x86/entry, selftests: Further improve user entry sanity checks")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/entry-common.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -18,8 +18,15 @@ static __always_inline void arch_check_u
 		 * state, not the interrupt state as imagined by Xen.
 		 */
 		unsigned long flags = native_save_fl();
-		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
-				      X86_EFLAGS_NT));
+		unsigned long mask = X86_EFLAGS_DF | X86_EFLAGS_NT;
+
+		/*
+		 * For !SMAP hardware we patch out CLAC on entry.
+		 */
+		if (boot_cpu_has(X86_FEATURE_SMAP))
+			mask |= X86_EFLAGS_AC;
+
+		WARN_ON_ONCE(flags & mask);
 
 		/* We think we came from user mode. Make sure pt_regs agrees. */
 		WARN_ON_ONCE(!user_mode(regs));
