Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA20C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1059A206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438743AbgDNK4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438400AbgDNKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4883DC061A10;
        Tue, 14 Apr 2020 03:34:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOItG-0008SS-BD; Tue, 14 Apr 2020 12:34:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EB3B91C0086;
        Tue, 14 Apr 2020 12:34:01 +0200 (CEST)
Date:   Tue, 14 Apr 2020 10:34:01 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Make BP scratch register warning more robust
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <afc628693a37acd287e843bcc5c0430263d93c74.1585761021.git.jpoimboe@redhat.com>
References: <afc628693a37acd287e843bcc5c0430263d93c74.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158686044154.28353.9906241096479989820.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b296695298d8632d8b703ac25fe70be34a07c0d9
Gitweb:        https://git.kernel.org/tip/b296695298d8632d8b703ac25fe70be34a07c0d9
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 01 Apr 2020 13:23:29 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 12:24:22 +02:00

objtool: Make BP scratch register warning more robust

If func is NULL, a seg fault can result.

This is a theoretical issue which was found by Coverity, ID: 1492002
("Dereference after null check").

Fixes: c705cecc8431 ("objtool: Track original function across branches")
Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/afc628693a37acd287e843bcc5c0430263d93c74.1585761021.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cb2d299..4b170fd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2005,8 +2005,8 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	}
 
 	if (state->bp_scratch) {
-		WARN("%s uses BP as a scratch register",
-		     func->name);
+		WARN_FUNC("BP used as a scratch register",
+			  insn->sec, insn->offset);
 		return 1;
 	}
 
