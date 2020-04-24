Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A7FC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E04720736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkZKXWoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgDXOWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgDXOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:22:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6EC09B045;
        Fri, 24 Apr 2020 07:21:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so10311312wrt.5;
        Fri, 24 Apr 2020 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P42ksOlVF/AdmvKPsOuYxhpgfKkeJHhYzXzUH8TEKYo=;
        b=RkZKXWojYgferx/UFn3wqIaV79UGDDSZqOrwzdw9IHGFm7l0weOYBhCmmwwSvlHkLj
         kU6gF8Dk8HA23Oi2gld3VpUdUisrwLGjo/rqjhtgQUCqwiAO6FDHMe4COyCATjWwZchU
         ZZEsN1V1cwmzkDLWOmQaW4zspyCQ548/BugXGLRp08CI7MNsAnC7Iol4+5CI6DF7TuOq
         Apl6adE9NKHH419sEN8v2HTquualX/4hTw9CkKLGy+lsMBUkxhIVDAzMMhwd60/WCflz
         WQ01F3qb6x9/zgSB73A6xupsAmBajt2q5AAML1r/SPdEn7yC2QPmVhiFWVsKwwoT4RjD
         onDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P42ksOlVF/AdmvKPsOuYxhpgfKkeJHhYzXzUH8TEKYo=;
        b=RHylmDetzf6LGb0LMW/aDZzaXZpBBCr6i/WYfihDdTEDxNjTV6OlzXVhbkYknybGnQ
         tl5qpwtpUhLs/giYtxG/FT2TZxQgZl4um6LRnTKbTu772WnofU98kDBZIBQupepK+t08
         NdF3/uhYBghkFcfbKLyURgCnqlT4WTuwoBbqvIipOK6+oTPckGfMNYgGeSg+hRfYnyGS
         A3tlHgN6xFRXYsRYyRISWNm/5AmS8d7mNO3AVZWOFT+3ccvwnWKP4ojVIzljXHRwkhsu
         4fVZqiCB0Q+OJX4vLVoUltwSTJ7cg5RtoMSoG2Qft+L1dQLExuT3YyAwAasijb1AC+3J
         aKrg==
X-Gm-Message-State: AGi0PuZidpRlkona8r8KqCFj0McHrQugA1cKpiJfL40ixIwVHOXqsKeg
        yISGKyICcnqrPWudBJeGk86NOUYPf2SdYPkaerc=
X-Google-Smtp-Source: APiQypJJ0vGexcoNVu6n5gVmRGV7DqLLurzwRE2ERIyibjQ6iAJM4ySCD/yDHkJDU7tOoJXeG2AM97nay1AkBBxdGDE=
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr12059598wrj.419.1587738118671;
 Fri, 24 Apr 2020 07:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200424111226.11796-1-colin.king@canonical.com>
In-Reply-To: <20200424111226.11796-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 24 Apr 2020 10:21:47 -0400
Message-ID: <CADnq5_NcPBfRTgVTAb8D+x+_HB6dJ1wE8_PLUup+iR3nP+2NuQ@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/dc: remove redundant assignment to variable 'option'
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 7:12 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable option is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> index 4245e1f818a3..e096d2b95ef9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
> @@ -679,8 +679,7 @@ void dce110_opp_v_set_csc_default(
>         if (default_adjust->force_hw_default == false) {
>                 const struct out_csc_color_matrix *elm;
>                 /* currently parameter not in use */
> -               enum grph_color_adjust_option option =
> -                       GRPH_COLOR_MATRIX_HW_DEFAULT;
> +               enum grph_color_adjust_option option;
>                 uint32_t i;
>                 /*
>                  * HW default false we program locally defined matrix
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
