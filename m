Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18612137B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+8QJCQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgCXQLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36908 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgCXQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MFEnZD0+4OUY81BkhDMbicOfY7KqrMse//Q9aHGwF/E=; b=S+8QJCQRCZeKwu2o9+iBLxSezr
        LR92FwnmoJGpvcACkudtPCfE40CIlHGxwtgunp8Gd43eQcc+/yqXKhjfxR7RLpw1qZZuDJOLdRY3I
        NNIdnkKkfpJNUumUjtALm+bVKG7IH8tFqH645/lxL4kg/p7ZNXZwLWqfOMviPv+hxm5dT/5WJ376b
        qRQ9v1y/IgugNd13FiY0w7rIAFf7/U1U6hlOdXamf59TTk8BAtWwQcVpeyAX4tuS4UC8SiNl4XETI
        XmNqTRQX14sFFUb6vaQm2Y//h8EceeE9aGRfNKkflKrUmxbvfqz7JJNhU5fLiRSkbF7B1ypkotl6u
        Wc2vLDlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9L-0006bY-Lr; Tue, 24 Mar 2020 16:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E1E5307276;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3E95220250FC4; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.617882545@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 12/26] objtool: Resize insn_hash
References: <20200324153113.098167666@infradead.org>
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
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
 


