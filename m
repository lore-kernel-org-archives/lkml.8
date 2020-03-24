Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCFEC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D442080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ez14tv5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgCXOYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36034 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgCXOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6ytk5toi7ed/P8/QssHvJfGQ5q0+1cUdkvB+sfDzJjE=; b=ez14tv5NMuAfam2g+bKqJlHUod
        AfXUbDjFq4B3gezzaBOGbBi3Ch4FBfpWeF3J7AQga0Mkebh0gW9FnRjzsq7+MI76GTGohFtLpU+nb
        cNyJVFieKbzLpisLknKSds29zt1az2UvmrcTRehTDF6XRgn79jswopGPfkZfI3W2dpjYhBa204tG8
        snmDtAmM0i615pgSX/FgTs18Q7B0iA3Qvz7VPckzvoO1qdCyBkK/HoxnLH8J/BHdxUjvjnnBFyz7w
        80lo5Hr8IQ7YF8zqGUsapwPnDVJTGu1RvPlFCo4I9TFINf4NbTUQvdDdq26SrsQDcFlLzWEi6hTOd
        Ne1RNHzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTv-0001hV-MR; Tue, 24 Mar 2020 14:24:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81FED307966;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D871286C13B8; Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Message-Id: <20200324142245.940973110@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 11/17] static_call: Simple self-test
References: <20200324135603.483964896@infradead.org>
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


