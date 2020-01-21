Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F560C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165DB22314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579621728;
	bh=DUpbShRDZk77wf9a5sFr0KbTfoqZP+FLdQNx/0LbCEk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cXjfKDVYvEOnCCn9m2ulfbvwcNjQEjX+3NVLPCngx3JxZJyR1m94dj+M/GZBxCMN+
	 WoPdMlnZU3dsigk0iCLt4b5VW1zJrxqOtp+v7q4bwcs75ekf+nAVHZ6WkpKNyOvb5i
	 6bMKY99Pc6BC7FkpWf09T+f6pszcaKiCcLX5GJPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgAUPsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:48:47 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31965 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAUPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:48:46 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 00LFmVZ5030073;
        Wed, 22 Jan 2020 00:48:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00LFmVZ5030073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579621711;
        bh=AQixjuCf/K2yinVV7kbNbY8GPzh8pYfirh3DgFRibnM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A/iTfNBgx5abwHrCQ8gPT9r6KdQU3yuzLMR64VdCFadhD+5dSj5+XkIkOXOAyUxWH
         0N+hH1uO2DHsd/11/Gw/7kPdrfIn09oUELxVKgSlddBn2FzV2UELzTRe4Xgr5Hxw+d
         ESpQYyyFyOQX6x7ZfsrTLSdq7Saga8s4iOPzGzFG432Yr0lEvCyfsHiSN5q++mA819
         hpTeJzhaCnafmIjJvkTtbDfPmwx0wup7bUJVreUnuGBMbGsvA+0OiD/QFlmrRFhKt/
         cSldF/03yFQ3bGnyqVZFHU+WnJVEEAjO4q62gTajPmM/qBkKcOsjcTRIvM2zZIi5yo
         ewO6JM6DeUehg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id n27so2129896vsa.0;
        Tue, 21 Jan 2020 07:48:31 -0800 (PST)
X-Gm-Message-State: APjAAAVbfVYoHOROwFbKy7umrWtg5tMzlZEhvD7RdsW4FPMVUNjuuSjb
        877KsUm3zK9/zv8SvpqeLtNcSTw4vsYjD0p6DWM=
X-Google-Smtp-Source: APXvYqzFPBt0396as/v2vHEDcKSPiLCqJE9WLqjty6LmgZEzEUXvOREnxBxPaB47BBZc+knEEc99kn7oQcXqU4Ghu7I=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr3009157vsh.179.1579621710438;
 Tue, 21 Jan 2020 07:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20200117171435.11591-1-masahiroy@kernel.org>
In-Reply-To: <20200117171435.11591-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Jan 2020 00:47:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-jkwUT3qcuqZeKUhiDjTP_XuEK1qgjTwEoL00v+c07g@mail.gmail.com>
Message-ID: <CAK7LNAQ-jkwUT3qcuqZeKUhiDjTP_XuEK1qgjTwEoL00v+c07g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use -S instead of -E for precise cc-option test
 in Kconfig
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 2:16 AM Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
>
> Currently, -E (stop after the preprocessing stage) is used to check
> whether the given compiler flag is supported.
>
> While it is faster than -S (or -c), it can be false-positive. You need
> to run the compilation proper to check the flag more precisely.
>
> For example, when testing "--param asan-instrument-allocas=3D1", my gcc
> gives a different result for -E vs -S.
>
> $ gcc -Werror --param asan-instrument-allocas=3D1 -E -x c /dev/null -o /d=
ev/null
> $ echo $?
> 0
>
> $ gcc -Werror --param asan-instrument-allocas=3D1 -S -x c /dev/null -o /d=
ev/null
> cc1: error: invalid --param name =E2=80=98asan-instrument-allocas=E2=80=
=99; did you mean =E2=80=98asan-instrument-writes=E2=80=99?
> $ echo $?
> 1
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild.


>  scripts/Kconfig.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index d4adfbe42690..bfb44b265a94 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -25,7 +25,7 @@ failure =3D $(if-success,$(1),n,y)
>
>  # $(cc-option,<flag>)
>  # Return y if the compiler supports <flag>, n otherwise
> -cc-option =3D $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -E -x c /dev/n=
ull -o /dev/null)
> +cc-option =3D $(success,$(CC) -Werror $(CLANG_FLAGS) $(1) -S -x c /dev/n=
ull -o /dev/null)
>
>  # $(ld-option,<flag>)
>  # Return y if the linker supports <flag>, n otherwise
> --
> 2.17.1
>


--=20
Best Regards
Masahiro Yamada
