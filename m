Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA72C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EE820748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSrJfnam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgGBAAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:00:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726764AbgGBAAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593648050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWlg4nprW+lT5HSpnWRIE5bylNtxirhxTV64sLs4Vrs=;
        b=aSrJfnam/ApHu3jv0xp0BiUCq3fJIdDTfI5iWKrMHGY56bHIAR02WXTeqzlqC1OB5Ze3zv
        2FK9uOI9xkqVDzm0GWbkxZQgCIoUqZYcNr5bYjurgFGvmgGw3YLvDPD9t8B1kOKCZkLmvF
        Da+OJB+u81ibAkeQ2GETGs+pIeG8gCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-sB73hjoBNmCbM2OEsCtKUA-1; Wed, 01 Jul 2020 20:00:46 -0400
X-MC-Unique: sB73hjoBNmCbM2OEsCtKUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 708708014D7;
        Thu,  2 Jul 2020 00:00:45 +0000 (UTC)
Received: from treble (ovpn-117-134.rdu2.redhat.com [10.10.117.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A628460CD1;
        Thu,  2 Jul 2020 00:00:44 +0000 (UTC)
Date:   Wed, 1 Jul 2020 19:00:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200702000041.movaiqpyzdmhlu67@treble>
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net>
 <20200701205108.wtgfnijav7lgfiqe@treble>
 <CAHk-=wiY-67yt4kGd2EW-7kChQgnLHZ_2aJ+=ps7i7rCz894PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiY-67yt4kGd2EW-7kChQgnLHZ_2aJ+=ps7i7rCz894PQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 02:02:42PM -0700, Linus Torvalds wrote:
> So the objtool rule might be:
> 
>  - in a STAC region, no exception handlers at all except for that
> ex_handler_uaccess case
> 
>  - and that case will clear AC if it triggers.
> 
> and maybe such an objtool check would show some case where I'm wrong,
> and we do some MSR read other other fault thing within a STAC region.
> That _sounds_ wrong to me, but maybe we have reason to do so that I
> just can't think or right now?

Here's an attempt at implementing this, in case anybody wants to play
with it.  Usual disclaimers apply...

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5e0d70a89fb8..470447225314 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -24,7 +24,7 @@
 struct alternative {
 	struct list_head list;
 	struct instruction *insn;
-	bool skip_orig;
+	bool skip_orig, exception, uaccess;
 };
 
 const char *objname;
@@ -1023,8 +1023,13 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		alt->insn = new_insn;
+
 		alt->skip_orig = special_alt->skip_orig;
+		alt->exception = special_alt->exception;
+		alt->uaccess   = special_alt->uaccess;
+
 		orig_insn->ignore_alts |= special_alt->skip_alt;
+
 		list_add_tail(&alt->list, &orig_insn->alts);
 
 		list_del(&special_alt->list);
@@ -2335,6 +2340,35 @@ static void fill_alternative_cfi(struct objtool_file *file, struct instruction *
 	}
 }
 
+static int handle_stac(struct symbol *func, struct instruction *insn,
+		       struct insn_state *state)
+{
+	if (state->uaccess) {
+		WARN_FUNC("recursive UACCESS enable", insn->sec, insn->offset);
+		return -1;
+	}
+
+	state->uaccess = true;
+	return 0;
+}
+
+static int handle_clac(struct symbol *func, struct instruction *insn,
+		       struct insn_state *state)
+{
+	if (!state->uaccess && func) {
+		WARN_FUNC("redundant UACCESS disable", insn->sec, insn->offset);
+		return -1;
+	}
+
+	if (func_uaccess_safe(func) && !state->uaccess_stack) {
+		WARN_FUNC("UACCESS-safe disables UACCESS", insn->sec, insn->offset);
+		return -1;
+	}
+
+	state->uaccess = false;
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2393,6 +2427,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				if (alt->skip_orig)
 					skip_orig = true;
 
+				if (alt->exception) {
+					if (!alt->uaccess && state.uaccess) {
+						WARN_FUNC("non-user-access exception with uaccess enabled",
+							  sec, insn->offset);
+						return 1;
+					}
+
+					if (alt->uaccess && handle_clac(func, insn, &state))
+						return 1;
+				}
+
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
 					if (backtrace)
@@ -2478,26 +2523,13 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
-			if (state.uaccess) {
-				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
+			if (handle_stac(func, insn, &state))
 				return 1;
-			}
-
-			state.uaccess = true;
 			break;
 
 		case INSN_CLAC:
-			if (!state.uaccess && func) {
-				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
+			if (handle_clac(func, insn, &state))
 				return 1;
-			}
-
-			if (func_uaccess_safe(func) && !state.uaccess_stack) {
-				WARN_FUNC("UACCESS-safe disables UACCESS", sec, insn->offset);
-				return 1;
-			}
-
-			state.uaccess = false;
 			break;
 
 		case INSN_STD:
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e74e0189de22..41f27199cae6 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -18,6 +18,7 @@
 #define EX_ENTRY_SIZE		12
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
+#define EX_HANDLER_OFFSET	8
 
 #define JUMP_ENTRY_SIZE		16
 #define JUMP_ORIG_OFFSET	0
@@ -35,8 +36,9 @@
 
 struct special_entry {
 	const char *sec;
-	bool group, jump_or_nop;
+	bool group, jump_or_nop, exception;
 	unsigned char size, orig, new;
+	unsigned char handler; /* __ex_table only */
 	unsigned char orig_len, new_len; /* group only */
 	unsigned char feature; /* ALTERNATIVE macro CPU feature */
 };
@@ -61,9 +63,11 @@ struct special_entry entries[] = {
 	},
 	{
 		.sec = "__ex_table",
+		.exception = true,
 		.size = EX_ENTRY_SIZE,
 		.orig = EX_ORIG_OFFSET,
 		.new = EX_NEW_OFFSET,
+		.handler = EX_HANDLER_OFFSET,
 	},
 	{},
 };
@@ -118,6 +122,20 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		}
 	}
 
+	if (entry->exception) {
+		struct rela *handler_rela;
+
+		alt->exception = true;
+
+		handler_rela = find_rela_by_dest(elf, sec, offset + entry->handler);
+		if (!handler_rela) {
+			WARN_FUNC("can't find handler rela", sec, offset + entry->handler);
+			return -1;
+		}
+		if (!strcmp(handler_rela->sym->name, "ex_handler_uaccess"))
+			alt->uaccess = true;
+	}
+
 	orig_rela = find_rela_by_dest(elf, sec, offset + entry->orig);
 	if (!orig_rela) {
 		WARN_FUNC("can't find orig rela", sec, offset + entry->orig);
diff --git a/tools/objtool/special.h b/tools/objtool/special.h
index 35061530e46e..3a62daef14b3 100644
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -16,6 +16,7 @@ struct special_alt {
 	bool skip_orig;
 	bool skip_alt;
 	bool jump_or_nop;
+	bool exception, uaccess;
 
 	struct section *orig_sec;
 	unsigned long orig_off;

