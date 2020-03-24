Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477E2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEA7207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JYE86fRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCXMwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:52:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbgCXMwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qXAOLPt6QGHGhV5Hqcq/R5T4WdGX89hi6VL4VBFKtIY=; b=JYE86fRGIIRdzgudSJPdWXJB8Z
        FGDb720oq6FVEmYZqrkDUCGECxfXvnx0FdSJ/BTcbFFh5wwOCohkvCw2aKl+PfIxQGd9KA8WC/31n
        esyYbjIj7AnpQHow/MuDpnpseXPaHK4gGHzTJn/QeHR5QqLFuurbaeSWj8sPMxDno1nEQzsVAQjCB
        Adoxs6VgEKKNJoaigrIFxBRo2Vtwg8yNpP+BZq43lRCHnNLHmiFpZmQqjEjR2TTqVzw31m2XSnR+b
        U3NR/3RJimW0TD6XYe0TiK5pgNgitc31JialV+LoIeGm5aVNMNHRFvSBbGN/P0KbC3hihHCwvitZq
        QTV17nlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGj2p-0004Hn-Cy; Tue, 24 Mar 2020 12:52:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B82C300235;
        Tue, 24 Mar 2020 13:52:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 017F429B1EAD8; Tue, 24 Mar 2020 13:52:32 +0100 (CET)
Date:   Tue, 24 Mar 2020 13:52:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     jpoimboe@redhat.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wolfram Sang <wsa@the-dreams.de>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Raphael Gault <raphael.gault@arm.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] objtool: Documentation: document UACCESS warnings
Message-ID: <20200324125232.GP20696@hirez.programming.kicks-ass.net>
References: <20200323212538.GN2452@worktop.programming.kicks-ass.net>
 <20200324001321.39562-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324001321.39562-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:13:20PM -0700, Nick Desaulniers wrote:
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

There's sadly nothing obvious about 2); __fentry__ is enough to end up
in schedule() through preempt_enable().

So any function that has function tracing on (mostly everything) is
already disqualified.
