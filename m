Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6C9C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BB92465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRb7UzFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgANO02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:26:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40891 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgANO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:26:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so12737851otj.7;
        Tue, 14 Jan 2020 06:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPuFWmGDBx3VY9Jzpyfn0aIZyXwJCyecc/87RTsvEfA=;
        b=DRb7UzFmkhqx/FQMyGY7acy+G2ByTNFiQsdoan2tiY0KHLJQ37c1VCddyV92T0/TwJ
         ppkXQYTlEN+bcheveDBr0p2vgS0hjyPhN0OMxUzdIdtlxUxtdkEIK7hM+o/7PSHcHgEy
         ImRF1aLx+3gtX/Zw93mrQeze18oUDniVVoKxjffWS0uxpLSz6K7Gakg5S3oXP2ewKegz
         l0POR4NQXsNUSd/OHH+FXKAMAgSsZPrqYPUTy1ddXDPa4mABtAwKIJW106IaU3iLKRJD
         Cp7QhI6q/pxnUmevghLJ3N7HikNp1mZnVrubelGQ+dSl0NmsUTDw5ukoXmczD2/DrCr2
         4Xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPuFWmGDBx3VY9Jzpyfn0aIZyXwJCyecc/87RTsvEfA=;
        b=TAqNIxIPB3CaNU4tJT0/WiTSEl7XikyTATY16ZJ2WP/W8h6Yp4o7dzvI81lyUcBMy8
         UY6RG552cm61oV67QG/LPXxJiWVg7Ik8oNdxtqN2rOp8djXDo21uTHbKba8FQojfKamZ
         Q75f/PI7MZ3PVTVdelkje/7Vln3+r9hBpDYxjORr/wiu2AhXlmDy0k5FMmXYRQzpv+Yn
         obRA7Vmqtv+fPafmcZBqqUcbECYom1xs1FlDeJOq70t+hkZ38hXbecM0vaeTePBJFq4s
         m6cxk2LlFeoWaQk0bR7eBLG5CipQ2orhiX/+7cOW//LVHRqAc/+mwUH3ZaFtW0yvUHcb
         O1Ew==
X-Gm-Message-State: APjAAAU2EoQCgf6SrjXrie6jmecgihkBIX8JRWjWSfN2VNbRq/GSIoSw
        HSoyi5pdtt8j7vG7BIIXoHZv1V6Lbk9wksd3WFc=
X-Google-Smtp-Source: APXvYqzRoHAemxMBX4HZxG//uu3ExRtzVSDGR5WFru0o8BS5D6hoKT83Bcg4cx3NgJrW13rhSjcetJbmGHwzukfgMjc=
X-Received: by 2002:a05:6830:147:: with SMTP id j7mr17413547otp.44.1579011986681;
 Tue, 14 Jan 2020 06:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20200113172038.99689-1-cengiz@kernel.wtf>
In-Reply-To: <20200113172038.99689-1-cengiz@kernel.wtf>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 14 Jan 2020 14:26:00 +0000
Message-ID: <CA+V-a8vowxJhV0FnHA8kGcLPLWLi8Xd7RSTABLDBtu7YpLYg9Q@mail.gmail.com>
Subject: Re: [PATCH] media: davinci: remove self assignment in vpfe
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cengiz,

Thank you for the patch.

On Mon, Jan 13, 2020 at 5:21 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> There's a self assignment which has no effect.
>
> Removed self assignment.
>
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  drivers/media/platform/davinci/vpfe_capture.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/platform/davinci/vpfe_capture.c b/drivers/media/platform/davinci/vpfe_capture.c
> index 916ed743d716..089648665cdf 100644
> --- a/drivers/media/platform/davinci/vpfe_capture.c
> +++ b/drivers/media/platform/davinci/vpfe_capture.c
> @@ -879,7 +879,6 @@ static int vpfe_enum_fmt_vid_cap(struct file *file, void  *priv,
>         /* Fill in the information about format */
>         pix_fmt = vpfe_lookup_pix_format(pix);
>         if (pix_fmt) {
> -               fmt->pixelformat = fmt->pixelformat;
good catch, but the correct fix is to assign pix_fmt->pixelformat to
fmt->pixelformat.

Cheers,
--Prabhakar Lad

>                 return 0;
>         }
>         return -EINVAL;
> --
> 2.24.1
>
