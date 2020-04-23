Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F46C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042A521569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgDWHvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgDWHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5BC08E859;
        Thu, 23 Apr 2020 00:49:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc4-0008Lg-A7; Thu, 23 Apr 2020 09:49:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D49AB1C0244;
        Thu, 23 Apr 2020 09:49:35 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Avoid iterating !text section symbols
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.346582716@infradead.org>
References: <20200416115119.346582716@infradead.org>
MIME-Version: 1.0
Message-ID: <158762817545.28353.9134729814159652246.tip-bot2@tip-bot2>
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

Commit-ID:     da837bd6f1994f780325649e8eee7d9b01c5ee4d
Gitweb:        https://git.kernel.org/tip/da837bd6f1994f780325649e8eee7d9b01c5ee4d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 23 Mar 2020 21:11:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:51 +02:00

objtool: Avoid iterating !text section symbols

validate_functions() iterates all sections their symbols; this is
pointless to do for !text sections as they won't have instructions
anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.346582716@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 923652b..e201aa1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2551,8 +2551,12 @@ static int validate_functions(struct objtool_file *file)
 	struct section *sec;
 	int warnings = 0;
 
-	for_each_sec(file, sec)
+	for_each_sec(file, sec) {
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+			continue;
+
 		warnings += validate_section(file, sec);
+	}
 
 	return warnings;
 }
