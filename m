Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34886C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3432206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfCHxS98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCYIm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41951 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727517AbgCYIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vPsu4xaDtC0cUQ8z//AAcrwJiPkiyYA4xb7Uk0+4OmQ=;
        b=RfCHxS98av0JEijMt7YBI2RERkFK3MqcXamf12o6EtspnU//ufMa8KxefLFPhYNs21TXzE
        eN2rf6y+4k+ekNt6f6V4LQczF1em0ZrYLE1YHpskGGcIRkQ3HmY5WbZELzGpM0KcraXlgn
        xRXSu7QF61Hj8J3ITq2xZWD6R7iF71k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-4dhY0Bh0P7KPK8Sy6CWI-w-1; Wed, 25 Mar 2020 04:42:23 -0400
X-MC-Unique: 4dhY0Bh0P7KPK8Sy6CWI-w-1
Received: by mail-wr1-f70.google.com with SMTP id y1so801603wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPsu4xaDtC0cUQ8z//AAcrwJiPkiyYA4xb7Uk0+4OmQ=;
        b=t2/yPmNKYzh+zJi38ZwqoDpx57g8UVm7dUiLFPOO0/NmZZpFCOpclfE8zfdwCxnHKk
         QdZs0W8tagjlhOexhe3Tt5BYtJVXHZesQ6jtqzcvrIRbUX5YUYL2go3MdyU3jOMqe4hY
         PufWm2tK4JZQ3qwwNofvOTd1J8tzhUd3Nboi0xkMyobw3PDQ/gCb/5uTGt4Ch9XhSjme
         siRWOqtE5GFkWcLJmmcjbninVg5vG+pdQjlrVqkAROM3ZH/snwETFbj4GGejJXXZcFEa
         zoi6cu50p05bK4sKjEYPQZFOkTc9RVzwrxKSTdRQxj+UPS8vEFarfOqochfvMM5g6hBu
         qmhQ==
X-Gm-Message-State: ANhLgQ105R/fjKQMPzGv0fQ2dlZHhmAUAq6nEqMJY1Is/09gZeXbK/4N
        cFZsecP8XSWLVdj2Pa4tmecirnWm0wXiEK1l5TgDRhhKGWg1MaXAxAh//3DVXC2V5NTsEukByKM
        oJ2X/KVadMeU5mvT7gH7Losdw
X-Received: by 2002:a05:600c:2904:: with SMTP id i4mr2375027wmd.41.1585125741635;
        Wed, 25 Mar 2020 01:42:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvToij3LAH7vsJcKSDmwLhIJ7G54oxAzIJnZfjCsg9NarWuID83kbDutfq980asRdgv9/TJXQ==
X-Received: by 2002:a05:600c:2904:: with SMTP id i4mr2375009wmd.41.1585125741333;
        Wed, 25 Mar 2020 01:42:21 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:20 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 08/10] objtool: Add abstraction for computation of symbols offsets
Date:   Wed, 25 Mar 2020 08:42:01 +0000
Message-Id: <20200325084203.17005-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

The jump destination and relocation offset used previously are only
reliable on x86_64 architecture. We abstract these computations by calling
arch-dependent implementations.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T. Remove superfluous comment, replace other addend offsets
      with arch_dest_rela_offset]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h            |  6 ++++++
 tools/objtool/arch/x86/decode.c | 11 +++++++++++
 tools/objtool/check.c           | 18 ++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index ced3765c4f44..a9a50a25ca66 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -66,6 +66,8 @@ struct stack_op {
 	struct op_src src;
 };
 
+struct instruction;
+
 void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
@@ -75,4 +77,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+unsigned long arch_jump_destination(struct instruction *insn);
+
+unsigned long arch_dest_rela_offset(int addend);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..7ce8650cf085 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,6 +11,7 @@
 #include "../../../arch/x86/lib/inat.c"
 #include "../../../arch/x86/lib/insn.c"
 
+#include "../../check.h"
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
@@ -66,6 +67,16 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
+unsigned long arch_dest_rela_offset(int addend)
+{
+	return addend + 4;
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->len + insn->immediate;
+}
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 90d3db00352d..7b80a4a6e53d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -590,13 +590,14 @@ static int add_jump_destinations(struct objtool_file *file)
 					       insn->len);
 		if (!rela) {
 			dest_sec = insn->sec;
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 		} else if (rela->sym->type == STT_SECTION) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->addend + 4;
+			dest_off = arch_dest_rela_offset(rela->addend);
 		} else if (rela->sym->sec->idx) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->sym->sym.st_value + rela->addend + 4;
+			dest_off = rela->sym->sym.st_value +
+				   arch_dest_rela_offset(rela->addend);
 		} else if (strstr(rela->sym->name, "_indirect_thunk_")) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
@@ -686,7 +687,7 @@ static int add_call_destinations(struct objtool_file *file)
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
 					       insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
 			if (!insn->call_dest)
 				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
@@ -709,13 +710,14 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (rela->sym->type == STT_SECTION) {
+			dest_off = arch_dest_rela_offset(rela->addend);
 			insn->call_dest = find_func_by_offset(rela->sym->sec,
-							      rela->addend+4);
+							      dest_off);
 			if (!insn->call_dest) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%x",
+				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  rela->sym->sec->name,
-					  rela->addend + 4);
+					  dest_off);
 				return -1;
 			}
 		} else
@@ -827,7 +829,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (!insn->immediate)
 			continue;
 
-		dest_off = insn->offset + insn->len + insn->immediate;
+		dest_off = arch_jump_destination(insn);
 		if (dest_off == special_alt->new_off + special_alt->new_len) {
 			if (!fake_jump) {
 				WARN("%s: alternative jump to end of section",
-- 
2.21.1

