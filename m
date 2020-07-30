Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB88C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464AC20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqczXSsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgG3JrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55349 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728739AbgG3JrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IyszSINmUuWIze0BnbavP6pqqJ9qAHJ6c6Qsw22nt4E=;
        b=MqczXSswaZmAtb+7fIfr+05fRUH7LK85h1vPHbwDqtulWBnkrJriQrbEHeT7KoLuHENVIU
        XfJp90IOpnaWGnSzIwbxkNwKp57SJy1LjubfpPhB1I7++yAd6kfLx8OpButYG1gf7vrumg
        qD+aG/vHU6Mea6Ozu6Yue5/xdRMxJ8o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-eLspCjMBNgyxs3kURoGa3A-1; Thu, 30 Jul 2020 05:47:03 -0400
X-MC-Unique: eLspCjMBNgyxs3kURoGa3A-1
Received: by mail-wr1-f71.google.com with SMTP id j16so7757942wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyszSINmUuWIze0BnbavP6pqqJ9qAHJ6c6Qsw22nt4E=;
        b=tcNj9aQlb+INECUl+Gxgff2z0IYCYtDRvLTPYwfdysOYbYGu+GtN/UHQ5mKcpjjO3I
         VJHGyMFxvWzkGhgHUivyCib0enlDO9ATFO5Iy9M01m1r4oX6/Y1JRwU4u+HPk559lnUP
         RobhToF61by7Ecpuo2pKowCIH7U7tfnAFzbAHId+xxNKdXKL6OcoZfk72UiUimdhttsO
         CCCvjThZOqTD29oxBr5E42K+VduVI+IbuhTujUOrH4ASuN8+xm+QYNr6DJfL+MBU5s/c
         Xd6D6xj3cSTALMlgf10IT0z4cvhPUIRF33d8IxApUu5yD8vDy0k5+iB7dekFXodmey4E
         iAtg==
X-Gm-Message-State: AOAM531HXRgyn+6pvlkwRGRHuvkIw82J4ytZYe9baTmdR1dhdB9XJgz+
        Gaoobx4uKeADSBphHXzXtJVhnIPZvAKHm1ffl2LdcAFjwpSi1xHP1eo1L8NoQU8SdOefa3ezPNI
        aYds8J/HfPKBWdEGeCvC3MqfV
X-Received: by 2002:a1c:18e:: with SMTP id 136mr12364018wmb.93.1596102422036;
        Thu, 30 Jul 2020 02:47:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeCvv9QIx3gUBDdMdGQ7ordtkh4NFfHe5C/Ru33YoKDiX4jELw1pNcq2XN0X7BPxUe7P8Oxg==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr12363995wmb.93.1596102421764;
        Thu, 30 Jul 2020 02:47:01 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:47:01 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 5/9] objtool: Make relocation in alternative handling arch dependent
Date:   Thu, 30 Jul 2020 10:46:48 +0100
Message-Id: <20200730094652.28297-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
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
 tools/objtool/arch/x86/arch_special.c | 13 +++++++++++++
 tools/objtool/check.c                 | 19 ++++++-------------
 tools/objtool/check.h                 |  6 ++++++
 tools/objtool/special.h               |  4 ++++
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
index 823561e4015c..34e0e162e6fd 100644
--- a/tools/objtool/arch/x86/arch_special.c
+++ b/tools/objtool/arch/x86/arch_special.c
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
index bb19e4c79e46..18ef9c64719f 100644
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
index 059c43bfeb18..c08ca6cd9a89 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -44,6 +44,12 @@ struct instruction {
 	struct cfi_state cfi;
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

