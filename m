Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06745C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EA420578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwZPiUWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgC0P3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37518 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbgC0P3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNIaK5JSNBt+d2c/mRdsOELL5mhGpDJM5tgWy+8p770=;
        b=SwZPiUWK4UR6KnagMMSpW16o07Fsi9ZJdkXk3nq++zifSv8butvzybWlzp1MVsL4tEBVJ+
        fQKiVWQ3s2RkEn4cUdpHMV/LfSA9EnUMVNMNpejjJZseKbr54Wruk4gJJ/Ms7FLq4146co
        H+rRo/GX11DURDgjsYaje5LvBzSk9Dw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-bS6GnB-MOEKeeu_C6T7U0w-1; Fri, 27 Mar 2020 11:29:17 -0400
X-MC-Unique: bS6GnB-MOEKeeu_C6T7U0w-1
Received: by mail-wr1-f71.google.com with SMTP id w12so4701083wrl.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNIaK5JSNBt+d2c/mRdsOELL5mhGpDJM5tgWy+8p770=;
        b=TGSBUAoQ7a+YqE9chd4Cdp0EcVR6b2trBvqDOwAtym90J2+SCqovxNBAP5AVMQ5OiM
         j3xnmSmbvh3fCU6ReCAT/akQdUiJ+WulTvoBq1tQZB3D0URMHqPvC7RcU8OG9UL0MZ45
         xG2aDJPkkvd4KVumfHtL8hPPlICQUdUCNgJJ7o4fehDJ0hGgqYpCsPGf0cDN0oQrhbiS
         99xYvYslFUpHAaRUQMOK6oDUHxmTPorcQd114V+qOMndZN3Fk5sTEGxCq9R+thKpAHT7
         RNjhxD5QZ2WVkkowQoGel1FE1Go3lME7x3MeD1kXAwX+uY/H53DYFZSKVS3+97MOdx1g
         Pcow==
X-Gm-Message-State: ANhLgQ25S7sSnNaTs6gCQheoB/FHCqc8Kdo2eSwTjKun3F2sj+/XgQGD
        k0rm4d2/B7DtWqtrDjEcGbR/jJqnPj3ofU9i2xH3beRPK6VRmkzZruP+QQ433zLOS78r+NSZZnU
        iqCZ+L32iqeB/InkccwO0+sG5
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr16613520wrw.53.1585322955998;
        Fri, 27 Mar 2020 08:29:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs1B//wsAVOFP9IcArgyZdxD8kjct5iUlLsqBeBSidkDdy63l+S/8brV9+Ad0bLJeNPU6Qosw==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr16613503wrw.53.1585322955781;
        Fri, 27 Mar 2020 08:29:15 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:29:14 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 08/10] objtool: Add abstraction for computation of symbols offsets
Date:   Fri, 27 Mar 2020 15:28:45 +0000
Message-Id: <20200327152847.15294-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
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
index fb1ddde66b48..dbfd1f5d06f7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -577,13 +577,14 @@ static int add_jump_destinations(struct objtool_file *file)
 					       insn->offset, insn->len);
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
@@ -673,7 +674,7 @@ static int add_call_destinations(struct objtool_file *file)
 		rela = find_rela_by_dest_range(file->elf, insn->sec,
 					       insn->offset, insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
 			if (!insn->call_dest)
 				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
@@ -696,13 +697,14 @@ static int add_call_destinations(struct objtool_file *file)
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
@@ -814,7 +816,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (!insn->immediate)
 			continue;
 
-		dest_off = insn->offset + insn->len + insn->immediate;
+		dest_off = arch_jump_destination(insn);
 		if (dest_off == special_alt->new_off + special_alt->new_len) {
 			if (!fake_jump) {
 				WARN("%s: alternative jump to end of section",
-- 
2.21.1

