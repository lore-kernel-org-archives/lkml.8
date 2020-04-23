Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C72C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE94B20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgDWHtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDWHtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B320C03C1AB;
        Thu, 23 Apr 2020 00:49:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWc1-0008JE-O1; Thu, 23 Apr 2020 09:49:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5293D1C0450;
        Thu, 23 Apr 2020 09:49:33 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:32 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rename elf_read() to elf_open_read()
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200422103205.61900-3-mingo@kernel.org>
References: <20200422103205.61900-3-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <158762817276.28353.6504307167044928918.tip-bot2@tip-bot2>
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

Commit-ID:     bc359ff2f6f3e8a9df38c39017e269bc442357c7
Gitweb:        https://git.kernel.org/tip/bc359ff2f6f3e8a9df38c39017e269bc442357c7
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 22 Apr 2020 12:32:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Apr 2020 08:34:18 +02:00

objtool: Rename elf_read() to elf_open_read()

'struct elf *' handling is an open/close paradigm, make sure the naming
matches that:

   elf_open_read()
   elf_write()
   elf_close()

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200422103205.61900-3-mingo@kernel.org
---
 tools/objtool/check.c | 2 +-
 tools/objtool/elf.c   | 2 +-
 tools/objtool/elf.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f2a8427..12e2aea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2614,7 +2614,7 @@ int check(const char *_objname, bool orc)
 
 	objname = _objname;
 
-	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);
 	if (!file.elf)
 		return 1;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index fab5534..453b723 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -542,7 +542,7 @@ static int read_relas(struct elf *elf)
 	return 0;
 }
 
-struct elf *elf_read(const char *name, int flags)
+struct elf *elf_open_read(const char *name, int flags)
 {
 	struct elf *elf;
 	Elf_Cmd cmd;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index a55bcde..5e76ac3 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -113,7 +113,7 @@ static inline u32 rela_hash(struct rela *rela)
 	return sec_offset_hash(rela->sec, rela->offset);
 }
 
-struct elf *elf_read(const char *name, int flags);
+struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
 void elf_add_rela(struct elf *elf, struct rela *rela);
