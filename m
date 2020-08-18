Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED03C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A292120825
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NbZZvuVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHRONE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHROM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F07C061345
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qyuZ4Fe2lEi9VRctd1Q1XO35Z3fFopV9KxbHulfliIk=; b=NbZZvuVEKTwVaaLkTnpr/gWHbv
        Ffggjxv1E9gM3pVizQo3QNLL0DamkGTrnWu0PTY6DA/1wKeTbrHheynYPZ+jysiAE+oD/Y4uiJ95w
        rydwdDaltdIMookN1hl5BN+qVu4CgtGCEXop+nAhlgyACSEN6MpvgDK0uHZtdYIlC/EU9c40c4vqR
        ML7HwWV2/A8ZY18fDQWEiu/yDTJRmLf3LxMPGRWZlLx2hhtHmqYgqBdN0QgOyDCOfNloUSJmyjMTd
        yOuYcjg8od1Ik4Q7zQ8o77Mt59GKNXEbmQsi5PiTD3EDV1grotlydpscEbkO0VP93tJZUEWWv3c24
        kAqOq1vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LK-0000oD-Px; Tue, 18 Aug 2020 14:12:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A71B9307890;
        Tue, 18 Aug 2020 16:12:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C485923D42C0B; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135804.922581202@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 11/18] static_call: Simple self-test
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig         |    6 ++++++
 kernel/static_call.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -103,6 +103,12 @@ config STATIC_KEYS_SELFTEST
 	help
 	  Boot time self-test of the branch patching code.
 
+config STATIC_CALL_SELFTEST
+	bool "Static call selftest"
+	depends on HAVE_STATIC_CALL
+	help
+	  Boot time self-test of the call patching code.
+
 config OPTPROBES
 	def_bool y
 	depends on KPROBES && HAVE_OPTPROBES
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -365,3 +365,46 @@ static void __init static_call_init(void
 #endif
 }
 early_initcall(static_call_init);
+
+#ifdef CONFIG_STATIC_CALL_SELFTEST
+
+static int func_a(int x)
+{
+	return x+1;
+}
+
+static int func_b(int x)
+{
+	return x+2;
+}
+
+DEFINE_STATIC_CALL(sc_selftest, func_a);
+
+static struct static_call_data {
+      int (*func)(int);
+      int val;
+      int expect;
+} static_call_data [] __initdata = {
+      { NULL,   2, 3 },
+      { func_b, 2, 4 },
+      { func_a, 2, 3 }
+};
+
+static int __init test_static_call_init(void)
+{
+      int i;
+
+      for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
+	      struct static_call_data *scd = &static_call_data[i];
+
+              if (scd->func)
+                      static_call_update(sc_selftest, scd->func);
+
+              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
+      }
+
+      return 0;
+}
+early_initcall(test_static_call_init);
+
+#endif /* CONFIG_STATIC_CALL_SELFTEST */


