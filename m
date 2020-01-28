Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79551C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 03:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2682467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 03:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580182098;
	bh=BhyghtdmAWWwwJHjRxMEXePXbm1jy4jT8e09vApDRBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t6TNPv5euEIQLyXtKKQ+zWlMGORNIitZCVMk5+VC4pArSqapgS+Fi4As9NsPhL9hy
	 ZHCtfHsQzYhbBPl9ftjpSYyaiJqr0OIfhkVOZph45RLd+zlrvYPt8l6M16KoYhaPEz
	 HpElexmzXjch2epxi6vqGXP9NYM1BHS1TAhBJXgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA1D2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 22:28:16 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:42408 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1D2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 22:28:16 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 00S3S3Tm020546
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:28:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 00S3S3Tm020546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580182084;
        bh=jPg30W9Wd4V1k+r19IZv85tXWHy/WeE9O1ipLqP4Wa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPj6ubQBmkVGjEEQKh3kQ5BMIKfaMjT4WjNc2VVZ+e/FixOuiozeJbLJ5G7tIufSa
         7E4cM/QmC389xoRBRUhqtw2zKPfwrlo4Xzaz3WuxrfpVfxMnIf3/hqdZqw5tlXQwel
         V6IX6Bf8fkrXR+uJlC5KKjaW2LTEwRNgAlNgHXwJeAaHe1JHQccDYn/JlmBTtF+uS8
         BsBUazz29Twp6bHjHEk6fhuykfDUFXLo+EdU25wLJQgz+03fQIQE05CESWLLSF4THA
         tWYzIQWDginPR1NK9FSYn8DINIfU7roeNvQP9sF6ltlR7w4JGhJDFXIlEp6IurNAz4
         STy4TyIxJaDHA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id r18so7181941vso.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 19:28:04 -0800 (PST)
X-Gm-Message-State: APjAAAVAal2hb2tQsi4Lan+hKTe1vZuVFqgYM/w/6YCm76L5FHM53cha
        NJdICzJeaFIFRP1Qf1FJ8Qkqv/andIJhOMMdiig=
X-Google-Smtp-Source: APXvYqwGIUxHJH2LBGc/TLAR3nkqL69dSib07JC9anxXOAaH117GDjLj548pzb7bFWOb8NNbUUp9rV4BKO6PMGnMkfQ=
X-Received: by 2002:a05:6102:48b:: with SMTP id n11mr12542394vsa.181.1580182083009;
 Mon, 27 Jan 2020 19:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20200127193549.187419-1-brendanhiggins@google.com> <20200127193549.187419-2-brendanhiggins@google.com>
In-Reply-To: <20200127193549.187419-2-brendanhiggins@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Jan 2020 12:27:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASR13WjasKPmq-8gURhNUpOsrsCN2ODUh56fpM9DKWq7A@mail.gmail.com>
Message-ID: <CAK7LNASR13WjasKPmq-8gURhNUpOsrsCN2ODUh56fpM9DKWq7A@mail.gmail.com>
Subject: Re: [RFC v1 1/2] kbuild: add arch specific dependency for BTF support
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        davidgow@google.com, heidifahim@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, Jan 28, 2020 at 4:36 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Some archs (like UM) do not build with CONFIG_DEBUG_INFO_BTF=y, so add
> an options for archs to select to opt-in or out of BTF typeinfo support.


Could you use a different subject prefix (e.g. "btf:") ?

This is unrelated to kbuild.

Thanks.


> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  lib/Kconfig.debug | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e4676b992eae9..f5bcb391f1b7d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -238,9 +238,12 @@ config DEBUG_INFO_DWARF4
>           But it significantly improves the success of resolving
>           variables in gdb on optimized code.
>
> +config ARCH_NO_BTF_TYPEINFO
> +       bool
> +
>  config DEBUG_INFO_BTF
>         bool "Generate BTF typeinfo"
> -       depends on DEBUG_INFO
> +       depends on DEBUG_INFO && !ARCH_NO_BTF_TYPEINFO
>         help
>           Generate deduplicated BTF type information from DWARF debug info.
>           Turning this on expects presence of pahole tool, which will convert
> --
> 2.25.0.341.g760bfbb309-goog
>


-- 
Best Regards
Masahiro Yamada
