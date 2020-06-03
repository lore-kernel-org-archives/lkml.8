Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E37C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DE220678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3iIhUE01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFCSRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:17:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B141C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vsOgcRZrbdf5xHzmcx7xUeya+RKEZLT28sw6blnmXJQ=; b=3iIhUE01YTZdyixR+M56LBUYYw
        BZyuak+gKuvumgjUme9G/ci/y21F03V0XePQLDVOulsuOJ/TUN26yX1Qx1+0GCHb8HBnEKcDuGPkF
        cKjX0iCEjw3n8V3AT4EhGyzvbBYkAt3R2VbDCjlTNXDRsn07gYN7/z5i3VlpgeesoT3zQjRcBpuSH
        DNXww2lC1eObmL4w2kNiJ2rqX3gpuXLFABZ9vxmLOHo7g527oIbWUF/u2Yrz0bwK94EiHIL56qJPI
        bL8EFIbPIs6qlAjcUvSaC2RWcEt68dzLzIabl5pDcMj1+i2/cDV0tZbmBd0XgEIm9pNGXo15lN1yQ
        f1CXLRZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgXwP-0006Wj-5Y; Wed, 03 Jun 2020 18:16:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 729D23006D0;
        Wed,  3 Jun 2020 20:16:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E2DC20C6A1FA; Wed,  3 Jun 2020 20:16:38 +0200 (CEST)
Date:   Wed, 3 Jun 2020 20:16:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
Message-ID: <20200603181638.GD2627@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net>
 <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net>
 <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
 <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com>
 <20200603160722.GD2570@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603160722.GD2570@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:07:22PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 03, 2020 at 04:47:54PM +0200, Marco Elver wrote:

> > With that in mind, you could whitelist "__ubsan_handle"-prefixed
> > functions in objtool. Given the __always_inline+noinstr+__ubsan_handle
> > case is quite rare, it might be reasonable.
> 
> Yes, I think so. Let me go have dinner and then I'll try and do a patch
> to that effect.

Here's a slightly more radical patch, it unconditionally allows UBSAN.

I've not actually boot tested this.. yet.

---
Subject: x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Jun  3 20:09:06 CEST 2020

The UBSAN instrumentation only inserts external CALLs when things go
'BAD', much like WARN(). So treat them similar to WARN()s for noinstr,
that is: allow them, at the risk of taking the machine down, to get
their message out.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler_types.h |    2 +-
 tools/objtool/check.c          |   28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -199,7 +199,7 @@ struct ftrace_likely_data {
 /* Section for code which can't be instrumented at all */
 #define noinstr								\
 	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_sanitize_undefined
+	__no_kcsan __no_sanitize_address
 
 #endif /* __KERNEL__ */
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2190,10 +2190,36 @@ static inline const char *call_dest_name
 	return "{dynamic}";
 }
 
+static inline bool noinstr_call_dest(struct symbol *func)
+{
+	/*
+	 * We can't deal with indirect function calls at present;
+	 * assume they're instrumented.
+	 */
+	if (!func)
+		return false;
+
+	/*
+	 * If the symbol is from a noinstr section; we good.
+	 */
+	if (func->sec->noinstr)
+		return true;
+
+	/*
+	 * The __ubsan_handle_*() calls are like WARN(), they only happen when
+	 * something 'BAD' happened. At the risk of taking the machine down,
+	 * let them proceed to get the message out.
+	 */
+	if (!strncmp(func->name, "__ubsan_handle_", 15))
+		return true;
+
+	return false;
+}
+
 static int validate_call(struct instruction *insn, struct insn_state *state)
 {
 	if (state->noinstr && state->instr <= 0 &&
-	    (!insn->call_dest || !insn->call_dest->sec->noinstr)) {
+	    !noinstr_call_dest(insn->call_dest)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
