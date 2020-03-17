Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ED7C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C13F20768
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rj1/+tdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCQRMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:12:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgCQRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=I+xjW8SmjuSc3NcehLz1xs8WhtELcrND9tPUxiTJy1I=; b=rj1/+tdVMy+dy1yAtLE+qHRoCx
        fnyWUpiIQNdd0joI6c50WL4gJmHrxEN8BAI61yPLChC+HqTRRmiQPAZrCiid1MiDOpUgRJx5kVTBH
        KWiBY0atYWQr759AZ7F0IACm6VHQLppRImA+xWloUDKN3rNVyXF2X0Uyekm7/ALLJnwdVahm1DFZ2
        XPo98mb8sypEARDNtuv/SFdhSYXvIfWOoF2rdf1+E9d7eH5OEgssBhAnSfIkvTaqKQ8zOxqNrTPb9
        hwyEKK3a1rIjyZDN3hBvPlgRCdoTLqoE0OVBgrXVHiazG+ZDtdVO22wEgLauzjpyUZTRzJ2bkEu3M
        fvIuuczg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEFkz-0002r9-Vu; Tue, 17 Mar 2020 17:11:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08FA53070F4;
        Tue, 17 Mar 2020 18:11:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EC92A20B16493; Tue, 17 Mar 2020 18:11:54 +0100 (CET)
Message-Id: <20200317170910.356432759@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 18:02:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v2 10/19] objtool: Rename find_containing_func()
References: <20200317170234.897520633@infradead.org>
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


