Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A82F21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rb4TAmHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506721AbgDPLxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506706AbgDPLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:52:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8AAC061BD3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6kFko+tI6uqSmZzN+BrRSaiCqmG948MnieaRkmvxg98=; b=Rb4TAmHrDKqMvHaitNhu2hdALa
        pRXdRnAcapd91R2AmtMo/2zWs0TS9N5McXXwNHjQ/mt2JRKzhFMnUaqniZ4m3J3/vwiHjwEWttz8+
        QXZdykI6WxybnpTiRddiKDwiRAq4JuYz/WYptibY3wAY220xmNIlfCc4LHDvQj0wan7gsgyUetqk0
        OI4u1tYGXHsw5+8IOMpvLFPXg/YXwbueAOzodv9ihLyK++JV8Q6/z6Mq8Nwt88jfdVwwYvXX/XvM7
        W/Pl7I7GI9FWGcVIaa6vLatR27KCylm1qTG1+2HCMIYryF09CN1nY7JZPfZ/k9DpbMZBfG2Un+G2X
        k5bJFlxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP34F-0004sG-Qd; Thu, 16 Apr 2020 11:52:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65B73307875;
        Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4F9902B0DE4C2; Thu, 16 Apr 2020 13:52:24 +0200 (CEST)
Message-Id: <20200416115119.227240432@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 16 Apr 2020 13:47:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, jthierry@redhat.com,
        alexandre.chartre@oracle.com
Subject: [PATCH v5 12/17] objtool: Use sec_offset_hash() for insn_hash
References: <20200416114706.625340212@infradead.org>
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


