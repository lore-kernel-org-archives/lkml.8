Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4822074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pc+UK6AQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFDKZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgFDKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:25:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88416C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HLUlGVzGh8D/8ZTgbqliDFpKr8IxVRxtSm/kD93Ik8k=; b=Pc+UK6AQ+epiZFSmkQttxPE1wH
        bVDuIRIcMZYjH92oSkk1fBAzlV0eUUB0WTnV2xXoMfghdXRhWgee3JpOxsegzMhymXM9Lk2nZhhJo
        j4warJ9WabkmyPxP+704iiAjQ2MmFnOE2C0q2hTrYxKBSPMfr+xSpfqLPjXhpQhg4KXNZBeVt3HIs
        vjx5k8rbDwGccgdjsFMHTu7V5CDJNxkioZf8211BTUiTam/EA3WI9gUkPOeNoh8i2Mu5BjkxXGSFn
        qziJEj5ylnqBJc1PtwjYjr5hqsb24XiRFAuji5wWa6X7/TbesJ0LZ1OgWswbsbvfnqupPvpzyJAfv
        QWK5yNng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgn3d-0001ap-Io; Thu, 04 Jun 2020 10:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F023306D6D;
        Thu,  4 Jun 2020 12:25:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E9B2420CC68B5; Thu,  4 Jun 2020 12:25:07 +0200 (CEST)
Message-ID: <20200604102428.307943402@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Jun 2020 12:22:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 7/8] x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
References: <20200604102241.466509982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UBSAN instrumentation only inserts external CALLs when things go
'BAD', much like WARN(). So treat them similar to WARN()s for noinstr,
that is: allow them, at the risk of taking the machine down, to get
their message out.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
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


