Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBEFC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7909C20737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T/tRavQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCLNwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46846 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ypgdn1/BQzpX4JG6EoZRPCg1tZz8S0USzOCybKh2HpM=; b=T/tRavQu0pQxLSjK4OqVju7BjP
        he5dYqS9VoxnKJEGW1de/UGhYdiwS4oM0MQKW0clGtyEicOPwH+YL7YsPcHLgqL1VxAsB1A1OvPmu
        lylP7WzLMcBMCb6xf49PSqgXXk2JlfzSTzC1BOsfDyxKDF2cCSunKNTCxhMcWN3onV81lwMDWmugl
        ahRcEfDjz5eCqo20TbjsFI3hzdQDjqFgSIxaVhos4DTbFVOxcC216b+Wi+Ny6o7AHwnFf4dKJqQvv
        I8tkuvRauw1nnCNERcBtY3YKPMo7VpwKEvAjGCXq9lmAn7uuohTcvPFHJP0ZsXA24Z2HYn8OQFAGA
        OX7XNy3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFO-0003Af-Bq; Thu, 12 Mar 2020 13:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5729F3070F9;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 493742B740B30; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135042.229372998@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 14/16] objtool: Optimize find_rela_by_dest_range()
References: <20200312134107.700205216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf shows there is significant time in find_rela_by_dest(); this is
because we have to iterate the address space per byte, looking for
relocation entries.

Optimize this by reducing the address space granularity.

This reduces objtool on vmlinux.o runtime from 4.8 to 4.4 seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   15 +++++++++++----
 tools/objtool/elf.h |   11 ++++++++++-
 2 files changed, 21 insertions(+), 5 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -204,7 +204,7 @@ struct symbol *find_symbol_by_name(struc
 struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
 				     unsigned int len)
 {
-	struct rela *rela;
+	struct rela *rela, *r = NULL;
 	unsigned long o;
 
 	if (!sec->rela)
@@ -212,12 +212,19 @@ struct rela *find_rela_by_dest_range(str
 
 	sec = sec->rela;
 
-	for (o = offset; o < offset + len; o++) {
+	for (o = offset & RELA_STRIDE_MASK; o < offset + len; o += RELA_STRIDE) {
 		hash_for_each_possible(sec->elf->rela_hash, rela, hash,
 				       __rela_hash(o, sec->idx)) {
-			if (rela->sec == sec && rela->offset == o)
-				return rela;
+			if (rela->sec != sec)
+				continue;
+
+			if (rela->offset >= offset && rela->offset < offset + len) {
+				if (!r || rela->offset < r->offset)
+					r = rela;
+			}
 		}
+		if (r)
+			return r;
 	}
 
 	return NULL;
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -86,9 +86,18 @@ struct elf {
 	DECLARE_HASHTABLE(rela_hash, 20);
 };
 
+#define RELA_STRIDE_BITS	4
+#define RELA_STRIDE		(1UL << RELA_STRIDE_BITS)
+#define RELA_STRIDE_MASK	(~(RELA_STRIDE - 1))
+
 static inline u32 __rela_hash(unsigned long offset, int idx)
 {
-	u32 ol = offset, oh = offset >> 32;
+	u32 ol, oh;
+
+	offset &= RELA_STRIDE_MASK;
+
+	ol = offset;
+	oh = offset >> 32;
 
 	__jhash_mix(ol, oh, idx);
 


