Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB03C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EF9206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHZJHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:07:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36117 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgHZJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:07:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id x24so929890otp.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCgdszg+UDbPAT++dmMRAeFSvMyoZiAg0p8cGDxBeXA=;
        b=URvpSH5MdnxF4/D5EmkYTyU545P/hunAd6e7+146PuS8NFespW1m9LkHN3TTS9FJe4
         UWntCc4oaV1mR/148buKH7x7zlEYY79aagEN47/AP6lpzxSVwUkGu0l/pp75FaWfi5hW
         obhcFULNfgVfoTjSSn43DDTBJyG34kFqgcWnCEUiOCkEWdGHL6MXzoEtS9KaSm1D3MJm
         lOYt+cBOoxSbIGo6QRGWq7voxXbcMJjo32c8oA2ECBLk+dOwYugOKayd54uXokvi0INM
         GhceqUG6Tl4k9fUImuG7YhAHlbXewVNrmTCx909g2IFjMt6/UmHnrC3eaxH64fEKzGaL
         3zlQ==
X-Gm-Message-State: AOAM531g9/+uOcbNBgxkiQeD9QlTJRdKrr/Fq6lJM3CNdHkQMycTdAa6
        MccqWFp4ysbTuS/+fASujaqrYFuZcV0+5PcTPj0=
X-Google-Smtp-Source: ABdhPJz/V9TF3DtKRsO706Gjnv1cdrtKt4MphsCq88tyd7IS2DJEHZObzq9y6iSw60e6ZK0QgK+6jiW4XNaNSxOHEEs=
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr8650513otb.107.1598432847127;
 Wed, 26 Aug 2020 02:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200728022746.87612-1-miaoqinglang@huawei.com>
In-Reply-To: <20200728022746.87612-1-miaoqinglang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Aug 2020 11:07:15 +0200
Message-ID: <CAMuHMdWfqh_AKyE+od_0yVPP6Lkv8LUAR1dWf8Df94W7b4qxLA@mail.gmail.com>
Subject: Re: [PATCH -next] m68k/amiga: missing platform_device_unregister() on
 error in amiga_init_devices()
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qinglang,

On Tue, Jul 28, 2020 at 4:24 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:
> Add the missing platform_device_unregister() before return
> from amiga_init_devices() in the error handling case.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Thanks for your patch!

> --- a/arch/m68k/amiga/platform.c
> +++ b/arch/m68k/amiga/platform.c
> @@ -188,8 +188,10 @@ static int __init amiga_init_devices(void)
>                         return PTR_ERR(pdev);
>                 error = platform_device_add_data(pdev, &a1200_ide_pdata,
>                                                  sizeof(a1200_ide_pdata));

The only reason why platform_device_add_data() can fail is because the
system ran out of memory.  If that's the case this early, the whole
system will fail to work anyway, and it doesn't matter that the IDE
driver will crash later due to missing platform data.

So I don't think it helps to increase kernel size by adding more error
handling.

> -               if (error)
> +               if (error) {
> +                       platform_device_unregister(pdev);
>                         return error;
> +               }
>         }
>
>         if (AMIGAHW_PRESENT(A4000_IDE)) {
> @@ -199,8 +201,10 @@ static int __init amiga_init_devices(void)
>                         return PTR_ERR(pdev);
>                 error = platform_device_add_data(pdev, &a4000_ide_pdata,
>                                                  sizeof(a4000_ide_pdata));
> -               if (error)
> +               if (error) {
> +                       platform_device_unregister(pdev);

Likewise.

>                         return error;
> +               }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
