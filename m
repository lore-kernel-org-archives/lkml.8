Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE8BC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB6024683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmLw0Hxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAVUWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:22:05 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35781 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:22:04 -0500
Received: by mail-wr1-f41.google.com with SMTP id g17so522923wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVuD5M/MYCtIro+NiHeJqsEtK6AMbnd7kxhI4hTwchA=;
        b=LmLw0HxdNBFf7ECjrsO5sltd9/xYioUniTzKT1bbDVnXENzkPG3gkkLmeSy4qClr2d
         e8dT3ZVxttShq2xC9cc1Cb9H5fwFDaRTdS7zwQDVHadroujs4Dv+nNgpwlxkeUCI5frb
         Vofl2Q+dUCC2bz+5GNm/pxC+YJfpVsVq9x1/KNCknqF0YhdXSqMVWzmWSkYid8F78UrJ
         RwdP9PO57Y7Ws9hUBvPv6v97LGzGZtH69IFU7ssOR0uaB45Wd7jSd5uvEsQH2s581CrT
         UFWB/62GGDv5384otm3o+Gr7ZS6NcCZ61ih24zvl4D7v6dMYOsMEPnulIRyl0oEWsyVI
         qCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVuD5M/MYCtIro+NiHeJqsEtK6AMbnd7kxhI4hTwchA=;
        b=tsNjw56SoQAt1Gz7yqbbPx0Qoi2FYZ8+X8AwHL0Uj/FbsvAr+A1WtUPK76TA5M0gMp
         JH9Ikbm02/7UyItmUVgu3k4LGoaa26JrxqnUVOeB9ve+1rhqiFd1vhV0UN4R8V6tdiPn
         QR3NmvR4W+zBEiwsF7clDUWi9dO3o1l3pFq0EccXS6MfDk4zAPRd8/5EJ7s1xQ2sngtv
         /3gtspaYJoubEUwHbnuzeECgt3AlopjtN6J1f1VQuhgTaCy41WpsCg60YQG8426ay8rO
         zMsQ8If012Iltt328C2HLKJHl4XLYZb6oHVJt1j4yo/Z04w9zwgmbdiZR9Uy03XujOCx
         BHFg==
X-Gm-Message-State: APjAAAV6J8UzGZN053CiKKioKd0EpP7zRPn0P3RpHwg2mZUJVy2BvJqZ
        YR8XxqZqYBOLUxP6m/KxaDRpAeTvdFnJzQEe3+A=
X-Google-Smtp-Source: APXvYqyeSw31DSoMsVo1tGcVhk/TW2SRv/VBLC1ScXJUSxOqdCQ+CHeLEYjUrgNXmb35TLEgo95z3NVp92YSiJflkKE=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr13693493wrn.124.1579724522583;
 Wed, 22 Jan 2020 12:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20200121135540.165798-1-chenzhou10@huawei.com>
In-Reply-To: <20200121135540.165798-1-chenzhou10@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 22 Jan 2020 15:21:48 -0500
Message-ID: <CADnq5_OeoTqpf5Rhtwac8gJ_8P5rUKYhrhRDC-5BgHt0WUYFnw@mail.gmail.com>
Subject: Re: [PATCH -next 00/14] drm/amdgpu: remove unnecessary conversion to bool
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:08 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> This patch series remove unnecessary conversion to bool in dir
> drivers/gpu/drm/amd/amdgpu/, which is detected by coccicheck.

Thanks for the patches.  Already applied this patch:
https://patchwork.freedesktop.org/series/72281/#rev2
which covers these.

Alex

>
> Chen Zhou (14):
>   drm/amdgpu: remove unnecessary conversion to bool in mmhub_v1_0.c
>   drm/amdgpu: remove unnecessary conversion to bool in vega10_ih.c
>   drm/amdgpu: remove unnecessary conversion to bool in navi10_ih.c
>   drm/amdgpu: remove unnecessary conversion to bool in gfx_v10_0.c
>   drm/amdgpu: remove unnecessary conversion to bool in sdma_v5_0.c
>   drm/amdgpu: remove unnecessary conversion to bool in athub_v1_0.c
>   drm/amdgpu: remove unnecessary conversion to bool in amdgpu_acp.c
>   drm/amdgpu: remove unnecessary conversion to bool in soc15.c
>   drm/amdgpu: remove unnecessary conversion to bool in nv.c
>   drm/amdgpu: remove unnecessary conversion to bool in mmhub_v9_4.c
>   drm/amdgpu: remove unnecessary conversion to bool in amdgpu_device.c
>   drm/amdgpu: remove unnecessary conversion to bool in athub_v2_0.c
>   drm/amdgpu: remove unnecessary conversion to bool in sdma_v4_0.c
>   drm/amdgpu: remove unnecessary conversion to bool in gfx_v9_0.c
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++-----
>  drivers/gpu/drm/amd/amdgpu/athub_v1_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/athub_v2_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c            |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         | 28 ++++++++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  2 +-
>  15 files changed, 43 insertions(+), 45 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
