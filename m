Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C21C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03DD206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFxlziYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgFHP2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730244AbgFHP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWSoHpgaOlyh318lsb+uBI/SJmEJgoQd6V63cW0tBS8=;
        b=hFxlziYecQpO7fASW5SJWKN5/wU8AX2aiRxOX0HVZ5RAYMXD4W1WT6zhl7AA03HbfosxHn
        42YBE2ma0k9GW11mJx8pT9fCpV/E7AHMZfz0up3WP73FG/+org2FU61Y9Kl0LB4LpWnH1K
        6uqKfsOQTo8ul3/M9ap3lCzOZpqFqZk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-IUOYU8tPNouySh0J5h2AGw-1; Mon, 08 Jun 2020 11:28:04 -0400
X-MC-Unique: IUOYU8tPNouySh0J5h2AGw-1
Received: by mail-wr1-f71.google.com with SMTP id f4so7309401wrp.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWSoHpgaOlyh318lsb+uBI/SJmEJgoQd6V63cW0tBS8=;
        b=azc+EpW5BGal0sWJNanLUi+S22EARIC+BPidOUlyS2bWtZBbdtjA1g7TEX+/JQOP2H
         DUcbMco+7yrdtsDJNiIOhY+1UqyuosmgBFqB+pwhFYfU9Wm15Smqb4Li8+g/j7g5vmBU
         2UWqXlyKu02WWxVPL/HEA0bpPVMKH3hVdipUPu+fFp/Clh0n+eJ+VIfQcOE4ZXaV47Ky
         uZBdtqnigTfg1Uvdc0olVeQ+I8a3+8pNK2GO3nTXYvWsa6qAWapkGJZAZYVZNjk4CrWC
         N1VLO42/t8zYH8Y/vDiA/9WQ60nWSHHKYvPYFVkO0qytoWQBz8YFgvfgO2rMCCVhWbsq
         4D6w==
X-Gm-Message-State: AOAM531AEep7xXiuFeFE0feilJv8kUX0lwZiVihqW1D9sKQPhLjEjloY
        AGO2RSChYJzlcWxTwcYqX3QC89OhElunEskhUqwE6syignDKQN77rsdAlC6hdpjnJ3u9JTJxsCH
        /MV4gCgtzRiaIdErDFk/HDOzt
X-Received: by 2002:a7b:c761:: with SMTP id x1mr17870342wmk.90.1591630082939;
        Mon, 08 Jun 2020 08:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZMY83EifawwJQiPcB+AWgQf3H17UwWt6TN/dh4xRYo8RczKQ/dsgElt0pXB73pj1GxQmLPA==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr17870328wmk.90.1591630082709;
        Mon, 08 Jun 2020 08:28:02 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:28:02 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 5/7] objtool: Make relocation in alternative handling arch dependent
Date:   Mon,  8 Jun 2020 16:27:52 +0100
Message-Id: <20200608152754.2483-6-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
References: <20200608152754.2483-1-jthierry@redhat.com>
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

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/x86/arch_special.c | 13 +++++++++++++
 tools/objtool/check.c                 | 19 ++++++-------------
 tools/objtool/check.h                 |  6 ++++++
 tools/objtool/special.h               |  4 ++++
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
index 823561e4015c..4931ad1a0ab5 100644
--- a/tools/objtool/arch/x86/arch_special.c
+++ b/tools/objtool/arch/x86/arch_special.c
@@ -35,3 +35,16 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 		break;
 	}
 }
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct rela *rela)
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
index 3fbb60fe94df..738bfd458595 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -108,12 +108,6 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
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
@@ -825,6 +819,8 @@ static int handle_group_alt(struct objtool_file *file,
 	alt_group = alt_group_next_index++;
 	insn = *new_insn;
 	sec_for_each_insn_from(file, insn) {
+		struct rela *alt_rela;
+
 		if (insn->offset >= special_alt->new_off + special_alt->new_len)
 			break;
 
@@ -841,14 +837,11 @@ static int handle_group_alt(struct objtool_file *file,
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
-		    find_rela_by_dest_range(file->elf, insn->sec, insn->offset, insn->len)) {
+		alt_rela = find_rela_by_dest_range(file->elf, insn->sec,
+						   insn->offset, insn->len);
+		if (alt_rela &&
+		    !arch_support_alt_relocation(special_alt, insn, alt_rela)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
 				  insn->sec, insn->offset);
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 49f9a5cc4228..785388cf3872 100644
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
index 44da89afeda2..e15d52d3595d 100644
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
+				 struct rela *rela);
 #endif /* _SPECIAL_H */
-- 
2.21.1

