Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FD7C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E5B24698
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 13:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgARNSe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 08:18:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgARNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 08:18:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so25161573wrj.12;
        Sat, 18 Jan 2020 05:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3M4ZjZLxqwNY1d3VEgK180VUD4b24X/dDEbhOgpWU6g=;
        b=SwRFDk/Gp+sL2UjCHAIKjbjiXeKR9cryRJiZ9L18P1Kj2ptt0NegAJetZVEIWUVR0Z
         cEeml+cJo28i7Y9LvCjelMARnkrRzDaOJIn0CXP4mw2OD8U36IFfNB7PWBohVMmjEn0V
         S9VLXrT5SnldvNqW2wOrJBX8K2p3LcUGzUO/K1e1Um/Qfei2tHjDZTug2lZUB5T0M/57
         SQWh8JfbEk8Tc/s7J+kfl21SzjSyQFdXPZuTSvIbxMIKUIzfXdBbc2cqUpoUwHEssiVF
         rz+KNjYMxZvclDEtyspvYdEx0kj5X+QKYTIou+yN9UT3KPCBWUbk/TInnQuRQPG5/HC7
         DeMQ==
X-Gm-Message-State: APjAAAUvAdSs+/HBxeUAoR6QSKYMiv4BMXNoi/aQ0U40pss6USELg4Ac
        O/s/1WFtyDeCuq3fN/fuer7rSyDsO1MX8ePHfCUvI8UG
X-Google-Smtp-Source: APXvYqxR/GvQvWoRh2G02bIHuRXJTaoflf3QgcqLAkmSYEKLZ92iFEDEakk266yNKrASQAL5RTz33vE+6RVjrPOu0P8=
X-Received: by 2002:adf:90ee:: with SMTP id i101mr8265714wri.417.1579353511444;
 Sat, 18 Jan 2020 05:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20191106120219.15028-1-alexandru.ardelean@analog.com> <20200116132901.23977-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200116132901.23977-1-alexandru.ardelean@analog.com>
From:   =?UTF-8?Q?Micha=C5=82_Nazarewicz?= <mina86@mina86.com>
Date:   Sat, 18 Jan 2020 13:18:20 +0000
Message-ID: <CA+pa1O1bCTgAg=7MFYsF1o2P2UTvppt92x0GfzVvDZ1+Ch-74Q@mail.gmail.com>
Subject: Re: [PATCH][RESEND] usb: gadget: ffs: ffs_aio_cancel(): Save/restore
 IRQ flags
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 at 13:27, Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Lars-Peter Clausen <lars@metafoo.de>
>
> ffs_aio_cancel() can be called from both interrupt and thread context. Make
> sure that the current IRQ state is saved and restored by using
> spin_{un,}lock_irq{save,restore}().
>
> Otherwise undefined behavior might occur.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 6f8b67e61771..bdac92d3a8d0 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1162,18 +1162,19 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
>  {
>         struct ffs_io_data *io_data = kiocb->private;
>         struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
> +       unsigned long flags;
>         int value;
>
>         ENTER();
>
> -       spin_lock_irq(&epfile->ffs->eps_lock);
> +       spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
>
>         if (likely(io_data && io_data->ep && io_data->req))
>                 value = usb_ep_dequeue(io_data->ep, io_data->req);
>         else
>                 value = -EINVAL;
>
> -       spin_unlock_irq(&epfile->ffs->eps_lock);
> +       spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
>
>         return value;
>  }
> --
> 2.20.1
>


-- 
Best regards
ミハウ “𝓶𝓲𝓷𝓪86” ナザレヴイツ
«If at first you don’t succeed, give up skydiving»
