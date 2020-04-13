Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99046C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741DF2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgn2+OLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgDMPRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgDMPRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:17:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E50CC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:17:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a81so10314761wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6/tAY7sG8rHBuZ3JGryCCYr3n1OexDLH2uk6dgjjXOE=;
        b=fgn2+OLLH1broPdcc/n91zxjUbINV+YKFu4617b9ChwUBY6ku2GPh+UQi2KCrydpZB
         uRIvV/qTyrtYa4cQ1idlbrH6Ip/SgQn/5Y25JeGcMcFhD1k1oiCapG75nbieQLXwAUUr
         36RAl2O6RlM7irJ5YAyVp/c7cE/Om8fPq6/CpLkO9hWs4fKKJGfNyOoDc7eeCqHYVmhM
         R664MVppEBLiwZ38BGlII8hlYSRFZhcrqifVX4of3ZzyovydCJbhejctPy8lgwtkC6gE
         197raXN3Ci+GKsXKp+qGBwiDY4f0ymNPhfnp9JGw87hsWJRfi6jG44I6/Q2r9JM6pl96
         HRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6/tAY7sG8rHBuZ3JGryCCYr3n1OexDLH2uk6dgjjXOE=;
        b=MHiKWJ7q+OCdWq6RQCLSaqioo8Dlf8wYwKPq2Co1RiPoQtgaEeoGGFjLsaQHM3dv7K
         hmG5UdcMQnijxZoGXw37RyfNgh3rhwvSwKreo8eIewOkpVAeuBrTZm1Ks+6l3QggP32y
         PmoID3gJkH6Cc/VtYuBRYhIpq1jYJyk3Z4P/d7AjNtUNWTnrBYFE44CsAGVT7o+i/CMP
         NSrus6Zv4jUReZZnk2tXbjjJUaWbli0OZ6z6Od8BQ99/k4asHQ+q7Dd1cQ5D2BSfElB/
         3r+CM3UnBOSf5WgPhUCCPXqX1rrwWQ6RqGIne+FqIraYwioOZ+a1n6Q+oxgkU7z77/e1
         Sikg==
X-Gm-Message-State: AGi0Pub/tx1ADcJFBUHSTNXOVxpb8UD899TsSjR8TJ0Gjxh5RBbtzcsg
        fz3+4itFP9kVlH8eAXBD15ml47OpjTBUsLI1Gz7uLg==
X-Google-Smtp-Source: APiQypJNiuhBu6h6TpUjqMxFco+WMWQExJxvPAtxUopumix9qPR3H5TS8oFTUN/GexIoDeqyEf4Iuan45+cHdKuBg7Y=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr19446547wmb.56.1586791058036;
 Mon, 13 Apr 2020 08:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200413143300.23244-1-yanaijie@huawei.com>
In-Reply-To: <20200413143300.23244-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Apr 2020 11:17:26 -0400
Message-ID: <CADnq5_NY20m3Y4C3J6jhuzHC-pXj0pSYLgOCVKxrAOA0n=txQw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove defined but not used variables in ci_dpm.c
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Mon, Apr 13, 2020 at 10:06 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following gcc warning:
>
> drivers/gpu/drm/radeon/ci_dpm.c:82:36: warning: =E2=80=98defaults_saturn_=
pro=E2=80=99
> defined but not used [-Wunused-const-variable=3D]
>  static const struct ci_pt_defaults defaults_saturn_pro =3D
>                                     ^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/radeon/ci_dpm.c:68:36: warning: =E2=80=98defaults_bonaire=
_pro=E2=80=99
> defined but not used [-Wunused-const-variable=3D]
>  static const struct ci_pt_defaults defaults_bonaire_pro =3D
>                                     ^~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_=
dpm.c
> index a9257bed3484..134aa2b01f90 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -65,13 +65,6 @@ static const struct ci_pt_defaults defaults_bonaire_xt=
 =3D
>         { 0x17C, 0x172, 0x180, 0x1BC, 0x1B3, 0x1BD, 0x206, 0x200, 0x203, =
0x25D, 0x25A, 0x255, 0x2C3, 0x2C5, 0x2B4 }
>  };
>
> -static const struct ci_pt_defaults defaults_bonaire_pro =3D
> -{
> -       1, 0xF, 0xFD, 0x19, 5, 45, 0, 0x65062,
> -       { 0x8C,  0x23F, 0x244, 0xA6,  0x83,  0x85,  0x86,  0x86,  0x83,  =
0xDB,  0xDB,  0xDA,  0x67,  0x60,  0x5F  },
> -       { 0x187, 0x193, 0x193, 0x1C7, 0x1D1, 0x1D1, 0x210, 0x219, 0x219, =
0x266, 0x26C, 0x26C, 0x2C9, 0x2CB, 0x2CB }
> -};
> -
>  static const struct ci_pt_defaults defaults_saturn_xt =3D
>  {
>         1, 0xF, 0xFD, 0x19, 5, 55, 0, 0x70000,
> @@ -79,13 +72,6 @@ static const struct ci_pt_defaults defaults_saturn_xt =
=3D
>         { 0x187, 0x187, 0x187, 0x1C7, 0x1C7, 0x1C7, 0x210, 0x210, 0x210, =
0x266, 0x266, 0x266, 0x2C9, 0x2C9, 0x2C9 }
>  };
>
> -static const struct ci_pt_defaults defaults_saturn_pro =3D
> -{
> -       1, 0xF, 0xFD, 0x19, 5, 55, 0, 0x30000,
> -       { 0x96,  0x21D, 0x23B, 0xA1,  0x85,  0x87,  0x83,  0x84,  0x81,  =
0xE6,  0xE6,  0xE6,  0x71,  0x6A,  0x6A  },
> -       { 0x193, 0x19E, 0x19E, 0x1D2, 0x1DC, 0x1DC, 0x21A, 0x223, 0x223, =
0x26E, 0x27E, 0x274, 0x2CF, 0x2D2, 0x2D2 }
> -};
> -
>  static const struct ci_pt_config_reg didt_config_ci[] =3D
>  {
>         { 0x10, 0x000000ff, 0, 0x0, CISLANDS_CONFIGREG_DIDT_IND },
> --
> 2.21.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
