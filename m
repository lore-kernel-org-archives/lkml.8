Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5A6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041A020758
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAGJH2JE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHTSEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHTSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:04:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9DC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:04:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a14so2974426wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LeRFjvgtCyux0Evs7yc9oix8Hrc6YHLHgKJRYeIXm9g=;
        b=FAGJH2JEUEHoCpdJw0cm0l3P4WYL3CMpFPdt/cXsAiWunaoSJDC99Yn/qyuqxeqmiW
         W02MYpgl8MdBhhC3brLb94opDv9BFtKvYAd7Z/xuwM1nQ9bW6ZaEtwVsQIhgN5SihIAs
         YJMnNrtYLoDlm18vYsX5W7ygrcaX+W2iN5ljtsOtP2yKTGa5FTm5x/axEDPPpZhe52u8
         RsQyi70djMGrTcUhSGcjMi0YxESh6TTuIlCZ+sF/14PnMp1hVCRhgR0IFjZyDLrDCbY9
         +FxnW2I9LOREnPga+AqrlhdAfpQ5+zdOXOiCBMm7CI+vdKFdTXzbWso0SmbZoIAvJOxS
         2+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LeRFjvgtCyux0Evs7yc9oix8Hrc6YHLHgKJRYeIXm9g=;
        b=Nh9rSeBlM7q+iQT54pN01eb1isLiIednxObLZbYYzJjZWBgVgRUYlBrjjMRHPdhMIv
         Iio1nmNdgCTlFg6y/ZuGaYfAGvkjCvfZ2zf8pjTuDmtWYcdBf0840DZgd5Ru291pToBb
         fqTZ2OM64R6ccb5/OW38zaN2aY6vjmsg7wTPpyRSLX8Sx1CMVVLQ5tT9JjbEGl60vr9Q
         tuObXFA8v+ZU79wBv0yWblY5IO5Y6BXJTI8NPoXO3mYyPKzJHwM13NYrpF+HGia3ExAI
         NMAc4F/u2LYYzExHAR4MmivE5k3A+1mtxvOE6h4661RmCOHSQ8BbyfRfZ46J/82KSp/r
         ev0Q==
X-Gm-Message-State: AOAM532qg9pTb/WNehSvjcNkzXqvu0DwaP/1Z5lofQY6CTtTSpcDSOu3
        5eQsw3tkHkuAW4+wcKXwR4MgnkFBsSV4HFiInzrF8TZ8
X-Google-Smtp-Source: ABdhPJwFnxDVqryk2d5u+r3zOBTy3CQLKMNm1UXJVNWqLw1pNA8KPsrtB2vGwU+fkyhUIVCSBQXWSnYpAJOS0XhlCqg=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr4587835wrs.124.1597946643168;
 Thu, 20 Aug 2020 11:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200819081808.26796-1-lukas.bulwahn@gmail.com> <f0d3f57c-416c-6a6a-0e9e-d3dc308f2b52@amd.com>
In-Reply-To: <f0d3f57c-416c-6a6a-0e9e-d3dc308f2b52@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Aug 2020 14:03:52 -0400
Message-ID: <CADnq5_NXykUUP8j53EEzo0uDtheokCkjEvjOF+DPaOT=a40=9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unintended executable mode
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dennis Li <Dennis.Li@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Aug 19, 2020 at 4:53 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 19.08.20 um 10:18 schrieb Lukas Bulwahn:
> > Besides the intended change, commit 4cc1178e166a ("drm/amdgpu: replace =
DRM
> > prefix with PCI device info for gfx/mmhub") also set the source files
> > mmhub_v1_0.c and gfx_v9_4.c to be executable, i.e., changed fromold mod=
e
> > 644 to new mode 755.
> >
> > Commit 241b2ec9317e ("drm/amd/display: Add dcn30 Headers (v2)") added t=
he
> > four header files {dpcs,dcn}_3_0_0_{offset,sh_mask}.h as executable, i.=
e.,
> > mode 755.
> >
> > Set to the usual modes for source and headers files and clean up those
> > mistakes. No functional change.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > applies cleanly on current master and next-20200819
> >
> > Alex, Christian, please pick this minor non-urgent cleanup patch.
>
> Alex is usually the one picking those up. If he misses something feel
> free to ping us once more.
>
> Thanks,
> Christian.
>
> >
> > Dennis, Jerry, please ack.
> >
> > Dennis, Jerry, you might want to check your development environment
> > introducing those executable modes on files.
> >
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c                         | 0
> >   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c                       | 0
> >   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h   | 0
> >   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  | 0
> >   drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h  | 0
> >   drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h | 0
> >   6 files changed, 0 insertions(+), 0 deletions(-)
> >   mode change 100755 =3D> 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> >   mode change 100755 =3D> 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.=
c
> >   mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/d=
cn/dcn_3_0_0_offset.h
> >   mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/d=
cn/dcn_3_0_0_sh_mask.h
> >   mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/d=
cn/dpcs_3_0_0_offset.h
> >   mode change 100755 =3D> 100644 drivers/gpu/drm/amd/include/asic_reg/d=
cn/dpcs_3_0_0_sh_mask.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4.c
> > old mode 100755
> > new mode 100644
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/=
amd/amdgpu/mmhub_v1_0.c
> > old mode 100755
> > new mode 100644
> > diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.=
h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> > old mode 100755
> > new mode 100644
> > diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask=
.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> > old mode 100755
> > new mode 100644
> > diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset=
.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
> > old mode 100755
> > new mode 100644
> > diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mas=
k.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
> > old mode 100755
> > new mode 100644
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
