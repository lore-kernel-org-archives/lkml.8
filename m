Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C048C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B6E2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595848910;
	bh=ciUtuoTzuTOJmqrSgErdlqmGpwurRqz0KD8VCbTBQOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gbnp/opZ9bvAdOS0SdsT5xNJbpeL72GTuhpSH7TCqkcZENYqH2bg2XtOkz946PTSh
	 25Qsd2h5XKkvTWvM0R/I87lSMf4I+iHIto9Ob504vJ5MXTRaOpkuZ0F3JmLD9PaLK3
	 d/kiH5bQvcHKfxOss0M8iksFL7M2FM840gm7arc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgG0LVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgG0LVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:21:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE690C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:21:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so11829383edr.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TTu31hLARJRsohvfso05Z79QSOvELrg4SIt3ybWefFQ=;
        b=bG1WgRH/B/wcmHbOd2y4WYybIwAG81XW8YkY5/3P03QuKnLlh+h7SyCp/ccy2i5Jc8
         xEshmCj1BIgvzaxmFrpwhYHt9Ds2YwRWqYfaRXjraimNmYVxMqhLnQlFv8HUjxBIoLbY
         fs1qBCraZecXeXECXp1fnHD8ft+3O76il6Ka0TUBWxCPveVWzrqBex92SdCx61bI5SDD
         qgGb+cDrA80zAIR6lbS/us6b3MRsfQdvj3n3bMhiqgUIgDdx+udYsYywFle8tUV2dNKm
         4Z0gonIY4S3vUavwywnwcimLdQyw9WynjkJJTXLbSFxT3sGnyWA0MneKPlcxkdvLNn+6
         v2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TTu31hLARJRsohvfso05Z79QSOvELrg4SIt3ybWefFQ=;
        b=s85QbzL2AThKb06nPyD5cucx2sP2CGppDlaRDZQRMDz1B1rfrzPh0G5T6/jQ3nd/uC
         EIpu3xAoBKQG1hv2FJUPr3X9eAqGpgHh+nUlMT6yfNc7DZLGeVWVjmIJd1b5Kg+wHPXD
         pJz8yBHMTcJYtaMdaGXPH7X4hoVQmsHxV5zbVEjHS4QAMyPmhaZpk68fCAXJTVzfVweM
         Z3jPJIklfEd09X0hFqpwyzMqw+T/N4WcIT70dvLCwWiqloWqOKHLKc+G1+8VeJ8jHplU
         j375v13Fh6/1JUBLtUte8nntCG95sdJ2m3d7UXrhEAHrRA9gf1xp0CQb9yhj6cAKH/1l
         g2uA==
X-Gm-Message-State: AOAM532TjVQCfV7fZ4WoQrtd4sQdDreFCFv1zniUcGRmJ2O5ebqCM44t
        LnYxIsRh04eongyDKAKlobM=
X-Google-Smtp-Source: ABdhPJyMbeMMAaWaGgAKpDBrgRZDkcvxpV6+s0bGDCbYs/eHFwVhqpiIZSp//L2ocfdGRtr27zcTOQ==
X-Received: by 2002:a05:6402:1ac4:: with SMTP id ba4mr20048330edb.60.1595848906686;
        Mon, 27 Jul 2020 04:21:46 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v24sm7138834eds.71.2020.07.27.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:21:46 -0700 (PDT)
Date:   Mon, 27 Jul 2020 13:21:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     peterz@infradead.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH] objtool,x86: Verify poke_int3_handler() is self contained
Message-ID: <20200727112144.GA55660@gmail.com>
References: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727104050.GH119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* peterz@infradead.org <peterz@infradead.org> wrote:

> 
> Abuse the SMAP rules to ensure poke_int3_handler() doesn't call out to
> anything.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -551,6 +551,14 @@ static const char *uaccess_safe_builtin[
>  	"__memcpy_mcsafe",
>  	"mcsafe_handle_tail",
>  	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
> +	/*
> +	 * Abuse alert!
> +	 *
> +	 * poke_int3_handler() is not in fact related to uaccess at all, we
> +	 * abuse the uaccess rules to ensure poke_int3_handler() is self
> +	 * contained and doesn't CALL out to other code.
> +	 */
> +	"poke_int3_handler",

So ->uaccess_safe makes sure that we don't CALL into non-uaccess-safe 
functions, but it still allows CALLs into *other* uaccess-safe 
functions, right?

So unless I missed something in the logic, the comment should say 
something like "doesn't CALL out to other non-uaccess safe code" or 
so? Which is, arguably, like 99% of all functions - but still, a whole 
bunch are allowed, such as low level instrumentation and other utility 
functions.

Thanks,

	Ingo
