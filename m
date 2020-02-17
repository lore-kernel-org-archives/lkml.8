Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5BC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD06F2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 23:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lK5YETle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgBQXra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:47:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34322 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgBQXra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 18:47:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so10016376pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X0DWzXHdssfbGqw78TpXjXFJwcsLkhgh50iR9RHP/qM=;
        b=lK5YETlebPLz0xampBO/XM+5XeHRSRz/PnDNc8BZYzUQ/hU6ikXc1o3+lLmbSSZ+KM
         oAkX2WvUgHdSUCcGYH1hpo71MueiJdnMhY1dOsVSiSNEhEgRcBtGYOBx6lLwck1N6xKI
         o6bSnVauQ+DO6lIxg9c1TazPtVL8b3hTYA0iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X0DWzXHdssfbGqw78TpXjXFJwcsLkhgh50iR9RHP/qM=;
        b=fOCDnXFwexp7hQSAv7rdqy5wBC1vQcPMj1xKlxFX78djdVBW/Kxk0NbaoYyzS/AXnh
         anpjvKKcqfZMmc2McZI+R16jr9G47f0zCB9Az5sQa6Xy1neboLWQ8/9DriXxjY1b1sv1
         m2lNkiRik5BqnTXzElRM/xjxU6RLTMIkOsV5YR5UJCsd51Tsfd9AeZ7zsZW1soFhyWs3
         w7rKRanjcdoKtTraM229Fq5FBDosz7b/4BfsiLFu91+O2rhriwKNNOxB1PAQ23A9mI04
         dbxGNcBPtBjm5UNpZx28EWu+buGdnIo9j5u5coDsNQnQ1ZpXeMV+owxBmWHwJOJ6P1hO
         7oVw==
X-Gm-Message-State: APjAAAULX9HMI/Orqo4aY1v05Hjz1JqSpvnNa+qRBsWzMqyzNTgGfLHj
        L9fLT5vfVHf283cfCbwn2eeKLw==
X-Google-Smtp-Source: APXvYqw/q5H7Gzh+HDrsa0huPDnENI68afk7XmDdR9NrlS7wQpmJ7Y6pTRE8QPmZMoW9mxxGqCLNhQ==
X-Received: by 2002:aa7:9ec9:: with SMTP id r9mr18757846pfq.85.1581983249280;
        Mon, 17 Feb 2020 15:47:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j14sm1952562pgs.57.2020.02.17.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 15:47:28 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:47:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <202002171546.A291F23F12@keescook>
References: <20200217222803.6723-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217222803.6723-1-idryomov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:28:03PM +0100, Ilya Dryomov wrote:
> I don't see what security concern is addressed by obfuscating NULL
> and IS_ERR() error pointers, printed with %p/%pK.  Given the number
> of sites where %p is used (over 10000) and the fact that NULL pointers
> aren't uncommon, it probably wouldn't take long for an attacker to
> find the hash that corresponds to 0.  Although harder, the same goes
> for most common error values, such as -1, -2, -11, -14, etc.
> 
> The NULL part actually fixes a regression: NULL pointers weren't
> obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
> dereferencing invalid pointers") which went into 5.2.  I'm tacking
> the IS_ERR() part on here because error pointers won't leak kernel
> addresses and printing them as pointers shouldn't be any different
> from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
> debugging based on existing pr_debug and friends excruciating.
> 
> Note that the "always print 0's for %pK when kptr_restrict == 2"
> behaviour which goes way back is left as is.
> 
> Example output with the patch applied:
> 
>                             ptr         error-ptr              NULL
> %p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
> %pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
> %px:           ffff888048c04020  fffffffffffffff2  0000000000000000
> %pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
> %pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000

This seems reasonable. Though I wonder -- since the efault string is
exposed now -- should this instead print all the error-ptr strings
instead of the unsigned negative pointer value?

-Kees

> 
> Fixes: 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  lib/vsprintf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 7c488a1ce318..f0f0522cd5a7 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -794,6 +794,13 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
>  	unsigned long hashval;
>  	int ret;
>  
> +	/*
> +	 * Print the real pointer value for NULL and error pointers,
> +	 * as they are not actual addresses.
> +	 */
> +	if (IS_ERR_OR_NULL(ptr))
> +		return pointer_string(buf, end, ptr, spec);
> +
>  	/* When debugging early boot use non-cryptographically secure hash. */
>  	if (unlikely(debug_boot_weak_hash)) {
>  		hashval = hash_long((unsigned long)ptr, 32);
> -- 
> 2.19.2
> 

-- 
Kees Cook
