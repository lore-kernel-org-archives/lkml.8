Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29FFC1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF5C20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mXEiTtNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCQRMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45162 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgCQRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=owoXv1sqxn4bHiBB5m+dTIvuJqzVsyaJByfiLpmHKcg=; b=mXEiTtNIxKXqBubwrO4cmANgvv
        +a/UNQYyqhp+82SwdK1NGtjshvcjn+ml0iVeKAO1+X5xrU4Ba9E8/MQueIo3Xt/Nqi7GHVTKbIksw
        qEo4RcExswAuquZxL1L4BX3twJgBzUtoG3uve8cUcDYtcdXbFT6zvH/VYH7YoGbhyzAVYy0rSLywB
        MlhjbIxoNL2XQSCZkTy4slahb3QAmAKCRRRYJY08Za6gxvTHtt33k3LsDfCNAcT8TRTVervIfUAIH
        iY6a5PrKs1gTDEO2NRIidZb1+fL7YQSNjG0pZ9Q9OdFi8mz1QyrOjLx+bztZSv18EuBLsyMzvK99i
        YsdvlwPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl0-0003j0-1P; Tue, 17 Mar 2020 17:11:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 257693073F0;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 17187264FDB00; Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Message-Id: <20200317170910.652251150@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 15/19] objtool: Optimize find_rela_by_dest_range()
References: <20200317170234.897520633@infradead.org>
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
 tools/objtool/elf.h |   16 +++++++++++++++-
 2 files changed, 26 insertions(+), 5 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -215,7 +215,7 @@ struct symbol *find_symbol_by_name(struc
 struct rela *find_rela_by_dest_range(struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len)
 {
-	struct rela *rela;
+	struct rela *rela, *r = NULL;
 	unsigned long o;
 
 	if (!sec->rela)
@@ -223,12 +223,19 @@ struct rela *find_rela_by_dest_range(str
 
 	sec = sec->rela;
 
-	for (o = offset; o < offset + len; o++) {
+	for_offset_range(o, offset, offset + len) {
 		hash_for_each_possible(elf->rela_hash, rela, hash,
 				       sec_offset_hash(sec, o)) {
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
@@ -83,9 +83,23 @@ struct elf {
 	DECLARE_HASHTABLE(rela_hash, 20);
 };
 
+#define OFFSET_STRIDE_BITS	4
+#define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
+#define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
+
+#define for_offset_range(_offset, _start, _end)		\
+	for (_offset = ((_start) & OFFSET_STRIDE_MASK);	\
+	     _offset <= ((_end) & OFFSET_STRIDE_MASK);	\
+	     _offset += OFFSET_STRIDE)
+
 static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
 {
-	u32 ol = offset, oh = offset >> 32, idx = sec->idx;
+	u32 ol, oh, idx = sec->idx;
+
+	offset &= OFFSET_STRIDE_MASK;
+
+	ol = offset;
+	oh = offset >> 32;
 
 	__jhash_mix(ol, oh, idx);
 


