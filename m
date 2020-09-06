Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C92C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834AA2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 16:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdrrg8HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgIFQIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgIFQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 12:08:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA1C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 09:08:11 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so8321875qth.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ghwFMKMmfkx7QGldOve6ecX8FxUB/3kseDl7ha5HipU=;
        b=Hdrrg8HQZVFYmmiZRK1/dhYgLJSfWJTDOh4NZlFqXNlYuK88hT/f7B6KR6RxqpuDgV
         15CpYv3FxWlcHQocyulLcD9P8b/SwbNSHa9utexLYWn6+n+iNhAphOOuUlZmtYOn1SKI
         jrkv5m91QhBJaHKc76v4gS5uORkBSWtJ3jQUI7QGH/L/nHLuHsRU4GB+qT7/4DqTg5A5
         QkJhqiDYrJuCrXUdqBqq8lyFI58Mrus7kwClLJHgnh14uhBfP20xNE4svKOCMi7VYSUR
         gP6Jz9yz1Kya35cNrf948nfO2JLRVv6A386uK5xbrm+Ju5hiZ1W+48MK9mF4bRtqcz/L
         J/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ghwFMKMmfkx7QGldOve6ecX8FxUB/3kseDl7ha5HipU=;
        b=cdJP5mYke8wMvidOGJ6EHFwC/r8OPkbsvwWiqyrZB/Px6hIzKztrNeNvzTZ7IzcaNL
         /3eIZRh+WJrxa1qs/Y3on0duCOwV1XOz1nUstsqNrK+9GWXoEAcZe8K8OSgIWGU9m+9Y
         KtaDPQaju1IGpDJdiBz4J66eM9poSSzPpo9ZCedakx4/OSH1Sz4ABklnXVt4/ldnM49h
         OiGIctD6PpGzQgSZ42FvBT7k4WN7vBJQYXPAHsyKruLjfbcIzn6ocFx5K78ZH07FbaBT
         da72t69JPA3dLl+2hpWp9vHCRzHDDF14tkpDhINdF/eumpfjyJzF1OS4LFPoxwkY1Rwd
         /dLg==
X-Gm-Message-State: AOAM5312XClyKsRb1003oTB3qTJsP6Ip31utmcakyMNpW9Z66VBKwgtn
        gpDORG3RAzNmibJTPxviPb4=
X-Google-Smtp-Source: ABdhPJwooTkLR8g1ZntKfU59cQgdvZtnQ0otlz+pSSqPbaVphE5X+L5vVVYn8ZLPgyl1358jLc1Nhw==
X-Received: by 2002:ac8:f23:: with SMTP id e32mr15121146qtk.168.1599408491153;
        Sun, 06 Sep 2020 09:08:11 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w128sm9132346qkb.6.2020.09.06.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 09:08:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 6 Sep 2020 12:08:09 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string.c: Clarify kerndoc for stpcpy()
Message-ID: <20200906160809.GA1620946@rani.riverdale.lan>
References: <202009060302.4574D8D0E0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202009060302.4574D8D0E0@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 03:06:29AM -0700, Kees Cook wrote:
> Fix the language around return values to indicate destination instead of
> source.
> 
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Link: https://lore.kernel.org/lkml/CAK7LNAQvQBhjYgSkvm-dVyNz2Jd2C2qAtfyRk-rngEDfjkc38g
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is a fix for lib-stringc-implement-stpcpy.patch in -mm.
> 
> Andrew, please note that it would be nice to get this into -rc6
> to unbreak the clang builds.
> 
> Thanks!
> ---
>  lib/string.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index 6bd0cf0fb009..32a56436c7eb 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -280,12 +280,12 @@ EXPORT_SYMBOL(strscpy_pad);
>   * @src: pointer to the beginning of string being copied from. Must not overlap
>   *       dest.
>   *
> - * stpcpy differs from strcpy in a key way: the return value is the new
> - * %NUL-terminated character. (for strcpy, the return value is a pointer to
> - * src. This interface is considered unsafe as it doesn't perform bounds
> - * checking of the inputs. As such it's not recommended for usage. Instead,
> - * its definition is provided in case the compiler lowers other libcalls to
> - * stpcpy.
> + * stpcpy differs from strcpy in a key way: the return value is a pointer
> + * to the new %NUL-terminated character in @dest. (For strcpy, the return
> + * value is a pointer to the start of @dest. This interface is considered
					      ^ need closing parenthesis

Thanks.
