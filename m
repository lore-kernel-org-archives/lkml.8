Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA69EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F85420714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lerPhT70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCXBMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:12:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgCXBMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=PZYj1qXP9cUJY9iynaNb4XscpCafoCGGtBKmUDfUS/4=; b=lerPhT70X2TfXzRff0m5vavcob
        yY1WpGXb07087FZ8mOg4nuSE+Sgfr2WuFlFbGr1XsfXNWIER+3C/z22uL+FOHJWBNQHXJfWjJdQpp
        Ckg061gGir6BDHQUrIaXAMXY2ArnrIGgsuZpuTvtZkKsBUCwDhqqQvlUia9qKuOiDlVp7AeGQ3Wef
        FA+IZlU6UUD/R7W3M8dVzvEBDqhhApaqWlYnHpgI9dVJ14bVGOFOGONUXseUd8YKnaHSCAm5yIwEr
        TNKZwcBdMkOJRJSCp/tyyP67NQTENbubVFoC9aeYmS4jSi89vKsg1sRvcZYu8FXtTRQszMWXULIS8
        ub3XCSoQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGY7I-0001a8-UC; Tue, 24 Mar 2020 01:12:28 +0000
Subject: Re: [PATCH] objtool: Documentation: document UACCESS warnings
To:     Nick Desaulniers <ndesaulniers@google.com>, jpoimboe@redhat.com,
        peterz@infradead.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200323212538.GN2452@worktop.programming.kicks-ass.net>
 <20200324001321.39562-1-ndesaulniers@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f55972ee-8e4e-844f-1678-cde1cdcc1fa9@infradead.org>
Date:   Mon, 23 Mar 2020 18:12:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324001321.39562-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/20 5:13 PM, Nick Desaulniers wrote:
> Compiling with Clang and CONFIG_KASAN=y was exposing a few warnings:
>   call to memset() with UACCESS enabled
> 
> Document how to fix these for future travelers.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/876
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  .../Documentation/stack-validation.txt        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
> index de094670050b..156fee13ba02 100644
> --- a/tools/objtool/Documentation/stack-validation.txt
> +++ b/tools/objtool/Documentation/stack-validation.txt
> @@ -289,6 +289,26 @@ they mean, and suggestions for how to fix them.
>        might be corrupt due to a gcc bug.  For more details, see:
>        https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
>  
> +9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
> +
> +   This means that an unexpected call to a non-whitelisted function exists
> +   outside of arch-specific guards.
> +   X86: SMAP (stac/clac): __uaccess_begin()/__uaccess_end()
> +   ARM: PAN: uaccess_enable()/uaccess_enable()
> +
> +   These functions should called to denote a minimal critical section around

                      should be called

> +   access to __user variables. See also: https://lwn.net/Articles/517475/
> +
> +   The intention of the warning is to prevent calls to funcB() from eventually
> +   calling schedule(), potentially leaking the AC flags state, and not
> +   restoring them correctly.
> +
> +   To fix, either:
> +   1) add the correct guards before and after calls to low level functions like
> +      __get_user_size()/__put_user_size().
> +   2) add funcB to uaccess_safe_builtin whitelist in tools/objtool/check.c, if
> +      funcB obviously does not call schedule().
> +
>  
>  If the error doesn't seem to make sense, it could be a bug in objtool.
>  Feel free to ask the objtool maintainer for help.
> 


-- 
~Randy

