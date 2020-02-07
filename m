Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC14C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EFD20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5N4N057"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgBGHFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:05:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44019 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:05:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so1182933oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 23:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AI/Ed1jGZu0syy2ZPa3aiPuxKymaXFosIYunW/DJlgg=;
        b=f5N4N057lze/UYExempS2s0dCoH9sLy74s6Isw5TBb7/s01mBzzDWFwD/EmbDtPZ8c
         ne3ozJuuy965JFt7rupc1pObbHtWJfpedMtj0AuzKB4Vd4kYIHURJ0MThF43IwOp8mFr
         ql0X+5PjZRWGOp2oKoDeu1U+mHPSwc37CgW60CFAJ2TK0v5zfHWa9eYsZiQ6OmChT+eW
         xwp2tE69NrwsSIufnkxubt+SbjO9+3X8xuVkoQV89xnEUP2WtRV9NcZJKL7wXjoXa5E0
         LDYH5YMWp1KLWEH1qbAkF4f6I7H6jNh3nRfs9WvGEJ3wDUP3HYEjy63BjD67LTq/RBox
         IB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AI/Ed1jGZu0syy2ZPa3aiPuxKymaXFosIYunW/DJlgg=;
        b=X0oxtujJoZAkVCLGBiSFAKDY29/JCm9JQ88xhtno05BuwrR4oZSOJX8I3XSaghWmYK
         nhnbqb42iJZz5j7MdfFqgLHjvncDLxsaI4vQ6MBlXll8bWZTPKCttTmmHz20Te9OfuT9
         dU6P2AL3w/U0cQPgtYim0ypvgEBgcn/cFJRfwiEMXrV8RTdbqwKzDMLzBnagf0pLSTmF
         L6U749u1FqVavYYeuniDZEnMaEwvpadGu4EgGZjjNLxUR/4k39a8R2OvEFk+n8Wp/gVY
         scg6eU1lhrzQDV10IckJd92hlyrE6qUGrYtn7JrK7WXGWnr9Fn6omH/RrNzm0dbVbnQ3
         bM0A==
X-Gm-Message-State: APjAAAW91bwtb1w31I+Uk4E7E/FO3iXqG52j75TnryAofZuD/Fono4LP
        sY9FphjPcD8/JG6YRiEvYNhpzXZQZUuSU0TyoBHQKFdT
X-Google-Smtp-Source: APXvYqwl3CbR6UotROZtdXyz3AsI+ZjBwM4bP86Bh8CXVgTY1ZYpkd16mlzMWA+GGiBq7ttJjps1pHl1EV2FdYXCiDI=
X-Received: by 2002:aca:ebcb:: with SMTP id j194mr1179392oih.154.1581059150234;
 Thu, 06 Feb 2020 23:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20200206111646.11755-1-oshpigelman@habana.ai>
In-Reply-To: <20200206111646.11755-1-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 7 Feb 2020 09:05:24 +0200
Message-ID: <CAFCwf12GYEcAHpundrSq9SQsiJEaM40s_4kF=mNGXFf0gKBOJg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix DDR bar address setting
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 1:16 PM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> DRAM_PHYS_BASE is already taken into account in MMU_PAGE_TABLES_ADDR.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 74785ccd2cb1..f634e9c5cad9 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -2575,8 +2575,7 @@ static int goya_hw_init(struct hl_device *hdev)
>          * After CPU initialization is finished, change DDR bar mapping inside
>          * iATU to point to the start address of the MMU page tables
>          */
> -       if (goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE +
> -                       (MMU_PAGE_TABLES_ADDR &
> +       if (goya_set_ddr_bar_base(hdev, (MMU_PAGE_TABLES_ADDR &
>                         ~(prop->dram_pci_bar_size - 0x1ull))) == U64_MAX) {
>                 dev_err(hdev->dev,
>                         "failed to map DDR bar to MMU page tables\n");
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
