Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CEEC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F182075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgDXOHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:07:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgDXOHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:07:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7E86AEC3;
        Fri, 24 Apr 2020 14:07:33 +0000 (UTC)
Date:   Fri, 24 Apr 2020 16:07:33 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 4/8] objtool: Add support for intra-function calls
In-Reply-To: <alpine.LSU.2.21.2004241102500.6175@pobox.suse.cz>
Message-ID: <alpine.LSU.2.21.2004241606230.11941@pobox.suse.cz>
References: <20200423125013.452964352@infradead.org> <20200423125042.794350465@infradead.org> <alpine.LSU.2.21.2004231619070.6520@pobox.suse.cz> <20200423152243.GV20730@hirez.programming.kicks-ass.net> <alpine.LSU.2.21.2004241102500.6175@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ---
> 
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index 6340ea0dd527..be6520155cfd 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -100,6 +100,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
>  		      modrm_reg = 0, sib = 0;
>  	struct stack_op *op = NULL;
> +	struct symbol *sym;
>  
>  	x86_64 = is_x86_64(elf);
>  	if (x86_64 == -1)
> @@ -496,22 +497,24 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
>  		*type = INSN_RETURN;
>  		break;
>  
> -	case 0xcf: /* iret */
> -		*type = INSN_EXCEPTION_RETURN;
> -
> -		ADD_OP(op) {
> -			/* add $40, %rsp */
> -			op->src.type = OP_SRC_ADD;
> -			op->src.reg = CFI_SP;
> -			op->src.offset = 5*8;
> -			op->dest.type = OP_DEST_REG;
> -			op->dest.reg = CFI_SP;
> -		}
> -		break;
> -
>  	case 0xca: /* retf */
>  	case 0xcb: /* retf */
> +	case 0xcf: /* iret */
>  		*type = INSN_CONTEXT_SWITCH;
> +
> +		sym = find_symbol_by_offset(sec, offset);

sym = find_symbol_containing(sec, offset);

of course

> +		if (sym && sym->type == STT_FUNC) {
> +			*type = INSN_OTHER;
> +
> +			ADD_OP(op) {
> +				/* add $40, %rsp */
> +				op->src.type = OP_SRC_ADD;
> +				op->src.reg = CFI_SP;
> +				op->src.offset = 5*8;
> +				op->dest.type = OP_DEST_REG;
> +				op->dest.reg = CFI_SP;
> +			}
> +		}
>  		break;
