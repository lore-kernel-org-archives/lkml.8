Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541D3C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358D6205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM4a93dg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD0Td6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgD0Td6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:33:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB3C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:33:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so210501wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RQZ1rqt62TGR9QlKawKQ7R+UMp19s5QFNMCT8s9pOcE=;
        b=HM4a93dgEM8jHKU4uRwndIQC+9ZAi1w+JKDvvaayAlvYgKy4orRFUm/h9kfqJKZdDg
         /2gmvLsvVY0oLqy1RS3x0dzqsUO1OI4b/aV3SNgXnOf5o2E+OCLVmrUbidI5lOCWY9iw
         IVRoRSLI3N7d7mclt4qnS5m9QiqII/zoFWEHIYvDaM+xS9fZPgyjeunv2YskwL+hO8je
         8yMNDdz/1hOiKrQmPmLZ7Evwhi9c2rQOY9me9oTDNG2nHvjdE0DF0/EDHonE4hVa8sYQ
         DztIJGCWLmkeul1tM9ufbyXA0P/C0l6C2TvE/yRGVzl6yCRUezzH9vUi+i4Azb5zZ9ho
         3fkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RQZ1rqt62TGR9QlKawKQ7R+UMp19s5QFNMCT8s9pOcE=;
        b=fG7Agi3lKKdYvFhFdoGt+5Iqj8BVmKFRmOYUHukAq1h6tOlS0HFKrxNNaN8ZTPh54p
         AShQitlxm3+hL5S+y02yyXNrbh7m+VQR+TI3u4wpFA1QmAyyIbPHZdUaa6MpwvT3Y4DP
         Kffkj1810cNeuy4PqDBWw98U+sG2KOlyv2iySuqsDFC55RVso2NKTISfEZ6QlIFE+ejs
         ch62YFbNaEiv9l3JrxFBpEe5se0JmnebHzYH52zf5HDOacuUrlKnJRNSa1Zpm91cfQwi
         OmUWFf0LxlXN8KPGkR5SORTFIKdiJGS3aa1qelEYl39mnS8b6umQIF7gVEWXLvPpVDHl
         RuLA==
X-Gm-Message-State: AGi0PuY2l8jPqUwjQ3e4399OYr2YmVMgkOiDm2rOEgmwo89BM1uoNHLu
        dqlWe6ypfX6+bNndWX0ipjlVyEUeZD/rx2gq/qs=
X-Google-Smtp-Source: APiQypLw47bboaDd/mZnU70Zl7MsZjLgr4FhkhEYQa6MoG/m0MmPRUu85gaYdD13flYQJddWJ/JLAKOQ2wX2qK/dJm8=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr295567wmb.56.1588016036543;
 Mon, 27 Apr 2020 12:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200427063726.21363-1-yanaijie@huawei.com> <d7546d27-a17f-8dcd-c396-79476a3972c1@amd.com>
In-Reply-To: <d7546d27-a17f-8dcd-c396-79476a3972c1@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Apr 2020 15:33:45 -0400
Message-ID: <CADnq5_Mc77ze3_0FP8i+5o4hfbWeGonmJ0Ow29ZBbp_AW371+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove conversion to bool in dc_link_ddc.c
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Yan <yanaijie@huawei.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Apr 27, 2020 at 4:03 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.04.20 um 08:37 schrieb Jason Yan:
> > The '>' expression itself is bool, no need to convert it to bool again.
> > This fixes the following coccicheck warning:
> >
> > drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c:602:28-33: WARNING:
> > conversion to bool not needed here
> >
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/driver=
s/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> > index 256889eed93e..aefd29a440b5 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> > @@ -599,7 +599,7 @@ bool dal_ddc_submit_aux_command(struct ddc_service =
*ddc,
> >       do {
> >               struct aux_payload current_payload;
> >               bool is_end_of_payload =3D (retrieved + DEFAULT_AUX_MAX_D=
ATA_SIZE) >
> > -                     payload->length ? true : false;
> > +                     payload->length;
> >
> >               current_payload.address =3D payload->address;
> >               current_payload.data =3D &payload->data[retrieved];
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
