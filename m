Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA1C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D6020637
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgBKMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:47:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45918 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgBKMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux0-0007X0-Es; Tue, 11 Feb 2020 13:47:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 240C31C2018;
        Tue, 11 Feb 2020 13:47:38 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:37 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Add is_static_jump() helper
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9b8b438df918276315e4765c60d2587f3c7ad698.1581359535.git.jpoimboe@redhat.com>
References: <9b8b438df918276315e4765c60d2587f3c7ad698.1581359535.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158142525791.411.14762185239829142608.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/objtool branch of tip:

Commit-ID:     a22961409c02b93ffa7ed78f67fb57a1ba6c787d
Gitweb:        https://git.kernel.org/tip/a22961409c02b93ffa7ed78f67fb57a1ba6c787d
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 10 Feb 2020 12:32:39 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 11 Feb 2020 13:36:01 +01:00

objtool: Add is_static_jump() helper

There are several places where objtool tests for a non-dynamic (aka
direct) jump.  Move the check to a helper function.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Julien Thierry <jthierry@redhat.com>
Link: https://lkml.kernel.org/r/9b8b438df918276315e4765c60d2587f3c7ad698.1581359535.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 796f6a1..9016ae1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -97,14 +97,19 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static bool is_static_jump(struct instruction *insn)
+{
+	return insn->type == INSN_JUMP_CONDITIONAL ||
+	       insn->type == INSN_JUMP_UNCONDITIONAL;
+}
+
 static bool is_sibling_call(struct instruction *insn)
 {
 	/* An indirect jump is either a sibling call or a jump to a table. */
 	if (insn->type == INSN_JUMP_DYNAMIC)
 		return list_empty(&insn->alts);
 
-	if (insn->type != INSN_JUMP_CONDITIONAL &&
-	    insn->type != INSN_JUMP_UNCONDITIONAL)
+	if (!is_static_jump(insn))
 		return false;
 
 	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
@@ -553,8 +558,7 @@ static int add_jump_destinations(struct objtool_file *file)
 	unsigned long dest_off;
 
 	for_each_insn(file, insn) {
-		if (insn->type != INSN_JUMP_CONDITIONAL &&
-		    insn->type != INSN_JUMP_UNCONDITIONAL)
+		if (!is_static_jump(insn))
 			continue;
 
 		if (insn->ignore || insn->offset == FAKE_JUMP_OFFSET)
@@ -764,8 +768,7 @@ static int handle_group_alt(struct objtool_file *file,
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
 
-		if (insn->type != INSN_JUMP_CONDITIONAL &&
-		    insn->type != INSN_JUMP_UNCONDITIONAL)
+		if (!is_static_jump(insn))
 			continue;
 
 		if (!insn->immediate)
