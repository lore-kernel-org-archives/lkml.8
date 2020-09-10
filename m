Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A124C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273CB20731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/zJmgzx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHWw2cmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIJS6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgIJSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7CC061795;
        Thu, 10 Sep 2020 11:54:40 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wGd6R3ZPOWzhOS3BtH72XGkKG64L4s9kAITb9yYdpBM=;
        b=c/zJmgzxzd/wihTFBzp6k3i6ZuVYwztSo3mHwzEKB7p0rDR6zFrjJCN/bzW0RW0dq7Qu+Y
        eZj9k/laDciGeThJvkxWMDFTtRWnWmtAqILenSbq+URDotSOhIOoZnkGEEK53qXo2tbV9B
        PooUWPkpreKOtOHK2pCjcqNtk0gHC/qU8WM4MxWLMR9rpCpUoChoa+xp0iYtiSCyffliTX
        BPcguA74Y5+iTWnXxg6cfFdMs0ty7nmFhGAX8YqRGW1FxtXib4s5wURAmiZMX9Yxcs8Dqo
        B04qAfZi+NZJdc2fpwE0GtuAXULYm3qej68GFPKt7vmv9ivqZK/fSzB22itUYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wGd6R3ZPOWzhOS3BtH72XGkKG64L4s9kAITb9yYdpBM=;
        b=vHWw2cmktinIUurB8q+urcZhV2ILiC5hjmb9iba8+j3+VCID1VY1H35eMTTe3m/6lHRWPF
        RS0RmOM3k9mItvAg==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Move macros describing structures to
 arch-dependent code
Cc:     Raphael Gault <raphael.gault@arm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407782.20229.3037188886359540244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c8ea0d672521ef663f0f9a77faa94d0d47102d77
Gitweb:        https://git.kernel.org/tip/c8ea0d672521ef663f0f9a77faa94d0d47102d77
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:21 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Move macros describing structures to arch-dependent code

Some macros are defined to describe the size and layout of structures
exception_table_entry, jump_entry and alt_instr. These values can vary
from one architecture to another.

Have the values be defined by arch specific code.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch/x86/include/arch_special.h | 20 ++++++++++++++++++-
 tools/objtool/special.c                       | 16 +--------------
 2 files changed, 21 insertions(+), 15 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h

diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
new file mode 100644
index 0000000..d818b2b
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _X86_ARCH_SPECIAL_H
+#define _X86_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		13
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e893f1e..b04f395 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -14,21 +14,7 @@
 #include "builtin.h"
 #include "special.h"
 #include "warn.h"
-
-#define EX_ENTRY_SIZE		12
-#define EX_ORIG_OFFSET		0
-#define EX_NEW_OFFSET		4
-
-#define JUMP_ENTRY_SIZE		16
-#define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		4
-
-#define ALT_ENTRY_SIZE		13
-#define ALT_ORIG_OFFSET		0
-#define ALT_NEW_OFFSET		4
-#define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
+#include "arch_special.h"
 
 #define X86_FEATURE_POPCNT (4*32+23)
 #define X86_FEATURE_SMAP   (9*32+20)
