Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22448C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1028206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLti2j7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDUUOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDUUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:14:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E85C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:14:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w20so441445pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p2bIY9zj9L3G0Z4iXTI/GW9ZxmVvZM+HX1uc08VpzmI=;
        b=ZLti2j7tRh8opB7s1kfUaTDQdCCSGJBnevAP30pTcILG3LN99PrbAH49Q52T6f4fx4
         9+58Z9Q564mXS9w/AB/CgLjw82dN/bIMn7mwyJYg2QZS5m4BsMPqZo3g1r2k+9JyK9si
         9a4QHwsq060uFubusPBCvn9tlre9j3k7+Q1Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p2bIY9zj9L3G0Z4iXTI/GW9ZxmVvZM+HX1uc08VpzmI=;
        b=uCvB6zoKf/UBRIMdm7Tw3glhFj8ejp4oZjX5bsrKwRAcwWKZnZALAtge+qevYslk0c
         M/FAUvaiVe7dcnwb0XQqmof+RfpL4tR0/QiyCa/tTpzf2BSUvfZbndm7aeoCJZ6qv7t7
         IOBbBhtzzUGVa51KHUuw7X2CW03/bxgFbkV/qFPBrPF7ChNxC3+EIPFPrTjwZewzSPI1
         NCBTbCUHQiVlvpaPYMHKwPuc0r+zw1A8UVXIOxarjyqfTxPhWx3o000nPvuxn0a+QlZX
         LApZeV0HJbkgl7H7AMYU3EBJns+nk/yvHbaQ5KydfaG8+hs+VFdnHrozwqT/0kyN8smK
         MH6Q==
X-Gm-Message-State: AGi0Pub66Vww7vNXGhxpE8RIHzzb7cTz2MCFqCajWrPGOdxAu/rNEt8S
        t2Iz66q2liZJFmmI+gS8axjX0A==
X-Google-Smtp-Source: APiQypI5Lc34S6EhsxtCmm6xzoMOm8dbe9rNH7fGtT38VtyT7y86+/tZ3PSvbZd189AZ0FbZk/5vkA==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr21687007plb.50.1587500079864;
        Tue, 21 Apr 2020 13:14:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm2920181pgh.63.2020.04.21.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:14:39 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:14:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool: optimize add_dead_ends for split sections
Message-ID: <202004211314.667D21F2C5@keescook>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421180724.245410-4-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:07:24AM -0700, Sami Tolvanen wrote:
> When running objtool on vmlinux.o compiled with -ffunction-sections,
> .rela.discard.(un)reachable often contains relocations that point to
> a different section. Instead of iterating through the list of all
> instructions each time, store a pointer to the last instruction of
> each section when decoding instructions.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/objtool/check.c | 43 ++++++++++++++++++++++++++-----------------
>  tools/objtool/check.h |  4 ++++
>  tools/objtool/elf.h   |  1 +
>  3 files changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 4770fb07b365..7d4104de0a5e 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -237,6 +237,7 @@ static void clear_insn_state(struct insn_state *state)
>  static int decode_instructions(struct objtool_file *file)
>  {
>  	struct section *sec;
> +	struct section_info *sec_info = NULL;
>  	struct symbol *func;
>  	unsigned long offset;
>  	struct instruction *insn;
> @@ -253,6 +254,8 @@ static int decode_instructions(struct objtool_file *file)
>  		    strncmp(sec->name, ".discard.", 9))
>  			sec->text = true;
>  
> +		insn = NULL;
> +
>  		for (offset = 0; offset < sec->len; offset += insn->len) {
>  			insn = malloc(sizeof(*insn));
>  			if (!insn) {
> @@ -279,6 +282,17 @@ static int decode_instructions(struct objtool_file *file)
>  			nr_insns++;
>  		}
>  
> +		if (insn) {
> +			sec_info = malloc(sizeof(*sec_info));
> +			if (!sec_info) {
> +				WARN("malloc failed");
> +				return -1;
> +			}
> +
> +			sec_info->last_insn = insn;
> +			sec->section_info = sec_info;
> +		}
> +
>  		list_for_each_entry(func, &sec->symbol_list, list) {
>  			if (func->type != STT_FUNC || func->alias != func)
>  				continue;
> @@ -312,7 +326,6 @@ static int add_dead_ends(struct objtool_file *file)
>  	struct section *sec;
>  	struct rela *rela;
>  	struct instruction *insn;
> -	bool found;
>  
>  	/*
>  	 * By default, "ud2" is a dead end unless otherwise annotated, because
> @@ -338,15 +351,13 @@ static int add_dead_ends(struct objtool_file *file)
>  		if (insn)
>  			insn = list_prev_entry(insn, list);
>  		else if (rela->addend == rela->sym->sec->len) {
> -			found = false;
> -			list_for_each_entry_reverse(insn, &file->insn_list, list) {
> -				if (insn->sec == rela->sym->sec) {
> -					found = true;
> -					break;
> -				}
> -			}
> +			struct section_info *sec_info = (struct section_info *)
> +				rela->sym->sec->section_info;
> +
> +			if (sec_info)
> +				insn = sec_info->last_insn;
>  
> -			if (!found) {
> +			if (!insn) {
>  				WARN("can't find unreachable insn at %s+0x%x",
>  				     rela->sym->sec->name, rela->addend);
>  				return -1;
> @@ -380,15 +391,13 @@ static int add_dead_ends(struct objtool_file *file)
>  		if (insn)
>  			insn = list_prev_entry(insn, list);
>  		else if (rela->addend == rela->sym->sec->len) {
> -			found = false;
> -			list_for_each_entry_reverse(insn, &file->insn_list, list) {
> -				if (insn->sec == rela->sym->sec) {
> -					found = true;
> -					break;
> -				}
> -			}
> +			struct section_info *sec_info = (struct section_info *)
> +				rela->sym->sec->section_info;
> +
> +			if (sec_info)
> +				insn = sec_info->last_insn;
>  
> -			if (!found) {
> +			if (!insn) {
>  				WARN("can't find reachable insn at %s+0x%x",
>  				     rela->sym->sec->name, rela->addend);
>  				return -1;
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index bc78eca7982e..353677ec85d4 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -47,6 +47,10 @@ struct instruction {
>  	struct orc_entry orc;
>  };
>  
> +struct section_info {
> +	struct instruction *last_insn;
> +};
> +
>  struct objtool_file {
>  	struct elf *elf;
>  	struct list_head insn_list;
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index ebbb10c61e24..98f2b41d18e4 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -40,6 +40,7 @@ struct section {
>  	int idx;
>  	unsigned int len;
>  	bool changed, text, rodata;
> +	void *section_info;
>  };
>  
>  struct symbol {
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

-- 
Kees Cook
