Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D8C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JO/ToWci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgCYRrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:47:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgCYRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6kFko+tI6uqSmZzN+BrRSaiCqmG948MnieaRkmvxg98=; b=JO/ToWci+SDLEigZsF7Oo1NZjn
        Gx/O8xobgd0fRT+NzLpwYi0PSlTuvIN/opgb3nv9JRqwNXfdkXXjEnMSJyLU0OgxNMhnacdQ3u0vE
        j04KMIGG8teq+RUeaH1I7zmPIeSw29MoFCnqWqiJTBQqfxE/blkLarl9CCiXmbV/oY5Y9mlLNrGnB
        IB6blN3IVg3kF5xMFQEuSBPekw4i9g4t4cmJ70UVCNxtaQPXeiSr9cR3asQpgZgozz3motr4bgOeP
        Rn56PzC5r8XlHNuOLAKArAtTaJh/Rc1FeSDtpng48KfMlle8ezOlJMtkD0yuG7mWEqkPHaDvfGeMT
        WD+3xFuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA82-0008RA-3b; Wed, 25 Mar 2020 17:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5193304D89;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BB58529BD8A2D; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174605.877866407@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 07/13] objtool: Use sec_offset_hash() for insn_hash
References: <20200325174525.772641599@infradead.org>
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


