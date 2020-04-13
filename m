Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58171C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F88C20739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJiZYCUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgDMPIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgDMPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:08:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE82C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:08:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so9867608wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lmXdNG7xBS4HYOxfe0aKo5VaQiBEjto7UlYRcKbMIBk=;
        b=NJiZYCUSLiuhyUkWZ/51MM7ZoS/pr/Rjd/1JM/5+yC6o1ffI+oyOkWnnL0lCNS+IYY
         nzovxt4dozYeB9UX6GZ5Gt91FQv3FrOLt+8JCpHubkXFcOJZsIVqi0IBYf4m65B8vJef
         Sml9ddEQ7CBt2kOyMwuWspVjKzDftw5jAe4B01txMaU834r1cNQquq5MLrexj9PKuy+8
         sN0vn6p6VieBkBAbioOn6DHP4GbqmUq6q5dThpw9wENcCCHc2e16KEU4NITIcyAwUcAh
         Tsjr6j/zJpNcuMlncfgTyPZwBCDMYkSFaxVMiZMj1FrcMUBl3O7ke0g64DURYjaWUZiA
         dNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmXdNG7xBS4HYOxfe0aKo5VaQiBEjto7UlYRcKbMIBk=;
        b=nK7KCljJj8lzJaUTUfu7AJVh7KWsL+U/tvfFUzNNZVql/peUh7ssy78mfOu4o+61d0
         opwc5oI0m7hT8SGWtoB8YVVu91bBWhaY4gB/DYApZywkfoE12YlzQ20yI7EuUq9A7s8w
         2Z1tqJHAcbPoxz9ZCifuBQ9GGLr5OAAWr4KNJzo7FlVnT1rc+nktO+KGML+q0s0RzdPQ
         falLBLkB1iA0X1Q5sMGEnxxWo/0AZnmkjAfXHw+lOZZko7Lxj2bn08zArAc1aeElGTRX
         RTHEpvcSWxb2Nf+9XvyB50SQ+2IPQVCTb9Sh4HsW1ZG85yf3OcT8Ty9WsJcokC0scYjJ
         0h8A==
X-Gm-Message-State: AGi0PuZs5cYtSzrU1OqK5wAjtYVrF+GWGlm/TWQJdGvLl4XdPJVqqc+O
        fjiteC5Agy/+KpuljXQkW1fd5K9vO1jk9fzdmgU=
X-Google-Smtp-Source: APiQypKWKFV+YEIjqwbr/X00Qq4OT5SRvkZuOT0CS3Tzf7C520HWjeFaeOiqOB44PBaFnwKSzs96FrHRsavN2XY4UDg=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr10952707wrs.124.1586790529368;
 Mon, 13 Apr 2020 08:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200413082249.23271-1-yanaijie@huawei.com>
In-Reply-To: <20200413082249.23271-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Apr 2020 11:08:38 -0400
Message-ID: <CADnq5_MkfeC+0pVqOOBfHMp3hA3-wHJN2fNcg0s10XAcFM+DTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: code clean up in dce80_hw_sequencer.c
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
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

On Mon, Apr 13, 2020 at 5:29 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following gcc warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_hw_sequencer.c:43:46=
:
> warning: =E2=80=98reg_offsets=E2=80=99 defined but not used [-Wunused-con=
st-variable=3D]
>  static const struct dce80_hw_seq_reg_offsets reg_offsets[] =3D {
>                                               ^~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied.  Thanks!

Alex

> ---
>  .../amd/display/dc/dce80/dce80_hw_sequencer.c | 28 -------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
> index 893261c81854..d2ceebdbdf51 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
> @@ -36,34 +36,6 @@
>  #include "dce/dce_8_0_d.h"
>  #include "dce/dce_8_0_sh_mask.h"
>
> -struct dce80_hw_seq_reg_offsets {
> -       uint32_t crtc;
> -};
> -
> -static const struct dce80_hw_seq_reg_offsets reg_offsets[] =3D {
> -{
> -       .crtc =3D (mmCRTC0_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
> -},
> -{
> -       .crtc =3D (mmCRTC1_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
> -},
> -{
> -       .crtc =3D (mmCRTC2_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
> -},
> -{
> -       .crtc =3D (mmCRTC3_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
> -},
> -{
> -       .crtc =3D (mmCRTC4_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
> -},
> -{
> -       .crtc =3D (mmCRTC5_CRTC_GSL_CONTROL - mmCRTC_GSL_CONTROL),
> -}
> -};
> -
> -#define HW_REG_CRTC(reg, id)\
> -       (reg + reg_offsets[id].crtc)
> -
>  /***********************************************************************=
********
>   * Private definitions
>   ***********************************************************************=
*******/
> --
> 2.21.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
