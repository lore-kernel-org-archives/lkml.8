Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D34C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A89206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgHQJKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:10:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgHQJKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:10:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3C82B67A;
        Mon, 17 Aug 2020 09:10:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82A9BDA6EF; Mon, 17 Aug 2020 11:08:54 +0200 (CEST)
Date:   Mon, 17 Aug 2020 11:08:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] overflow: Add __must_check attribute to check_*()
 helpers
Message-ID: <20200817090854.GA2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <202008151007.EF679DF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008151007.EF679DF@keescook>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 10:09:24AM -0700, Kees Cook wrote:
> Since the destination variable of the check_*_overflow() helpers will
> contain a wrapped value on failure, it would be best to make sure callers
> really did check the return result of the helper. Adjust the macros to use
> a bool-wrapping static inline that is marked with __must_check. This means
> the macros can continue to have their type-agnostic behavior while gaining
> the function attribute (that cannot be applied directly to macros).
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - de-generalized __must_check_overflow() from being named "bool" (willy)
> - fix comment typos (rasmus)
> v1: https://lore.kernel.org/lkml/202008121450.405E4A3@keescook
> ---
>  include/linux/overflow.h | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 93fcef105061..f1c4e7b56bd9 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -43,6 +43,16 @@
>  #define is_non_negative(a) ((a) > 0 || (a) == 0)
>  #define is_negative(a) (!(is_non_negative(a)))
>  
> +/*
> + * Allows for effectively applying __must_check to a macro so we can have
> + * both the type-agnostic benefits of the macros while also being able to
> + * enforce that the return value is, in fact, checked.
> + */
> +static inline bool __must_check __must_check_overflow(bool overflow)
> +{
> +	return unlikely(overflow);

How does the 'unlikely' hint propagate through return? It is in a static
inline so compiler has complete information in order to use it, but I'm
curious if it actually does.

> +}
> +
>  #ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
>  /*
>   * For simplicity and code hygiene, the fallback code below insists on
> @@ -52,32 +62,32 @@
>   * alias for __builtin_add_overflow, but add type checks similar to
>   * below.
>   */
> -#define check_add_overflow(a, b, d) ({		\
> +#define check_add_overflow(a, b, d) __must_check_overflow(({	\
>  	typeof(a) __a = (a);			\
>  	typeof(b) __b = (b);			\
>  	typeof(d) __d = (d);			\
>  	(void) (&__a == &__b);			\
>  	(void) (&__a == __d);			\
>  	__builtin_add_overflow(__a, __b, __d);	\
> -})
> +}))

In case the hint gets dropped, the fix would probably be

#define check_add_overflow(a, b, d) unlikely(__must_check_overflow(({	\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
 	__builtin_add_overflow(__a, __b, __d);	\
})))
