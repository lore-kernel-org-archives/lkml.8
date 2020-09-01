Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38956C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176E62083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVEC2u8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VV2JJXCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgIAL6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:58:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgIALtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:33 -0400
Date:   Tue, 01 Sep 2020 11:48:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85wVmOm1kMlurlnGYumf8OEnfaCq3Wezd7o8nByDQG4=;
        b=bVEC2u8n0ZGyDr//mpfmRh9GjqYlNLFGhrtKo1D3qTL7iPo2UqvHkS+W2OESSEN97i2uqD
        l2RgjU/mhJJAwrMg+Y8zbC4krKUyHnlsckRV0pz9FyM7JednIsqQi26SI2bsks6HbGi6tb
        KPK2P2M/pLP22K0eowzI65gMhm2DjtJ2BpNzCZ4siAsfv+ZOXP6EbHO/WpKpIyf3o1la2m
        /Ofw+4A/8YAaAWJEkof13JGByuZJQDopvLyHLBgoPiIkSQTM9CPg9G5G734QmkATPaF1jJ
        o1ot7rJpFnh03h+09bqibcHWb0wXSupqvzSfyV+HJDxnrTy160sVw5TrnkFrfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85wVmOm1kMlurlnGYumf8OEnfaCq3Wezd7o8nByDQG4=;
        b=VV2JJXCe7ZQO+nj/zQsF7Sc1Poi56kb5aEssRE091uBAoScC/aU+atSBZDIrjcc3k+WsI+
        wX4YFlryi+sa0hAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] jump_label,module: Fix module lifetime for
 __jump_label_mod_text_reserved()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.504501338@infradead.org>
References: <20200818135804.504501338@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088779.20229.8498091230478204573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     0db6e3734b130207026df1e78455fa98ca1d6f50
Gitweb:        https://git.kernel.org/tip/0db6e3734b130207026df1e78455fa98ca1d6f50
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:39 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:04 +02:00

jump_label,module: Fix module lifetime for __jump_label_mod_text_reserved()

Nothing ensures the module exists while we're iterating
mod->jump_entries in __jump_label_mod_text_reserved(), take a module
reference to ensure the module sticks around.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20200818135804.504501338@infradead.org
---
 kernel/jump_label.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index cdb3ffa..e661c61 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -539,19 +539,25 @@ static void static_key_set_mod(struct static_key *key,
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
