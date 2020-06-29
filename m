Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D479C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE49204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWpyylI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgF2S54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgF2S5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E84C031C5B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:39:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so6474999plm.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymZPYXlQnFHAh4p3MfqCbK0ew51uYtV97Wu+f+eSAbk=;
        b=eWpyylI85AglLaoIbXKzgT6INWjE87+tmdZZnx1ZJBJZGzUDo44tIyHwfSnXs9UAnK
         GFO1nStX3pLJCvkUKDiYfLpuvRhlsZ50stz4D6ueFL6OC2H6TDM/KPyeHnDlp1F4dyYZ
         IoUn4Q9g2K4c/FroVZbyT4tTwtB454OK2eUFxaTQGLxVezqM6fXAdeHPWgBj2kMU731k
         b5Hv5ZIT9nSInEuw34rqU43ogvIy8wuX7a3v6Q4gFbiuD/Cpp7M1UoZbHpUtqh53dw7M
         2VDEuwXMia3oKnJXpCt6D3LJUPa9OLIUbKUCXcCIebNSTZ3vFPexaa6WyhOzf7G5cR/T
         EUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymZPYXlQnFHAh4p3MfqCbK0ew51uYtV97Wu+f+eSAbk=;
        b=r9BI7nduWF3aoTFr+ZMcj0op0yFWryUO2Z3+WnQS0ffq1Xlob7GmnudH3gSZQhfMwe
         GduxWKm3hLdWrfRlEU3CLhlgwMu/JZVtUNjKkFLNblZI6ER/5BGh0PJonyydQRID1Jlh
         kfMX+Kikxm0dW+szHQrMNcoollIRAiZ7/nGmNQtBNZwMlQ+pkAk7b/CkTcKWRydUFvDh
         TSp+7Rm4ChHg1FVGBkMDwU9gZQw5T1/QFwA+w++3GZb/X7cgxxVZpwyVgdvZduQhHZtL
         AHvcIiSz6pU6apVXGodsGy7KgxHZXSe1xJ+oNtJ4ilwEX6jUK+I3DHWWgUNgZ1HiKQCQ
         IdKg==
X-Gm-Message-State: AOAM531KrU0FmIfJQ5/mjhlh0Ro5/A23w53cfIBxZysGm2kIIFI+1ywK
        O+S6HfpCEA+ZZ24XpqXCZiTQdVOlsk7Lm79JZuIhkg==
X-Google-Smtp-Source: ABdhPJx7WdyCIxUBawfx7KsliaWmLRKCViWely/imMPZEbhEYUYv0E0W0mfsBENNOc2Iz6VkBFm7Y7EZ+oiIH0Zwjfw=
X-Received: by 2002:a17:902:7208:: with SMTP id ba8mr14269978plb.179.1593452347063;
 Mon, 29 Jun 2020 10:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200629085911.1676554-1-masahiroy@kernel.org>
In-Reply-To: <20200629085911.1676554-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jun 2020 10:38:56 -0700
Message-ID: <CAKwvOd=qe5KE1vdUYQmpsW2zmDbk5i-MgRujs9B7wqnAj+af0w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: make Clang build userprogs for target architecture
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:59 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Programs added 'userprogs' should be compiled for the target
> architecture i.e. the same architecture as the kernel.
>
> GCC does this correctly since the target architecture is implied
> by the toolchain prefix.
>
> Clang builds standalone programs always for the host architecture
> because the target triple is currently missing.
>
> Fix this.
>
> Fixes: 7f3a59db274c ("kbuild: add infrastructure to build userspace programs")

This is a neat feature I didn't know about; looks relatively new.
What's the test case command line invocation to test this with Clang?

> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 73948798ce3f..cac29cc2ec25 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -970,8 +970,8 @@ LDFLAGS_vmlinux     += --pack-dyn-relocs=relr
>  endif
>
>  # Align the bit size of userspace programs with the kernel
> -KBUILD_USERCFLAGS  += $(filter -m32 -m64, $(KBUILD_CFLAGS))
> -KBUILD_USERLDFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
> +KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
> +KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))

That should be fine.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

>
>  # make the checker run with the right architecture
>  CHECKFLAGS += --arch=$(ARCH)
> --


-- 
Thanks,
~Nick Desaulniers
