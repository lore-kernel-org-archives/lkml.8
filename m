Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7081BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EA7206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589503394;
	bh=/NpL6DlEyWzGjhr5R+16BHRJFbdGjA2sc8Fxxm5obkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pqgDfSa0LCOhpk9pxTVP53olszqZADFbWqPh5vqKxw0vi9VTr39tME8EWeQfwfR7T
	 XVUL0EFuS/XQ875rOqP7eHF+9FvOUgFsdzKHZAZPuJi9B3jwjVByIoFyDMoS9VIJTE
	 vbzwIgjWyJlPxjEHemyNCiKUkmKZx7jOUdiXAK3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgEOAnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:43:13 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:27817 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgEOAnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:43:13 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 04F0gj4E014765;
        Fri, 15 May 2020 09:42:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 04F0gj4E014765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589503366;
        bh=pAEN3YWmHNyYopbj1izroY7IInG57bR+xcNL9DJ7U3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jUdD7odt4QbNiGXOtO56JSC+BW18zigCwFPLvsmti85LWXAE+imjHQ2i+ctbYNWws
         sJazj4mrq2+S2SUm2vJKMVszoxYEWO5dYcshVz/H99bGa68xHkNw+zm40vuSWNMQFe
         dm6PamMzDNYAyiC3czcO6GGlcU16jrQoySlkwfutlYcP0fGhzR4TvqIP4LDLja+UfL
         iTJtH9/8Dkkhkal1+3Xs9RtnHGwKzlLeWr4IZY8rLt7eiRn9CkFqO7Y5+0sw091kCX
         ccZ9UoEZEo8ksOav4IQeYMv7LeJH+H46+6Zmjh4uBGMqoQz1/3IdgE+7GluRL9XpIY
         2Azfyv2++vZRg==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id i5so167025uaq.1;
        Thu, 14 May 2020 17:42:46 -0700 (PDT)
X-Gm-Message-State: AOAM530BAzGKoBXzteHHfFtg1bbrvABh+arunFrF+N8/jYwiOFKiPKHq
        1jlxSiZ2QZEfW4Hkly1SMLYM/2QSqdUJNRNdSHE=
X-Google-Smtp-Source: ABdhPJzsN7cd/eZ4oVWS6nFdHWvx5auTPBA1Z7gn70ARdC+yqVm9F2PM/OU4/ZP9QfPnzGgVpxzLc66XmLzWGeydfew=
X-Received: by 2002:ab0:7298:: with SMTP id w24mr973182uao.95.1589503365097;
 Thu, 14 May 2020 17:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <87imgykunh.fsf@m5Zedd9JOGzJrf0>
In-Reply-To: <87imgykunh.fsf@m5Zedd9JOGzJrf0>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 May 2020 09:42:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKz9Cu2aPxM2xo22Y_1b2+E1NQibi0ZgLRyGr5+ZLWoQ@mail.gmail.com>
Message-ID: <CAK7LNAQKz9Cu2aPxM2xo22Y_1b2+E1NQibi0ZgLRyGr5+ZLWoQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: compile_h: fix compiler version detection with clang
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 7:43 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>
>
> In some setup clang will print a line about CUDA version it detects,
> like this:
>
>     Found CUDA installation: /opt/cuda, version 10.1
>
> So grepping ' version ' matches 2 lines, and results in a broken string in
> compiler.h, which doesn't compile.
>
> This commit adds a "head -n1" to fix this problem.
>
> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>


I do not know what to do about this.


This problem had already been fixed by a different
patch, which is queued up in linux-next.

9a950154668729a472d17b8e307d92e7c60f45f7

This patch
https://patchwork.kernel.org/patch/11505803/

So, the future releases will be OK.


For back-porting to the stable kernel,
your one-liner fixup is simpler.




> ---
>  scripts/mkcompile_h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index 5b80a4699740..8e6b4fc6fdd9 100755
> --- a/scripts/mkcompile_h
> +++ b/scripts/mkcompile_h
> @@ -62,7 +62,7 @@ UTS_VERSION="$(echo $UTS_VERSION $CONFIG_FLAGS $TIMESTAMP | cut -b -$UTS_LEN)"
>    printf '#define LINUX_COMPILE_BY "%s"\n' "$LINUX_COMPILE_BY"
>    echo \#define LINUX_COMPILE_HOST \"$LINUX_COMPILE_HOST\"
>
> -  CC_VERSION=$($CC -v 2>&1 | grep ' version ' | sed 's/[[:space:]]*$//')
> +  CC_VERSION=$($CC -v 2>&1 | grep ' version ' | head -n1 | sed 's/[[:space:]]*$//')
>    LD_VERSION=$($LD -v | head -n1 | sed 's/(compatible with [^)]*)//' \
>                       | sed 's/[[:space:]]*$//')
>    printf '#define LINUX_COMPILER "%s"\n' "$CC_VERSION, $LD_VERSION"
> --
> 2.26.2



--
Best Regards
Masahiro Yamada
