Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCADDC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF1324953
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340095;
	bh=RpCOqBR4v3FHWcOXyUprhr2wJAYbPKCXR2v4g0MUhGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fSXXnyl7U4Cn5cAvknpc/99dhufOvADGrRaUHne1lrJKb1HiqCDlHJA4jiJLEMojj
	 81ukUuZsDTdrxCwWg56v5ApaQCY+a+cRYr/KGpwvkIcpPZijnmQvX4sAWE4g7Oqeqs
	 H2wpzhwRqS2DgB9G4YS4dT1nwgZ7V+RbCZokV3x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgEANez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:32966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbgEANeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:34:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77CF0216FD;
        Fri,  1 May 2020 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340089;
        bh=RpCOqBR4v3FHWcOXyUprhr2wJAYbPKCXR2v4g0MUhGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+9W9JhLsyTMBj+U7WwXpICNhq2F5IucaM5dnMVlIpiPad8XdxRIM+tJ7iMyT+/y7
         A3KhdHvE3XR2sUuo3MUGJIpexcj2y+UHANfObE5Ty1lHG0vQGCfwpieurpf69fnAnC
         /HOVzNYf7MlM+zNKmIQ4yZ+5RSTaUVB3P5VCmwG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Miroslav Benes <mbenes@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 102/117] objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
Date:   Fri,  1 May 2020 15:22:18 +0200
Message-Id: <20200501131557.685691506@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

[ Upstream commit bd841d6154f5f41f8a32d3c1b0bc229e326e640a ]

CONFIG_UBSAN_TRAP causes GCC to emit a UD2 whenever it encounters an
unreachable code path.  This includes __builtin_unreachable().  Because
the BUG() macro uses __builtin_unreachable() after it emits its own UD2,
this results in a double UD2.  In this case objtool rightfully detects
that the second UD2 is unreachable:

  init/main.o: warning: objtool: repair_env_string()+0x1c8: unreachable instruction

We weren't able to figure out a way to get rid of the double UD2s, so
just silence the warning.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/6653ad73c6b59c049211bd7c11ed3809c20ee9f5.1585761021.git.jpoimboe@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ccd5319d1284c..04fc04b4ab67e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2062,14 +2062,27 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
+	if (!insn->func)
+		return false;
+
+	/*
+	 * CONFIG_UBSAN_TRAP inserts a UD2 when it sees
+	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
+	 * the UD2, which causes GCC's undefined trap logic to emit another UD2
+	 * (or occasionally a JMP to UD2).
+	 */
+	if (list_prev_entry(insn, list)->dead_end &&
+	    (insn->type == INSN_BUG ||
+	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
+	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
+		return true;
+
 	/*
 	 * Check if this (or a subsequent) instruction is related to
 	 * CONFIG_UBSAN or CONFIG_KASAN.
 	 *
 	 * End the search at 5 instructions to avoid going into the weeds.
 	 */
-	if (!insn->func)
-		return false;
 	for (i = 0; i < 5; i++) {
 
 		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
-- 
2.20.1



