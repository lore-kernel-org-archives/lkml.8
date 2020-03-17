Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03DCC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC1F20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WOpw2DJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgCQRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nvk5f76qbl0HtJg1jL+4J+0+y4ARf4fTNz/qr5jKuDQ=; b=WOpw2DJXbq7v11b5E0CZc23ikO
        47YU334Tj0D0C/5EqRJi1vGyvwIOpGYqesQg8xpYL0IP64znFt4bAjGOEuVt9ImQGLTgYZtA0bGiz
        pEViQAtegpsr3hii8sgdbQ95mqC7mYI6U6ZWLiRysCYX5HiSPxRAUuJ3WGT3B+nZ1RSXrGTdYdYQA
        TGLG9UEE3sZh4H4wQXuIxnZPYVRs2bgzkz6vhsCp7bGqmtce66vX0uC4ciq3BY8iAsrMhvKcPZFUE
        3ZzHf4vr5p+shdSVKhwuW3rxpBwpTk0ZVq+j8EgqGCyXrAr4pPDRgklpaVmemLiQhvW5pkMi9RbPS
        hyhr6BGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFl0-0002rF-CT; Tue, 17 Mar 2020 17:11:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E9613073EC;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0EC7820B16496; Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Message-Id: <20200317170910.592855293@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 14/19] objtool: Delete cleanup()
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf shows we spend a measurable amount of time spend cleaning up
right before we exit anyway. Avoid the needsless work and just
terminate.

This reduces objtool on vmlinux.o runtime from 5.4s to 4.8s

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   19 -------------------
 1 file changed, 19 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2476,23 +2476,6 @@ static int validate_reachable_instructio
 	return 0;
 }
 
-static void cleanup(struct objtool_file *file)
-{
-	struct instruction *insn, *tmpinsn;
-	struct alternative *alt, *tmpalt;
-
-	list_for_each_entry_safe(insn, tmpinsn, &file->insn_list, list) {
-		list_for_each_entry_safe(alt, tmpalt, &insn->alts, list) {
-			list_del(&alt->list);
-			free(alt);
-		}
-		list_del(&insn->list);
-		hash_del(&insn->hash);
-		free(insn);
-	}
-	elf_close(file->elf);
-}
-
 static struct objtool_file file;
 
 int check(const char *_objname, bool orc)
@@ -2560,8 +2543,6 @@ int check(const char *_objname, bool orc
 	}
 
 out:
-	cleanup(&file);
-
 	if (ret < 0) {
 		/*
 		 *  Fatal error.  The binary is corrupt or otherwise broken in


