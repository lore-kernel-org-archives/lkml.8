Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0792C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75332051A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQgckbFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDSQmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:42:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725793AbgDSQmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587314522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnxWFRTNQd3pem8wNeDHkmVrqzPwOk4LBIxXKDyZPQo=;
        b=RQgckbFOr6jJqJHxNiJcSF/EPQxWuZebk8CBNikuMN8ul0QTjxqXSzEqI6GJhaveSbDxH0
        MMMThukOsTAoi7gSO+oGndAH6hAsRGfmCx+RkJ1wyRHJl09Rg+a44hdu6Pz7XEnWnHXsB0
        BQql72lIyCUrqmQyegQp3hzzX/P0WUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-Z39XpQHmNa2sIZeuGp1bFA-1; Sun, 19 Apr 2020 12:41:57 -0400
X-MC-Unique: Z39XpQHmNa2sIZeuGp1bFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B40BB107ACC9;
        Sun, 19 Apr 2020 16:41:55 +0000 (UTC)
Received: from treble (ovpn-112-237.rdu2.redhat.com [10.10.112.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C52DC1001DC2;
        Sun, 19 Apr 2020 16:41:53 +0000 (UTC)
Date:   Sun, 19 Apr 2020 11:41:50 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 4/7] objtool: Add support for intra-function calls
Message-ID: <20200419164150.q5ut7gjhwzdrg4lf@treble>
References: <20200416150752.569029800@infradead.org>
 <20200416151024.944613249@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416151024.944613249@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:07:56PM +0200, Peter Zijlstra wrote:
> From: Alexandre Chartre <alexandre.chartre@oracle.com>
> 
> Change objtool to support intra-function calls. On x86, an intra-function
> call is represented in objtool as a push onto the stack (of the return
> address), and a jump to the destination address. That way the stack
> information is correctly updated and the call flow is still accurate.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200414103618.12657-4-alexandre.chartre@oracle.com
> ---
>  include/linux/frame.h                            |   11 +
>  tools/objtool/Documentation/stack-validation.txt |    8 +
>  tools/objtool/arch/x86/decode.c                  |   17 ++-
>  tools/objtool/check.c                            |  129 ++++++++++++++++++-----
>  tools/objtool/check.h                            |    1 
>  5 files changed, 140 insertions(+), 26 deletions(-)
> 
> --- a/include/linux/frame.h
> +++ b/include/linux/frame.h
> @@ -15,9 +15,20 @@
>  	static void __used __section(.discard.func_stack_frame_non_standard) \
>  		*__func_stack_frame_non_standard_##func = func
>  
> +/*
> + * This macro indicates that the following intra-function call is valid.
> + * Any non-annotated intra-function call will cause objtool to issue warning.

issue *a* warning

> +static int setup_call_dest(struct objtool_file *file, struct instruction *insn)
> +{
> +	unsigned long dest_off;
> +
> +	dest_off = insn->offset + insn->len + insn->immediate;
> +	insn->call_dest = find_func_by_offset(insn->sec, dest_off);
> +	if (!insn->call_dest)
> +		insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
> +
> +	if (!insn->call_dest) {
> +		/* intra-function call */
> +		if (insn->intra_function_call)
> +			return 0;
> +
> +		WARN_FUNC("intra-function call", insn->sec, insn->offset);
> +		return -1;
> +	}
> +
> +	/* regular call */
> +	if (insn->func && insn->call_dest->type != STT_FUNC) {
> +		WARN_FUNC("unsupported call to non-function",
> +			  insn->sec, insn->offset);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +

This function should first be added in a separate patch which doesn't
change functionality.

> @@ -2269,6 +2327,29 @@ static int validate_branch(struct objtoo
>  			if (dead_end_function(file, insn->call_dest))
>  				return 0;
>  
> +			if (insn->intra_function_call) {
> +				/*
> +				 * The call instruction can update the stack
> +				 * state. Then make the intra-function call
> +				 * behaves like and unconditional jump.

grammar fix: "behave like an unconditional jump".

> +				 */
> +				ret = handle_insn_ops(insn, &state);
> +				if (ret)
> +					return ret;

validate_branch's callers aren't currently able to handle a negative
return code.

> +
> +				ret = validate_branch(file, func, insn,
> +						      insn->jump_dest, state);
> +				if (ret) {
> +					if (backtrace) {
> +						BT_FUNC("(intra-function call)",
> +							insn);
> +					}
> +					return ret;
> +				}
> +
> +				return 0;
> +			}
> +

Could this be cleaner if the insn->type were just changed to
INSN_JUMP_UNCONDITIONAL?  Then it could share the normal jump logic.

Also, now that more instructions are getting stack ops, I wonder if the
ops can just be handled generically for every instruction, with a call
to handle_insn_ops() above, before the switch statement.

-- 
Josh

