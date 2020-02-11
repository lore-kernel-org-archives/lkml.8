Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D71DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2B920870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgBKMrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:47:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45926 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgBKMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux0-0007Wz-AS; Tue, 11 Feb 2020 13:47:38 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C86A01C2017;
        Tue, 11 Feb 2020 13:47:37 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:37 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Add relocation check for alternative sections
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
References: <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158142525750.411.6760839149757331330.tip-bot2@tip-bot2>
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

Commit-ID:     dc4197236c20e761f2007c641afd193f81a00a74
Gitweb:        https://git.kernel.org/tip/dc4197236c20e761f2007c641afd193f81a00a74
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 10 Feb 2020 12:32:40 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 11 Feb 2020 13:39:52 +01:00

objtool: Add relocation check for alternative sections

Relocations in alternative code can be dangerous, because the code is
copy/pasted to the text section after relocations have been resolved,
which can corrupt PC-relative addresses.

However, relocations might be acceptable in some cases, depending on the
architecture.  For example, the x86 alternatives code manually fixes up
the target addresses for PC-relative jumps and calls.

So disallow relocations in alternative code, except where the x86 arch
code allows it.

This code may need to be tweaked for other arches when objtool gets
support for them.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Julien Thierry <jthierry@redhat.com>
Link: https://lkml.kernel.org/r/7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9016ae1..b038de2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -768,6 +768,27 @@ static int handle_group_alt(struct objtool_file *file,
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
 
+		/*
+		 * Since alternative replacement code is copy/pasted by the
+		 * kernel after applying relocations, generally such code can't
+		 * have relative-address relocation references to outside the
+		 * .altinstr_replacement section, unless the arch's
+		 * alternatives code can adjust the relative offsets
+		 * accordingly.
+		 *
+		 * The x86 alternatives code adjusts the offsets only when it
+		 * encounters a branch instruction at the very beginning of the
+		 * replacement group.
+		 */
+		if ((insn->offset != special_alt->new_off ||
+		    (insn->type != INSN_CALL && !is_static_jump(insn))) &&
+		    find_rela_by_dest_range(insn->sec, insn->offset, insn->len)) {
+
+			WARN_FUNC("unsupported relocation in alternatives section",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
 		if (!is_static_jump(insn))
 			continue;
 
