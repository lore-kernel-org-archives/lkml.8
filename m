Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2696AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC5E20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INa19P5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgG3Jr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729398AbgG3JrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEMshKDz7PmQLTP16K44wpvX1yUrPsSc5Pu5IrKoXsg=;
        b=INa19P5NiXF91IE0acWakf6cJJyaTkj7iJtx7wzhCiyx8SL9SCXHKs+9nuCiuh58aKEqCZ
        7wkGve846wpBYYRkzx+ir0mqdWbxCfJX1CMpGwrNEghczdv0Pt3IAmKtReLv6XXs9bE2MW
        XugCpK0T0RsdFarVt775laCqWx6hqEY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-HlJmp2tUPLShyuUn4_7ylQ-1; Thu, 30 Jul 2020 05:47:08 -0400
X-MC-Unique: HlJmp2tUPLShyuUn4_7ylQ-1
Received: by mail-wr1-f71.google.com with SMTP id r29so3384550wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEMshKDz7PmQLTP16K44wpvX1yUrPsSc5Pu5IrKoXsg=;
        b=rQRqCRO5rrnM2Z4oRSOaPDtgiUChdfTLNRwdw3F1mvIN43E69F2PP6ib8W3/pqC20O
         nleEvw6gvV9IfN5Jxza8r94hB3YAK/U9fYf4Ez5ShnJHAPgx94FKoILI+G3+Hfh08FfY
         fNMk6fnWejoXBEN+7amLyLxF7lWUqWO1uc2mFWycIorr4g4QXS9l7rpSGZ7mFaXud+au
         BDAs7BTiInuBwrWbJK7RmvWMj8NLjuIgThGLxSYkZY0l9XPtU+Auitp/Mobes2juGZeF
         W9IFucMeXJm+ybM/OYB2TwYHm+90QDlR0ZN0Q7OUc4Echk0RcBC39+wNouzhVetElJCA
         mvPg==
X-Gm-Message-State: AOAM53160xRJiUihS4Mci5kUiSYXf8bdvmmeW5b9N2ss+wvZriNof7Fu
        3xy286353K3rgIWzC1Fv6ThzZgg60erEKggciVzE/7IMdl2enB4a0IeikycKm1ToFOKGQW48XbB
        1fYNPA5WSeRzLyH9t4y75dHph
X-Received: by 2002:a5d:438c:: with SMTP id i12mr2141660wrq.210.1596102426496;
        Thu, 30 Jul 2020 02:47:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxASD9ieU19Eh9lLkKSGjIeLEiY3ewp273oAe/P6DOy00F7yRwZb3tkLo8bXZTJsXK2fWN5rg==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr2141632wrq.210.1596102426206;
        Thu, 30 Jul 2020 02:47:06 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:47:05 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 9/9] objtool: Abstract unwind hint reading
Date:   Thu, 30 Jul 2020 10:46:52 +0100
Message-Id: <20200730094652.28297-10-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of unwind hints and the semantics associated with them depend
on the architecture. Let arch specific code convert unwind hints into
objtool stack state descriptions.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h            |  5 +--
 tools/objtool/arch/x86/decode.c | 54 ++++++++++++++++++++++++++++++
 tools/objtool/cfi.h             |  3 +-
 tools/objtool/check.c           | 58 +++++----------------------------
 tools/objtool/orc_gen.c         |  4 ++-
 5 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 2e2ce089b0e9..44107e9aab71 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -7,12 +7,11 @@
 #define _ARCH_H
 
 #include <stdbool.h>
+#include <linux/frame.h>
 #include <linux/list.h>
 #include "objtool.h"
 #include "cfi.h"
 
-#include <asm/orc_types.h>
-
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
 	INSN_JUMP_UNCONDITIONAL,
@@ -86,4 +85,6 @@ unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
 
+int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1967370440b3..2099809925af 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -6,6 +6,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#include <linux/frame.h>
+
 #define unlikely(cond) (cond)
 #include <asm/insn.h>
 #include "../../../arch/x86/lib/inat.c"
@@ -15,6 +17,7 @@
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
+#include <asm/orc_types.h>
 
 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
@@ -583,3 +586,54 @@ const char *arch_nop_insn(int len)
 
 	return nops[len-1];
 }
