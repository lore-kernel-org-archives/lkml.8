Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D8EC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16132071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BkiXl71J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgDUSHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgDUSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:07:36 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F9C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e18so12090332pld.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mKZgWKTP9nyB3m6imB1oWbJmLGuM3Run3ACrycwRXo0=;
        b=BkiXl71Ju4RoZwGuop1242f7nPTIl1QtJbh0t1/aJS5V1RbTj0ig+XmGT4ANz+ObG2
         JbmwyufL7tqvPmoqkImWWmAgQ1G9l16RL+ocbWy5WDJljW1KdTK1Xlk6miC5G1GJyfSC
         CnBHK8d8ZICOQ1NCQJOqdduvYbt2h5cvgc8ujidiZ6vGCjJWN5F6zZEYrVUhHDHVdDKd
         yZGNzA+FarHu383z1bpWfYdsOpnpHLTSIc1Nit1aI9v6Lk+ciEsp4E8bY+SRVk+rBo4q
         F3M74IMWQhKrkzUOXarzuelT0A6fRUQCkPIVWn+15BEaUWOSGA3Hy5BphgNS4Fuw2TpM
         Hj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mKZgWKTP9nyB3m6imB1oWbJmLGuM3Run3ACrycwRXo0=;
        b=UMuH5hM16csGEnKjNB/uXGzMLyOCwpXDlScdNPMYg2gtyMsDjEjuQHWcH0LQyCVLkg
         HJkxpTLf6UXmYExBAHcwLSYecRAyiod1cKe2SSYymIxsiyt0HuXOPJWr5cZea2a1cWR6
         KX9fGHz4auymiW+DndHHiZ63StDIFBBFWlUt8ldctkAjH4huOQjEijSnRUoBWrYfHwic
         CAw8nGPH2A8NQU2D4/seK+HGuTUdPIRfyCmWG4NCO8WCpnRgiIw8IOkEsT8x7Wr9Rim2
         WDSc9RcXUFZaKzoxuD3xegbSOCmdoOBcTEzTfKMBDJ9GS4WfX/jAXSU3ZLN3U7ItREXf
         46YA==
X-Gm-Message-State: AGi0PuZxjVLMRgF2bFLRAN49p9/N9hDlb+WsrcCs6g7rRUmr46LxLPBb
        KmpHRehV013QkCTfcOH9fTJuoJfqIe2py8dpPJ8=
X-Google-Smtp-Source: APiQypIB1Hn2TWcwGvGfZLdETbRCDJ/Wqg5d98rBz4Ei2HyNE+9LmwS7HVGo2ypBkYFB63iTI0DsX1wWPUhsRqa+oQY=
X-Received: by 2002:a63:5d60:: with SMTP id o32mr22283536pgm.172.1587492455521;
 Tue, 21 Apr 2020 11:07:35 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:07:23 -0700
In-Reply-To: <20200421180724.245410-1-samitolvanen@google.com>
Message-Id: <20200421180724.245410-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200421180724.245410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH 2/3] objtool: optimize insn_hash for split sections
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running objtool on vmlinux.o compiled with -ffunction-sections,
we end up with a ton of collisions in the insn_hash table as each
function is in its own section. This results in a runtime of minutes
instead of seconds. Use both section index and offset as the key to
avoid this, similarly to rela_hash.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/objtool/check.c | 5 +++--
 tools/objtool/check.h | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4b170fd08a28..4770fb07b365 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -34,7 +34,8 @@ struct instruction *find_insn(struct objtool_file *file,
 {
 	struct instruction *insn;
 
-	hash_for_each_possible(file->insn_hash, insn, hash, offset)
+	hash_for_each_possible(file->insn_hash, insn, hash,
+			       sec_offset_hash(sec, offset))
 		if (insn->sec == sec && insn->offset == offset)
 			return insn;
 
@@ -273,7 +274,7 @@ static int decode_instructions(struct objtool_file *file)
 			if (ret)
 				goto err;
 
-			hash_add(file->insn_hash, &insn->hash, insn->offset);
+			hash_add(file->insn_hash, &insn->hash, insn_hash(insn));
 			list_add_tail(&insn->list, &file->insn_list);
 			nr_insns++;
 		}
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index f0ce8ffe7135..bc78eca7982e 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -56,6 +56,11 @@ struct objtool_file {
 
 int check(const char *objname, bool orc);
 
+static inline u32 insn_hash(struct instruction *insn)
+{
+	return sec_offset_hash(insn->sec, insn->offset);
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

