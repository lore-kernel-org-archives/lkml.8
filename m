Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B82C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB4E2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r70f2n6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgHROns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgHROns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:43:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601BC061389;
        Tue, 18 Aug 2020 07:43:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so18546660wro.2;
        Tue, 18 Aug 2020 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nn+dQltSNrTpEOmO/72SIoczPIww+KaSGSIwYHiMyqs=;
        b=r70f2n6UEVQH/7cm8pp0ownDfW4G5pAIS3odxMw8ievkejBcDlkfTg/gGG8BMNIwdn
         EXAoAGCT1+2D2HBWjcOgSXDwQKKikB8wZOPpcwckTaiwCVAeojiVlQM74th3Rg03QaK7
         32/RwSaB2G/cCMyzuIWSgVPA7AhJnfvf6mPkM7LBUR6B8sPtha+R/lHLlx3291PH8ZhV
         h3tdM6xoaRG8zeyeZlPEW5tXuHZvpo28CuH3oHDyXnHn0hy0etpKS1ksNKWn3CBGZZWT
         StLicyOr8olMszHL36nXBRFW41wuvRxfqLa9dHrmjfMHTgtiOmRSiVfkA0GNsjSBZsyJ
         8PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nn+dQltSNrTpEOmO/72SIoczPIww+KaSGSIwYHiMyqs=;
        b=JqAhUm74AwdmVxZqzttYSLCUvaTp2hOX/A6m72tlW/5T6qD7etMm2PhkOq7UqVnEug
         avsJjTKJ76KS7i2EtAp4m7HMQR/uKVOBha/sqwJCw5AX87AKii6CzVjMldloWjb5Gf+3
         O26JLKYVthaZgv9r1mdr2C0CYlMgm6eHkCg9pd2GU+gaDJuSKmyu3kQlgxPYOrsSX8K/
         tqU2/qdhTsDb9rP/dfthrIsy9eQi4TDmEROL+oJLy2gcsCiAe9r8LUx31hdLspGR/Fz5
         kIhRkAdfTEtwpUqvJLtLAK0ZXJOH6xeJIlkVO246HYVNy9Axtp5ErgMLPCjOHRqZgUH2
         Eq2w==
X-Gm-Message-State: AOAM531NbM/BsErXqlCmsSRD80o1i71on24ia+fO0ABy37/J10L5MPRC
        LqQN82D/6K18AhtFNq4H97ym5Vt7a2NQguYtmlA=
X-Google-Smtp-Source: ABdhPJy/Kl5SzhrZm43eFQ5CqHvKNB6Ze6VOIYOn4HWeUuJcUR+R2Fdj9tdc6stlUAnpOpwapgVwAkd3wyZfc9ROc+Y=
X-Received: by 2002:adf:a351:: with SMTP id d17mr20309653wrb.111.1597761826407;
 Tue, 18 Aug 2020 07:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200818120914.20280-1-colin.king@canonical.com>
In-Reply-To: <20200818120914.20280-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Aug 2020 10:43:35 -0400
Message-ID: <CADnq5_P5ozoOT4H0hrjxM1JwpvJGQ0UCnp00Kf5+Msh2CdBHgg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix potential integer overflow
 when shifting 32 bit variable bl_pwm
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 8:09 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The 32 bit unsigned integer bl_pwm is being shifted using 32 bit arithmetic
> and then being assigned to a 64 bit unsigned integer.  There is a potential
> for a 32 bit overflow so cast bl_pwm to enforce a 64 bit shift operation
> to avoid this.
>
> Addresses-Coverity: ("unintentional integer overflow")
> Fixes: 3ba01817365c ("drm/amd/display: Move panel_cntl specific register from abm to panel_cntl.")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
> index a6d73d30837c..df7f826eebd8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
> @@ -76,7 +76,7 @@ static unsigned int dce_get_16_bit_backlight_from_pwm(struct panel_cntl *panel_c
>         else
>                 bl_pwm &= 0xFFFF;
>
> -       current_backlight = bl_pwm << (1 + bl_int_count);
> +       current_backlight = (uint64_t)bl_pwm << (1 + bl_int_count);
>
>         if (bl_period == 0)
>                 bl_period = 0xFFFF;
> --
> 2.27.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
