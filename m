Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789322072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438753AbgDNK5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438344AbgDNKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07017C061A0E;
        Tue, 14 Apr 2020 03:34:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOItG-0008ST-QS; Tue, 14 Apr 2020 12:34:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CD501C0450;
        Tue, 14 Apr 2020 12:34:02 +0200 (CEST)
Date:   Tue, 14 Apr 2020 10:34:02 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Fix switch table detection in .text.unlikely
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157c35d42ca9b6354bbb1604fe9ad7d1153ccb21.1585761021.git.jpoimboe@redhat.com>
References: <157c35d42ca9b6354bbb1604fe9ad7d1153ccb21.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158686044205.28353.15676020800667912710.tip-bot2@tip-bot2>
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

Commit-ID:     b401efc120a399dfda1f4d2858a4de365c9b08ef
Gitweb:        https://git.kernel.org/tip/b401efc120a399dfda1f4d2858a4de365c9b08ef
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 01 Apr 2020 13:23:28 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 12:06:21 +02:00

objtool: Fix switch table detection in .text.unlikely

If a switch jump table's indirect branch is in a ".cold" subfunction in
.text.unlikely, objtool doesn't detect it, and instead prints a false
warning:

  drivers/media/v4l2-core/v4l2-ioctl.o: warning: objtool: v4l_print_format.cold()+0xd6: sibling call from callable instruction with modified stack frame
  drivers/hwmon/max6650.o: warning: objtool: max6650_probe.cold()+0xa5: sibling call from callable instruction with modified stack frame
  drivers/media/dvb-frontends/drxk_hard.o: warning: objtool: init_drxk.cold()+0x16f: sibling call from callable instruction with modified stack frame

Fix it by comparing the function, instead of the section and offset.

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/157c35d42ca9b6354bbb1604fe9ad7d1153ccb21.1585761021.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4811325..cb2d299 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1050,10 +1050,7 @@ static struct rela *find_jump_table(struct objtool_file *file,
 	 * it.
 	 */
 	for (;
-	     &insn->list != &file->insn_list &&
-	     insn->sec == func->sec &&
-	     insn->offset >= func->offset;
-
+	     &insn->list != &file->insn_list && insn->func && insn->func->pfunc == func;
 	     insn = insn->first_jump_src ?: list_prev_entry(insn, list)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
