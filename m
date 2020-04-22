Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA9C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7368621D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDVWZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgDVWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DBC03C1AB;
        Wed, 22 Apr 2020 15:24:59 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnR-0001Qg-Oa; Thu, 23 Apr 2020 00:24:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21FBA1C04CF;
        Thu, 23 Apr 2020 00:24:43 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:42 -0000
From:   "tip-bot2 for Kristen Carlson Accardi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Do not assume order of parent/child functions
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158759428235.28353.10463012010844983639.tip-bot2@tip-bot2>
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

Commit-ID:     5920038dc2aa75b7aa3f5ca767b06a71c67cf897
Gitweb:        https://git.kernel.org/tip/5920038dc2aa75b7aa3f5ca767b06a71c67cf897
Author:        Kristen Carlson Accardi <kristen@linux.intel.com>
AuthorDate:    Wed, 15 Apr 2020 14:04:43 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 21 Apr 2020 18:50:26 -05:00

objtool: Do not assume order of parent/child functions

If a .cold function is examined prior to it's parent, the link
to the parent/child function can be overwritten when the parent
is examined. Only update pfunc and cfunc if they were previously
nil to prevent this from happening.

This fixes an -ffunction-sections issue.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 43748cb..03e542d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -418,7 +418,13 @@ static int read_symbols(struct elf *elf)
 			size_t pnamelen;
 			if (sym->type != STT_FUNC)
 				continue;
-			sym->pfunc = sym->cfunc = sym;
+
+			if (sym->pfunc == NULL)
+				sym->pfunc = sym;
+
+			if (sym->cfunc == NULL)
+				sym->cfunc = sym;
+
 			coldstr = strstr(sym->name, ".cold");
 			if (!coldstr)
 				continue;
