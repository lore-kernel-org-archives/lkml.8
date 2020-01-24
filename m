Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BBCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FC32072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMEGJDXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbgAXNnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:43:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43294 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387395AbgAXNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:43:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so1135721lfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vM9NxQR0ujnIvLGT7DQiVM7HfIlfrM31EsC/Rw16dw=;
        b=UMEGJDXM78qLcTTyc7ssbIuEA+CQkWtMfc1V9CUxGLyLBoOCNIHObJEcGCh1JqPvbq
         SezO5E/p0c+y3w2Vi10zUQX4Vx6IqCCu2juGYQT73hNhwRkpO+z85+0CJnyotW0z5Fj1
         9hw9/blLyI8JTP14f9EMlGGF02dcJ2Pr0LiSBPlNC1jO19hSzS79ExjqpCjT4K/wag8y
         hfR4q+0SyjYTGX6lmbqF1KxHuF883frOpe7os8SoY/zDvhkmRZR6JjXtm3wPj+d6+xfR
         IwFmQuKGDsgt6th8WRmqXZj6PfLzeyKwuls+CPrdUmemXRj1lFC5Qn06rTc+SzDVB1Kv
         h17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vM9NxQR0ujnIvLGT7DQiVM7HfIlfrM31EsC/Rw16dw=;
        b=c7Ns4OoBvBR9IK/oMgue1nT8B1q/m0M/A/Obdn7sNjOAyrIhegWgEg3Q/StCECCXH4
         clPesuKI+usIiMOI0OTCwScTU8Ikw/QQu3eftNC01Y1rOpyKfqyOsKYKf98wrNoxS6qA
         +DbvGfveblvPP1Su769nwgeK70ez8pjehStN2tyO6FQIbNBZpgjo2fSvf/LjIRzx4naP
         d4bRTiId2jzq41Bpv19d1dC0hkkHRNDLL0v2XadAdsJaK8MWdf/pXDPBY+GcMmM5C4T6
         0n9G+xS9T7YSVqyn0MwFp0YXG+Ap9ln+QHBtwCmaqEqEK9Ws0D8Rsc70dsCYYX8dIRbw
         Dy2w==
X-Gm-Message-State: APjAAAVJYQ6S8fflsQ4FW95ec46fxETAtIm9vprSumPqQCq5I3XT0q/N
        wDNitaYeqSzqza/vq2+rjjNsKgUyrkgK0D91nwF3WA==
X-Google-Smtp-Source: APXvYqyNlGr0EHQRCpzcFlmkBR1ZbUk0dh6CQ4vh3ieW3+EsqRNfYyWa1h3syYEuH1U9FNfwj+R1ToYiFr7ma74TUK8=
X-Received: by 2002:a05:6512:64:: with SMTP id i4mr1407230lfo.55.1579873419310;
 Fri, 24 Jan 2020 05:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20200124092806.004582306@linuxfoundation.org> <20200124092807.172946256@linuxfoundation.org>
In-Reply-To: <20200124092807.172946256@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Jan 2020 19:13:27 +0530
Message-ID: <CA+G9fYupGFyHCjikJqwiW5Y6_G+vqnn07Fgx50+=u2OKrrNyog@mail.gmail.com>
Subject: Re: [PATCH 5.4 007/102] libbpf: Fix call relocation offset
 calculation bug
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<trim>
> Fixes: 48cca7e44f9f ("libbpf: add support for bpf_call")
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Link: https://lore.kernel.org/bpf/20191119224447.3781271-1-andriin@fb.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  tools/lib/bpf/libbpf.c                             |    8 ++++++--
>  tools/testing/selftests/bpf/progs/test_btf_haskv.c |    4 ++--
>  tools/testing/selftests/bpf/progs/test_btf_newkv.c |    4 ++--
>  tools/testing/selftests/bpf/progs/test_btf_nokv.c  |    4 ++--
>  4 files changed, 12 insertions(+), 8 deletions(-)
>
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1791,9 +1791,13 @@ bpf_program__collect_reloc(struct bpf_pr
>                                 pr_warning("incorrect bpf_call opcode\n");
>                                 return -LIBBPF_ERRNO__RELOC;
>                         }
> +                       if (sym.st_value % 8) {
> +                               pr_warn("bad call relo offset: %lu\n", sym.st_value);

Perf build failed on stable-rc 5.4 branch for arm, arm64, x86_64 and i386.

libbpf.c: In function 'bpf_program__collect_reloc':
libbpf.c:1795:5: error: implicit declaration of function 'pr_warn';
did you mean 'pr_warning'? [-Werror=implicit-function-declaration]
     pr_warn("bad call relo offset: %lu\n", sym.st_value);
     ^~~~~~~
     pr_warning
libbpf.c:1795:5: error: nested extern declaration of 'pr_warn'
[-Werror=nested-externs]
Makefile:653: arch/arm64/Makefile: No such file or directory
cc1: all warnings being treated as errors

build links,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.4/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/69/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.4/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/69/consoleText
