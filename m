Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A934C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0926E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8IzkPfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBMSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:47:20 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:48325 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:47:19 -0500
Received: by mail-ua1-f73.google.com with SMTP id m2so1668436ual.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q6Z9P/dVJ1hNdsghQK1UTCWedGdDNEtUHw2XO4diJH8=;
        b=B8IzkPfiDs+4w+hN3BIhtLvlwpZLtZJNNjh/Rg9ugfQPd1tZyGCdohhNoUR2HtbsqJ
         rKF2WKANlBkRxzLTMHru7xB5W8fecWqkIUkbopggT2Qvemsk4pfMtF62XMkZ2mIvw3g0
         S+UVvsZVbUyv6lMPqLBm/fjlkTXCXEzjTusVgBqkTM7TxhDRZPex65oUq9AxTc+4mkzI
         RguoQ/7wOjudBSZ/H2LatAcRwufEeMkbOOJHBtrjLeAryg2FupFtiR/J/Yck/cSwpvVh
         LbIyHHrKZTBS464tKAjZ2V2ArIlyvaHnU/04XugcRcvRIEe/v5ONIoF9HyX2/kZS4Opu
         HNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q6Z9P/dVJ1hNdsghQK1UTCWedGdDNEtUHw2XO4diJH8=;
        b=WGjqCW80q2eiGmj2/DuOvsNQQHRXYRYk3S7az+RoQyRVil0vJ/35xPW7Jaa4V4B2J6
         vku/eKkmr3okvso6TfBXlcAOKJCIv2bEkeGcUDdtAzJGnILi//B+bJ8fGtsqnp0o11Q5
         Vn/TTh/jFkHs4c26WsfcI1Odf0oEymWiycUraz24lKfxcUhJ1aXCoWMFg6GwpSjAIZ1M
         CIQLPZkzAK7QcNgYf2ugNVUmswEFTEV/Amf3wH+rv3a9GRBUV62YIqMwXrbrRI3EgNCd
         I9uIovvQJl+ZduMgwViZxE5MGTrFdQXeDJNlpaubXzAiP4ghTlhWjM0vOfTfpiLpbL0Y
         ZbBQ==
X-Gm-Message-State: APjAAAVs7lYVLmKzGnBgKh2Rok+a+R+Rgy7kbaJxz53kTpSZgRW/ZDqF
        X1ZL1ByImQSafoKOVgewuKPdLpiYp+3wH0J9k08=
X-Google-Smtp-Source: APXvYqw+IKWERf/nxtHdSo39yKfhVwMBdVtyqYhJ9nAB98anQ4xhG2KebPUHyh6D1AunE9L0IoHPZa9+nm06t1xBW9M=
X-Received: by 2002:a67:f30d:: with SMTP id p13mr16077583vsf.112.1581619637977;
 Thu, 13 Feb 2020 10:47:17 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:47:08 -0800
Message-Id: <20200213184708.205083-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH] objtool: ignore .L prefixed local symbols
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jpoimboe@redhat.com, peterz@infradead.org
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Top of tree LLVM has optimizations related to
-fno-semantic-interposition to avoid emitting PLT relocations for
references to symbols located in the same translation unit, where it
will emit "local symbol" references.

Clang builds fall back on GNU as for assembling, currently. It appears a
bug in GNU as introduced around 2.31 is keeping around local labels in
the symbol table, despite the documentation saying:

"Local symbols are defined and used within the assembler, but they are
normally not saved in object files."

When objtool searches for a symbol at a given offset, it's finding the
incorrectly kept .L<symbol>$local symbol that should have been discarded
by the assembler.

A patch for GNU as has been authored.  For now, objtool should not treat
local symbols as the expected symbol for a given offset when iterating
the symbol table.

commit 644592d32837 ("objtool: Fail the kernel build on fatal errors")
exposed this issue.

Link: https://github.com/ClangBuiltLinux/linux/issues/872
Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html#Symbol-Names
Link: https://sourceware.org/ml/binutils/2020-02/msg00243.html
Link: https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/286292010
Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
Debugged-by: Fangrui Song <maskray@google.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Build tested allyesconfig with ToT Clang and GCC 9.2.1.
Boot tested defconfig with ToT Clang and GCC 9.2.1.

 tools/objtool/elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index edba4745f25a..9c1e3cc928b0 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -63,7 +63,8 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 
 	list_for_each_entry(sym, &sec->symbol_list, list)
 		if (sym->type != STT_SECTION &&
-		    sym->offset == offset)
+		    sym->offset == offset &&
+		    strstr(sym->name, ".L") != sym->name)
 			return sym;
 
 	return NULL;
-- 
2.25.0.225.g125e21ebc7-goog

