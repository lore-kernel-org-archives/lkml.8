Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33DCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED56208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmBofkxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgCXQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgCXQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6kFko+tI6uqSmZzN+BrRSaiCqmG948MnieaRkmvxg98=; b=lmBofkxCzWiu3BuMbsxoEnRMfP
        cd3OnN06Ctki0Qme0rOGbVyLVxdE9EP3JlarY89z7bOujPmNV40tZLnEZlVbygmZLqx2Yju7un+eC
        DZjIa2F+AgIVevlRvWckdis8FK3GPOJ3NigMEeODD37tiKYthOHXBoif0Ld6WY+2AoNQnwIJKnPYm
        mnR8yD57SCilS9OY5Xg6U82Ei2aiA7PqzxhpC/K8vj0C/ZgHC/JM+i7MzdokgK6yLtLybq0fRpILJ
        TvZISB7ap+PuAfsZLNnlU3enydXafxqmVi2xBY47qDaNBkmze2mlQ3ZVyzG5Sx2hqVoRFdexxDozg
        +GaYgSEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9N-0000CM-EG; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E7833075C0;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6278B29A490FA; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160925.168274291@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 21/26] objtool: Use sec_offset_hash() for insn_hash
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for find_insn_containing(), change insn_hash to use
sec_offset_hash().

This actually reduces runtime; probably because mixing in the section
index reduces the collisions due to text sections all starting their
instructions at offset 0.

Runtime on vmlinux.o from 3.1 to 2.5 seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -34,9 +34,10 @@ struct instruction *find_insn(struct obj
 {
 	struct instruction *insn;
 
-	hash_for_each_possible(file->insn_hash, insn, hash, offset)
+	hash_for_each_possible(file->insn_hash, insn, hash, sec_offset_hash(sec, offset)) {
 		if (insn->sec == sec && insn->offset == offset)
 			return insn;
+	}
 
 	return NULL;
 }
@@ -276,7 +277,7 @@ static int decode_instructions(struct ob
 			if (ret)
 				goto err;
 
-			hash_add(file->insn_hash, &insn->hash, insn->offset);
+			hash_add(file->insn_hash, &insn->hash, sec_offset_hash(sec, insn->offset));
 			list_add_tail(&insn->list, &file->insn_list);
 			nr_insns++;
 		}


