Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0880C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85E72074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOnJXWOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIDPdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgIDPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599233595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrVz+KLbKI6BdLhyF2fMlzFox3txKG0LPn3niHgImoA=;
        b=SOnJXWOP8N0dwJ/vSXD9lUPYhuDwaegBdZM9+9sC/L1PTYAhBH4S8D/KCq2mILxsyKSgKb
        064VHJueFnRu6IeQKwUXmRkvsew22tGnVQE4FdKh+MSyprBWLcIezynDDjiyzAYhpEzSAq
        5xW7+cyzv93xL12m94fObCHSxx+rak4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-eGmBl3RBPDqy_6U0FYXZ_g-1; Fri, 04 Sep 2020 11:33:13 -0400
X-MC-Unique: eGmBl3RBPDqy_6U0FYXZ_g-1
Received: by mail-ed1-f71.google.com with SMTP id y15so2858725ede.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrVz+KLbKI6BdLhyF2fMlzFox3txKG0LPn3niHgImoA=;
        b=fmQdSDCDaiSv9wAkOa0bHfo8ZhETCDnKdk1sWjrLHAqlrKevvKRB3YhHHbbLSCcSDB
         aiuXnUsWi21dxEU+XF7eFUrUVR+kDPsYWVe27e+j/rk7Y/3GaxLohXbvMdUkGTkYfybg
         iYDP8cXiuqxcM7YnpJHBorkCI7EKwPgB9zzRKfc+bYLGqBad0uvi/Jt79+mDPYZWPalM
         qFd6aEHPinFWkAJdSWhsbm+amXciTILcUN31SLe+FXBSTF39pMYcUCz01DUaKcLWnOhf
         SQ3yRxSVyqQW2vMRv5ceSPYRvQg5dPTzLeG4asBXR36Wv/SpT0o0qjlDrbmFJVfyviT+
         hYCQ==
X-Gm-Message-State: AOAM5326U6E6uJNAb4yNoJUMEwyCkk06ix2QSDq+/37EToDf6XsWO9pD
        JlarhM1HjxdeUG4HFXqAH+aRr3rjCZi9dh7HoFCxFaVZ5AXlcU9iSIAjQ5XpIOFv8iF1AmRMpGv
        5jh2xH2eTofOUHsEYJANilzue
X-Received: by 2002:a05:6402:17b5:: with SMTP id j21mr8895146edy.276.1599233592376;
        Fri, 04 Sep 2020 08:33:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzquBwBTR4pU/rFyhz41uof7tyQJTyw3BfjNsyZuXuGbXnpe30LPlOlIHzdN8J7b7it3e3Htg==
X-Received: by 2002:a05:6402:17b5:: with SMTP id j21mr8895118edy.276.1599233592050;
        Fri, 04 Sep 2020 08:33:12 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id o6sm6374294edh.40.2020.09.04.08.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:33:11 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 05/10] objtool: Make relocation in alternative handling arch dependent
Date:   Fri,  4 Sep 2020 16:30:23 +0100
Message-Id: <20200904153028.32676-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by the comment in handle_group_alt(), support of
relocation for instructions in an alternative group depends on whether
arch specific kernel code handles it.

So, let objtool arch specific code decide whether a relocation for
the alternative section should be accepted.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/special.c | 13 +++++++++++++
 tools/objtool/check.c            | 19 ++++++-------------
 tools/objtool/check.h            |  6 ++++++
 tools/objtool/special.h          |  4 ++++
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 823561e4015c..34e0e162e6fd 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -35,3 +35,16 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 		break;
 	}
 }
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	/*
+	 * The x86 alternatives code adjusts the offsets only when it
+	 * encounters a branch instruction at the very beginning of the
+	 * replacement group.
+	 */
+	return insn->offset == special_alt->new_off &&
+	       (insn->type == INSN_CALL || is_static_jump(insn));
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6156bd9a687c..8217a9a9a838 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -109,12 +109,6 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
-static bool is_static_jump(struct instruction *insn)
-{
-	return insn->type == INSN_JUMP_CONDITIONAL ||
-	       insn->type == INSN_JUMP_UNCONDITIONAL;
-}
-
 static bool is_sibling_call(struct instruction *insn)
 {
 	/* An indirect jump is either a sibling call or a jump to a table. */
@@ -866,6 +860,8 @@ static int handle_group_alt(struct objtool_file *file,
 	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
+		struct reloc *alt_reloc;
+
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
 			break;
 
@@ -882,14 +878,11 @@ static int handle_group_alt(struct objtool_file *file,
 		 * .altinstr_replacement section, unless the arch's
 		 * alternatives code can adjust the relative offsets
 		 * accordingly.
-		 *
-		 * The x86 alternatives code adjusts the offsets only when it
-		 * encounters a branch instruction at the very beginning of the
-		 * replacement group.
 		 */
-		if ((insn->offset != special_alt->new_off ||
-		    (insn->type != INSN_CALL && !is_static_jump(insn))) &&
-		    find_reloc_by_dest_range(file->elf, insn->sec, insn->offset, insn->len)) {
+		alt_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+						   insn->offset, insn->len);
+		if (alt_reloc &&
+		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
 				  insn->sec, insn->offset);
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 0abdf8efdbc0..58374255934b 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -47,6 +47,12 @@ struct instruction {
 #endif
 };
 
+static inline bool is_static_jump(struct instruction *insn)
+{
+	return insn->type == INSN_JUMP_CONDITIONAL ||
+	       insn->type == INSN_JUMP_UNCONDITIONAL;
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 44da89afeda2..1dc1bb3e74c6 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -7,6 +7,7 @@
 #define _SPECIAL_H
 
 #include <stdbool.h>
+#include "check.h"
 #include "elf.h"
 
 struct special_alt {
@@ -30,4 +31,7 @@ int special_get_alts(struct elf *elf, struct list_head *alts);
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
 
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc);
 #endif /* _SPECIAL_H */
-- 
2.21.3

