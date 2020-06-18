Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66DD520739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qpw0iIv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgFROuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgFROus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:50:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD0FC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VtYCJE/oH9RIRtB69gnARcAs6iVGsEeQiZ4RuRx1+NU=; b=qpw0iIv5LPlE8oAua3R2FeHhn2
        silltdUfW3egjsCz90mMwLG8l2sGvtpjjHEYcTqQih07HpCPguwZAv7XtBM8QTYS5cpkjR3liDTGh
        p3TRenuyn7OwdQnzYKyhtMmkUsLdg1Icm9R3TAF4wwl5LmK6IwWXpjl4IdeKVoEzchHbm8k/uSDMO
        oSLAcr87ks/h2DEE7DNCq6lJ0y74Uncpl7JleA52rjuzuz3q32hA73FOI4m98p8tPS8mQ3633RIh+
        NrLsHPCvjhnGVtm33hb8sKGSiPcM0YH6wAg5n44/8Nc3SKQjGtls16fhDjzsDG6lY/wGfRHUx9GKG
        45iChykA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvsA-0002xi-8V; Thu, 18 Jun 2020 14:50:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 582243075EF;
        Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 214D02146C3FE; Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Message-ID: <20200618144801.642309720@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 16:44:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
References: <20200618144407.520952071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe_kernel_read() leaves .noinstr.text section

Since we use UD2 as a short-cut for 'CALL __WARN', treat it as such.
Have the bare exception handler do the report_bug() thing.

Fixes: 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like entries")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
---
 arch/x86/kernel/traps.c |   50 +++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -216,40 +216,34 @@ static inline void handle_invalid_op(str
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
+static noinstr bool handle_bug(struct pt_regs *regs)
+{
+	bool handled = false;
+
+	/*
+	 * All lies, just get the WARN/BUG out.
+	 */
+	instrumentation_begin();
+	if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
+		regs->ip += LEN_UD2;
+		handled = true;
+	}
+	instrumentation_end();
+
+	return handled;
+}
+
 DEFINE_IDTENTRY_RAW(exc_invalid_op)
 {
 	bool rcu_exit;
 
 	/*
-	 * Handle BUG/WARN like NMIs instead of like normal idtentries:
-	 * if we bugged/warned in a bad RCU context, for example, the last
-	 * thing we want is to BUG/WARN again in the idtentry code, ad
-	 * infinitum.
+	 * We use UD2 as a short encoding for 'CALL __WARN', as such
+	 * handle it before exception entry to avoid recursive WARN
+	 * in case exception entry is the one triggering WARNs.
 	 */
-	if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
-		enum bug_trap_type type;
-
-		nmi_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_finish();
-		type = report_bug(regs->ip, regs);
-		if (regs->flags & X86_EFLAGS_IF)
-			trace_hardirqs_on_prepare();
-		instrumentation_end();
-		nmi_exit();
-
-		if (type == BUG_TRAP_TYPE_WARN) {
-			/* Skip the ud2. */
-			regs->ip += LEN_UD2;
-			return;
-		}
-
-		/*
-		 * Else, if this was a BUG and report_bug returns or if this
-		 * was just a normal #UD, we want to continue onward and
-		 * crash.
-		 */
-	}
+	if (!user_mode(regs) && handle_bug(regs))
+		return;
 
 	rcu_exit = idtentry_enter_cond_rcu(regs);
 	instrumentation_begin();


