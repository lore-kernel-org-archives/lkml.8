Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDE7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1787820767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MfWWEdwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgIBNtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgIBNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:41:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1789BC06123B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HLJQCZHx6poAziNUgEdGRzGFUk3q15Hg/3SXsnWe/Zo=; b=MfWWEdwYq0knADT+MsiPZXiJub
        7eVu6bk577u/zpj5cOmG3zltjwUbJO183eW3qS0VHaAH5HkC0vDxFLnUisfgBBCpmN1lRZjCgkylB
        0NHToSfJNVc+ma2vGWtSQG8BErKFtRC2HeV6kUMl9oc4VXB/zhM2Ufg45Uv2vmheufbXj2olW0cev
        KVBkNHsNFvhNMLaUXmTR1reyY2UxvP7zScZ9MpYB9D4gmu6szvwkv5rmynLp5j5CBCdXY/nS1JD6R
        qIDals+GBf7qhGWVxp8BsQioPeFrF8of8qoMsVDU3HYrphlnqSOMUhxvVkxNI0ezXXesXwAsiZbf8
        4bTn5PVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDSxr-0002dd-EB; Wed, 02 Sep 2020 13:38:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3D203062BA;
        Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AE88020104617; Wed,  2 Sep 2020 15:38:11 +0200 (CEST)
Message-ID: <20200902133200.666781610@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Sep 2020 15:25:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH 01/13] x86/entry: Fix AC assertion
References: <20200902132549.496605622@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

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
@@ -18,8 +18,16 @@ static __always_inline void arch_check_u
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
+		if (boot_cpu_has(X86_FEATURE_SMAP) ||
+		    (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
+			mask |= X86_EFLAGS_AC;
+
+		WARN_ON_ONCE(flags & mask);
 
 		/* We think we came from user mode. Make sure pt_regs agrees. */
 		WARN_ON_ONCE(!user_mode(regs));


