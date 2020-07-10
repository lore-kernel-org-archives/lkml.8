Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643D6C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2A3207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x9PhXOyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGJNob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJNoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A352C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6ytk5toi7ed/P8/QssHvJfGQ5q0+1cUdkvB+sfDzJjE=; b=x9PhXOyKwpZCAfzGOlMsr6CtqT
        vQdSR10qdBUIkJwVRjNG/ikdhzlEhDjLs1g0Oc0hKOkYQr0Kf3E4wAomxEzxCiSndGT2VqGPYt2vp
        VpI4721z7b08+OfEIOVZdJymUow3XWCA9Bicp6kr51B89xqBuWRgwM355h/1OH3VUw2YA7kxweW3t
        VOcvufa8dpeuaSi58aMDpKWvYuHjHCLsFzgmZWc1l3gX4pSLlMFF6unN78xyOTAxue8eJ881ZuSpN
        DZ7tbJhD7ZbSVJOf9GxC++hVsMEtA/dVcrXR0cVojoDnRXVB/Nuekgg3Cx4vHETUIlYs2QGBFM61L
        di8/Uz5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttK2-000182-1q; Fri, 10 Jul 2020 13:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D743730797C;
        Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0F6DC2B7A733B; Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Message-ID: <20200710134336.798619415@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Jul 2020 15:38:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v6 11/17] static_call: Simple self-test
References: <20200710133831.943894387@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig         |    6 ++++++
 kernel/static_call.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
@@ -364,3 +364,31 @@ static void __init static_call_init(void
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
+static int __init test_static_call_init(void)
+{
+	WARN_ON(static_call(sc_selftest)(2) != 3);
+	static_call_update(sc_selftest, &func_b);
+	WARN_ON(static_call(sc_selftest)(2) != 4);
+	static_call_update(sc_selftest, &func_a);
+	WARN_ON(static_call(sc_selftest)(2) != 3);
+
+	return 0;
+}
+early_initcall(test_static_call_init);
+
+#endif /* CONFIG_STATIC_CALL_SELFTEST */


