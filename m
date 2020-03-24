Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD12EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857F12080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCwRm6eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgCXOZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:25:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgCXOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2Qsfk0HOB3x9nc2pqsOJnCHVpv340CkHcue6gSdP15s=; b=aCwRm6eRhy2j4SD2NOzM/vKFTM
        0lKCrv0vIbvkypOEH5o50Qo7HrQc1suavNkJr/tma/L3PAfP4+8TYAHYaHZD05AjkCYXuQNrqOk7k
        zfrjps0GqbOqi0uFvELU5kwUV2gZYgjy5GoNYx1uMaGsHdxSbScmfBt2Zfwt40PIhKxzQAFBwRPFO
        7AtQn8/SiQQ2OrHzMcwwZothMX9YZnc9/N73JSBvzmKl979N3WfY1tingxGBVZyoXOx6MWADobr+3
        QpNmkhEnLQQ+wdrGbfFAuDhxHTfxgSyMpIZdth288P5rOkjzl+GC2x+FuqwLcTtvsBDv9v1Np9XqE
        C3cIX9LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTt-0001fa-KF; Tue, 24 Mar 2020 14:24:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18FC2307770;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F3889286C13B1; Tue, 24 Mar 2020 15:24:34 +0100 (CET)
Message-Id: <20200324142245.509814003@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 04/17] jump_label,module: Fix module lifetime for __jump_label_mod_text_reserved
References: <20200324135603.483964896@infradead.org>
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


