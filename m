Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA7C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38B72070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0gvFfmy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgD1TUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728981AbgD1TTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:52 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2092C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=o57KJG7FUndGuDb6ctvmoUs++JMbSj8MPYpWk/nAFrY=; b=0gvFfmy89/lVoxEkPNC6CKgnjq
        4j5NSb5AW/zf0sIQJ1JBM8bbRItOgmx8SOCNlUwHa0uvBjNS8D4UzWXn6hAqW6DQ+0OYfj3ro9qIt
        CepiGeZQWBeOa9Br17PqNyGdWbHBiEFjXsZTA8W4Ouo9qk15OaLz6STDk4kCln6LfrysA0e9km0iB
        Cs30CqOSAVJEB5y9+QoLSw6X3ThN4oCTK/b6FrU1UNfmP/L48FUxPjduMLjizg3VVra8am3JCRFvp
        IH2OLKW6mwubKiYQvmu1TF8k4cjA6rYvAu3V8RN8Ha/hOlmrXZjKrrvMGKHmDmgGBJJMHjhVU65qK
        zPTJq7/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlR-0007ky-JG; Tue, 28 Apr 2020 19:19:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5BC730774A;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8EAF325D01314; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191659.795115188@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 07/14] objtool: Make handle_insn_ops() unconditional
References: <20200428191101.886208539@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that every instruction has a list of stack_ops; we can trivially
distinquish those instructions that do not have stack_ops, their list
is empty.

This means we can now call handle_insn_ops() unconditionally.

Suggested-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2247,6 +2247,9 @@ static int validate_branch(struct objtoo
 				return 0;
 		}
 
+		if (handle_insn_ops(insn, &state))
+			return 1;
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
@@ -2306,9 +2309,6 @@ static int validate_branch(struct objtoo
 			break;
 
 		case INSN_EXCEPTION_RETURN:
-			if (handle_insn_ops(insn, &state))
-				return 1;
-
 			/*
 			 * This handles x86's sync_core() case, where we use an
 			 * IRET to self. All 'normal' IRET instructions are in
@@ -2328,8 +2328,6 @@ static int validate_branch(struct objtoo
 			return 0;
 
 		case INSN_STACK:
-			if (handle_insn_ops(insn, &state))
-				return 1;
 			break;
 
 		case INSN_STAC:


