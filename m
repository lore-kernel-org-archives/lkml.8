Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98EDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B723420B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbgDCI6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:58:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:58060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390474AbgDCI6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:58:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3EBFAC65;
        Fri,  3 Apr 2020 08:58:20 +0000 (UTC)
Date:   Fri, 3 Apr 2020 10:58:20 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/5] objtool: Support Clang non-section symbols in ORC
 generation
In-Reply-To: <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2004031057320.25955@pobox.suse.cz>
References: <cover.1585761021.git.jpoimboe@redhat.com> <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, Josh Poimboeuf wrote:

> When compiling the kernel with AS=clang, objtool produces a lot of
> warnings:
> 
>   warning: objtool: missing symbol for section .text
>   warning: objtool: missing symbol for section .init.text
>   warning: objtool: missing symbol for section .ref.text
> 
> It then fails to generate the ORC table.
> 
> The problem is that objtool assumes text section symbols always exist.
> But the Clang assembler is aggressive about removing them.
> 
> When generating relocations for the ORC table, objtool always tries to
> reference instructions by their section symbol offset.  If the section
> symbol doesn't exist, it bails.
> 
> Do a fallback: when a section symbol isn't available, reference a
> function symbol instead.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/669
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/orc_gen.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
> index 41e4a2754da4..4c0dabd28000 100644
> --- a/tools/objtool/orc_gen.c
> +++ b/tools/objtool/orc_gen.c
> @@ -88,11 +88,6 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
>  	struct orc_entry *orc;
>  	struct rela *rela;
>  
> -	if (!insn_sec->sym) {
> -		WARN("missing symbol for section %s", insn_sec->name);
> -		return -1;
> -	}
> -
>  	/* populate ORC data */
>  	orc = (struct orc_entry *)u_sec->data->d_buf + idx;
>  	memcpy(orc, o, sizeof(*orc));
> @@ -105,8 +100,32 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
>  	}
>  	memset(rela, 0, sizeof(*rela));
>  
> -	rela->sym = insn_sec->sym;
> -	rela->addend = insn_off;
> +	if (insn_sec->sym) {
> +		rela->sym = insn_sec->sym;
> +		rela->addend = insn_off;
> +	} else {
> +		/*
> +		 * The Clang assembler doesn't produce section symbols, so we
> +		 * have to reference the function symbol instead:
> +		 */
> +		rela->sym = find_symbol_containing(insn_sec, insn_off);
> +		if (!rela->sym) {
> +			/*
> +			 * Hack alert.  This happens when we need to reference
> +			 * the NOP pad insn immediately after the function.
> +			 */
> +			rela->sym = find_symbol_containing(insn_sec,
> +							   insn_off - 1);
> +		}

I suppose there is always just one NOP pad insn, right? Anyway, it would 
be better to get rid of it as you proposed.

> +		if (!rela->sym) {
> +			WARN("missing symbol for insn at offset 0x%lx\n",
> +			     insn_off);
> +			return -1;
> +		}
> +
> +		rela->addend = insn_off - rela->sym->offset;
> +	}
> +
>  	rela->type = R_X86_64_PC32;
>  	rela->offset = idx * sizeof(int);
>  	rela->sec = ip_relasec;

Miroslav
