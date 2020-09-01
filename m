Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C392C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34616206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzB+6u5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgIANyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgIANwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:52:06 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9128C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:52:05 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u126so1178832oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8hcm2K727CJua1c+VIHcKsQUWGaU38NC8nW5M5njWS0=;
        b=RzB+6u5Rh384ZLBaf8gb7xled8dPfCLq+M2yOBByA0tFWFBkZQaR+kN9x2/6LT6eRl
         mexSqTVWGfN9maHW7dUYIxUseUHzUA0tILgKWHslrsfW9+Eiksr7uG40fwDLuvsd6JGC
         y126TvWhr/wt6v6B9u23q4PFYqVYXRnjrSeTt5aCcuDJ1MXsIZqduhGFdsW9yC/3xauB
         O9utFyuiP6lDr1F1DqF3YPz59bSKYWyu0ZKXA9v0VQ2NTxr6q2+d6IkhAVRpqrbh0jHN
         dbcgQwk0w0ofT8vtjquQS5u8S7ROgNAOMlME+vl/8RgOPbUs32ZMTmAj3jsX43gh4RUk
         Wo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8hcm2K727CJua1c+VIHcKsQUWGaU38NC8nW5M5njWS0=;
        b=cRsMxOmTIZ9P6zRRtCNS2rRlXqpSlTDR9vg2Q1tAv0j5SJ1K26AYHCTLJbe0KdjDZI
         mm6xk7jKfBmVjJctLLbl8wNlLDzsjYbJFGM4vrlVjBI2aHheRtNdgTJOkhJAjE018Nx4
         YbTQppIAbHEy2Zrbs4havrky7GcO83kqqFiZKcl0mHHrr0zjsUf89LagzI5J53ZySBNE
         uOwHdax4SRZBDc4fsI87rq9cTEPdGdNTlZfmEJ9CJEieINNOrRlVx4x3CgYlxlBYgm3p
         VN4oSbFZMoSzteIWpXZQVPNtevcHg7aXdvTDCgzJpyM8WrUg3n0Lr1jM+uWQDjPyRt+H
         kKPA==
X-Gm-Message-State: AOAM532dO4qW9Xf7/DukbgHDbccum/7BUzZiebFFlVMpHkOzf+lPgIrt
        7rbsyqURNQDJs7kMn6b7a2XuTYiMcxabUQtiA8o=
X-Google-Smtp-Source: ABdhPJxg2Hv2wMNBD5cwLy4ygarowXgs9U0Ug/N06kuRO8ITa7JOinjMQlO+/bn4AbKgWoD6EHBqyqmaySDbTH10lhQ=
X-Received: by 2002:aca:ec50:: with SMTP id k77mr1149644oih.35.1598968325175;
 Tue, 01 Sep 2020 06:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com> <20200901002326.1137289-2-ndesaulniers@google.com>
In-Reply-To: <20200901002326.1137289-2-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 1 Sep 2020 15:51:52 +0200
Message-ID: <CA+icZUXZAsenwohDCiUb9ZvtJUfFOJV6xHFiekfMPJh68UGvPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] compiler-clang: add build check for clang 10.0.1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 2:23 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> During Plumbers 2020, we voted to just support the latest release of
> Clang for now.  Add a compile time check for this.
>
> We plan to remove workarounds for older versions now, which will break
> in subtle and not so subtle ways.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/9
> Link: https://github.com/ClangBuiltLinux/linux/issues/941
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Marco Elver <elver@google.com>
> Acked-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
> Changes V1 -> V2:
> * use a more informational error, as per Kees.
> * collect tags.
>
>  include/linux/compiler-clang.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index cee0c728d39a..230604e7f057 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,6 +3,14 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>
> +#define CLANG_VERSION (__clang_major__ * 10000 \
> +                    + __clang_minor__ * 100    \
> +                    + __clang_patchlevel__)
> +
> +#if CLANG_VERSION < 100001
> +# error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
> +#endif
> +
>  /* Compiler specific definitions for Clang compiler */
>
>  /* same as gcc, this was present in clang-2.6 so we can assume it works
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
