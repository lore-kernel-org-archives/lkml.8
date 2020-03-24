Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A787C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56827208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ywp2hdih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgCXQLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgCXQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ET9w82hEnD2mMr6F0WQ7E25947u7sDgJQ7IZiEnRWQM=; b=Ywp2hdihDX0N8Qq9jf4vDZgx22
        oBGTanY3n6nMo77Dyw5f6D4v5WoLm39t6n5kZYeonaRSzSQf95tfWtvds29OwYAxcQTkF/UFp8Bc1
        HvALukAc5Kf+RatPCDiiprFEpkgCJ8kbremI8yRp2R7rZVemdAM42Op2mhOQujGvSjfkk1e3hK0MD
        sxpYqJtJiaViudIauDOqRQvxLXSR+foYutG8CSGw1pEFoH6eLTsLTgogP5l10DO7y/ZFD9QXsxM6y
        CZVTxoyAzmBRNuJ4wtO1vTlgOvdo90WFpgttI+VB40J/ukUiJT5aODdr7rF/JhClQRZTIWT5lVAQe
        MemWrL6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9K-0000BR-9X; Tue, 24 Mar 2020 16:11:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F1C43007F2;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1BB0329A490F1; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.024341229@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 02/26] objtool: Rename func_for_each_insn()
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is func_for_each_insn() and func_for_each_insn_all(), the both
iterate the instructions, but the first uses symbol offset/length
while the second uses insn->func.

Rename func_for_each_insn() to sym_for_eac_insn() because it iterates
on symbol information.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -77,17 +77,17 @@ static struct instruction *next_insn_sam
 	     insn;							\
 	     insn = next_insn_same_func(file, insn))
 
-#define func_for_each_insn(file, func, insn)				\
-	for (insn = find_insn(file, func->sec, func->offset);		\
+#define sym_for_each_insn(file, sym, insn)				\
+	for (insn = find_insn(file, sym->sec, sym->offset);		\
 	     insn && &insn->list != &file->insn_list &&			\
-		insn->sec == func->sec &&				\
-		insn->offset < func->offset + func->len;		\
+		insn->sec == sym->sec &&				\
+		insn->offset < sym->offset + sym->len;			\
 	     insn = list_next_entry(insn, list))
 
-#define func_for_each_insn_continue_reverse(file, func, insn)		\
+#define sym_for_each_insn_continue_reverse(file, sym, insn)		\
 	for (insn = list_prev_entry(insn, list);			\
 	     &insn->list != &file->insn_list &&				\
-		insn->sec == func->sec && insn->offset >= func->offset;	\
+		insn->sec == sym->sec && insn->offset >= sym->offset;	\
 	     insn = list_prev_entry(insn, list))
 
 #define sec_for_each_insn_from(file, insn)				\
@@ -281,7 +281,7 @@ static int decode_instructions(struct ob
 				return -1;
 			}
 
-			func_for_each_insn(file, func, insn)
+			sym_for_each_insn(file, func, insn)
 				insn->func = func;
 		}
 	}
@@ -2024,7 +2024,7 @@ static int validate_branch(struct objtoo
 
 				i = insn;
 				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, func, i) {
+				sym_for_each_insn_continue_reverse(file, func, i) {
 					if (i->save) {
 						save_insn = i;
 						break;


