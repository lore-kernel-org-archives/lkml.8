Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAF6C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693B9208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 18:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEJSa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 14:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgEJSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 14:30:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A8C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 11:30:26 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXqiW-0003ow-Le; Sun, 10 May 2020 20:30:24 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 176F4100D21;
        Sun, 10 May 2020 20:30:24 +0200 (CEST)
Date:   Sun, 10 May 2020 11:55:58 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] objtool/urgent for 5.7-rc5
References: <158911175703.19109.2236997977254447943.tglx@nanos.tec.linutronix.de>
Message-ID: <158911175824.19109.2928860984731892266.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest objtool/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-05-10

up to:  1119d265bc20: objtool: Fix infinite loop in find_jump_table()


A single fix for objtool to prevent an infinite loop in the jump table
search which can be triggered when building the kernel with
-ffunction-sections.

Thanks,

	tglx

------------------>
Josh Poimboeuf (1):
      objtool: Fix infinite loop in find_jump_table()


 tools/objtool/check.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b170fd08a28..0e8f9a32e4d1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -72,6 +72,17 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
 
+static struct instruction *prev_insn_same_sym(struct objtool_file *file,
+					       struct instruction *insn)
+{
+	struct instruction *prev = list_prev_entry(insn, list);
+
+	if (&prev->list != &file->insn_list && prev->func == insn->func)
+		return prev;
+
+	return NULL;
+}
+
 #define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn;							\
@@ -1050,8 +1061,8 @@ static struct rela *find_jump_table(struct objtool_file *file,
 	 * it.
 	 */
 	for (;
-	     &insn->list != &file->insn_list && insn->func && insn->func->pfunc == func;
-	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
+	     insn && insn->func && insn->func->pfunc == func;
+	     insn = insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
 			break;

