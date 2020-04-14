Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7140AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5351E206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438732AbgDNK42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438401AbgDNKeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8277C061A41;
        Tue, 14 Apr 2020 03:34:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOItH-0008Sj-8p; Tue, 14 Apr 2020 12:34:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DECA71C0086;
        Tue, 14 Apr 2020 12:34:02 +0200 (CEST)
Date:   Tue, 14 Apr 2020 10:34:02 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Support Clang non-section symbols in ORC
 generation
Cc:     Dmitry Golovin <dima@golovin.in>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
References: <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158686044251.28353.5727217228270138782.tip-bot2@tip-bot2>
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

Commit-ID:     e81e0724432542af8d8c702c31e9d82f57b1ff31
Gitweb:        https://git.kernel.org/tip/e81e0724432542af8d8c702c31e9d82f57b1ff31
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 01 Apr 2020 13:23:27 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 12:03:42 +02:00

objtool: Support Clang non-section symbols in ORC generation

When compiling the kernel with AS=clang, objtool produces a lot of
warnings:

  warning: objtool: missing symbol for section .text
  warning: objtool: missing symbol for section .init.text
  warning: objtool: missing symbol for section .ref.text

It then fails to generate the ORC table.

The problem is that objtool assumes text section symbols always exist.
But the Clang assembler is aggressive about removing them.

When generating relocations for the ORC table, objtool always tries to
reference instructions by their section symbol offset.  If the section
symbol doesn't exist, it bails.

Do a fallback: when a section symbol isn't available, reference a
function symbol instead.

Reported-by: Dmitry Golovin <dima@golovin.in>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/669
Link: https://lkml.kernel.org/r/9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com
---
 tools/objtool/orc_gen.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 41e4a27..4c0dabd 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -88,11 +88,6 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	struct orc_entry *orc;
 	struct rela *rela;
 
-	if (!insn_sec->sym) {
-		WARN("missing symbol for section %s", insn_sec->name);
-		return -1;
-	}
-
 	/* populate ORC data */
 	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
 	memcpy(orc, o, sizeof(*orc));
@@ -105,8 +100,32 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	}
 	memset(rela, 0, sizeof(*rela));
 
-	rela->sym = insn_sec->sym;
-	rela->addend = insn_off;
+	if (insn_sec->sym) {
+		rela->sym = insn_sec->sym;
+		rela->addend = insn_off;
+	} else {
+		/*
+		 * The Clang assembler doesn't produce section symbols, so we
+		 * have to reference the function symbol instead:
+		 */
+		rela->sym = find_symbol_containing(insn_sec, insn_off);
+		if (!rela->sym) {
+			/*
+			 * Hack alert.  This happens when we need to reference
+			 * the NOP pad insn immediately after the function.
+			 */
+			rela->sym = find_symbol_containing(insn_sec,
+							   insn_off - 1);
+		}
+		if (!rela->sym) {
+			WARN("missing symbol for insn at offset 0x%lx\n",
+			     insn_off);
+			return -1;
+		}
+
+		rela->addend = insn_off - rela->sym->offset;
+	}
+
 	rela->type = R_X86_64_PC32;
 	rela->offset = idx * sizeof(int);
 	rela->sec = ip_relasec;
