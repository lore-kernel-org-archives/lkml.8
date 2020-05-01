Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E914EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2831208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 05:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588311402;
	bh=ITHgm7CVZM9N9q691dn/C1/xpfMwGz/lhM+iQqln9B4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fw+xQp1LcY1YiGqLGpSFbp0Pm7/lTZHtOde3lIvMlsfHZZeAJkSChoH88rMr0IGY4
	 fp8Dp8R4E1Y1ekzhUlJwJcn9CDLcCyToj/lYL3NAlOLJSCYP5xV2hwfgUQUjx+7IEh
	 ceWThykjn9OpaGeXy+7V44wUoz+/HIDBd9v062f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEAFgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 01:36:42 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54653 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgEAFgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 01:36:41 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0415aK9l020039;
        Fri, 1 May 2020 14:36:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0415aK9l020039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588311381;
        bh=rvnQE9b4dBvxYjO6+FOTAfe9JaZnZPEijbvL8xA4ur0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SwMzvfc7seIj2p20Jm2pxYwiKU5BY6zxSNDYxYyuFmRqQn7xZBSpYJgRvQwn3WTMj
         zJUtAztUhZes7rjIhfdhnmnDWlXQzq4dVv/2On1kMJOH+OFiEyt6f9AHORPfsia4iS
         Vh8mdsHCjOK2qIjsKIOXVYXOlFzilN1CD9BCM/o2cNBN2NbcaY6ykyxjHRw8/xu3pM
         G20/FD2kjQxJW+kaYZWjS1vWNBljPK1tTTeAt7PEPodgtjSnjHhXiDIvYx3esj13HB
         Fwj/hhhL+p+UuSth3OEWfVUNv1X2Ai9bf5KoS80kOH8DtkBfjLlAaJAKXpo7jYxDJm
         OB6x7mGw6/QyQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id b5so5747868vsb.1;
        Thu, 30 Apr 2020 22:36:20 -0700 (PDT)
X-Gm-Message-State: AGi0Pubk8aJspkE+rJ/embh7bC2Gf1Lp5w7eOjEIjF0Kz0VEdSv4qn+q
        UhKLaEK0yqBc1m8g1KGvufuPQO/ekNI0s9x1aIg=
X-Google-Smtp-Source: APiQypIX+UaDnFMep97CoNrJiHdvF2WLqZvYHRqdBtSlFk2z5Zo4PKfuCTRYLBL6eouslJJkIBeR2hajT9eyPcz2Ab4=
X-Received: by 2002:a67:6e07:: with SMTP id j7mr2052547vsc.181.1588311379700;
 Thu, 30 Apr 2020 22:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200425060640.823362-1-masahiroy@kernel.org>
In-Reply-To: <20200425060640.823362-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 May 2020 14:35:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvEWRnEA-ewRWGqGrqOzav-ONvEXw2Q7dVwDLQ+u9xww@mail.gmail.com>
Message-ID: <CAK7LNATvEWRnEA-ewRWGqGrqOzav-ONvEXw2Q7dVwDLQ+u9xww@mail.gmail.com>
Subject: Re: [PATCH] unicore32: do not evaluate compiler's library path when cleaning
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Guan Xuetao <gxt@pku.edu.cn>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 3:07 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit a83e4ca26af8 ("kbuild: remove cc-option switch from
> -Wframe-larger-than="), 'make ARCH=unicore32 clean' emits error
> messages as follows:
>
>   $ make ARCH=unicore32 clean
>   gcc: error: missing argument to '-Wframe-larger-than='
>   gcc: error: missing argument to '-Wframe-larger-than='
>
> We do not care compiler flags when cleaning.
>
> Use the '=' operator for lazy expansion because we do not use
> GNU_LIBC_A or GNU_LIBGCC_A when cleaning.
>
> Fixes: a83e4ca26af8 ("kbuild: remove cc-option switch from -Wframe-larger-than=")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>


Applied to linux-kbuild.


>  arch/unicore32/lib/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/unicore32/lib/Makefile b/arch/unicore32/lib/Makefile
> index 098981a01841..5af06645b8f0 100644
> --- a/arch/unicore32/lib/Makefile
> +++ b/arch/unicore32/lib/Makefile
> @@ -10,12 +10,12 @@ lib-y       += strncpy_from_user.o strnlen_user.o
>  lib-y  += clear_user.o copy_page.o
>  lib-y  += copy_from_user.o copy_to_user.o
>
> -GNU_LIBC_A             := $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libc.a)
> +GNU_LIBC_A             = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libc.a)
>  GNU_LIBC_A_OBJS                := memchr.o memcpy.o memmove.o memset.o
>  GNU_LIBC_A_OBJS                += strchr.o strrchr.o
>  GNU_LIBC_A_OBJS                += rawmemchr.o                  # needed by strrchr.o
>
> -GNU_LIBGCC_A           := $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libgcc.a)
> +GNU_LIBGCC_A           = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libgcc.a)
>  GNU_LIBGCC_A_OBJS      := _ashldi3.o _ashrdi3.o _lshrdi3.o
>  GNU_LIBGCC_A_OBJS      += _divsi3.o _modsi3.o _ucmpdi2.o _umodsi3.o _udivsi3.o
>
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
