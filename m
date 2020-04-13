Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39CC352B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6912074B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aff51BbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgDMPP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgDMPPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:15:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856DC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:15:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so9650590wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOE2P5jEH093/SFJkXAgVgRQaZk9Rt+ir8LjiFeoQis=;
        b=aff51BbTFzKsXCpL5YhrA7DxEgyrrRCPmWwZUOL3KHYaxbOFqz2qgeZWsZxz0soAsP
         UWdXdUwjE6+rqWK6X8x3JrDIYZfySNLGRtMr/hGTw4BxYQRgRoQqIkjhy2Ui+DsPeJU/
         3w0XtJekYhySKH5t6TkwnBpWYKOJ4cQhY4Kihj0k5hGnmRfZBPSGH8M9wCx1VD/i5Kaa
         8oVeKu6Q9+fxZPQRI6RJcb/7+6nXXHMalCRkZ8eBwVXKpH9stjFi02JGZ+ai3Avkzitp
         nTZry48J4GQGvTh6EATNQOiLsE7Poc6LQl+TgMJ7Dw+MxALVuie46Z3gUHxr/1ERsuBg
         /NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOE2P5jEH093/SFJkXAgVgRQaZk9Rt+ir8LjiFeoQis=;
        b=TcFxRpEOKMn9o/BAOpCmKf3gxS8vhSbH7KyNaVV/YLJDvF9+1LokCZFcnGkewk9gZu
         W4Kta66X7diH/+d0zyrTQ1nArLTzd+s4ndHNfy4yy0VZuyF/HsaUfVivyC5hTjVkJR+5
         yunNgLlGr0aeXseeFAia+idliv0be/eTwv3dSFll2cZ8yNE1pea1iop6DT/uIb1/zkoN
         Y9oeuIHGIRXU/rJyOBxm80/t4EhJzxzXMcC+FBqAuamo0omUMfZykTj2kNTHenuCXxGE
         YLQ4l9UevWW1LMCS9cFmrd/M7QOJE3RBRZ9tgM5mt5kA79vnbRO7leJSkgfUlmI4zx4l
         xRGw==
X-Gm-Message-State: AGi0PuYT3fmcyffU0/CWmeoRKv6wxbKTZtRXx7IyQX5yGraa0pMYG5Fy
        OYLjOlJ0do9qRxIH9JHIIABm3pAqJphAcZReM70=
X-Google-Smtp-Source: APiQypLHuiS6scHkDpSNfTRPyoEdHVy8Bj6zjoCNDYrKSaz9THG91uzh6/pXXdN3L1Hm1QzrZ4lPTVZY3QJSZiT3zhA=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr2795738wmh.39.1586790951873;
 Mon, 13 Apr 2020 08:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200413143235.22945-1-yanaijie@huawei.com>
In-Reply-To: <20200413143235.22945-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Apr 2020 11:15:40 -0400
Message-ID: <CADnq5_NejL35EFrK3doJHQXE3z5qeE_KVydB4AxbmGC=-_-++Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove dead code in si_dpm.c
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Mon, Apr 13, 2020 at 10:06 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> This code is dead, let's remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si_dpm.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> index 0860e85a2d35..c00ba4b23c9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
> @@ -345,26 +345,6 @@ static const struct si_dte_data dte_data_tahiti =
>         false
>  };
>
> -#if 0
> -static const struct si_dte_data dte_data_tahiti_le =
> -{
> -       { 0x1E8480, 0x7A1200, 0x2160EC0, 0x3938700, 0 },
> -       { 0x7D, 0x7D, 0x4E4, 0xB00, 0 },
> -       0x5,
> -       0xAFC8,
> -       0x64,
> -       0x32,
> -       1,
> -       0,
> -       0x10,
> -       { 0x78, 0x7C, 0x82, 0x88, 0x8E, 0x94, 0x9A, 0xA0, 0xA6, 0xAC, 0xB0, 0xB4, 0xB8, 0xBC, 0xC0, 0xC4 },
> -       { 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700 },
> -       { 0x2AF8, 0x2AF8, 0x29BB, 0x27F9, 0x2637, 0x2475, 0x22B3, 0x20F1, 0x1F2F, 0x1D6D, 0x1734, 0x1414, 0x10F4, 0xDD4, 0xAB4, 0x794 },
> -       85,
> -       true
> -};
> -#endif
> -
>  static const struct si_dte_data dte_data_tahiti_pro =
>  {
>         { 0x1E8480, 0x3D0900, 0x989680, 0x2625A00, 0x0 },
> --
> 2.21.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
