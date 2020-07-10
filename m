Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C0C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089AE2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRcgCgjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGJNop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgGJNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FDFC08E8A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2Qsfk0HOB3x9nc2pqsOJnCHVpv340CkHcue6gSdP15s=; b=aRcgCgjH0DlMSBaIu3OhM995pN
        5TSmKw4I1MxBQ2jBlaHOO33IZKsHliFrX6XOBdlIlQIUNqj1fDb19XPH+DcDEWfEPNDIABcJUWAVe
        wYPaBvcCJRZd6Uff2yxkpSUUuijaUrjt2TQga1xVXyCuv7TeAQYrb5velm9Sh/PAKgSEEopD6eCp/
        BqsJHAuOKqacBhLvlmHNssFbB3I4Pf/1AEwYe680bZV0X+mB9+BUlG7bCVq91QhQrenqwAcKaSQ8H
        EA3OP2PpNwNAS+QzhqZ0k2lqcIf1PK6Law5iEC5lnvC8UU0csV3eONTYQMeHxhJ5B7H6c/Vsxmbxm
        k6NfZQMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttJz-0003ss-MQ; Fri, 10 Jul 2020 13:44:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E816306099;
        Fri, 10 Jul 2020 15:44:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DF7382B7A7334; Fri, 10 Jul 2020 15:44:09 +0200 (CEST)
Message-ID: <20200710134336.380692290@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Jul 2020 15:38:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v6 04/17] jump_label,module: Fix module lifetime for __jump_label_mod_text_reserved
References: <20200710133831.943894387@infradead.org>
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


