Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E5C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C424206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3apTvFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1HFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:05:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39905 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgD1HFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588057499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I3ZR6Rjo+QDH0ub7B+nknteTuwhrVmqa1zGuEUMXNho=;
        b=O3apTvFe9PeO6+utkKNmDngcudzHAuOZr14Uo/SQI6FBboIwNBvu5DuzmpeUFY2FYNDClF
        G+JxO3GyTPXu0wi7kgMQHo059w+fCTM4hENKwdmMMSqRJsAGi1cqrn9HmIL32H0taLv3y6
        a/172unmOzMHVlRBZDyiT9sgiwowaQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Z1dHabTvPeWaHSKvg3oHlw-1; Tue, 28 Apr 2020 03:04:55 -0400
X-MC-Unique: Z1dHabTvPeWaHSKvg3oHlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0834800D24;
        Tue, 28 Apr 2020 07:04:53 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 386215D716;
        Tue, 28 Apr 2020 07:04:52 +0000 (UTC)
Date:   Tue, 28 Apr 2020 02:04:50 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200428070450.w5l5ey54dtmqy5ph@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200302155239.7ww7jfeu4yeevpkb@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 09:52:40AM -0600, Josh Poimboeuf wrote:
> On Mon, Mar 02, 2020 at 09:18:29AM -0600, Josh Poimboeuf wrote:
> > > So I think on machines without X86_FEATURE_SMAP, trying to unwind from
> > > the two NOPs at f41 and f42 will cause the unwinder to report an
> > > error? Looking at unwind_next_frame(), "sp:(und)" without the "end:1"
> > > marker seems to be reserved for errors.
> 
> I think we can blame this one on Peter ;-)
> 
>   764eef4b109a ("objtool: Rewrite alt->skip_orig")
> 
> With X86_FEATURE_SMAP, alt->skip_orig gets set, which tells objtool to
> skip validation of the NOPs.  That has the side effect of not
> propagating the ORC state to the NOPs as well.

I almost forgot about this one, until I rediscovered it just now...
Peter, I just realized you weren't CCed on the original email, oops.

I'm thinking something like this should fix it.  Peter, does this look
ok?

(I should probably split it into two patches: STAC/CLAC fix and then
revert 764eef4b109a.)

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool: Fix ORC gap in STAC/CLAC alternatives

Since commit 764eef4b109a ("objtool: Rewrite alt->skip_orig"), the new
skip_orig actually skips objtool validation of the original instruction,
resulting in an empty gap in the ORC data.

Revert the skip_orig logic to how it was before, which is to convert the
original instruction to a NOP.

For the SMAP case, convert the original instruction to a matching
STAC/CLAC, so that it doesn't matter which path is taken.

Fixes: 764eef4b109a ("objtool: Rewrite alt->skip_orig")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c   | 60 ++++++++++++++++++++++++-----------------
 tools/objtool/special.c | 16 -----------
 tools/objtool/special.h |  1 -
 3 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0c732d586924..541fcf16283c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -23,7 +23,6 @@
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
-	bool skip_orig;
 };
 
 const char *objname;
@@ -773,12 +772,26 @@ static int handle_group_alt(struct objtool_file *file,
 	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
 	unsigned long dest_off;
 
+	/*
+	 * For uaccess checking, propagate the STAC/CLAC from the alternative
+	 * to the original insn to avoid paths where we see the STAC but then
+	 * take the NOP instead of CLAC (and vice versa).
+	 */
+	if (!orig_insn->ignore_alts && orig_insn->type == INSN_NOP &&
+	    *new_insn &&
+	    ((*new_insn)->type == INSN_STAC ||
+	     (*new_insn)->type == INSN_CLAC))
+		orig_insn->type = (*new_insn)->type;
+
 	last_orig_insn = NULL;
 	insn = orig_insn;
 	sec_for_each_insn_from(file, insn) {
 		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
 			break;
 
+		if (special_alt->skip_orig)
+			insn->type = INSN_NOP;
+
 		insn->alt_group = true;
 		last_orig_insn = insn;
 	}
@@ -970,8 +983,6 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		alt->insn = new_insn;
-		alt->skip_orig = special_alt->skip_orig;
-		orig_insn->ignore_alts |= special_alt->skip_alt;
 		list_add_tail(&alt->list, &orig_insn->alts);
 
 		list_del(&special_alt->list);
@@ -2221,12 +2232,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		insn->visited |= visited;
 
 		if (!insn->ignore_alts) {
-			bool skip_orig = false;
-
 			list_for_each_entry(alt, &insn->alts, list) {
-				if (alt->skip_orig)
-					skip_orig = true;
-
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
 					if (backtrace)
@@ -2234,9 +2240,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 					return ret;
 				}
 			}
-
-			if (skip_orig)
-				return 0;
 		}
 
 		switch (insn->type) {
@@ -2325,26 +2328,33 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_STAC:
-			if (state.uaccess) {
-				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
-				return 1;
-			}
+			if (uaccess) {
+				if (state.uaccess) {
+					WARN_FUNC("recursive UACCESS enable",
+						  sec, insn->offset);
+					return 1;
+				}
 
-			state.uaccess = true;
+				state.uaccess = true;
+			}
 			break;
 
 		case INSN_CLAC:
-			if (!state.uaccess && func) {
-				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
-				return 1;
-			}
+			if (uaccess) {
+				if (!state.uaccess && func) {
+					WARN_FUNC("redundant UACCESS disable",
+						  sec, insn->offset);
+					return 1;
+				}
 
-			if (func_uaccess_safe(func) && !state.uaccess_stack) {
-				WARN_FUNC("UACCESS-safe disables UACCESS", sec, insn->offset);
-				return 1;
-			}
+				if (func_uaccess_safe(func) && !state.uaccess_stack) {
+					WARN_FUNC("UACCESS-safe disables UACCESS",
+						  sec, insn->offset);
+					return 1;
+				}
 
-			state.uaccess = false;
+				state.uaccess = false;
+			}
 			break;
 
 		case INSN_STD:
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e74e0189de22..ec7adbd32d57 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -100,22 +100,6 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		 */
 		if (feature == X86_FEATURE_POPCNT)
 			alt->skip_orig = true;
-
-		/*
-		 * If UACCESS validation is enabled; force that alternative;
-		 * otherwise force it the other way.
-		 *
-		 * What we want to avoid is having both the original and the
-		 * alternative code flow at the same time, in that case we can
-		 * find paths that see the STAC but take the NOP instead of
-		 * CLAC and the other way around.
-		 */
-		if (feature == X86_FEATURE_SMAP) {
-			if (uaccess)
-				alt->skip_orig = true;
-			else
-				alt->skip_alt = true;
-		}
 	}
 
 	orig_rela = find_rela_by_dest(elf, sec, offset + entry->orig);
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 35061530e46e..ac729a20042c 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -14,7 +14,6 @@ struct special_alt {
 
 	bool group;
 	bool skip_orig;
-	bool skip_alt;
 	bool jump_or_nop;
 
 	struct section *orig_sec;
-- 
2.21.1

