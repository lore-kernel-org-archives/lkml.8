Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98706C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76940206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHACZ8Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404659AbgFXPwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404606AbgFXPvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5CBC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2Qsfk0HOB3x9nc2pqsOJnCHVpv340CkHcue6gSdP15s=; b=FHACZ8OkiEyxYLkMEia3AT7amH
        5uhJITj4XXLZaUpJMFC7LUy6dw9gFmR1fUdu1v8f4frCmbhl/obmB12hoWrXjjmPEpyQ2W2QRHEta
        lhOsQ6MOs0g+Meosuchl49q8O2WXcdIDYD94/Tela2/OY/YYqr2KwO7Hr4XiRP6pnqZRP380W2P+9
        /iucd+rpRYliYvf7HH++pl3b0CU3q2OiADmtqjzeQathc4e9Qie+C+ak65350YCzoNV4nTwKvrDnb
        ssrOFZOFZ2bnj1yM1hac4bHSsbcgTlS0OM6Ir+IrixqOWgXRNYZVVx+O9zX5VSQ3c2AMTR6a1tFD9
        BYShSSLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gC-0001cX-7f; Wed, 24 Jun 2020 15:51:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA88A3007CD;
        Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D97B4236E775B; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624154156.969420584@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 04/17] jump_label,module: Fix module lifetime for __jump_label_mod_text_reserved
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing ensures the module exists while we're iterating
mod->jump_entries in __jump_label_mod_text_reserved(), take a module
reference to ensure the module sticks around.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/jump_label.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -539,19 +539,25 @@ static void static_key_set_mod(struct st
 static int __jump_label_mod_text_reserved(void *start, void *end)
 {
 	struct module *mod;
+	int ret;
 
 	preempt_disable();
 	mod = __module_text_address((unsigned long)start);
 	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
+	if (!try_module_get(mod))
+		mod = NULL;
 	preempt_enable();
 
 	if (!mod)
 		return 0;
 
-
-	return __jump_label_text_reserved(mod->jump_entries,
+	ret = __jump_label_text_reserved(mod->jump_entries,
 				mod->jump_entries + mod->num_jump_entries,
 				start, end);
+
+	module_put(mod);
+
+	return ret;
 }
 
 static void __jump_label_mod_update(struct static_key *key)


