Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1A9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B657206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgHYHsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:48:11 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44855 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgHYHsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:48:09 -0400
Received: by mail-yb1-f194.google.com with SMTP id i10so6636671ybt.11;
        Tue, 25 Aug 2020 00:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfaePIFgkKDaQAvHyLocpP4Zlin9g8e2YzOSoHz2+5g=;
        b=TdBnLyTH6xPp1R/3FBMAPWOlrOkbGHAkfm6pHDLU5T+N0HtXCJ3RrllGDgGBLnJjLf
         vY+cOASe1zd79HSxG9nqp/+L3ihYG5DlKlRBwpbpIwBxPnccUOrNj3wqBguhN9sZbIsM
         WU2LjM7rba/n7bAaChgl7FrVDDwyeiBnj+cwArMwLTJ9YiFpkUpdPFIhzthXkVyblAse
         OXP6R0Hehnz/lPfFxWwJK2HgsVHIsldu+1RzjdM4t2FH4/F62c/1MqxH2ysUekY2KFW/
         xC3O55b/Cpf79yPDJH0KT0OkyeZbEEOyaK7xxu6hVvcsJgAzunZC5IkSHupvvtzyaj1d
         aNgw==
X-Gm-Message-State: AOAM531OEz1Iu+MwnPnM8lWj2dT85MxTjDll7QxcaQZuV2f/fg3foca7
        Jkgrwyb+E9eadO0Ps52I602QWwYTxzHxf5baXrE=
X-Google-Smtp-Source: ABdhPJzzoQCHoXnnSY9x7+KhRyF3ktxgw1KVvIH0dVLRr/ri2WIgVCoeB1qGC/E8jcdRDplu5z/cKMya91xE/i8mUtU=
X-Received: by 2002:a25:2b89:: with SMTP id r131mr12592617ybr.131.1598341688832;
 Tue, 25 Aug 2020 00:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200825062900.11210-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200825062900.11210-1-dinghao.liu@zju.edu.cn>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 25 Aug 2020 09:47:56 +0200
Message-ID: <CA+7wUswtuOPqQ131F5LdH=7dH+sWZc+jmMHXpaYmTDUehvx5eQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: radeon: Fix memleak in radeonfb_pci_register
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 9:27 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When radeon_kick_out_firmware_fb() fails, info should be
> freed just like the subsequent error paths.
>
> Fixes: 069ee21a82344 ("fbdev: Fix loading of module radeonfb on PowerMac")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/video/fbdev/aty/radeon_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 3fe509cb9b87..13bd2bd5c043 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2307,7 +2307,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
>
>         ret = radeon_kick_out_firmware_fb(pdev);
>         if (ret)
> -               return ret;
> +               goto err_release_fb;

Good catch ! Thanks

Reviewed-by: Mathieu Malaterre <malat@debian.org>

>         /* request the mem regions */
>         ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
> --
> 2.17.1
>
