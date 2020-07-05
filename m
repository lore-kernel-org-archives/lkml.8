Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81024C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5589A207CD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593933346;
	bh=f/rNIq4FFnCrcB/xtn5iOzZ0AiF4Fg+dIpJ0iVbaWb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O85QcLyRnBJbWoPV0vWe4z5tO332QnDQxFOOvdmtPKo0y5vsxoaQFXQJKTCUmL/oG
	 VN8LDI+JMQ25Mwq6OKEmUTj26udNhUJkgXK03T1SREmWi9aX9wl39IZ5dnVcQHB5ea
	 gdvLQqOLKzEdpUx5rkIyrqMxOyOOipB+XOaJLkkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgGEHPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:15:43 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45461 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgGEHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:15:43 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0657FQaA008848
        for <linux-kernel@vger.kernel.org>; Sun, 5 Jul 2020 16:15:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0657FQaA008848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593933327;
        bh=PJbBbaILIqDMU0+WFa/cebDB6LQ6qs1/sFVhHjDojog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DztYS/OFv6CZAH6gMLid9ljSsXv51+9HftO79hMuMiC+MbsySwiJZJOVuuap7tu0k
         AoWeEb/0gnba6ITuPfFTHyuG5T+h1UdpyfRZQU/v5ucsTsL1WWSRCgi9FoeuMKx4Mu
         Sf6YNOtVk512EYojyEHNzdjgtvIVDJ6mcJWQF3SLb4hX+qoFVS0JxEbBT82NKffero
         8DL8OWq5YhQQchQNYnnuqrunytvSTtZT8LaHTza9ST2SghmRaeTePNnrlQVCdAHoB1
         xBbe14bJ3UhSt9mHKDegcuaj+yh/Y1RPzSZpLtT1mTjUGSnJShWGGulxeU/2PD9nKt
         Xqd58vRUYSZFw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id r5so18990513vso.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 00:15:27 -0700 (PDT)
X-Gm-Message-State: AOAM5307fQw+fOKuy9EdgiplCO9Emfy4VnP9tIIs76Ip0zdWwUFW2JZ2
        zLb0msc0n+wrjvb17bvG/xvOjk4YXOrR3sTcU84=
X-Google-Smtp-Source: ABdhPJxoLHYsKXWsTIEqU/6wKKc4PjKSkrPLKcd+zilvxky/rrk5sej6VNbPewjUUAHaoBnXyoEZDJaMRuJFji/P+8Q=
X-Received: by 2002:a67:6c84:: with SMTP id h126mr29235849vsc.181.1593933325977;
 Sun, 05 Jul 2020 00:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Jul 2020 16:14:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7=NCsJ5irVUCStkfCLt0d=R5AX6cEwc9z=b_-V=-0Ng@mail.gmail.com>
Message-ID: <CAK7LNAR7=NCsJ5irVUCStkfCLt0d=R5AX6cEwc9z=b_-V=-0Ng@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: Do not track `defconfig` from `make savedefconfig`
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:12 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Running `make savedefconfig` creates by default `defconfig`, which is,
> currently, on git=E2=80=99s radar, for example, `git status` lists this f=
ile as
> untracked.
>
> So, add the file to `.gitignore`, so it=E2=80=99s ignored by git.
>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 87b9dd8a163b..f07500889fba 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -143,6 +143,9 @@ x509.genkey
>  /allrandom.config
>  /allyes.config
>
> +# Kconfig presets, default savedefconfg output


I just noticed this comment is wrong
since 'defconfig' is not a preset.

I will change it to 'Kconfig savedefconfig output'.

Thanks.


> +/defconfig
> +
>  # Kdevelop4
>  *.kdev4
>
> --
> 2.27.0
>


--=20
Best Regards
Masahiro Yamada
