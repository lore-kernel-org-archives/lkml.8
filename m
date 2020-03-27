Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37264C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D592078B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXqNNbut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgC0P3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:29:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55967 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbgC0P3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585322955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJbVki3d6xGnePglUGelW4ilifdkrwj5VgDQOLjbBOE=;
        b=OXqNNbut425B36SK9ODMj6ahIAo9k6p5W96SkDK3DpnpeYzwSVRryh0eSW0zL3jvGJbuW/
        zM01yp8Y/0HX2+0dBk8lkVJQKZ7EvfQ94JEoNfkwFJuHPmAVz+6SdwJf7wvYcEGPh9LbVp
        5eUq/6Ts7K5011gsIV5ikjY0e7Q4LqM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Oya0zjIENLmOJDOHsui2Dg-1; Fri, 27 Mar 2020 11:29:14 -0400
X-MC-Unique: Oya0zjIENLmOJDOHsui2Dg-1
Received: by mail-wr1-f70.google.com with SMTP id v17so644660wro.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJbVki3d6xGnePglUGelW4ilifdkrwj5VgDQOLjbBOE=;
        b=b1M8tFxmJ8YoJkylqwzTCLOjgKz0Rj5DbRrnqUYHN+J4eGHcA3COR5PnKyyUCPc4SK
         K7Vfr0Cfa2WIZfVWh/YTTWzhBlgUQ3QBx7OdlPQGqWUli3VvLpvc5ZjmMZbBaIu8T0Kn
         kUwkDvGqjXIAkxKILHdku09cHGGApQR7vqjZ3uIWypsETLFg+Lg7iOvFn9prt8SCyU0P
         MVSab5HDj/LOPVeMtchTLgeu39rvZLDNNyv4QJ2BMjmzk4b9ZCf266aX2czHOeKTVF8B
         +XxW1+iC6ymb2KlBZ+HBEd4hEgavV9MtqWka0Fg/kCjFLeQSurNqAQtziFyJIBrn6X3y
         Wyuw==
X-Gm-Message-State: ANhLgQ0GOkOvEOc8lWmZo8kYkX9gBOEoF5f6THFL6cJv7Ft4iQ2+J+xT
        Jx1fuBZW6yw9IBwDeZuQ9BY10OIvAZEJqo+x4LDxmz7IeI4xix5aNSNgKzDwUGozERO9I4k0hhF
        hFxCJwmdMEYAS2naPa9u4fh9i
X-Received: by 2002:a5d:6a82:: with SMTP id s2mr16021061wru.205.1585322952572;
        Fri, 27 Mar 2020 08:29:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtoWkTLT8K8FlfBBGTQarbu0+JwUcSgVWcFb8p3d38s6nowNbLGGgei94BDh0gLS2EwnwkWew==
X-Received: by 2002:a5d:6a82:: with SMTP id s2mr16021048wru.205.1585322952409;
        Fri, 27 Mar 2020 08:29:12 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id i8sm8906856wrb.41.2020.03.27.08.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:29:11 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 07/10] objtool: check: Allow save/restore hint in non standard function symbols
Date:   Fri, 27 Mar 2020 15:28:44 +0000
Message-Id: <20200327152847.15294-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327152847.15294-1-jthierry@redhat.com>
References: <20200327152847.15294-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel code base provides CODE_SYM_START/END to declare assembly
code sequences that don't follow function standard calling conventions.

As non-C/non-standard code, these sequences can very much benefit from
unwind hints. However, when a restore unwind_hint is used in a
non-function code sequence, objtool will crash when looking for the
corresponding save hint.

Record the code symbol an instruction belongs to and look for save hints
belonging to the same code symbol as the restore hint.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/check.c | 27 +++++++++++++++++++--------
 tools/objtool/check.h |  1 +
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 65809c74f6a8..fb1ddde66b48 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -236,7 +236,7 @@ static void clear_insn_state(struct insn_state *state)
 static int decode_instructions(struct objtool_file *file)
 {
 	struct section *sec;
-	struct symbol *func;
+	struct symbol *sym;
 	unsigned long offset;
 	struct instruction *insn;
 	unsigned long nr_insns = 0;
@@ -278,18 +278,22 @@ static int decode_instructions(struct objtool_file *file)
 			nr_insns++;
 		}
 
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC || func->alias != func)
+		list_for_each_entry(sym, &sec->symbol_list, list) {
+			if ((sym->type != STT_FUNC && sym->type != STT_NOTYPE) ||
+			     sym->alias != sym)
 				continue;
 
-			if (!find_insn(file, sec, func->offset)) {
+			if (!find_insn(file, sec, sym->offset)) {
 				WARN("%s(): can't find starting instruction",
-				     func->name);
+				     sym->name);
 				return -1;
 			}
 
-			sym_for_each_insn(file, func, insn)
-				insn->func = func;
+			sym_for_each_insn(file, sym, insn) {
+				insn->code_sym = sym;
+				if (sym->type == STT_FUNC)
+					insn->func = sym;
+			}
 		}
 	}
 
@@ -758,6 +762,7 @@ static int handle_group_alt(struct objtool_file *file,
 		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
 		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
 		fake_jump->func = orig_insn->func;
+		fake_jump->code_sym = orig_insn->code_sym;
 	}
 
 	if (!special_alt->new_len) {
@@ -2065,9 +2070,15 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (insn->restore) {
 				struct instruction *save_insn, *i;
 
+				if (!insn->code_sym) {
+					WARN_FUNC("restore instruction doesn't belong to any symbol",
+						  insn->sec, insn->offset);
+					return 1;
+				}
+
 				i = insn;
 				save_insn = NULL;
-				sym_for_each_insn_continue_reverse(file, func, i) {
+				sym_for_each_insn_continue_reverse(file, insn->code_sym, i) {
 					if (i->save) {
 						save_insn = i;
 						break;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index f0ce8ffe7135..d1b55961474c 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -42,6 +42,7 @@ struct instruction {
 	struct rela *jump_table;
 	struct list_head alts;
 	struct symbol *func;
+	struct symbol *code_sym;
 	struct stack_op stack_op;
 	struct insn_state state;
 	struct orc_entry orc;
-- 
2.21.1

