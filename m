Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B684921941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wI7hGuHw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+cJd3Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIJS54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:57:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgIJSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:06 -0400
Date:   Thu, 10 Sep 2020 18:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9JrUiWLo4xgc7Nm46o/qAOj/I8jdZXgmm6feeC2d7qE=;
        b=wI7hGuHw5346uoA8vN1JeT5EpTuzsY3INZCNjtzGAN3Rm1RyKrw5ceEZEE1pK/2+fx+0lN
        BrtY4H8IW/p73zGLM3zZ8mqe3QQrBCF0uhQjlpcssUsK+yd4H4p7TCB5murPhJquKsWVuP
        a4QM+bKVtsuh0dVEBZqGhy/Wxw6IyvzOCwYYPNMdcz39isj6R7/+7tOQRt72rHCcD9uwK0
        g+/tOmzvbTdjP3NejB8ZWe9Wp7bZhbX9MM80puK+qZcC23P1kyafI60yhAoZev6B6adXQh
        H+cqMJq7WoICtW3yhbVibVVNxNnlaQoHg4kc1j5Bibeq9C84sRdzfgMXVPIHIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9JrUiWLo4xgc7Nm46o/qAOj/I8jdZXgmm6feeC2d7qE=;
        b=S+cJd3Dq+8Qvj9kMWvVCQypJH5/teBK1yr2+Ts0VYgIPTapFw+X3jDBNsZVuNEPm8gc0cC
        gWBZdoJjxdgR8/Dw==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Abstract alternative special case handling
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407738.20229.15097756239524250564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     eda3dc905834dc9c99132f987f77b68cf53a8682
Gitweb:        https://git.kernel.org/tip/eda3dc905834dc9c99132f987f77b68cf53a8682
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:22 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Abstract alternative special case handling

Some alternatives associated with a specific feature need to be treated
in a special way. Since the features and how to treat them vary from one
architecture to another, move the special case handling to arch specific
code.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch/x86/Build     |  1 +-
 tools/objtool/arch/x86/special.c | 37 +++++++++++++++++++++++++++++++-
 tools/objtool/objtool.h          |  2 ++-
 tools/objtool/special.c          | 32 ++++-----------------------
 tools/objtool/special.h          |  2 ++-
 tools/objtool/weak.c             |  2 +--
 6 files changed, 47 insertions(+), 29 deletions(-)
 create mode 100644 tools/objtool/arch/x86/special.c

diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 7c50040..9f7869b 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,3 +1,4 @@
+objtool-y += special.o
 objtool-y += decode.o
 
 inat_tables_script = ../arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
new file mode 100644
index 0000000..823561e
--- /dev/null
+++ b/tools/objtool/arch/x86/special.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "../../special.h"
+#include "../../builtin.h"
+
+#define X86_FEATURE_POPCNT (4 * 32 + 23)
+#define X86_FEATURE_SMAP   (9 * 32 + 20)
+
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+	switch (feature) {
+	case X86_FEATURE_SMAP:
+		/*
+		 * If UACCESS validation is enabled; force that alternative;
+		 * otherwise force it the other way.
+		 *
+		 * What we want to avoid is having both the original and the
+		 * alternative code flow at the same time, in that case we can
+		 * find paths that see the STAC but take the NOP instead of
+		 * CLAC and the other way around.
+		 */
+		if (uaccess)
+			alt->skip_orig = true;
+		else
+			alt->skip_alt = true;
+		break;
+	case X86_FEATURE_POPCNT:
+		/*
+		 * It has been requested that we don't validate the !POPCNT
+		 * feature path which is a "very very small percentage of
+		 * machines".
+		 */
+		alt->skip_orig = true;
+		break;
+	default:
+		break;
+	}
+}
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index a635f68..4125d45 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -12,6 +12,8 @@
 
 #include "elf.h"
 
+#define __weak __attribute__((weak))
+
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index b04f395..1a2420f 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -16,9 +16,6 @@
 #include "warn.h"
 #include "arch_special.h"
 
-#define X86_FEATURE_POPCNT (4*32+23)
-#define X86_FEATURE_SMAP   (9*32+20)
-
 struct special_entry {
 	const char *sec;
 	bool group, jump_or_nop;
@@ -54,6 +51,10 @@ struct special_entry entries[] = {
 	{},
 };
 
+void __weak arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+{
+}
+
 static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 			 struct section *sec, int idx,
 			 struct special_alt *alt)
@@ -78,30 +79,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 
 		feature = *(unsigned short *)(sec->data->d_buf + offset +
 					      entry->feature);
-
-		/*
-		 * It has been requested that we don't validate the !POPCNT
-		 * feature path which is a "very very small percentage of
-		 * machines".
-		 */
-		if (feature == X86_FEATURE_POPCNT)
-			alt->skip_orig = true;
-
-		/*
-		 * If UACCESS validation is enabled; force that alternative;
-		 * otherwise force it the other way.
-		 *
-		 * What we want to avoid is having both the original and the
-		 * alternative code flow at the same time, in that case we can
-		 * find paths that see the STAC but take the NOP instead of
-		 * CLAC and the other way around.
-		 */
-		if (feature == X86_FEATURE_SMAP) {
-			if (uaccess)
-				alt->skip_orig = true;
-			else
-				alt->skip_alt = true;
-		}
+		arch_handle_alternative(feature, alt);
 	}
 
 	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 3506153..44da89a 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -28,4 +28,6 @@ struct special_alt {
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
 
+void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
+
 #endif /* _SPECIAL_H */
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 29180d5..7843e9a 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -9,8 +9,6 @@
 #include <errno.h>
 #include "objtool.h"
 
-#define __weak __attribute__((weak))
-
 #define UNSUPPORTED(name)						\
 ({									\
 	fprintf(stderr, "error: objtool: " name " not implemented\n");	\
