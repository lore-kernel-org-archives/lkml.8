Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B452075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdERGfYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439877AbgDNMHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:07:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439868AbgDNMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586866064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEC8FYl9uhBFK47ugtlOgCp6ZrKZaj+2J1s4LLyaaZY=;
        b=YdERGfYyJtB3dg/BMMAHulK53eAh9sCb9G+4FBwj4tsoSKUlLNEuYShMR9p321C9VmDwM4
        rTgDQcWP91iO5dD2sGwJ7gpHYBTsd83/3cnWwcTBwNqj9KYkX5e4P3Wy38c8dGKUg5gFVD
        aZ6djJygMJFVcOpBC1p5qpLXGmo7Wis=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-UHS2G6L1OFG2VFdGtSvaCQ-1; Tue, 14 Apr 2020 08:07:37 -0400
X-MC-Unique: UHS2G6L1OFG2VFdGtSvaCQ-1
Received: by mail-wr1-f69.google.com with SMTP id y1so8564677wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NEC8FYl9uhBFK47ugtlOgCp6ZrKZaj+2J1s4LLyaaZY=;
        b=Zq709LXXe+kRYIWG8sDQFT1DvqzoPrl34Wczi2IGYlPNizSVaKH9UrgIh28jFwRMrm
         /NZhgJXS77+/yOMDLmBjwK8ZvMjpOSFv3n4mMOJ1Yk43RnS0GUusr/ED3KUclPTAhxAW
         R6OjaSquqGlo5QwOYmr9vTFCGR/RyiAk6XIsjwho/gxfUGwC5xesdQmNdVBZxfQ5QmeM
         FhMZXf/y+3NKs/wIRMQMZXD1+Spo1xoX2jV6wFTY0ELYoaDZEB5I1VCrkLbF56t8ZYWe
         3e8t5V6OlECZyrnq8q7WQw9LXT7DZCNSV3TF3wvqDYlkEwzfnhurJf27biDNBQSfcDFy
         Rgrw==
X-Gm-Message-State: AGi0PubqMHHTMXsU+WBjzYO8YzyY0uOYtH3efAdEjeVkUUNLub7ceo/M
        M+ip8szTBkYCU4UlihArw+KAf+qv+IP+COJWAFmNv9uU8Wju88h1sy8Dm8syQGORq31wb7DVnzq
        hf1R5kYOjrFiVSNCtplyouNSF
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr14945395wrs.158.1586866056120;
        Tue, 14 Apr 2020 05:07:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ/TOwYbLO6fuH4+A8IvrCU6PztJAKksLkPgek7aqUIxHWKYcijQ94Q8l8s2npcQPFb2Wwynw==
X-Received: by 2002:adf:fdc1:: with SMTP id i1mr14945359wrs.158.1586866055753;
        Tue, 14 Apr 2020 05:07:35 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id m13sm19530228wrx.40.2020.04.14.05.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:07:35 -0700 (PDT)
Subject: Re: [PATCH V3 3/9] objtool: Add support for intra-function calls
To:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-4-alexandre.chartre@oracle.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <80aff36b-dbd2-82bf-dcf3-af0e5344c978@redhat.com>
Date:   Tue, 14 Apr 2020 13:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414103618.12657-4-alexandre.chartre@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 4/14/20 11:36 AM, Alexandre Chartre wrote:
> Change objtool to support intra-function calls. On x86, an intra-function
> call is represented in objtool as a push onto the stack (of the return
> address), and a jump to the destination address. That way the stack
> information is correctly updated and the call flow is still accurate.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>   include/linux/frame.h                         |  11 ++
>   .../Documentation/stack-validation.txt        |   8 ++
>   tools/objtool/arch/x86/decode.c               |   6 +
>   tools/objtool/check.c                         | 126 ++++++++++++++----
>   tools/objtool/check.h                         |   1 +
>   5 files changed, 128 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/frame.h b/include/linux/frame.h
> index 02d3ca2d9598..c7178e6c9d48 100644
> --- a/include/linux/frame.h
> +++ b/include/linux/frame.h
> @@ -15,9 +15,20 @@
>   	static void __used __section(.discard.func_stack_frame_non_standard) \
>   		*__func_stack_frame_non_standard_##func = func
>   
> +/*
> + * This macro indicates that the following intra-function call is valid.
> + * Any non-annotated intra-function call will cause objtool to issue warning.
> + */
> +#define ANNOTATE_INTRA_FUNCTION_CALL				\
> +	999:							\
> +	.pushsection .discard.intra_function_call;		\

