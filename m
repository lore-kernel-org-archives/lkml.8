Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1133C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C8E208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QqP3th3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgCXQMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36956 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbgCXQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Uz3mmWYdEEIoE9G9bfDwpjl7wm9pMhGYd7oZPOSjZls=; b=QqP3th3uxcHN2/zID2XxXr8t4G
        FaOfyL11o9IS2EKiMOy6H1aqpqDrKkV6ELLjzYIuhnx84OaWRbOUF5CeqT2tE2t2++L4UG6rd229H
        Tx1Rt6ihBmPEIqbia8tA/lTyCEEPL7Ra1p+0qG/sJQ3porTbDEHWY3gjA7f8gQx7lMumjBm1W1QSj
        Xd2uqu5pSpJCI6syIX4jNLkNvUhb9CNBGA5qLYkjpPlHB3KRFwhUT9BVaMVhTXwwcsvYrUY4hcTNH
        bFw3v1mAWwtzU35bTkWknJ4kKYnARmWUxknyBUE3at+FLZuHrDWRf4qSneOyTVDb4H6jtoIBcBzLL
        +eIF8dFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9M-0006bd-JI; Tue, 24 Mar 2020 16:11:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E2E53073A4;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4B6CF29A490F4; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.800720170@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 15/26] objtool: Delete cleanup()
References: <20200324153113.098167666@infradead.org>
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
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
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


