Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BE8C433FB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FE7206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595611373;
	bh=r2bvTgJVFOy2nvuFGj5HP3nR/6u1hmTETRYmwF6GqF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1iph6kho4rRP2dXYUSCxPmnZas1fi0MLI1RhHjn2at9uk2jR1jnc6dxE6ypNXfvVY
	 /9cCSwUbVQU674gzsZArU9oZhfbDRE4vZwoUjiZxeZLnG7lI4ZX91xqM6BTuAc+snH
	 TFNOXZINJuPtodojQiDtlv3tBx7JinKSdEMXnpx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgGXRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:22:51 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:30769 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGXRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:49 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 06OHMPw1031479;
        Sat, 25 Jul 2020 02:22:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 06OHMPw1031479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595611346;
        bh=LWMEPECGL2KW6K1W/e+nfX6uJGebj/WZA9gxTGugdzo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qyv5xd2ljXpyciIB+0OqabxFlqkAGXGfJQ9FGmI9cpwkpJYvBOIcvjI5etfx+cYof
         lTu50cvr0EvfB7YT/1JdajQ21jcntjKrm7N0cTgLBsIil8WWYYHCV+jNCN90cPps7B
         ndiDPKmSdfTKqrt0z4hQj94SnDkbtiIBfgUsLm3+5slde/dh83rNWv4XQFDEi72QsJ
         wQVigobjrPG0bra/E7R3iKDeHJkQFKwL2nzlyyC5Vie4Z09Ouuf/bN4S3GDlyA0k66
         uXnHqvMuVhiyrXeTMU3LXP7VKmClxM1YsblgBG966xuJbD3zLnuJfbfBvjWKbQhbxF
         qp5ELz6VrYQ9g==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id p6so3177012uaq.12;
        Fri, 24 Jul 2020 10:22:26 -0700 (PDT)
X-Gm-Message-State: AOAM531M4kgMBcE3X9ByWvCCmnpv7fjNmSHRKmB8hhIbdB17fPVOrjTf
        PLIZ7A03+foEPbMt+lq5inSXQ5EUGzHVMP0ISek=
X-Google-Smtp-Source: ABdhPJxbjvpAaJiZ5L5sJbMXAn13ZFEXyR/FxrgcsToH6oJqNRKWx2ujUIdsWuyibk+0/voJmJm+Oi6qkmN+5yeLkmA=
X-Received: by 2002:ab0:71d3:: with SMTP id n19mr9059170uao.25.1595611345151;
 Fri, 24 Jul 2020 10:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200722053417.5915-1-jcmvbkbc@gmail.com> <20200722053417.5915-3-jcmvbkbc@gmail.com>
In-Reply-To: <20200722053417.5915-3-jcmvbkbc@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Jul 2020 02:21:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtFJidvPTJSP3JE0c=xPq4vegvCRETbO0n5TQeb+j6KA@mail.gmail.com>
Message-ID: <CAK7LNAQtFJidvPTJSP3JE0c=xPq4vegvCRETbO0n5TQeb+j6KA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xtensa: add uImage and xipImage to targets
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:34 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> uImage and xipImage are always rebuilt in the xtensa kernel build
> process. Add them to 'targets' to avoid that.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


>  arch/xtensa/boot/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
> index 801fe30b4dfe..f6bb352f94b4 100644
> --- a/arch/xtensa/boot/Makefile
> +++ b/arch/xtensa/boot/Makefile
> @@ -18,6 +18,7 @@ export BIG_ENDIAN
>
>  subdir-y       := lib
>  targets                += vmlinux.bin vmlinux.bin.gz
> +targets                += uImage xipImage
>
>  # Subdirs for the boot loader(s)
>
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada
