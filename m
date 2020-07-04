Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0243EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD66921D95
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 21:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0U1cLZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGDVjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 17:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgGDVjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:39:31 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4743EC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 14:39:31 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id j1so1391366oof.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gx+cgDLg9bWdeN2YnwpLPBrXIDJCNX8H1+rl425vCFY=;
        b=t0U1cLZTfUGRi25QiAborBDtgEMWqjP64t8dPf5OUzo7LfG3omawEi8/kFFuMbr6Ph
         v4Dd08CLT6J9qmkXL4u+sce27VgdbweZq0XVlMA12n5lZkuiIr0/qLCHDlmBVpQXmAWL
         wwzn6EWqcZIoGkyVFiCai5BYA/aqXngVv21qFrO3LzQ3SJtUY8Z8FAVpa50rlhum8qLr
         afYdlEkr7wv5EaQPNpPsLtXSMlyjgNSZJXr8w+nzJbmKOiqMPBDlepS4aYZceyjDROUs
         TVLw082yIyBYIuDd7XWm8aObVpRbsbIIR3/Sl8pr670A9ScH6cpBzlQ+xAcSZAxHV9Ky
         YzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gx+cgDLg9bWdeN2YnwpLPBrXIDJCNX8H1+rl425vCFY=;
        b=sRdZBcNe008zv08+e0KqLgWl8kw1k+fCNlqiLTvHhJS/z4wmqdBQ4pvgvh9ADxdsEL
         g2OzbJcikQLycKM6RuiYulZcE/wAt9nZrkrMKd0KPB/SKAkCC6oLdG/GoCCut7xwH19b
         mtwb/779qYSp64jFMVksIRU7i5gUoLPkA0e4ourdEzMEmbj5Vf1+k1C+BDWwEXiu95xq
         56crOF9oriDPyjvOcYgxz8tcDTkb9b2U0VE+qYAVnWvRxTMumMkOJATuCMe/QCEQbRGy
         ItS9sxRjEoCdT7HlCfntAR8cHu4Fo2KgaJA6TeezcGb3NQ5nsgo/KEmxU4WEI0vugisa
         xbUw==
X-Gm-Message-State: AOAM531iZW93Qi2OQBDYYhkOBlLcLtZtyN9xwtNeG/sd3EEd00gbs1MP
        ePpmgia5sDUX/bBBKprg6mhQ2oNTObXKt0D0eSc=
X-Google-Smtp-Source: ABdhPJzESOl50PuQMPsOfL/breGq+Sa0Y32iWGtNhgcN1e1Gd6s7ZAwckGM31RcZS/3slhbVB3V8+cF5mniJUsYDhAQ=
X-Received: by 2002:a4a:dfb5:: with SMTP id k21mr28490795ook.27.1593898770343;
 Sat, 04 Jul 2020 14:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200704195116.19669-1-oshpigelman@habana.ai>
In-Reply-To: <20200704195116.19669-1-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 5 Jul 2020 00:39:04 +0300
Message-ID: <CAFCwf12WXAnVA1mTCxiifG7npi4hVJquPvC_NTG-9c4Gyc+u1A@mail.gmail.com>
Subject: Re: [PATCH] habanalbas: rephrase error message
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 10:51 PM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> Rephrase F/W error message to make it more understandable to ordinary
> users.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/firmware_if.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
> index baf790cf4b78..171baa2b56b0 100644
> --- a/drivers/misc/habanalabs/firmware_if.c
> +++ b/drivers/misc/habanalabs/firmware_if.c
> @@ -566,7 +566,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
>                                 "Device reports FIT image is corrupted\n");
>                 else
>                         dev_err(hdev->dev,
> -                               "Device failed to load, %d\n", status);
> +                               "Failed to load firmware to device, %d\n",
> +                               status);
>
>                 rc = -EIO;
>                 goto out;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
