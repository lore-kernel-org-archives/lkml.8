Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526ADC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCCB20663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asti5zcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCXTn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:43:59 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39685 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgCXTn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:43:58 -0400
Received: by mail-pj1-f66.google.com with SMTP id ck23so1938463pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMwuWt/x8/Lg/gYGKLGY8KESJf2qihGpVN/AvMGP9WM=;
        b=asti5zcyxi28k2F7jzWQqNDZhd7jAk3HIjrN+7+lNozgmuUhj2ejp/YKgjNdMHz7AU
         rozgOmx1ZrcUcvvruvJAVMB/hoG3GRUY1SrRjw2dczW3NWYbnFvgf3noCIUunm7FgFDK
         bWXwF1YShJ50ug40s4xkd8f1Gww+vUp3XyX3AezKCypjnNxpq3TIQ6zyvIhaDg2QscZE
         sNLDKUlC7xJ45ljaKpB0JCbIUe4SQbNGsyPfQpKmIq1379FCdzXp0jF8xDlGgR91ghy9
         I4semSDRHhydpmbihRT7dzkwleFViqPBodmko9HKxFsz17JpJnDbDX61Rep/3ur4Oqqe
         NBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMwuWt/x8/Lg/gYGKLGY8KESJf2qihGpVN/AvMGP9WM=;
        b=q5XcsMmbyCayU0dQ4KHIPVBbOfqcdCPc8BhY6AfQtF5FHfNEmmo/Y+G3bW1s/bdCKR
         BZ4SLQEU9v3jvvG55KPiXSDv8xLGKKLM2rPUptGxMmE6zvvl4bzgRWMBSVE/LE2u7Iyh
         WEM70YZ2NCNv80vX7Y22Fi83b04Bqrp3AkrWim2AMyGL4JWjjVLn+/c9FyRVz9p+tBlw
         ImyYOhSvdXhW450nj4h/3pT609CWv8fKhm9NupsUEGvzfztedCXRUZHyh6C789luoC7O
         /w1EPijB/5Hjf2YbH2SdNeBJc/HQQ+bqH3tb8EO1S4oiy8Xfr9EHbCRevA9dcmQcffc/
         oTjw==
X-Gm-Message-State: ANhLgQ3FRfTtkMk2pYFIFQ99p9oAEdRSS0T4NL/FaUupjUAz3FF1UunH
        we/hY062uZLnPApWIUgQeXH/uCcib6ZA3oLZJWEHng==
X-Google-Smtp-Source: ADFU+vtvL1sQaYU3l4knK4Hv8fnNBDm40WQmov2Ui0KB+bXxFAzhuxGuCrTB+C8ULDqyjJFc4Lcfu8NZI33UvVjU7ZA=
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr6067812pjb.27.1585079036745;
 Tue, 24 Mar 2020 12:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200324161507.7414-1-masahiroy@kernel.org>
In-Reply-To: <20200324161507.7414-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 12:43:46 -0700
Message-ID: <CAKwvOdkLW=Q5-vaFZDY_UOy66ZZoR7yaSd2zKv8N2Gv8PvJgYw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove AS variable
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just noting that this got rolled up into a 3 patch series:
https://lore.kernel.org/lkml/CAKwvOdkjiyyt8Ju2j2O4cm1sB34rb_FTgjCRzEiXM6KL4muO_w@mail.gmail.com/T/#u

On Tue, Mar 24, 2020 at 9:15 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> As commit 5ef872636ca7 ("kbuild: get rid of misleading $(AS) from
> documents") noted, we rarely use $(AS) in the kernel build.
>
> Now that the only/last user of $(AS) in drivers/net/wan/Makefile was
> converted to $(CC), $(AS) is no longer used in the build process.
>
> You can still pass in AS=clang, which is just a switch to turn on
> the LLVM integrated assembler.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 16d8271192d1..339e8c51a10b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -405,7 +405,6 @@ KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>
>  # Make variables (CC, etc...)
> -AS             = $(CROSS_COMPILE)as
>  LD             = $(CROSS_COMPILE)ld
>  CC             = $(CROSS_COMPILE)gcc
>  CPP            = $(CC) -E
> @@ -472,7 +471,7 @@ KBUILD_LDFLAGS :=
>  GCC_PLUGINS_CFLAGS :=
>  CLANG_FLAGS :=
>
> -export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
> +export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP OBJSIZE READELF PAHOLE LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200324161507.7414-1-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
