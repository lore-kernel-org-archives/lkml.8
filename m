Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D289C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D0E20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TWFYJhy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFLQGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:06:05 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CACEC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N1uaLpyQMdwVjun7pUEBDc50plR3DjmpgwYvI+V9ogo=; b=TWFYJhy9OxMpaFG1lwTqeVGxib
        75Y2VwSLQUxKx92r9Vh0nNiA/53AXfMu//G9WrL7mjR13Pc5GK3U4LkD9U2HJEWQ6SvlbYX44WJHl
        dmdIg/4IqctMS6qbRJ1Fv1UD0gVskFs30vZUBiSmR8FP6C+V7dRrkpuVgqY+VbReBHNsM4rAp/QwQ
        AqkHMqpDxYB/9fV4BSFv+W7o0E9WQGfQIQ1Hbd1WQHVqtRvw5YQTFZkbhcj3s9Pw2aJasM3rzi8Hn
        MjQR5x6pNBCMz4q49yPdAvPR2EMuWuU16XkKnykpSA5W2d2yVwKfB1NAfB4Fq0Y2e8Lp2p+cAlKV/
        BVk+6cSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjmBV-00075H-QS; Fri, 12 Jun 2020 16:05:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79106301AC6;
        Fri, 12 Jun 2020 18:05:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 322E32146F532; Fri, 12 Jun 2020 18:05:34 +0200 (CEST)
Date:   Fri, 12 Jun 2020 18:05:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 18/32] objtool: mcount: Move nop_mcount()
Message-ID: <20200612160534.GD2554@hirez.programming.kicks-ass.net>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <7109ceb239a88c2901eeb7f52c29f69cdb413cd3.1591125127.git.mhelsley@vmware.com>
 <20200612132656.GQ2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612132656.GQ2531@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:26:57PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 02, 2020 at 12:50:11PM -0700, Matt Helsley wrote:
> > +static int nop_mcount(struct section * const rels,
> > +		      const char *const txtname)
> > +{
> > +	struct reloc *reloc;
> > +	struct section *txts = find_section_by_index(lf, rels->sh.sh_info);
> > +	unsigned mcountsym = 0;
> > +	int once = 0;
> > +
> > +	list_for_each_entry(reloc, &rels->reloc_list, list) {
> > +		int ret = -1;
> > +
> > +		if (!mcountsym)
> > +			mcountsym = get_mcountsym(reloc);
> > +
> > +		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
> 
> This makes no sense to me; why not have mcountsym be a 'struct symbol
> *' and have get_mcountsym() return one of those.
> 
> 	if (reloc->sym == mcountsym && ... )
> 
> is much nicer, no?

On top of that, I suppose we can do something like the below.

Then you can simply write:

	if (reloc->sym->class == SYM_MCOUNT && ..)

---

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 45452facff3b..94e4b8fcf9c1 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Any varying coverage in these files is non-deterministic
 # and is generally not a function of system call inputs.
-KCOV_INSTRUMENT		:= n
+# KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 432417a83902..133c0c285be6 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -341,6 +341,24 @@ static int read_sections(struct elf *elf)
 	return 0;
 }
 
+static bool is_mcount_symbol(const char *name)
+{
+	if (name[0] == '.')
+		name++;
+
+	if (name[0] == '_')
+		name++;
+
+	return !strcmp(name, "mcount", 6) ||
+	       !strcmp(name, "_fentry__") ||
+	       !strcmp(name, "_gnu_mcount_nc");
+}
+
+static bool is_kcov_symbol(const char *name)
+{
+	return !strncmp(name, "__sanitizer_cov_", 16);
+}
+
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *symtab_shndx, *sec;
@@ -410,6 +428,12 @@ static int read_symbols(struct elf *elf)
 		} else
 			sym->sec = find_section_by_index(elf, 0);
 
+
+		if (is_mcount_symbol(sym->name))
+			sym->class = SYM_MCOUNT;
+		else if (is_kcov_symbol(sym->name))
+			sym->class = SYM_KCOV;
+
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
 
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 78a2db23b8b6..3c1cccb7b5ff 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -42,6 +42,12 @@ struct section {
 	bool changed, text, rodata, noinstr;
 };
 
+enum symbol_class {
+	SYM_REGULAR = 0,
+	SYM_MCOUNT,
+	SYM_KCOV,
+};
+
 struct symbol {
 	struct list_head list;
 	struct rb_node node;
@@ -55,6 +61,7 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
+	enum symbol_class class;
 	bool uaccess_safe;
 };
 
