Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BEAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7495206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3Jv0LjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCLNwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OIoJnK6nmduG3w0tuQae40Uwk/VDEii3nd82MA9JZeY=; b=f3Jv0LjErrUB/TeErboBJAVzyT
        XrYpyquCiSdwwaRob6ySDbQuM7oCYuT6upJ59Sl3LqmzlZf8FHQBC3hf/u3ngSTH6cw/QN5js0VNa
        VTtUrTI7YWwi4GCKHsj+9IGAwIas3ZWJPm+o+ZKqZkjqTt2svCI23/WA2V2Kg41qkto1tbfJcJlH8
        0hM5gBMjEFE4wmjzLvHIH0vu8FL+MBi7bHci3FvZa8endGjBZhsoA6PsHSR9YhS0XXo7Hft/5sQ3Y
        nOr2n/GVI1eksA6o3QyQ8fRJTaIwDjR3hngHrWinLro7OztXNnr5nCq0vfz+0ykHmIY5iFKIW4rtj
        GajzsXew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFO-0006Wj-Mn; Thu, 12 Mar 2020 13:51:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52A5530708D;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 44F732B740AE6; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135042.170706113@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 13/16] objtool: Delete cleanup()
References: <20200312134107.700205216@infradead.org>
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
@@ -2520,23 +2520,6 @@ static int validate_reachable_instructio
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
@@ -2613,8 +2596,6 @@ int check(const char *_objname, bool orc
 	}
 
 out:
-	cleanup(&file);
-
 	/* ignore warnings for now until we get all the code cleaned up */
 	if (ret || warnings)
 		return 0;


