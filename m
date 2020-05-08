Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791BDC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5085520708
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588916366;
	bh=s1QOfFaBR3ddl7wV1dbceN/IOgXnzOguwOOgiPfWhGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I5KzMMtZKhUKJvkeQGLRECQtYJqRHGwDjscrsIPNH9AzKLeskGVs9yPRJ3/omCVNN
	 d2uDTsLnX8dOV5IX5j69ZbSnosEqIdf27IsHsyHd38yPo9qKWwoCLviD4khmZkoCz7
	 w1VEDp/CKuH2STex3Z4L1DWz0DZaREM4BT8sCPy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHFjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:39:25 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:34644 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgEHFjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:39:24 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 0485dAgs031709
        for <linux-kernel@vger.kernel.org>; Fri, 8 May 2020 14:39:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 0485dAgs031709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588916351;
        bh=SqKr69BWgpV8udoi/Flc/nNEFYVLgHRZP6ZiW69HDQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BYPavCJdDx9mWU/oYwDFRkdGBtMHQLhI4ehXr7WRmITBv5v2PKwD6ptkpn1+Mu0id
         fpxv2lZJdBw1o8dCt9IL+D/bBPucLIKGMFI1RF4mq/6J7FtpcMwmlfpFvJN19e+Yu/
         ePIji5FU3kBkKasUqseZbbALnD8UmmbKG3p6XqgH8vnf2Avwzn2dX3hdmvl9TmaY/n
         xk4YPQAMW4c+ZsI3r46vCHHqoZtIFPiCKTsi+VZjBeg6olxm76MlcIq6dirxS8yjeH
         TtsLe7mvNkJO/kdnFZk3B8FZgw9v+egP/aM/pOmJrLOOJ6Xgx0NORotCq1xMgj3USf
         b9hP9EADz5xWw==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id w188so133393vkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:39:11 -0700 (PDT)
X-Gm-Message-State: AGi0PuZQJJN8IImKMWfR2KyxS4qLiVZsr7VKj/RutG+XYl8m9WtIORzv
        t7dvemuZrZTjg3jiVIGoFV/mPz8tQ4RhBWgVsuA=
X-Google-Smtp-Source: APiQypI+ysgFwE7foMEUn00XG6rjxwOrxSiDvC4blyElwPeN4nEuPDi2a6Z9H6Ggo5Ykk+k5HJ7Hyh0H5cf8GfdZ9hE=
X-Received: by 2002:a1f:1ed1:: with SMTP id e200mr501090vke.96.1588916350322;
 Thu, 07 May 2020 22:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <1588729957-19164-1-git-send-email-sidgup@codeaurora.org>
In-Reply-To: <1588729957-19164-1-git-send-email-sidgup@codeaurora.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 8 May 2020 14:38:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuhT-t81t86HwsYZkCp9kK3iOHX9VYtx=Hp18veFx3Dg@mail.gmail.com>
Message-ID: <CAK7LNATuhT-t81t86HwsYZkCp9kK3iOHX9VYtx=Hp18veFx3Dg@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: headers_install: Exit with error on config leak
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 10:53 AM Siddharth Gupta <sidgup@codeaurora.org> wrote:
>
> Misuse of CONFIG_* in UAPI headers should result in an error. These config
> options can be set in userspace by the user application which includes
> these headers to control the APIs and structures being used in a kernel
> which supports multiple targets.
>
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>

Applied to linux-kbuild. Thanks.

> ---
>  scripts/headers_install.sh | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index a07668a..94a8335 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -64,7 +64,7 @@ configs=$(sed -e '
>         d
>  ' $OUTFILE)
>
> -# The entries in the following list are not warned.
> +# The entries in the following list do not result in an error.
>  # Please do not add a new entry. This list is only for existing ones.
>  # The list will be reduced gradually, and deleted eventually. (hopefully)
>  #
> @@ -98,18 +98,19 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
>
>  for c in $configs
>  do
> -       warn=1
> +       leak_error=1
>
>         for ignore in $config_leak_ignores
>         do
>                 if echo "$INFILE:$c" | grep -q "$ignore$"; then
> -                       warn=
> +                       leak_error=
>                         break
>                 fi
>         done
>
> -       if [ "$warn" = 1 ]; then
> -               echo "warning: $INFILE: leak $c to user-space" >&2
> +       if [ "$leak_error" = 1 ]; then
> +               echo "error: $INFILE: leak $c to user-space" >&2
> +               exit 1
>         fi
>  done
>
> --
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project



-- 
Best Regards
Masahiro Yamada
