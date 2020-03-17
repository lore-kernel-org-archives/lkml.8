Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F18A20767
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nKcZkd0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgCQRMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45002 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9woxsqJ1lSAxBBYxAWoNw9eOK3fEd3UsJ8ybAO4SbwM=; b=nKcZkd0cLfLdAReC5kmaJn3sVy
        HjgQ9VBmhhXTsqsChmM8wF4rODE8SW7yGs9O/QKZpZfovzqrzSzETn/hx4Ygi+EuT3ziI2ParCuDy
        o7gIMqMpOFHrmXo1nOMIOECyhniSsqlKKhg4Pb6ANmqDVJF7lC9cQmkoBKHSevoIlMhYQuIs4ioUm
        TovAYco8+UAa+kN2ORHHJUlhVyvtAey9ApBmidKTsFjjpKIDTK10vo8H2TJirU1RBTG5kaXmShpgz
        o2mQMiM2vYf/r4GkzClUKaPPvr51g5xykKAZ8dSm3BU0CQNPbZwvVKo0BSxFEJKVI41bwfhkyOP/7
        DzCERWXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFky-0003id-2v; Tue, 17 Mar 2020 17:11:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D25F2304C2C;
        Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC75A20B16496; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170909.880891990@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 02/19] objtool: Rename func_for_each_insn()
References: <20200317170234.897520633@infradead.org>
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


