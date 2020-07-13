Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE6C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D4720738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGMTLD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:11:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41190 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:11:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id y22so11882375oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MpVvhG0JVWd5ZaN/xljEJTQI0xBB2N/Pxsg6vh3TZC4=;
        b=UOYXW6X7yUaLaWtccEf4RF4eVRZp9+XzkO9tP1sMJTozX7Iq0AuKsIcjT60pIjO3sU
         UbYvTOGQGnyQvRDTz92O0T5HOxEVRHhHZzzSf+L6C9DRhfz0TZo8S+7FK+W3WQvrOhlK
         XaOioiHWR/IQYxvPnK+aIRZSeArvsgBP7V3raxd8ZwHxIcTHMhnNqUGtwCWsnpEf0SZ1
         9o4eTJGdV8ocI/A3ZJlcBnxstU0C/NNfValEXb63YqrZYaSdghFJMu+QURA4KbtNTrs0
         nyCbqzGU0CGZiHAhQ/EBL6V0eDdu/wUhoEob0ZHZn+tC3eHd530qpEFrXRZCUTFj0X2w
         ry0g==
X-Gm-Message-State: AOAM531yMevlWTqcdpQ6z2u6Z4+qGtEG5KkWTSYwKCmAhdQ4cKLGozlX
        AuEnBfDYheR4csrWWwBgkygl5v09oKFjqRiwyrg=
X-Google-Smtp-Source: ABdhPJxXxNw9aVYGctt6r8N5ny/jPyJ3Am7BlJCr1kAkrVfQt2JDGZfW2anQv3ymH75eJgtSxSQWLRuOH0va5OE+Zvk=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr829631oih.54.1594667462193;
 Mon, 13 Jul 2020 12:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-2-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-2-lee.jones@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jul 2020 21:10:51 +0200
Message-ID: <CAMuHMdVaO3gABJxRzBL+2U9axfAuBLRghSY0vCc9f8a6huiYZg@mail.gmail.com>
Subject: Re: [PATCH 01/10] misc: c2port: core: Ensure source size does not
 equal destination size in strncpy()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Rodolfo Giometti <giometti@linux.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Fri, Jun 26, 2020 at 3:06 PM Lee Jones <lee.jones@linaro.org> wrote:
> We need to ensure there's a place for the NULL terminator.

But who's filling that space with a NUL (not NULL) terminator?

> Fixes the following W=1 warning(s):
>
>  In file included from include/linux/bitmap.h:9,
>  from include/linux/nodemask.h:95,
>  from include/linux/mmzone.h:17,
>  from include/linux/gfp.h:6,
>  from include/linux/umh.h:4,
>  from include/linux/kmod.h:9,
>  from include/linux/module.h:16,
>  from drivers/misc/c2port/core.c:9:
>  In function ‘strncpy’,
>  inlined from ‘c2port_device_register’ at drivers/misc/c2port/core.c:926:2:
>  include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
>  297 | #define __underlying_strncpy __builtin_strncpy
>  | ^
>  include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
>  307 | return __underlying_strncpy(p, q, size);
>  | ^~~~~~~~~~~~~~~~~~~~
>
> Cc: Rodolfo Giometti <giometti@linux.it>
> Cc: "Eurotech S.p.A" <info@eurotech.it>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/c2port/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> index 33bba18022892..80d87e8a0bea9 100644
> --- a/drivers/misc/c2port/core.c
> +++ b/drivers/misc/c2port/core.c
> @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
>         }
>         dev_set_drvdata(c2dev->dev, c2dev);

c2dev is allocated using:

        c2dev = kmalloc(sizeof(struct c2port_device), GFP_KERNEL);

hence the allocated memory is not zeroed.

>
> -       strncpy(c2dev->name, name, C2PORT_NAME_LEN);
> +       strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);

strncpy()
  1. does not terminate the destination with a NUL if the source length
      is C2PORT_NAME_LEN - 1,
  2. fills all remaining space in the destination buffer with NUL characters.

So c2dev.name[C2PORT_NAME_LEN - 1] always contains an uninitialized
value.

Now, it seems the only caller of c2port_device_register() passes
"uc" as the name.  Which means in practice c2dev.name[] will be
NUL-terminated. However, the last byte will still be uninitialized, and
if the buffer is ever copied to userspace, your patch will have introduced
a leak.

>         c2dev->ops = ops;
>         mutex_init(&c2dev->mutex);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
