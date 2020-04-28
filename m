Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C90CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E98206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PN7Ie7bm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgD1OQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727831AbgD1OQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:16:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6D8C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pAQRX/aoroLpdOnLU1y2sJc3cDTYVusPKhqBDXuV3FM=; b=PN7Ie7bmTbHbffJMEchRT/7iMy
        zy9rjejjfbUi8CKInSLhS0OgzHr/P0jAQzeGrkaM0UxhjyLUKlr/rxDqVScQK73Qf8ZZFQXTFCbsy
        4WRGST6cUHJETfU/+vPoqna2QsMK0owAikdHTRv2NnlctC+SMKkVMfT6KDRkJD7rQGSiztTbZSS0v
        S0op3jHylU7I9GR5b+6LerSuDnsiqJkRoxbYhLEuG62rOY32EJBpwhjefEdjuOkj6xbgjkRN8rllH
        8f/hYKHRg3q+2BQHwvtThOebiN/o0TI5pwBYTO7E3AN7thbor50+gDir22KUeriiB4bTApbkdRkNX
        vz3a1sAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTR21-0001X0-1u; Tue, 28 Apr 2020 14:16:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F4176301224;
        Tue, 28 Apr 2020 16:16:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF50D29A85796; Tue, 28 Apr 2020 16:16:14 +0200 (CEST)
Date:   Tue, 28 Apr 2020 16:16:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        alexandre.chartre@oracle.com
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428141614.GA13616@hirez.programming.kicks-ass.net>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428124627.GC13558@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:46:27PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 02:04:50AM -0500, Josh Poimboeuf wrote:

> > I'm thinking something like this should fix it.  Peter, does this look
> > ok?
> 
> Unfortunate. But also, I fear, insufficient. Specifically consider
> things like:
> 
> 	ALTERNATIVE "jmp 1f",
> 		"alt...
> 		"..."
> 		"...insn", X86_FEAT_foo
> 	1:
> 
> This results in something like:
> 
> 
> 	.text	.altinstr_replacement
> 	e8 xx	...
> 	90
> 	90
> 	...
> 	90
> 
> Where all our normal single byte nops (0x90) are unreachable with
> undefined CFI, but the alternative might have CFI, which is never
> propagated.
> 
> We ran into this with the validate_alternative stuff from Alexandre.

> So rather than hacking around this issue, should we not make
> create_orc() smarter?
> 
> I'm trying to come up with something, but so far I'm just making a mess.

Like this, it's horrid, but it seems to work.

What do you think of the approach? I'll work on cleaning it up if you
don't hate it too much ;-)


---

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 9d2bf2daaaa6..2a853ae994ea 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -10,17 +10,129 @@
 #include "check.h"
 #include "warn.h"
 
-int create_orc(struct objtool_file *file)
+static bool same_cfi(struct cfi_state *a, struct cfi_state *b)
 {
+	return memcmp(a, b, sizeof(*a));
+}
+
+static struct instruction *next_insn_same_sec(struct objtool_file *file,
+					      struct instruction *insn)
+{
+	struct instruction *next = list_next_entry(insn, list);
+
+	if (!next || &next->list == &file->insn_list || next->sec != insn->sec)
+		return NULL;
+
+	return next;
+}
+
+struct alternative {
+	struct list_head list;
 	struct instruction *insn;
+	bool skip_orig;
+};
+
+static int alt_cfi(struct objtool_file *file,
+		   struct instruction *prev_insn,
+		   struct instruction *orig_insn,
+		   struct instruction *alt_insn)
+{
+	unsigned long orig_offset = orig_insn->offset;
+	unsigned long alt_offset = alt_insn->offset;
+	struct instruction *next_insn;
+	bool orig_orc, alt_orc;
+
+	orig_orc = !prev_insn || same_cfi(&orig_insn->cfi, &prev_insn->cfi);
+	alt_orc  = !prev_insn || same_cfi(&alt_insn->cfi,  &prev_insn->cfi);
+
+again:
+	if ((orig_orc || alt_orc)) {
+		if (orig_insn->offset - orig_offset != alt_insn->offset - alt_offset) {
+			WARN_FUNC("alternative has unaligned ORC", orig_insn->sec, orig_insn->offset);
+			return -1;
+		}
+
+		if (orig_insn->visited) {
+			if (same_cfi(&orig_insn->cfi, &alt_insn->cfi)) {
+				WARN_FUNC("alternative violates ORC invariance", orig_insn->sec, orig_insn->offset);
+				return -1;
+			}
+		} else {
+			/*
+			 * We're in unreachable NOPs, allow the alternative to
+			 * override the CFI/ORC data.
+			 */
+			orig_insn->cfi = alt_insn->cfi;
+		}
+	}
+
+	next_insn = next_insn_same_sec(file, alt_insn);
+	if (!next_insn)
+		return 0;
+
+	if (next_insn->offset == -1 /*FAKE_JUMP_OFFSET*/)
+		return 0;
+
+	alt_orc = same_cfi(&alt_insn->cfi, &next_insn->cfi);
+	alt_insn = next_insn;
+
+	do {
+		next_insn = next_insn_same_sec(file, orig_insn);
+		if (!next_insn)
+			return 0;
+		if (!next_insn->alt_group)
+			return 0;
+
+		orig_orc = next_insn->visited && same_cfi(&orig_insn->cfi, &next_insn->cfi);
+		orig_insn = next_insn;
+	} while (orig_insn->offset - orig_offset < alt_insn->offset - alt_offset);
+
+	goto again;
+}
+
+static void orig_fill(struct objtool_file *file,
+		      struct instruction *prev_insn,
+		      struct instruction *insn)
+{
+	for (;;) {
+		if (!insn->visited)
+			insn->cfi = prev_insn->cfi;
+
+		prev_insn = insn;
+		insn = next_insn_same_sec(file, insn);
+		if (!insn)
+			return;
+		if (!insn->alt_group)
+			return;
+	}
+}
+
+int create_orc(struct objtool_file *file)
+{
+	struct instruction *insn, *prev_insn = NULL;
 
 	for_each_insn(file, insn) {
 		struct orc_entry *orc = &insn->orc;
 		struct cfi_reg *cfa = &insn->cfi.cfa;
 		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
+		int ret;
 
 		orc->end = insn->cfi.end;
 
+		if (insn->alt_group && !insn->ignore_alts) {
+			struct alternative *alt;
+
+			list_for_each_entry(alt, &insn->alts, list) {
+				if (alt->insn->offset == -1 /*FAKE_JUMP_OFFSET*/)
+					continue;
+				ret = alt_cfi(file, prev_insn, insn, alt->insn);
+				if (ret)
+					return ret;
+			}
+
+			orig_fill(file, prev_insn, insn);
+		}
+
 		if (cfa->base == CFI_UNDEFINED) {
 			orc->sp_reg = ORC_REG_UNDEFINED;
 			continue;
@@ -76,6 +188,8 @@ int create_orc(struct objtool_file *file)
 		orc->sp_offset = cfa->offset;
 		orc->bp_offset = bp->offset;
 		orc->type = insn->cfi.type;
+
+		prev_insn = insn;
 	}
 
 	return 0;
