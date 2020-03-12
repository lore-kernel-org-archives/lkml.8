Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AADC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E801D20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yd9MiQY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCLWXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:23:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33998 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgCLWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iiReo9Iqud/DA9U+IeqU+NwjNu9N8bsJJVgU+1dNGHY=; b=Yd9MiQY+ZzpHxCYCBkuLnHwgyy
        vQ5vPPg6Db0SafyhJjFabDGbn/XuRdwzcRxFm6ZexHLcBltrt7jYoZn2wiR6PL8bqTtpdMnMefQJq
        hR7M6VTCp/452VzpN4RUm/E/kZQDXvoAmol+1lyK1tZY/Msz8Bi9/2cDzGXSNzdblvSNLgWmCPTYS
        12Vxz7ISpC34S8ZdrWavC2TQoTN8n6oRnjae2JODQ3wCchePwl8sEZ1uJw3Zne7/GmP+IABWS+xet
        GtGRCvJ6DPsjtPosv6lOT5zaJ2LHw38ViE0OBJVA5UuNZRYzUijC3nI+G3yhgQhcBfcPLyDBzDSGg
        XbdpCXmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCWEg-0004iD-Lq; Thu, 12 Mar 2020 22:23:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C907798114E; Thu, 12 Mar 2020 23:23:24 +0100 (CET)
Date:   Thu, 12 Mar 2020 23:23:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Message-ID: <20200312222324.GD5086@worktop.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312162337.GU12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312162337.GU12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:23:37PM +0100, Peter Zijlstra wrote:

> So one of the problem i've ran into while playing with this and Thomas'
> patches is that it is 'difficult' to deal with indirect function calls.
> 
> objtool basically gives up instantly.
> 
> I know smatch has passes were it looks for function pointer assignments
> and carries that forward into it's callchain generation. Doing something
> like that for objtool is going to be 'fun'...
> 
> For now I've got limited success dodging a few instances with
> __always_inline (which then results in the compiler resolving the
> indirection).

Here's a little something that at least detects 'immediate' function
pointers crossing the boundary.

It's slow though; it almost tripples the runtime. But I'm too tired to
make it fast, maybe tomorrow.

---

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -247,6 +247,9 @@ static int decode_instructions(struct ob
 		    strncmp(sec->name, ".discard.", 9))
 			sec->text = true;

+		if (!strcmp(sec->name, ".noinstr.text"))
+			sec->noinstr = true;
+
 		for (offset = 0; offset < sec->len; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
@@ -2040,6 +2043,28 @@ static int validate_return(struct symbol
 	return 0;
 }

+static int validate_rela(struct instruction *insn, struct insn_state *state)
+{
+	struct section *sec;
+	struct rela *rela;
+
+	if (!(state->noinstr && state->instr <= 0))
+		return 0;
+
+	rela = find_rela_by_dest_range(insn->sec, insn->offset, insn->len);
+	if (!rela || !rela->sym || !rela->sym->sec)
+		return 0;
+
+	sec = rela->sym->sec;
+	if (sec->text && !sec->noinstr) {
+		WARN_FUNC("loading non-noinstr function pointer\n",
+			  insn->sec, insn->offset);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -2222,6 +2247,10 @@ static int validate_branch(struct objtoo
 			return 0;

 		case INSN_STACK:
+			ret = validate_rela(insn, &state);
+			if (ret)
+				return ret;
+
 			if (update_insn_state(insn, &state))
 				return 1;

@@ -2285,6 +2314,10 @@ static int validate_branch(struct objtoo
 			break;

 		default:
+			ret = validate_rela(insn, &state);
+			if (ret)
+				return ret;
+
 			break;
 		}

@@ -2442,8 +2475,8 @@ static int validate_sec_functions(struct
 	 * not correctly determine insn->call_dest->sec (external symbols do
 	 * not have a section).
 	 */
-	if (vmlinux && !strcmp(sec->name, ".noinstr.text"))
-		state.noinstr = true;
+	if (vmlinux)
+		state.noinstr = sec->noinstr;

 	list_for_each_entry(func, &sec->symbol_list, list) {
 		if (func->type != STT_FUNC)
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -43,7 +43,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata;
+	bool changed, text, rodata, noinstr;
 };

 struct symbol {

