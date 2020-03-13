Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74970C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ED7206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1nmA48x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCMOef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:34:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51672 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHZPe3dzdQ+iNkBRliZVEUBgYfzQuU1kZVe3hGShyMo=; b=1nmA48x/SGbvi37QnEIsGDzOvb
        I9PeNgy1XMTXIZ93ZEHIkvfJAmQqy3hq5b8EwNZ22Eljxlbb81y5wEKmYr3w+IcY+J3qdVF2DVeOf
        XUc9YA9XgAAW79otZupc+Vn2Q2dqYxtk+UBXrfWpg/Twt3W1eP83Wu3xZthtO9gppljv/4ljruNlO
        +Hcw3kLewcna6PWNlj/lAZ5KKsvOhttMnkOYsA5X8SwuvCsdDM0rEFUQPkO8nsZnIJNbDjdB+/BtJ
        muAnt6IikYvkcvQuZbwmrX1W1gE/YD3UZr7uliKk+uaPVPitrntbBPLiZj68+2t95GX7/4GVCx5uv
        Sfj8D5Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jClOR-0006Kp-Bw; Fri, 13 Mar 2020 14:34:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CF30300470;
        Fri, 13 Mar 2020 15:34:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E8F32BE08CCC; Fri, 13 Mar 2020 15:34:29 +0100 (CET)
Date:   Fri, 13 Mar 2020 15:34:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 04/16] objtool: Annotate identity_mapped()
Message-ID: <20200313143429.GB12521@hirez.programming.kicks-ass.net>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.641079164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312135041.641079164@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:11PM +0100, Peter Zijlstra wrote:

> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -416,7 +416,7 @@ static void add_ignores(struct objtool_f
>  
>  		case STT_SECTION:
>  			func = find_symbol_by_offset(rela->sym->sec, rela->addend);
> -			if (!func || func->type != STT_FUNC)
> +			if (!func || (func->type != STT_FUNC && func->type != STT_NOTYPE))
>  				continue;
>  			break;
>  
> @@ -425,7 +425,7 @@ static void add_ignores(struct objtool_f
>  			continue;
>  		}
>  
> -		func_for_each_insn(file, func, insn)
> +		sym_for_each_insn(file, func, insn)
>  			insn->ignore = true;
>  	}
>  }


This conflicts with:

  7acfe5315312 ("objtool: Improve call destination function detection")

which wasn't in the tree we were working against :/

I've resolved it something like so.

---
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -406,7 +406,7 @@ static void add_ignores(struct objtool_f
 {
 	struct instruction *insn;
 	struct section *sec;
-	struct symbol *func;
+	struct symbol *sym;
 	struct rela *rela;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
@@ -416,12 +416,12 @@ static void add_ignores(struct objtool_f
 	list_for_each_entry(rela, &sec->rela_list, list) {
 		switch (rela->sym->type) {
 		case STT_FUNC:
-			func = rela->sym;
+			sym = rela->sym;
 			break;
 
 		case STT_SECTION:
-			func = find_func_by_offset(rela->sym->sec, rela->addend);
-			if (!func)
+			sym = find_symbol_by_offset(rela->sym->sec, rela->addend);
+			if (!sym || (sym->type != STT_FUNC || sym->type != STT_NOTYPE))
 				continue;
 			break;
 
@@ -430,7 +430,7 @@ static void add_ignores(struct objtool_f
 			continue;
 		}
 
-		sym_for_each_insn(file, func, insn)
+		sym_for_each_insn(file, sym, insn)
 			insn->ignore = true;
 	}
 }
