Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E05C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90794214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyfnqLcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgDQN6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730687AbgDQN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:58:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A10C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:58:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so3177866wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3NhOD7WWCRFx2NWhkccCqUNA946AiGi6gVRl1iOG8JY=;
        b=qyfnqLcP+9kRh0M5SMq3ClD2TyNOg2DQBddfRvlwEQF+YzANtODQE9oMBqhMir6PtP
         nePvDTfrt8dYFjR3dD1sdiAvn1i+YB0JMDQsCNrBqQtw7wsRv6oJR66nY4BI/YqnCXNn
         S7zOrxeniQ9CILrkRmG8vZ6jgdyfgpJ6UDD55lkPPoPnPwhzS7yzdbokS2ELU4gc+S/r
         tZsF1DfgSbAdCjRLJ7UtFmZ8pWIUIUmeMGHrjOsJuTbbrsXYViOcMhwKBtg33lvptF6d
         4Osc+ftORpKT2meqaMhgycJPvtzeEMNpVepRknzSnhJ5QsfVcAlpSlLjWpscVcnh5lQl
         ltMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3NhOD7WWCRFx2NWhkccCqUNA946AiGi6gVRl1iOG8JY=;
        b=kG+jHJe/8kdiELYMxOy86sRSf1t7X03XS661JtTW7KrhI8eTVBrhR7NI6DP013V+7n
         BbdCj7uN5WNPNlp0eAJv1xHsq9suUdOkOeUsxnaYdGGLLyYCWBMrjBy/fPZadmDGuy62
         1xsU9avOkSmM7W/vaIpRJdorCJTPBScBZ5bhrH3dPZLR7ITgVRFTNfan6R5Zq36lcJuU
         ghdDfcJJfZZ71Dc3EP5OQkgtbgBXi2UHB3lhYQu6GEKBm7ZTw7snPgIA0hE9HjunMJmU
         /7fnCIAubW8j9eDh1NY+OF6phIH4K7mhPK9xZCGLygTPYYzyovicIs89TZmZt0CxI9W2
         Ze+w==
X-Gm-Message-State: AGi0PuYmOPC9uI+UtJONYU40pr1iryQ08/hXyJmlc9SQzOwpODM+4/UD
        odEy4+/AGQ6Q8rb7zvjh+S7MCFuDy8ViGnHESLk=
X-Google-Smtp-Source: APiQypKZa7qguwGxfdxcCF2TK+61OAmPsOG+ZgPl4y3bjlh/AJZ2N3AnJWbmdkm8BbYfsOXpqUarNyQq6OUyOFFqJ3s=
X-Received: by 2002:a5d:4106:: with SMTP id l6mr4008599wrp.111.1587131894437;
 Fri, 17 Apr 2020 06:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200417073219.40320-1-yanaijie@huawei.com>
In-Reply-To: <20200417073219.40320-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Apr 2020 09:58:03 -0400
Message-ID: <CADnq5_OTQEvOFZ3WaOAGQqMpkcsSkQ2fwge2+YUV59URnwLHgw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: remove defined but not used variables
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
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

On Fri, Apr 17, 2020 at 9:16 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following gcc warning:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:710:46:
> warning: =E2=80=98PSMGCEDCThresholdConfig_vega10=E2=80=99 defined but not=
 used
> [-Wunused-const-variable=3D]
>  static const struct vega10_didt_config_reg
> PSMGCEDCThresholdConfig_vega10[] =3D
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/vega10_powertune.c:654:46:
> warning: =E2=80=98PSMSEEDCThresholdConfig_Vega10=E2=80=99 defined but not=
 used
> [-Wunused-const-variable=3D]
>  static const struct vega10_didt_config_reg
> PSMSEEDCThresholdConfig_Vega10[] =3D
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied.  Thanks!

Alex

> ---
>  .../amd/powerplay/hwmgr/vega10_powertune.c    | 23 -------------------
>  1 file changed, 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/dri=
vers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> index ca9b23b5abc9..9757d47dd6b8 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
> @@ -651,18 +651,6 @@ static const struct vega10_didt_config_reg   PSMSEED=
CStallDelayConfig_Vega10[] =3D
>         {   0xFFFFFFFF  }  /* End of list */
>  };
>
> -static const struct vega10_didt_config_reg   PSMSEEDCThresholdConfig_Veg=
a10[] =3D
> -{
> -/* ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> - *      Offset                             Mask                         =
                        Shift                                              =
    Value
> - * ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> - */
> -       /* SQ EDC THRESHOLD */
> -       {   ixDIDT_SQ_EDC_THRESHOLD,           DIDT_SQ_EDC_THRESHOLD__EDC=
_THRESHOLD_MASK,           DIDT_SQ_EDC_THRESHOLD__EDC_THRESHOLD__SHIFT,    =
        0x0000 },
> -
> -       {   0xFFFFFFFF  }  /* End of list */
> -};
> -
>  static const struct vega10_didt_config_reg   PSMSEEDCCtrlResetConfig_Veg=
a10[] =3D
>  {
>  /* ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> @@ -707,17 +695,6 @@ static const struct vega10_didt_config_reg   PSMSEED=
CCtrlConfig_Vega10[] =3D
>         {   0xFFFFFFFF  }  /* End of list */
>  };
>
> -static const struct vega10_didt_config_reg   PSMGCEDCThresholdConfig_veg=
a10[] =3D
> -{
> -/* ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> - *      Offset                             Mask                         =
                        Shift                                              =
    Value
> - * ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> - */
> -       {   mmGC_EDC_THRESHOLD,                GC_EDC_THRESHOLD__EDC_THRE=
SHOLD_MASK,                GC_EDC_THRESHOLD__EDC_THRESHOLD__SHIFT,         =
        0x0000000 },
> -
> -       {   0xFFFFFFFF  }  /* End of list */
> -};
> -
>  static const struct vega10_didt_config_reg   PSMGCEDCDroopCtrlConfig_veg=
a10[] =3D
>  {
>  /* ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------
> --
> 2.21.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
