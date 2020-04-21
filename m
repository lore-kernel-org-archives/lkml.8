Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF01C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A400420724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGCQDwXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDUWJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:09:00 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3BC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:09:00 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i128so279880pfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mDHmY9kBbmtNLTrTQf1PZE7xxuj6hLsL/6YrTc8c7yY=;
        b=aGCQDwXUwab/IFGFL0C2/sPd00y7giG3htT2IvaQwERtnmIhE4vFRCiTlAk8ZK2lD4
         cWmNTyBbRDLEAp4xxbbb8nJzimMh9DGynsK9Zeo9bNGhV1bH1bDWy5OJA/aAyKEVLc9U
         aq0U0jZZgDO83gaseC7GtEEm+TomUY/EtJoieeq6FUPFDOs8kQF1S514KYXZIGerTjOY
         Pnb58cHk9jUAUY4ZSmcv1x7xuFL6c0tQrXwAFEFHr0+6mjTAjuU9ItNAIIx1uQSPJTjf
         fK5kgxKsyZX0GRMt745tsKADCUuBO7gudvEoR2MeS4Tar5KAKdZpJAk1N+IIsgp3NUSl
         beLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDHmY9kBbmtNLTrTQf1PZE7xxuj6hLsL/6YrTc8c7yY=;
        b=cKcIOQoAXjRFJRZ6FUbjnEe/YzF2Qe1JVBrB4VQBQYOH1QSOSnKnnlW3iSUlF3Jqlg
         19HjxWH2HicEgiWXe0rPqqm1qa5RVTIl/qo17env4ixol+rRtZP/BiJ3xVM51QKQ4kwk
         kYJAKlQxC1/GYlRkNS5J/cSux8PToXdYdSikN50sJMy4bjKNrTf+ny2F8ZgkLwhL7yU3
         uQbytdRKaJD4p4rO9+ilRA2u4Uwf16ckaDEf8+HeRu7socIqbqsVN/b+GHVTu4gtWSnI
         C7wvenzokDgLJUrZmcSKMte3wnaJBPhjpi3mZxLqMCXWNLIyLFn2E+FYJdWgdzC7scCt
         Hkug==
X-Gm-Message-State: AGi0Pua9SIk47i/71l56+ZChqUJjGLJZKF+QP6Z6g9oZMoyHA7XLaYhX
        upvUCw5z+DLQmDOBkTOhrxU43pqwCQl/P23A5Tk=
X-Google-Smtp-Source: APiQypLrhcQL0vqQUMMlsvCCuOZabqtDCM2FzSnRjUVEsqtbk9nsbyrXKQqTYh2/VriwXxrYIjzW5d4L9zjsu3exT/U=
X-Received: by 2002:a65:611a:: with SMTP id z26mr22656595pgu.341.1587506940061;
 Tue, 21 Apr 2020 15:09:00 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:08:43 -0700
In-Reply-To: <20200421220843.188260-1-samitolvanen@google.com>
Message-Id: <20200421220843.188260-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200421180724.245410-1-samitolvanen@google.com> <20200421220843.188260-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v2 2/2] objtool: optimize add_dead_ends for split sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating through all instructions to find the last
instruction each time .rela.discard.(un)reachable points beyond the
section, use find_insn to locate the last instruction by looking at
the last bytes of the section instead.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b170fd08a28..4f1d405420a4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -303,6 +303,19 @@ static int decode_instructions(struct objtool_file *file)
 	return ret;
 }
 
+static struct instruction *find_last_insn(struct objtool_file *file,
+					  struct section *sec)
+{
+	struct instruction *insn = NULL;
+	unsigned int offset;
+	unsigned int end = (sec->len > 10) ? sec->len - 10 : 0;
+
+	for (offset = sec->len - 1; offset >= end && !insn; offset--)
+		insn = find_insn(file, sec, offset);
+
+	return insn;
+}
+
 /*
  * Mark "ud2" instructions and manually annotated dead ends.
  */
@@ -311,7 +324,6 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *sec;
 	struct rela *rela;
 	struct instruction *insn;
-	bool found;
 
 	/*
 	 * By default, "ud2" is a dead end unless otherwise annotated, because
@@ -337,15 +349,8 @@ static int add_dead_ends(struct objtool_file *file)
 		if (insn)
 			insn = list_prev_entry(insn, list);
 		else if (rela->addend == rela->sym->sec->len) {
-			found = false;
-			list_for_each_entry_reverse(insn, &file->insn_list, list) {
-				if (insn->sec == rela->sym->sec) {
-					found = true;
-					break;
-				}
-			}
-
-			if (!found) {
+			insn = find_last_insn(file, rela->sym->sec);
+			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%x",
 				     rela->sym->sec->name, rela->addend);
 				return -1;
@@ -379,15 +384,8 @@ static int add_dead_ends(struct objtool_file *file)
 		if (insn)
 			insn = list_prev_entry(insn, list);
 		else if (rela->addend == rela->sym->sec->len) {
-			found = false;
-			list_for_each_entry_reverse(insn, &file->insn_list, list) {
-				if (insn->sec == rela->sym->sec) {
-					found = true;
-					break;
-				}
-			}
-
-			if (!found) {
+			insn = find_last_insn(file, rela->sym->sec);
+			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%x",
 				     rela->sym->sec->name, rela->addend);
 				return -1;
-- 
2.26.1.301.g55bc3eb7cb9-goog

