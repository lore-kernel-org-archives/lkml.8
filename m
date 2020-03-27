Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF82C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F42070A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZogiQvD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgC0BAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:00:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36618 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727683AbgC0BAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 21:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585270815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYYz+dLHtQkfzjd1wcCUHm8UY1gsj6e46qHq8G1ei0U=;
        b=ZogiQvD+DJzLWv7Vvlp6cmeN7xTiJPKm2u5Z9s+Fk5adDYDBa8jyuYeriWB300LeEOMrB4
        oLF7w+BVIL1m+4XRq+J0umNTnA+Lm2FHuEwih/yVRfpgXmIw92uChU06fZtmJ9SA1rJG2J
        Sz8ub1lzvb5Q20YAHUTyLLSUFiJT9rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-OB6_u16JMfeXy3PE_Varng-1; Thu, 26 Mar 2020 21:00:11 -0400
X-MC-Unique: OB6_u16JMfeXy3PE_Varng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D5A5189D6D4;
        Fri, 27 Mar 2020 01:00:10 +0000 (UTC)
Received: from treble (ovpn-112-33.rdu2.redhat.com [10.10.112.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECC2F1001B09;
        Fri, 27 Mar 2020 01:00:08 +0000 (UTC)
Date:   Thu, 26 Mar 2020 20:00:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200327010001.i3kebxb4um422ycb@treble>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326195718.GD2452@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 08:57:18PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 26, 2020 at 04:49:38PM +0100, Peter Zijlstra wrote:
> > > The 'insn == first' check isn't ideal, but at least it works (I think?).
> > 
> > It works, yes, for exactly this one case.
>
> How's this? Ignore the ignore_cfi bits, that's a 'failed' experiment.

It still seems complex to me.

What do you think about this?  If we store save_insn in the state when
we see insn->save, the restore logic becomes a lot easier.  Then if we
get a restore without a save, we can just ignore the restore hint in
that path.  Later, when we see the restore insn again from the save
path, we can then compare the insn state with the saved state to make
sure they match.

This assumes no crazy save/restore scenarios.  It also means that the
restore path has to be reachable from the save path, for which I had to
make a change to make IRETQ *not* a dead end if there's a restore hint
immediately after it.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e637a4a38d2a..e9becd50f148 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1265,7 +1265,6 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
 			insn->restore = true;
-			insn->hint = true;
 			continue;
 		}
 
@@ -2003,7 +2002,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *first, struct insn_state state)
 {
 	struct alternative *alt;
-	struct instruction *insn, *next_insn;
+	struct instruction *insn, *next_insn, *save_insn = NULL;
 	struct section *sec;
 	u8 visited;
 	int ret;
@@ -2034,54 +2033,32 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		visited = 1 << state.uaccess;
 		if (insn->visited) {
-			if (!insn->hint && !insn_state_match(insn, &state))
+			if (!insn->hint && !insn->restore &&
+			    !insn_state_match(insn, &state)) {
 				return 1;
+			}
+
+			if (insn->restore && save_insn) {
+				if (!insn_state_match(insn, &save_insn->state))
+					return 1;
+				save_insn = NULL;
+			}
 
 			if (insn->visited & visited)
 				return 0;
 		}
 
-		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
-
-				i = insn;
-				save_insn = NULL;
-				func_for_each_insn_continue_reverse(file, func, i) {
-					if (i->save) {
-						save_insn = i;
-						break;
-					}
-				}
-
-				if (!save_insn) {
-					WARN_FUNC("no corresponding CFI save for CFI restore",
-						  sec, insn->offset);
-					return 1;
-				}
-
-				if (!save_insn->visited) {
-					/*
-					 * Oops, no state to copy yet.
-					 * Hopefully we can reach this
-					 * instruction from another branch
-					 * after the save insn has been
-					 * visited.
-					 */
-					if (insn == first)
-						return 0;
-
-					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
-						  sec, insn->offset);
-					return 1;
-				}
+		if (insn->save)
+			save_insn = insn;
 
-				insn->state = save_insn->state;
-			}
+		if (insn->restore && save_insn) {
+			insn->state = save_insn->state;
+			save_insn = NULL;
+		}
 
+		if (insn->hint)
 			state = insn->state;
-
-		} else
+		else
 			insn->state = state;
 
 		insn->visited |= visited;
@@ -2191,12 +2168,17 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CONTEXT_SWITCH:
-			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_FUNC("unsupported instruction in callable function",
-					  sec, insn->offset);
-				return 1;
+			if (!next_insn || !next_insn->restore) {
+				if (func) {
+					WARN_FUNC("unsupported instruction in callable function",
+							sec, insn->offset);
+					return 1;
+				}
+
+				return 0;
 			}
-			return 0;
+
+			break;
 
 		case INSN_STACK:
 			if (update_insn_state(insn, &state))
@@ -2293,7 +2275,7 @@ static int validate_unwind_hints(struct objtool_file *file)
 	clear_insn_state(&state);
 
 	for_each_insn(file, insn) {
-		if (insn->hint && !insn->visited) {
+		if ((insn->hint || insn->save || insn->restore) && !insn->visited) {
 			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);

