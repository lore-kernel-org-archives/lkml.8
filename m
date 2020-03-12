Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD35C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385B2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JL9crViK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgCLNw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46842 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NZY8LLu61qP3GV21cOZY0cQ5nNfPOQbo9ZX2uk33ydM=; b=JL9crViKZ2dd2guInTKAM0xXob
        1KiU3WOzu1yVXW1bLDYxjiD9ZIVaDc+QttJPfAlKuio/DMVA5jYWXDA/dSec92pLr+nGspItBgmZt
        stsso/sgpbUxd2JyzHQ0yC8kVlJqme26mUbHfXuH+srN7aiIVcM9KoYO1gt2GxPsVnW0zAc5QeSet
        8oqjfTH9QVK31s8xWZpA1vX9c2+6M0FsCnCjom8QFWj9lZ8Jp1euzkrZh3mghNIKKBskwmqqXy56I
        m4ZOxBLlVEB1lf4tMC9a9E0EP10E+7Axbs5X2U7OfTmk0mNHjxKy81VYgpv9zucWuUBWFGG4cDrAf
        3Jfs4ysg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFO-0003Ac-B4; Thu, 12 Mar 2020 13:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 487A330704D;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 34A3A2B92DA13; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135041.994956104@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 10/16] objtool: Resize insn_hash
References: <20200312134107.700205216@infradead.org>
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
 


