Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79753C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D34320724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWIJU/Tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgCLNwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46820 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9woxsqJ1lSAxBBYxAWoNw9eOK3fEd3UsJ8ybAO4SbwM=; b=qWIJU/TtvWkgc7W626VvqfNK5g
        JENK2fyIF9K6t+CnhrzfHAQusWC+R9Q3ELbUP1+fWaYIBpPzhr4NQ8mEphlrtvEzGe4VIiY2gTO3n
        eg2YK2Skt6eiS3WITZ1vuzJ62KsxtNfG0E2eC3UC7qkbxxf5oL9Fugmp2/1knucmecHdpcY6vJdm8
        768FNefzFUXqekzbCKNhAue58FFBYkhC1b2g36iWLfcx/aPty2WDYTrky7MKEjjEQzNVoAZBoZFHb
        z3fQtFOSBtd5qtQ+7pyON7uAt14ByK23YpbPzq1Kz1fLXGojKcf2F83nkc7GRAXNhTAiCkOlPuAsz
        hCESnp1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFM-0003AR-O7; Thu, 12 Mar 2020 13:51:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 204653011E0;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0AB442B7403DF; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135041.524075934@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 02/16] objtool: Rename func_for_each_insn()
References: <20200312134107.700205216@infradead.org>
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


