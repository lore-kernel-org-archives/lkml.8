Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D891FC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA14B2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCYS0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:26:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:49376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgCYS0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:26:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24058ABD1;
        Wed, 25 Mar 2020 18:26:07 +0000 (UTC)
Date:   Wed, 25 Mar 2020 19:26:06 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v4 02/13] objtool: Factor out CFI hints
In-Reply-To: <20200325174605.455086309@infradead.org>
Message-ID: <alpine.LSU.2.21.2003251924440.3128@pobox.suse.cz>
References: <20200325174525.772641599@infradead.org> <20200325174605.455086309@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Peter Zijlstra wrote:

> Move the application of CFI hints into it's own function.
> No functional changes intended.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/check.c |   67 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2033,6 +2033,41 @@ static int validate_return(struct symbol
>  	return 0;
>  }
>  
> +static int apply_insn_hint(struct objtool_file *file, struct section *sec,
> +			   struct symbol *func, struct instruction *insn,
> +			   struct insn_state *state)
> +{
> +	if (insn->restore) {
> +		struct instruction *save_insn, *i;
> +
> +		i = insn;
> +		save_insn = NULL;
> +		sym_for_each_insn_continue_reverse(file, func, i) {
> +			if (i->save) {
> +				save_insn = i;
> +				break;
> +			}
> +		}
> +
> +		if (!save_insn) {
> +			WARN_FUNC("no corresponding CFI save for CFI restore",
> +				  sec, insn->offset);
> +			return 1;
> +		}
> +
> +		if (!save_insn->visited) {
> +			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
> +				  sec, insn->offset);
> +			return 1;
> +		}
> +
> +		insn->state = save_insn->state;
> +	}
> +
> +	state = insn->state;

It does not matter, because it will change later again, but there should 
be

*state = insn->state;

here, right?

> +	return 0;
> +}
> +
>  /*
>   * Follow the branch starting at the given instruction, and recursively follow
>   * any other branches (jumps).  Meanwhile, track the frame pointer state at
> @@ -2081,35 +2116,9 @@ static int validate_branch(struct objtoo
>  		}
>  
>  		if (insn->hint) {
> -			if (insn->restore) {
> -				struct instruction *save_insn, *i;
> -
> -				i = insn;
> -				save_insn = NULL;
> -				sym_for_each_insn_continue_reverse(file, func, i) {
> -					if (i->save) {
> -						save_insn = i;
> -						break;
> -					}
> -				}
> -
> -				if (!save_insn) {
> -					WARN_FUNC("no corresponding CFI save for CFI restore",
> -						  sec, insn->offset);
> -					return 1;
> -				}
> -
> -				if (!save_insn->visited) {
> -					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
> -						  sec, insn->offset);
> -					return 1;
> -				}
> -
> -				insn->state = save_insn->state;
> -			}
> -
> -			state = insn->state;
> -
> +			ret = apply_insn_hint(file, sec, func, insn, &state);
> +			if (ret)
> +				return ret;
>  		} else
>  			insn->state = state;
>  
> 
> 

