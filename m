Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D09C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1501E20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5O/tZUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHYOpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:45:53 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A01C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:45:53 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h3so11812382oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=VTr+UBTs8M83B6cwmjPIyb1RPvibp4IuDq2rGpbu+JE=;
        b=T5O/tZUp+lYaSBiQmWvop8RewiuyH9rZZFLeiYNmnxy+nO2npT3cCPAGOIQmOWwYDu
         FqcE2cD8M6/WcZwfiffethd0UodvN9WYZQtBGJBBt4s2SpxKupl5ZCRFWr3wd9JjGtDJ
         MvUZ1MvGTMNRAFhUJJyKWxAMesWLSUpEqOUb0/GUJdexrHvxlKxBIYWqMQaHpM+uxI0f
         DLFHTvPWZYICuDwOCaVFlO0pT3quj0E+yJCnvdf3V+gjGytGdt1+Q38sn86iaEivlOnB
         7DbpN/1PktDbLTEVqES/iNDJwx026o4iUxAFL1RrF9nB845F+Fzd5YbrLsyNo3RP0FV4
         eFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=VTr+UBTs8M83B6cwmjPIyb1RPvibp4IuDq2rGpbu+JE=;
        b=O7kK8O0reXdoKTpT6y/EklggpxjbkgmjB0BbLontYs4tcOHv087wmBWEJWPYZI0eKD
         etCjgNek/NbvvGaJrX6/u/YeJIlPbuH3ux40kUUNdSjMU2rOJzxAoAPcfjsqG+ef/MIg
         h5HBKSKwHeqtQy3W3UiVwf0ll8tnPOAiiIRRe9HZYpgJ52LFn5X8Yws0YI/u5o1o0Djg
         FGoSxE3M/mLUmbmwBmmJnlaK9u2TBg0PQWoMRLIE4nIeh6Naw9knwUSTsj7CYzxSIHRj
         WqMJCCwwOCylHVfuddkI5XjOLZ15ES/uNskfKuGweKrL4+v/Ss5y+jcOxKtUQXe9elWQ
         f9qg==
X-Gm-Message-State: AOAM531isdQ1VDD1d8lJx3ZCmzSOvThVOdkqmOPLpduVN9ZCxO6sJlcJ
        TSigoQviqjXl08fuCwOvhzezx3naloB2Jev/JoQ=
X-Google-Smtp-Source: ABdhPJyQu+oGC+8t3DwICtYWsqdZqeQr2c24pHoLgUtv3lH9lAxkgZJP8ccZ+ojSOOybLxP+LEzuIrAsHvmsysPwlgg=
X-Received: by 2002:aca:acd5:: with SMTP id v204mr1196935oie.35.1598366752520;
 Tue, 25 Aug 2020 07:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200825143540.2948637-1-ndesaulniers@google.com>
In-Reply-To: <20200825143540.2948637-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 25 Aug 2020 16:45:40 +0200
Message-ID: <CA+icZUXt4F76TaOxSc1=pVunguxqvYWe7+ypwsS4f=uwc7A=EA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add LLVM maintainers
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 4:35 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Nominate Nathan and myself to be point of contact for clang/LLVM related
> support, after a poll at the LLVM BoF at Linux Plumbers Conf 2020.
>
> While corporate sponsorship is beneficial, its important to not entrust
> the keys to the nukes with any one entity. Should Nathan and I find
> ourselves at the same employer, I would gladly step down.
>
> Cc: clang-built-linux@googlegroups.com
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 33aab0c88118..0cbb24753153 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4249,6 +4249,8 @@ S:        Maintained
>  F:     .clang-format
>
>  CLANG/LLVM BUILD SUPPORT

Congrats!

Thanks, this was overdue and requested at ClangBuiltLinux Meetup in
Zurich in February.

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> +M:     Nathan Chancellor <natechancellor@gmail.com>
> +M:     Nick Desaulniers <ndesaulniers@google.com>
>  L:     clang-built-linux@googlegroups.com
>  S:     Supported
>  W:     https://clangbuiltlinux.github.io/
> --
> 2.28.0.297.g1956fa8f8d-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200825143540.2948637-1-ndesaulniers%40google.com.
