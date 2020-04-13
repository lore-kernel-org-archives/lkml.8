Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB622C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786CD2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586773863;
	bh=h01TVcjgIHX6FUskz6JjMnvCNlJroUk4jJme6wnS/LE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GDx5LYGn0IjvlQP9w6O52HzMb8HzeFKz2xxW+S4NuZpMRPWM1VMtCH3+p9UziNrij
	 hfsRXFKGdpm4G0t+3hvvUlWRFOz+2vuAiaYr9j8dvU0qyRWxm06Xf8b8gNigTMZfPQ
	 kEKYBT8D/S1lFWdKscur8Wqx4/k/tEt/GLSBoswI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgDMKbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgDMKbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:31:00 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6FB52054F;
        Mon, 13 Apr 2020 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586773859;
        bh=h01TVcjgIHX6FUskz6JjMnvCNlJroUk4jJme6wnS/LE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RrcG67ZJ3fAFvV98m4dH/lsCLeCQwwZzOqvt0QqkgSnLtSWRpwJw/OUZITKOHL2OF
         jUEqOPPAW0lzg8HIjIN87BNqQdLQIE2p+levrK3VTnqcr6RveBoc2R4sKQ83ZoI8L0
         d+lqceYmVIy9MISfjBDFNYGYgIUGQD6FWtkBzA3g=
Received: by mail-io1-f47.google.com with SMTP id m4so8845768ioq.6;
        Mon, 13 Apr 2020 03:30:59 -0700 (PDT)
X-Gm-Message-State: AGi0PuaOjnc36AyxV+BqVTLIeID8Geu36iPo2F6Ju5+FCoPUcVI0rSeW
        Jt/FxbVQIMwFfW+bp9y9EFttM4lL85vdVmUOv/o=
X-Google-Smtp-Source: APiQypLM+RPRw2HjmV6vMWpCCz4MDGssnyHG/JuEqFYXykihcZ7dZZiO4o2bl6Jdx+Ty9fIVUVnXLTXKPM1pK8qkJSU=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr4297625ioh.203.1586773859224;
 Mon, 13 Apr 2020 03:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200412024927.GA6884@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200412024927.GA6884@dhcp-128-65.nay.redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 13 Apr 2020 12:30:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGA-VJdzkWMtWjrXt5HCDmRxdG0YqsoiRUQQS8SL1=Txw@mail.gmail.com>
Message-ID: <CAMj1kXGA-VJdzkWMtWjrXt5HCDmRxdG0YqsoiRUQQS8SL1=Txw@mail.gmail.com>
Subject: Re: [PATCH] efi/earlycon: fix early printk for wider fonts
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Apr 2020 at 04:49, Dave Young <dyoung@redhat.com> wrote:
>
> When I play with terminus fonts I noticed the efi early printk does
> not work because the earlycon code assumes font width is 8.
>
> Here add the code to adapt with larger fonts.  Tested with all kinds
> of kernel built-in fonts on my laptop. Also tested with a local draft
> patch for 14x28 !bold terminus font.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks Dave. I tested this with the 10x18 font, which is utterly
broken for efifb unless I apply this patch.

I'll queue this as a fix.




> ---
>  drivers/firmware/efi/earlycon.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> --- linux-x86.orig/drivers/firmware/efi/earlycon.c
> +++ linux-x86/drivers/firmware/efi/earlycon.c
> @@ -114,14 +114,16 @@ static void efi_earlycon_write_char(u32
>         const u32 color_black = 0x00000000;
>         const u32 color_white = 0x00ffffff;
>         const u8 *src;
> -       u8 s8;
> -       int m;
> +       int m, n, bytes;
> +       u8 x;
>
> -       src = font->data + c * font->height;
> -       s8 = *(src + h);
> +       bytes = BITS_TO_BYTES(font->width);
> +       src = font->data + c * font->height * bytes + h * bytes;
>
> -       for (m = 0; m < 8; m++) {
> -               if ((s8 >> (7 - m)) & 1)
> +       for (m = 0; m < font->width; m++) {
> +               n = m % 8;
> +               x = *(src + m / 8);
> +               if ((x >> (7 - n)) & 1)
>                         *dst = color_white;
>                 else
>                         *dst = color_black;
>
