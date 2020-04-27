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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CB1C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E7A214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5DS4mi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgD0Tco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgD0Tcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:32:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD13C03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:32:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so206842wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4/npxxtH+H1OeXXMGzZZnqf+6zu3hCivzxJohpfCQF4=;
        b=n5DS4mi790uR4KR7jkR4G+Sa4b1EbK+SfC23Apm2Z+aCa5so6VCDig/MIh1Jf6cBP8
         n+8EqbD1Llns9FfaffKpvEtCTkf4srgM7b6luuSYYV37ANfVYbT6LXmVQPVdqaM4aTHz
         KLIiqTX7GaouFxw3sYQziltDN2ALBDdWsJSN56/exqCntOxbuQtzI7xfTzXEVf8bfGUx
         4DPHCU1dJVR/eXPBrseFSVmz6jtTJNrGlXsOq02zpSZ3h+geeEvDTvLEMZS9DZQPcG/F
         rn7yre0pMarF8QzdOsYlKRXnVOXanX2bAMhRuM2q7SI4TUj6m8kR4T2KSvjOmhg7Z8/S
         7Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4/npxxtH+H1OeXXMGzZZnqf+6zu3hCivzxJohpfCQF4=;
        b=Qm+ov99vhFA3rp63WWj9t77jTTYpk9dgIQNxNsvvsMvzH23LAZK0bgpweF2vVaefAM
         7LN7AMtfhVqoe5YyYv2/0D3CmodyohCPZonC2Zyoil1LTu8HP3TgZ1JRZLam88xdVMbY
         n5HgNFaN2HRKu2UR9clncI4j6IABGkNLcyHsbBMvzC0Gt5kb4UoqY3QKebwEEBMRoeBb
         jpIvqxBfZzpxG/ERSXc5+2m+1AQhYInwhWZ9kDYkYl0U2lJjpQWsNITZXHqrsX9MyhOJ
         wBGij+t2FBLDSx1nFiZYizPkQJh02Rj6bKwkfcMPmgSNDc1y30hVmJIR513RWNaRhGCk
         beJw==
X-Gm-Message-State: AGi0PuZV3N5xZlpbLxcAycyF75uzGzppokV+GoE5UpwcrT8P9dfuK+dz
        +570xrpDXOk6jsZPb19w48MNfVLxOUxUbIQAFiw=
X-Google-Smtp-Source: APiQypJwGs92/0Duteoz2jJWYEITGhMBlH7Ezu6BITIsatXNYDTf+lZCUXwEqwNTqKgT/ilVjIO/lJ6ZE2N5pJMOCnY=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr242589wmh.39.1588015962213;
 Mon, 27 Apr 2020 12:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200427063715.21255-1-yanaijie@huawei.com> <ca33223e-efd8-cc26-1dec-c7975a5001ca@amd.com>
In-Reply-To: <ca33223e-efd8-cc26-1dec-c7975a5001ca@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Apr 2020 15:32:30 -0400
Message-ID: <CADnq5_P+U3Kz1r+ehHKZeHULYix5hzJfn0hrn80OtAKNzsZczw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove conversion to bool in dcn20_mpc.c
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
> > The '=3D=3D' expression itself is bool, no need to convert it to bool a=
gain.
> > This fixes the following coccicheck warning:
> >
> > drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c:455:70-75: WARNING:
> > conversion to bool not needed here
> >
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers=
/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> > index de9c857ab3e9..9d7432f3fb16 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> > @@ -452,7 +452,7 @@ void mpc2_set_output_gamma(
> >               next_mode =3D LUT_RAM_A;
> >
> >       mpc20_power_on_ogam_lut(mpc, mpcc_id, true);
> > -     mpc20_configure_ogam_lut(mpc, mpcc_id, next_mode =3D=3D LUT_RAM_A=
 ? true:false);
> > +     mpc20_configure_ogam_lut(mpc, mpcc_id, next_mode =3D=3D LUT_RAM_A=
);
> >
> >       if (next_mode =3D=3D LUT_RAM_A)
> >               mpc2_program_luta(mpc, mpcc_id, params);
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
