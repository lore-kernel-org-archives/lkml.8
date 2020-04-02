Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF8C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9A42080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V+COQAxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbgDBHam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:30:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46326 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:30:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id k191so1432273pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DVqNkiJ8dAgtFZhXgT1A32VI+149xn1Gsgt+wdCSTjE=;
        b=V+COQAxIniDRCPd3Vq5FAa6kChS/sUrfhl+HUWZ7mJEGtLTBgR5kSzJYdcvjcmH3um
         UKMyI2AvWfvlt3gp2xmSYZE/4FGSyIFY471dzZCbrnknD7UqZjVxaQbO9qAFOz8D+tTg
         x/PQNC2nnrj68UYq49g7yvwH/bX7EurYG89F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DVqNkiJ8dAgtFZhXgT1A32VI+149xn1Gsgt+wdCSTjE=;
        b=PXiQmpprsrsytPc6KHfA37yu2CsSV8KK3o9j8fg7ULZw/BEn1p8F52xGVt6smXsoLu
         wOPHucnf+N2ZSKxNRXc8SnxGqRs6FpVTCQN0n5IC4DxgdmYAaV9zgWiYFdO3FjV+xObj
         kSkZpdT0yCgP2CNTN7k2NaHkDtNij56KAhl1F06uxtkZKCC7YlXfdTfmx0RElPvFqRfH
         8K6SQMnQ+uQzvUrrBbhbOlS4fMnz0+Iki3+AtMExh48nNgdneFFLDDv9cOAyY4x+61Tq
         inPvI6P7aKP/Jn84hmBsE8HbGBeoFaRDImjn0Zlb012EcLpjmIWLa6buIOjUguKbW1NJ
         Vy4w==
X-Gm-Message-State: AGi0PuYrUO7M/i2oI+vWLDcIWICt30vQWQiOx3y+i78Zwvk6it+pkb6S
        ENblIAl3bBEkh1fRss71a1p94YMYoJM=
X-Google-Smtp-Source: APiQypIu59LNvQH4O6YHPfKQcLQl+kaYyht6h+Dqy3QeqTrBB7MyRDbDFYEJvIz0HgFygDHtkV3DhQ==
X-Received: by 2002:aa7:9a8e:: with SMTP id w14mr1840684pfi.113.1585812640239;
        Thu, 02 Apr 2020 00:30:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x70sm2980143pfc.21.2020.04.02.00.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:30:39 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:30:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/5] objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
Message-ID: <202004020030.209A886D3C@keescook>
References: <cover.1585761021.git.jpoimboe@redhat.com>
 <6653ad73c6b59c049211bd7c11ed3809c20ee9f5.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6653ad73c6b59c049211bd7c11ed3809c20ee9f5.1585761021.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:23:25PM -0500, Josh Poimboeuf wrote:
> CONFIG_UBSAN_TRAP causes GCC to emit a UD2 whenever it encounters an
> unreachable code path.  This includes __builtin_unreachable().  Because
> the BUG() macro uses __builtin_unreachable() after it emits its own UD2,
> this results in a double UD2.  In this case objtool rightfully detects
> that the second UD2 is unreachable:
> 
>   init/main.o: warning: objtool: repair_env_string()+0x1c8: unreachable instruction
> 
> We weren't able to figure out a way to get rid of the double UD2s, so
> just silence the warning.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks for finding a way to work around this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/objtool/check.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e3bb76358148..aaec5e1277ea 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2382,14 +2382,27 @@ static bool ignore_unreachable_insn(struct instruction *insn)
>  	    !strcmp(insn->sec->name, ".altinstr_aux"))
>  		return true;
>  
> +	if (!insn->func)
> +		return false;
> +
> +	/*
> +	 * CONFIG_UBSAN_TRAP inserts a UD2 when it sees
> +	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
> +	 * the UD2, which causes GCC's undefined trap logic to emit another UD2
> +	 * (or occasionally a JMP to UD2).
> +	 */
> +	if (list_prev_entry(insn, list)->dead_end &&
> +	    (insn->type == INSN_BUG ||
> +	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
> +	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
> +		return true;
> +
>  	/*
>  	 * Check if this (or a subsequent) instruction is related to
>  	 * CONFIG_UBSAN or CONFIG_KASAN.
>  	 *
>  	 * End the search at 5 instructions to avoid going into the weeds.
>  	 */
> -	if (!insn->func)
> -		return false;
>  	for (i = 0; i < 5; i++) {
>  
>  		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
> -- 
> 2.21.1
> 

-- 
Kees Cook
