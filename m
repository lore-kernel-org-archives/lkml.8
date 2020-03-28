Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC78C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7640220714
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sk88MhJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1TEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:04:52 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41243 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgC1TEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 15:04:51 -0400
Received: by mail-il1-f195.google.com with SMTP id t6so8358013ilj.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AP+1qId3R/yF3OuH9WI1UJKSGs0Ex2bEojikXrSbq98=;
        b=Sk88MhJOXT+yZvT3IzSNNVPqpypHQwBvXLRR0hKLFRtdqYUq+QMn0Y8tms1RA8D2bq
         9NK7sIn6jnFSLisf5wIXycz1rXYpaMOo/AUuSZz5C41VgNwMMARLDFW9AUPXeOacVQ5f
         VqjPPebPuB7i6P9j+xOD+coJl4yF1fp1iHCLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AP+1qId3R/yF3OuH9WI1UJKSGs0Ex2bEojikXrSbq98=;
        b=YseiRcNUVTp5KcwcW8ykp2Nra1/xECCgofJGypJcRCdNCJ0P/Pberpnu0ApQC2fu+s
         3tHgUxUHqKvpvQHqsmYELxBKyuT8vlmPJUHLyD6QYH5gfj64eTZzL0+5tUDHC1oBFU6O
         1aeMd/XKdchZdMnW+DAPg/sNX6MJH9UmUMkdXv8cTS6M1v9CNwsHBk865w/raPAM3G4x
         2kH9VbAGLC5D1yqoYX0jSV+TY193hEGgoXbfUQ9k3gTs/ZWEOtZTYfuavzETgkfSdcQ5
         PcENGvMqirAo7V5dwiyPRdHFtHgs4i28vC05UkHgtyMoEZZWRKjbRCT+/ENSuJ/xmxXG
         Kh6A==
X-Gm-Message-State: ANhLgQ1vRh/+mkjBO/QCzxDUfM7bh5N5vlJKdq7j/7IFbtDMpVZT0ZaX
        2iDw/pmyBkGDRtVsYIWetR8cviA4dqVDAAlGSnYbgT2Fiqg=
X-Google-Smtp-Source: ADFU+vv2wg+b/xOJOKCXXGuy2LimYRCOQ60Jb9R7Ciwy6mzswC/bVOyrg2XS5brYA2vB48Vsdjsgr5WIhIk6BHLVk54=
X-Received: by 2002:a92:8517:: with SMTP id f23mr5046513ilh.106.1585422289417;
 Sat, 28 Mar 2020 12:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <202003281643.02SGhMtr029198@sdf.org>
In-Reply-To: <202003281643.02SGhMtr029198@sdf.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Sun, 29 Mar 2020 03:04:24 +0800
Message-ID: <CAJMQK-g7ah22RKaeMNyzBn70_vN2xS1P7Kx445WzmSn4iqRHfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 39/50] arm: kexec_file: Avoid temp buffer for RNG seed
To:     George Spelvin <lkml@sdf.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 12:43 AM George Spelvin <lkml@sdf.org> wrote:
>
> After using get_random_bytes(), you want to wipe the buffer
> afterward so the seed remains secret.
>
> In this case, we can eliminate the temporary buffer entirely.
> fdt_setprop_placeholder returns a pointer to the property value
> buffer, allowing us to put the random data directy in there without
> using a temporary buffer at all.  Faster and less stack all in one.
>
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>  arch/arm64/kernel/machine_kexec_file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 7b08bf9499b6b..69e25bb96e3fb 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -106,12 +106,12 @@ static int setup_dtb(struct kimage *image,
>
>         /* add rng-seed */
>         if (rng_is_initialized()) {
> -               u8 rng_seed[RNG_SEED_SIZE];
> -               get_random_bytes(rng_seed, RNG_SEED_SIZE);
> -               ret = fdt_setprop(dtb, off, FDT_PROP_RNG_SEED, rng_seed,
> -                               RNG_SEED_SIZE);
> +               void *rng_seed;
> +               ret = fdt_setprop_placeholder(dtb, off, FDT_PROP_RNG_SEED,
> +                               RNG_SEED_SIZE, &rng_seed);
>                 if (ret)
>                         goto out;
> +               get_random_bytes(rng_seed, RNG_SEED_SIZE);
>         } else {
>                 pr_notice("RNG is not initialised: omitting \"%s\" property\n",
>                                 FDT_PROP_RNG_SEED);
> --
> 2.26.0
>
