Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D24C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D321D20578
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DU6l9Rqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgG3GKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgG3GKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C39C0619D5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ajn8A7ieLOdvkHmqDHWkDin8UoyM6nGIIdZB2H8Jcwk=; b=DU6l9RqejOr4FWp4Da3uvA2Tt4
        UydC2aUE0VQBnLaCuPKIApC77ahsUYNJ7ym6aAD3tRCfVi4dXLsEfGRW7Ah+m8aJ9jf0Bv00Fmrs8
        z73Ua0zzNgoGIMRMVh0Rck0NwY/g6Y7y1Pm1YsVs6soFEFFLQcW2EV2uURtVeyXXXKGnRzK6roMZA
        +24uikCApmvpEG2r7D3cNl2lt7cu6Hug5AwDLhA7QCTn/NuDwsw/W6qG2I3Dfn98xVkpV1Vl1xMdR
        ysacCZ1WKDzjl3jnpaKoWPg1Sqvz5Trzt6MT4kBEaSiAMt1Qs42xfvBxkYodq2km3wzfPmtqZYGMF
        xXumZgCQ==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11m5-0007V4-Hu; Thu, 30 Jul 2020 06:10:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/8] modules: return licensing information from find_symbol
Date:   Thu, 30 Jul 2020 08:10:26 +0200
Message-Id: <20200730061027.29472-8-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730061027.29472-1-hch@lst.de>
References: <20200730061027.29472-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report the GPLONLY status through a new argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/module.h |  2 +-
 kernel/module.c        | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index be04ba2f881daa..30b0f5fcdb3c37 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -582,7 +582,7 @@ struct module *find_module(const char *name);
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
 	const s32 *crcs;
-	enum {
+	enum mod_license {
 		NOT_GPL_ONLY,
 		GPL_ONLY,
 		WILL_BE_GPL_ONLY,
diff --git a/kernel/module.c b/kernel/module.c
index a0df783a8a6e5b..afb2bfdd5134b3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -495,6 +495,7 @@ struct find_symbol_arg {
 	struct module *owner;
 	const s32 *crc;
 	const struct kernel_symbol *sym;
+	enum mod_license license;
 };
 
 static bool check_exported_symbol(const struct symsearch *syms,
@@ -528,6 +529,7 @@ static bool check_exported_symbol(const struct symsearch *syms,
 	fsa->owner = owner;
 	fsa->crc = symversion(syms->crcs, symnum);
 	fsa->sym = &syms->start[symnum];
+	fsa->license = syms->license;
 	return true;
 }
 
@@ -587,6 +589,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 static const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
 					const s32 **crc,
+					enum mod_license *license,
 					bool gplok,
 					bool warn)
 {
@@ -601,6 +604,8 @@ static const struct kernel_symbol *find_symbol(const char *name,
 			*owner = fsa.owner;
 		if (crc)
 			*crc = fsa.crc;
+		if (license)
+			*license = fsa.license;
 		return fsa.sym;
 	}
 
@@ -1074,7 +1079,7 @@ void __symbol_put(const char *symbol)
 	struct module *owner;
 
 	preempt_disable();
-	if (!find_symbol(symbol, &owner, NULL, true, false))
+	if (!find_symbol(symbol, &owner, NULL, NULL, true, false))
 		BUG();
 	module_put(owner);
 	preempt_enable();
@@ -1352,7 +1357,7 @@ static inline int check_modstruct_version(const struct load_info *info,
 	 * locking is necessary -- use preempt_disable() to placate lockdep.
 	 */
 	preempt_disable();
-	if (!find_symbol("module_layout", NULL, &crc, true, false)) {
+	if (!find_symbol("module_layout", NULL, &crc, NULL, true, false)) {
 		preempt_enable();
 		BUG();
 	}
@@ -1436,6 +1441,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	struct module *owner;
 	const struct kernel_symbol *sym;
 	const s32 *crc;
+	enum mod_license license;
 	int err;
 
 	/*
@@ -1445,7 +1451,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	 */
 	sched_annotate_sleep();
 	mutex_lock(&module_mutex);
-	sym = find_symbol(name, &owner, &crc,
+	sym = find_symbol(name, &owner, &crc, &license,
 			  !(mod->taints & (1 << TAINT_PROPRIETARY_MODULE)), true);
 	if (!sym)
 		goto unlock;
@@ -2216,7 +2222,7 @@ void *__symbol_get(const char *symbol)
 	const struct kernel_symbol *sym;
 
 	preempt_disable();
-	sym = find_symbol(symbol, &owner, NULL, true, true);
+	sym = find_symbol(symbol, &owner, NULL, NULL, true, true);
 	if (sym && strong_try_module_get(owner))
 		sym = NULL;
 	preempt_enable();
@@ -2252,7 +2258,7 @@ static int verify_exported_symbols(struct module *mod)
 	for (i = 0; i < ARRAY_SIZE(arr); i++) {
 		for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
 			if (find_symbol(kernel_symbol_name(s), &owner, NULL,
-					true, false)) {
+					NULL, true, false)) {
 				pr_err("%s: exports duplicate symbol %s"
 				       " (owned by %s)\n",
 				       mod->name, kernel_symbol_name(s),
-- 
2.27.0

