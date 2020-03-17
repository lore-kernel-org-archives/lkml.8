Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64B2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7877D20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LtLu0WUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCQRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgCQRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NZY8LLu61qP3GV21cOZY0cQ5nNfPOQbo9ZX2uk33ydM=; b=LtLu0WUyNuQV7VB4RpVFJGHVTW
        fkJ8Je5j2ymaYfvtIXnqvQAyz88iZz8paJ5TG0Ni6PvYHlbI2YvXiMtDFCHFgt3BtPYGCPC+qFP5R
        RY0dtYG6RxB3+H3pfXcmVTEZ/vaRecnvd7tNNPR+c+svWAoVyyIZnm27jR793hFU2xi8+nq5VIG1Z
        qRJZVrq1l7yB28sl8ZiykkY+5LBAQSaSsvT4JymZAm34POWYYRGc+wE6YZCwdPued6XkNB0KYGgrX
        pjLvHDmB2+wg1nmEnC3Mxvf1DxmjLsGo+JECp5hNrEYRe6EecKrg8CFIJY3y23/cSoIKOnCyRk6N7
        Z53UKvpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl0-0002rE-Cd; Tue, 17 Mar 2020 17:11:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D23A307198;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F2429264FDB17; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170910.416506048@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 11/19] objtool: Resize insn_hash
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf shows we're spending a lot of time in find_insn() and the
statistics show we have around 3.2 million instruction. Increase the
hash table size to reduce the bucket load from around 50 to 3.

This shaves about 2s off of objtool on vmlinux.o runtime, down to 16s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -50,7 +50,7 @@ struct instruction {
 struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
-	DECLARE_HASHTABLE(insn_hash, 16);
+	DECLARE_HASHTABLE(insn_hash, 20);
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 


