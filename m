Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE49C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2592D214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hMy99Y+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgCXQLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgCXQLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dCXjFUGfk843n9oykCpvB/oOEVCL3ZyDFoIlQzoYOq0=; b=hMy99Y+nSNkGsnk11fO3dPQrNr
        VB/mUVpwrLmnxn7HMeQue8Kd3roILT0aI67E+C2iawm9XuX0k6Kz8oaQ9kSewOTZy9Op6Jm+A73Zg
        qMnxxmZokWE5Qe5tXhUO/Khp+ykIVvEYvHFgx6hCPKL7fIyw7w3a6sWgKKaHMDPHUy8i91GD7UTDU
        dCoONEK1VHILQPo3l6i2UdqCOpB2g2G5q8aIkEqON/bERzn+AzdU8s0tXxPYQ8R1Jt11KDAqdphSe
        ECzHS+hFy67Di0EGLfpAfDLMJgYNqI2RoSzoNM4NdR6uOyjVS+V9qzYwLWqeP8oAghv4SMUCCJd46
        wE3h665g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9L-0006bW-LY; Tue, 24 Mar 2020 16:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B732307112;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3BA7629A490FB; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.558470724@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 11/26] objtool: Rename find_containing_func()
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency; we have:

  find_symbol_by_offset() / find_symbol_containing()
  find_func_by_offset()   / find_containing_func()

fix that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c  |    2 +-
 tools/objtool/elf.h  |    2 +-
 tools/objtool/warn.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -187,7 +187,7 @@ struct symbol *find_symbol_containing(st
 	return NULL;
 }
 
-struct symbol *find_containing_func(struct section *sec, unsigned long offset)
+struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -91,7 +91,7 @@ struct symbol *find_symbol_containing(st
 struct rela *find_rela_by_dest(struct section *sec, unsigned long offset);
 struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
 				     unsigned int len);
-struct symbol *find_containing_func(struct section *sec, unsigned long offset);
+struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 struct section *elf_create_section(struct elf *elf, const char *name, size_t
 				   entsize, int nr);
 struct section *elf_create_rela_section(struct elf *elf, struct section *base);
--- a/tools/objtool/warn.h
+++ b/tools/objtool/warn.h
@@ -21,7 +21,7 @@ static inline char *offstr(struct sectio
 	char *name, *str;
 	unsigned long name_off;
 
-	func = find_containing_func(sec, offset);
+	func = find_func_containing(sec, offset);
 	if (func) {
 		name = func->name;
 		name_off = offset - func->offset;


