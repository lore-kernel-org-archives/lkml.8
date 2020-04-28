Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B36AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F502206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g/JBn7Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgD1P0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbgD1P0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:26:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C12CC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pE5vSr7Spo2FuDpvhFoHEFRbhpgrw9RpdC4r2XFMOhk=; b=g/JBn7Axftn4tgXbxxtt8kWjk1
        7x86v1HP+bioBiCqH7j9cGMhEmexCzBELS1LdCE8yAukYqykYMY0SL7iIYYTZlKD/OesHVrCMcTGZ
        1f67tgixfIyoeEKdrmql4A9iHT9iGxot8xNTwnl77rN9NVw3sHHM4xk/vgKjnsxAYzp++jpTHd8EF
        CYgv9ES6IiUDhWb3Jm1dRGSOjANWdziGAOLGoVRXUjM3A17Skwb7SXXWAOAZ2XQtedhbcVSkdwp3c
        A5hcdAM5hx/Kpwe/jo3Uc6BsgislaEpbcdkXlVTv6kxDABn/4LcRyMKKpKCpNAHj2jitv0IlSkA5p
        O1rZtkKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTS7O-0001Ck-Np; Tue, 28 Apr 2020 15:25:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 180953079C8;
        Tue, 28 Apr 2020 17:25:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BCD9201F9F0C; Tue, 28 Apr 2020 17:25:52 +0200 (CEST)
Date:   Tue, 28 Apr 2020 17:25:52 +0200
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
Message-ID: <20200428152552.GD13592@hirez.programming.kicks-ass.net>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
 <20200302151829.brlkedossh7qs47s@treble>
 <20200302155239.7ww7jfeu4yeevpkb@treble>
 <20200428070450.w5l5ey54dtmqy5ph@treble>
 <20200428124627.GC13558@hirez.programming.kicks-ass.net>
 <20200428141614.GA13616@hirez.programming.kicks-ass.net>
 <20200428143157.nxxrgfpo3leia2kr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428143157.nxxrgfpo3leia2kr@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:31:57AM -0500, Josh Poimboeuf wrote:
> That's quite the monstrosity, and I still don't see the point.  I
> thought we decided to just disallow CFI changes in alternatives anyway?
> That can be done much simpler.

Something like so then ?

---
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8443ec690051..d14d83e6edb0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -940,6 +940,7 @@ static int handle_group_alt(struct objtool_file *file,
 
 		last_new_insn = insn;
 
+		insn->alt_group = true;
 		insn->ignore = orig_insn->ignore_alts;
 		insn->func = orig_insn->func;
 
@@ -2242,6 +2243,11 @@ static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
 	list_for_each_entry(op, &insn->stack_ops, list) {
 		int res;
 
+		if (insn->alt_group) {
+			WARN_FUNC("alternative has CFI", insn->sec, insn->offset);
+			return 1;
+		}
+
 		res = update_cfi_state(insn, &state->cfi, op);
 		if (res)
 			return res;
@@ -2439,12 +2445,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 	sec = insn->sec;
 
-	if (insn->alt_group && list_empty(&insn->alts)) {
-		WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
-			  sec, insn->offset);
-		return 1;
-	}
-
 	while (1) {
 		next_insn = next_insn_same_sec(file, insn);
 
@@ -2494,8 +2494,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				}
 			}
 
-			if (skip_orig)
+			if (skip_orig) {
+				struct instruction *prev_insn = insn;
+				sec_for_each_insn_continue(file, insn) {
+					if (!insn->alt_group)
+						break;
+					if (!insn->visited)
+						insn->cfi = prev_insn->cfi;
+				}
 				return 0;
+			}
 		}
 
 		if (handle_insn_ops(insn, &state))
