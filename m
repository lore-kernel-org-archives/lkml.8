Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD01C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B8B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cv8nrh6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCQRMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45276 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgCQRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0f5ju+NTHnF9em3bX6jKZGjJjWejDNJLAl87ZEKr/L0=; b=cv8nrh6lNdHhzE3jgSSTOoc8i2
        V4Cuz/xQFo0TkWQ2M4ppt8QCO38ovP3VBCeECgR8WmKqR9FpFprQ/nlivI5JeMU0S0vhH4BxyiD7w
        wJGsOyvtdhoXfqU6noEM39IoBDQoSXE9+JlQqMvYqg0ykEn6/j5ssXSpJwbd43Q1uJSkYbFUI1GqQ
        zkK+kPkunGNEgf922yh74B1HpoItWEez+neF7Xix4Wzy8aIDLIZF0v61LbOKgOcWTOWLi0SB7N+jQ
        duXOVbYbEon3rh/Y3XthjoFftOR+GYKaoNhWFMrD6PvoPco4yMlQeREiwyZnvPiFph2ntXRIDGyU3
        61p5CASg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl1-0003jO-CF; Tue, 17 Mar 2020 17:11:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CDAE30743E;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2EA54264FDB00; Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Message-Id: <20200317170910.901367876@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 18/19] objtool: Use sec_offset_hash() for insn_hash
References: <20200317170234.897520633@infradead.org>
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


