Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F572C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE1A20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9d3nGYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbgDBRkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:40:45 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34658 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390107AbgDBRko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:40:44 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so54600pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNj9UWy+adV8xUYOhsOn+0IPS9HHD1PHgo+3YUVx5tE=;
        b=j9d3nGYO+vImn9Ah56bhXrZY5ohVu3dkH9USmRV2WScjAPCWH8zRCrBp1U5+hzFaP1
         +CSS6P7LMyN8Bx0wBTHJz52pxR+7g4ZZGMU6wAvQKH38g3SvuAynX7g/hO7bHvL85grU
         MAQZnqjpjGOyuoyyW85+/dINzwUUZ4oKynDPOkWVbSuOflXn9ojlm0ut9LnLil6QK7oD
         g5TjrdMsBZhZMuIhUGzyGlJU+n0WWz/mmkVUawuY2ILtjQjGfRrASKzHVIFV+SFLrstI
         XyFqwz98+8hl8qMrm1y12zUCHZNBtbpErPSeWXs5iE3CCdUoSMyeslHSNMbW3SGO1Nxt
         0Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNj9UWy+adV8xUYOhsOn+0IPS9HHD1PHgo+3YUVx5tE=;
        b=AdnEMp8K8wXYb6HOXJpuATUCWbZQfil9GAPTJlZDV0qp72+uBjd7UZ7UbkCULMYRCH
         rTKAOpLOQahTORBG0v7gVVEU6FuY4eu3/ef5/m0OzqPdZw/p+y1SnhiFGQJTwG/IoytY
         1Dq2ta0ryP0WSot3u8EI7g2I31oZnsZiWh+c71Z9U62ca2dAJFyYmsWu2QStMnv7iTV+
         GExoDfJLQKZZxf2ITaNRElL0E+MTQGxKmc2mfB2qmrwr59SMBVxqAlT4orRJM1p0OkJq
         CrOzlMllcjXrGm0Q0vAVl8M7tAq9xXwVEiLHLQl5vnMEpOnHahChNBQH39C7/lP3FJ+A
         PJew==
X-Gm-Message-State: AGi0PuatoRsLRpW+bHVzgsyDpo5BCzvQxDXr6Avro6FiNTNpd2hYT6bn
        E4GqtS+TgRnwmZNqu+SN0d2EVqDkToMfvxlTIx1W6w==
X-Google-Smtp-Source: APiQypIdxa1oDQwUT8/HPtN0SsfP+74JHOVfIUEAdwj3kA0JfxTpxqsmYGp3noybOOAdNmZl81K8fAcmMCRbTmK/Pk4=
X-Received: by 2002:a17:90a:8085:: with SMTP id c5mr4564376pjn.186.1585849242863;
 Thu, 02 Apr 2020 10:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200402173842.96013-1-maskray@google.com>
In-Reply-To: <20200402173842.96013-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Apr 2020 10:40:31 -0700
Message-ID: <CAKwvOdkHugeJW8GOa_8Pf+axPnhFiy+4t0fsOyzp2hxaDE1NAw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: fix the name of llvm-size
To:     Fangrui Song <maskray@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 10:38 AM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> The tool is called llvm-size, not llvm-objsize.
>
> Fixes: fcf1b6a35c16 ("Documentation/llvm: add documentation on building w/ Clang/LLVM")
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  Documentation/kbuild/llvm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index d6c79eb4e23e..eefbdfa3e4d9 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -51,7 +51,7 @@ LLVM has substitutes for GNU binutils utilities. These can be invoked as
>  additional parameters to `make`.
>
>         make CC=clang AS=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \\
> -         OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-objsize \\
> +         OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size \\
>           READELF=llvm-readelf HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar \\
>           HOSTLD=ld.lld
>
> --

OBJCOPY -> llvm-objcopy
OBJDUMP -> llvm-objdump
OBJSIZE -> llvm-size

Oops, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