Very nit-pickish but my brain wants to add an 's' to that section name. 
Like for the sections "unwind_hints" or "altinstructions".

> +	.long 999b;						\
> +	.popsection;
> +
>   #else /* !CONFIG_STACK_VALIDATION */
>   
>   #define STACK_FRAME_NON_STANDARD(func)
> +#define ANNOTATE_INTRA_FUNCTION_CALL
>   
>   #endif /* CONFIG_STACK_VALIDATION */
>   
> diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
> index de094670050b..09f863fd32d2 100644
> --- a/tools/objtool/Documentation/stack-validation.txt
> +++ b/tools/objtool/Documentation/stack-validation.txt
> @@ -290,6 +290,14 @@ they mean, and suggestions for how to fix them.
>         https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
>   
>   
> +9. file.o: warning: unsupported intra-function call
> +
> +   This warning means that a direct call is done to a destination which
> +   is not at the beginning of a function. If this is a legit call, you
> +   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
> +   directive right before the call.
> +
> +
>   If the error doesn't seem to make sense, it could be a bug in objtool.
>   Feel free to ask the objtool maintainer for help.
>   
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index a62e032863a8..f4d70b8835c4 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -437,6 +437,12 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
>   
>   	case 0xe8:
>   		*type = INSN_CALL;
> +		/*
> +		 * For the impact on the stack, a call behaves like
> +		 * a push of an immediate value (the return address).
> +		 */
> +		op->src.type = OP_SRC_CONST;
> +		op->dest.type = OP_DEST_PUSH;
>   		break;
>   
>   	case 0xfc:
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 8f0525d5d895..ad362c5de281 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -654,44 +654,58 @@ static int add_jump_destinations(struct objtool_file *file)
>   	return 0;
>   }
>   
> +static int configure_call(struct objtool_file *file, struct instruction *insn)