+
+int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint)
+{
+	struct cfi_reg *cfa = &insn->cfi.cfa;
+
+	if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
+		insn->ret_offset = hint->sp_offset;
+		return 0;
+	}
+
+	insn->hint = true;
+
+	switch (hint->sp_reg) {
+	case ORC_REG_UNDEFINED:
+		cfa->base = CFI_UNDEFINED;
+		break;
+	case ORC_REG_SP:
+		cfa->base = CFI_SP;
+		break;
+	case ORC_REG_BP:
+		cfa->base = CFI_BP;
+		break;
+	case ORC_REG_SP_INDIRECT:
+		cfa->base = CFI_SP_INDIRECT;
+		break;
+	case ORC_REG_R10:
+		cfa->base = CFI_R10;
+		break;
+	case ORC_REG_R13:
+		cfa->base = CFI_R13;
+		break;
+	case ORC_REG_DI:
+		cfa->base = CFI_DI;
+		break;
+	case ORC_REG_DX:
+		cfa->base = CFI_DX;
+		break;
+	default:
+		WARN_FUNC("unsupported unwind_hint sp base reg %d",
+			  insn->sec, insn->offset, hint->sp_reg);
+		return -1;
+	}
+
+	cfa->offset = hint->sp_offset;
+	insn->cfi.hint_type = hint->type;
+	insn->cfi.end = hint->end;
+
+	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;
+
+	return 0;
+}
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index c7c59c6a44ee..f5aeca023133 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -29,10 +29,11 @@ struct cfi_state {
 	struct cfi_reg cfa;
 	int stack_size;
 	int drap_reg, drap_offset;
-	unsigned char type;
+	unsigned char hint_type;
 	bool bp_scratch;
 	bool drap;
 	bool end;
+	bool sp_only;
 };
 
 #endif /* _OBJTOOL_CFI_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d6731e88259d..d856580369dd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1217,7 +1217,6 @@ static int read_unwind_hints(struct objtool_file *file)
 	struct reloc *reloc;
 	struct unwind_hint *hint;
 	struct instruction *insn;
-	struct cfi_reg *cfa;
 	int i;
 
 	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
@@ -1252,49 +1251,10 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
 
-		cfa = &insn->cfi.cfa;
-
-		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
-			continue;
-		}
-
-		insn->hint = true;
-
-		switch (hint->sp_reg) {
-		case ORC_REG_UNDEFINED:
-			cfa->base = CFI_UNDEFINED;
-			break;
-		case ORC_REG_SP:
-			cfa->base = CFI_SP;
-			break;
-		case ORC_REG_BP:
-			cfa->base = CFI_BP;
-			break;
-		case ORC_REG_SP_INDIRECT:
-			cfa->base = CFI_SP_INDIRECT;
-			break;
-		case ORC_REG_R10:
-			cfa->base = CFI_R10;
-			break;
-		case ORC_REG_R13:
-			cfa->base = CFI_R13;
-			break;
-		case ORC_REG_DI:
-			cfa->base = CFI_DI;
-			break;
-		case ORC_REG_DX:
-			cfa->base = CFI_DX;
-			break;
-		default:
-			WARN_FUNC("unsupported unwind_hint sp base reg %d",
-				  insn->sec, insn->offset, hint->sp_reg);
+		if (arch_decode_insn_hint(insn, hint)) {
+			WARN_FUNC("Bad unwind hint", insn->sec, insn->offset);
 			return -1;
 		}
-
-		cfa->offset = hint->sp_offset;
-		insn->cfi.type = hint->type;
-		insn->cfi.end = hint->end;
 	}
 
 	return 0;
@@ -1571,9 +1531,9 @@ static bool has_valid_stack_frame(struct insn_state *state)
 	return false;
 }
 
-static int update_cfi_state_regs(struct instruction *insn,
-				  struct cfi_state *cfi,
-				  struct stack_op *op)
+static int update_sp_only_cfi_state(struct instruction *insn,
+				    struct cfi_state *cfi,
+				    struct stack_op *op)
 {
 	struct cfi_reg *cfa = &cfi->cfa;
 
@@ -1679,8 +1639,8 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		return 0;
 	}
 
-	if (cfi->type == ORC_TYPE_REGS || cfi->type == ORC_TYPE_REGS_IRET)
-		return update_cfi_state_regs(insn, cfi, op);
+	if (cfi->sp_only)
+		return update_sp_only_cfi_state(insn, cfi, op);
 
 	switch (op->dest.type) {
 
@@ -2084,10 +2044,10 @@ static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 			break;
 		}
 
-	} else if (cfi1->type != cfi2->type) {
+	} else if (cfi1->hint_type != cfi2->hint_type) {
 
 		WARN_FUNC("stack state mismatch: type1=%d type2=%d",
-			  insn->sec, insn->offset, cfi1->type, cfi2->type);
+			  insn->sec, insn->offset, cfi1->hint_type, cfi2->hint_type);
 
 	} else if (cfi1->drap != cfi2->drap ||
 		   (cfi1->drap && cfi1->drap_reg != cfi2->drap_reg) ||
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 00f1efd05653..a36aee98bed0 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -9,6 +9,8 @@
 #include "check.h"
 #include "warn.h"
 
+#include <asm/orc_types.h>
+
 struct orc_data {
 	struct list_head list;
 	struct instruction *insn;
@@ -92,7 +94,7 @@ int create_orc(struct objtool_file *file)
 
 		orc->sp_offset = cfa->offset;
 		orc->bp_offset = bp->offset;
-		orc->type = insn->cfi.type;
+		orc->type = insn->cfi.hint_type;
 	}
 
 	return 0;
-- 
2.21.3

