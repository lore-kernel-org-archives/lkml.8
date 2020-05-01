Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6600AC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A222497E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgEASWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730771AbgEASWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB17C08E859;
        Fri,  1 May 2020 11:22:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIx-0003iC-P5; Fri, 01 May 2020 20:22:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 95F1A1C0820;
        Fri,  1 May 2020 20:22:23 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:23 -0000
From:   "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Uniquely identify alternative instruction groups
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158835734357.8414.168402690817847729.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     13fab06d9a3ad3afdfd51c7f8f87f2ae28444648
Gitweb:        https://git.kernel.org/tip/13fab06d9a3ad3afdfd51c7f8f87f2ae28444648
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Tue, 14 Apr 2020 12:36:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:31 +02:00

objtool: Uniquely identify alternative instruction groups

Assign a unique identifier to every alternative instruction group in
order to be able to tell which instructions belong to what
alternative.

[peterz: extracted from a larger patch]
Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 tools/objtool/check.c | 6 +++++-
 tools/objtool/check.h | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cc52da6..4da6bfb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -752,7 +752,9 @@ static int handle_group_alt(struct objtool_file *file,
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
+	static unsigned int alt_group_next_index = 1;
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
+	unsigned int alt_group = alt_group_next_index++;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -761,7 +763,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
-		insn->alt_group = true;
+		insn->alt_group = alt_group;
 		last_orig_insn = insn;
 	}
 
@@ -795,6 +797,7 @@ static int handle_group_alt(struct objtool_file *file,
 	}
 
 	last_new_insn = NULL;
+	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
@@ -804,6 +807,7 @@ static int handle_group_alt(struct objtool_file *file,
 
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
+		insn->alt_group = alt_group;
 
 		/*
 		 * Since alternative replacement code is copy/pasted by the
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 12a9660..2428022 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -30,12 +30,13 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, ignore_alts;
+	bool dead_end, ignore, ignore_alts;
 	bool hint;
 	bool retpoline_safe;
 	s8 instr;
 	u8 visited;
 	u8 ret_offset;
+	int alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