The name "configure_call()" is a bit vague. What about naming this 
set_local_call_destination() ? (Since it deals with call destinations 
that don't need relocations and sets their actual target destination).

> +{
> +	unsigned long dest_off;
> +
> +	dest_off = insn->offset + insn->len + insn->immediate;
> +	insn->call_dest = find_func_by_offset(insn->sec, dest_off);
> +	if (!insn->call_dest)
> +		insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
> +
> +	if (insn->call_dest) {
> +		/* regular call */
> +		if (insn->func && insn->call_dest->type != STT_FUNC) {
> +			WARN_FUNC("unsupported call to non-function",
> +				  insn->sec, insn->offset);
> +			return -1;
> +		}
> +		return 0;
> +	}
> +
> +	/* intra-function call */
> +	if (!insn->intra_function_call)
> +		WARN_FUNC("intra-function call", insn->sec, insn->offset);
> +
> +	dest_off = insn->offset + insn->len + insn->immediate;
> +	insn->jump_dest = find_insn(file, insn->sec, dest_off);
> +	if (!insn->jump_dest) {
> +		WARN_FUNC("can't find call dest at %s+0x%lx",
> +			  insn->sec, insn->offset,
> +			  insn->sec->name, dest_off);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Find the destination instructions for all calls.
>    */
>   static int add_call_destinations(struct objtool_file *file)
>   {
>   	struct instruction *insn;
> -	unsigned long dest_off;
>   	struct rela *rela;
>   
>   	for_each_insn(file, insn) {
> -		if (insn->type != INSN_CALL)
> +		if (insn->type != INSN_CALL || insn->ignore)
>   			continue;
>   
>   		rela = find_rela_by_dest_range(file->elf, insn->sec,
>   					       insn->offset, insn->len);
>   		if (!rela) {
> -			dest_off = insn->offset + insn->len + insn->immediate;
> -			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
> -			if (!insn->call_dest)
> -				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
> -
> -			if (insn->ignore)
> -				continue;
> -
> -			if (!insn->call_dest) {
> -				WARN_FUNC("unsupported intra-function call",
> -					  insn->sec, insn->offset);
> -				if (retpoline)
> -					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
> -				return -1;
> -			}
> -
> -			if (insn->func && insn->call_dest->type != STT_FUNC) {
> -				WARN_FUNC("unsupported call to non-function",
> -					  insn->sec, insn->offset);
> +			if (configure_call(file, insn))
>   				return -1;
> -			}
> -
>   		} else if (rela->sym->type == STT_SECTION) {
>   			insn->call_dest = find_func_by_offset(rela->sym->sec,
>   							      rela->addend+4);
> @@ -1337,6 +1351,42 @@ static int read_retpoline_hints(struct objtool_file *file)
>   	return 0;
>   }
>   
> +static int read_intra_function_call(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct instruction *insn;
> +	struct rela *rela;
> +
> +	sec = find_section_by_name(file->elf,
> +				   ".rela.discard.intra_function_call");
> +	if (!sec)
> +		return 0;
> +
> +	list_for_each_entry(rela, &sec->rela_list, list) {
> +		if (rela->sym->type != STT_SECTION) {
> +			WARN("unexpected relocation symbol type in %s",
> +			     sec->name);
> +			return -1;
> +		}
> +
> +		insn = find_insn(file, rela->sym->sec, rela->addend);
> +		if (!insn) {
> +			WARN("bad .discard.intra_function_call entry");
> +			return -1;
> +		}
> +
> +		if (insn->type != INSN_CALL) {
> +			WARN_FUNC("intra_function_call not a direct call",
> +				  insn->sec, insn->offset);
> +			return -1;
> +		}
> +
> +		insn->intra_function_call = true;

Maybe you could directly lookup the target instruction here and set 
insn->jump_dest here.

Then you wouldn't need as much changes in add_call_destination(), just 
adding the following in the "!rela" branch:

	if (insn->intra_function_call)
		continue;

> +	}
> +
> +	return 0;
> +}
> +
>   static void mark_rodata(struct objtool_file *file)
>   {
>   	struct section *sec;
> @@ -1392,6 +1442,10 @@ static int decode_sections(struct objtool_file *file)
>   	if (ret)
>   		return ret;
>   
> +	ret = read_intra_function_call(file);
> +	if (ret)
> +		return ret;
> +
>   	ret = add_call_destinations(file);
>   	if (ret)
>   		return ret;
> @@ -2155,7 +2209,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   				return ret;
>   
>   			if (!no_fp && func && !is_fentry_call(insn) &&
> -			    !has_valid_stack_frame(&state)) {
> +			    !has_valid_stack_frame(&state) &&
> +			    !insn->intra_function_call) {
>   				WARN_FUNC("call without frame pointer save/setup",
>   					  sec, insn->offset);
>   				return 1;
> @@ -2164,6 +2219,29 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>   			if (dead_end_function(file, insn->call_dest))
>   				return 0;
>   
> +			if (insn->intra_function_call) {
> +				/*
> +				 * The call instruction can update the stack
> +				 * state. Then make the intra-function call
> +				 * behaves like and unconditional jump.
> +				 */
> +				ret = update_insn_state(insn, &state);
> +				if (ret)
> +					return ret;
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
>   			break;
>   
>   		case INSN_JUMP_CONDITIONAL:
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index 953db38dfc35..6a80903fc4aa 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -36,6 +36,7 @@ struct instruction {
>   	int alt_group;
>   	bool dead_end, ignore, ignore_alts;
>   	bool hint, save, restore;
> +	bool intra_function_call;
>   	bool retpoline_safe;
>   	u8 visited;
>   	struct symbol *call_dest;
> 

Cheers,

-- 
Julien Thierry

