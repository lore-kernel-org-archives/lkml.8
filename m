Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AAAC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8783A20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE/AdT5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCYImj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39682 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727501AbgCYImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrdvUnhrwryyBR43K7InCr/vnbST4z9N1od+0RG8OUQ=;
        b=eE/AdT5LZmkW/0NUY7Yd8q6LfOvvxj8rl6qvtfNts80zWqrgUdobQMmTff/VcxncxpbMgB
        ypGBaLVNHx1c5BxzAVk0OM5p5lpRz8ime27BM5PPDX+nIVG6y+J4ozrSvkcctbtZhBT2s2
        PHx45ioPXilWj+TTtBZBCMiiSja16wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-UJGpaBeqO46GdeucCClHjA-1; Wed, 25 Mar 2020 04:42:21 -0400
X-MC-Unique: UJGpaBeqO46GdeucCClHjA-1
Received: by mail-wm1-f70.google.com with SMTP id n25so405470wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrdvUnhrwryyBR43K7InCr/vnbST4z9N1od+0RG8OUQ=;
        b=eMu8DGqKtKqH9i8FHtGlauLrXDf3Nmxm/GtniqGv1+1S9ZFnkq8ycHBJ1YG+G8GkPc
         38zbXwzfBJJCufDHj/DWwP1gYQCM+JzuxuDzTf5UbJD6+/atj9zk32AD6gN6tPTv4bgm
         jwUWsWsADzNQ2TVd56WTkzo/zyn1GjS3wU/ZBsU3vI0Mt7f9vcyd4w98WpTSeoXJkNGz
         UfkVfzS5CS0U5thsqxbDqntUP6bC7AMpm6PyO/RxUiQqnQFLj4loLHJIIEHWNONLWgxs
         hNVPcFX5RIV+Ce7vFKFvjO0y4AN0CP6sNIReqf6q6tjE5Zrlf3pgJnrUyl7zrIT/4HiV
         Jy5w==
X-Gm-Message-State: ANhLgQ16ef1SUoMnRLz8gUdqhOiLW/DVrMKbIhISFYtTR1APfsxw9FBs
        /BGpdYOkCSkrgXm6A/zxX6r3t073DFzAtzAHctXa66rze/7DPXGVp13KF/ogrS7EXS4/u8cNnWt
        Q0KS4Eo8aOLoe1vL/MptWIF11
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr2080901wrq.119.1585125740112;
        Wed, 25 Mar 2020 01:42:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vurw86r6TOM0OujIpqSTbXgvDzROEI718CpCwwv+RJTJMC4gbShTbqnqTbDyKNtWRy94QMxjA==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr2080880wrq.119.1585125739801;
        Wed, 25 Mar 2020 01:42:19 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:19 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 07/10] objtool: check: Allow save/restore hint in non standard function symbols
Date:   Wed, 25 Mar 2020 08:42:00 +0000
Message-Id: <20200325084203.17005-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
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
index 7bf4dbc2e31f..90d3db00352d 100644
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
 	int ret;
@@ -276,18 +276,22 @@ static int decode_instructions(struct objtool_file *file)
 			list_add_tail(&insn->list, &file->insn_list);
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
 
-			func_for_each_insn(file, func, insn)
-				insn->func = func;
+			func_for_each_insn(file, sym, insn) {
+				insn->code_sym = sym;
+				if (sym->type == STT_FUNC)
+					insn->func = sym;
+			}
 		}
 	}
 
@@ -771,6 +775,7 @@ static int handle_group_alt(struct objtool_file *file,
 		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
 		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
 		fake_jump->func = orig_insn->func;
+		fake_jump->code_sym = orig_insn->code_sym;
 	}
 
 	if (!special_alt->new_len) {
@@ -2043,9 +2048,15 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
-				func_for_each_insn_continue_reverse(file, func, i) {
+				func_for_each_insn_continue_reverse(file, insn->code_sym, i) {
 					if (i->save) {
 						save_insn = i;
 						break;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6d875ca6fce0..0cfdad839b76 100644
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

