Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1792C5519A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9E12071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587889254;
	bh=32JPrJrGuDRD2wkuFtj2MYt27oiR4LTyT2PFdhPaclQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ADGB9xjWbb82v69v6ENoIMHMqCXzv5/u7rzpTIaGvTbQL5fzdXH8reQWFl2yXQAaz
	 mksKEM0IFyPI7+nyy9TM66W1ur0QflhTvxnqDATLhOIDt2TDoNcEUPe5b6ml3MMKgL
	 gLEsAd5a6SSMP8nzV7oRk5/tUo38Od9PDTEBbV/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgDZIUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 04:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgDZIUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 04:20:53 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5D7217BA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587889253;
        bh=32JPrJrGuDRD2wkuFtj2MYt27oiR4LTyT2PFdhPaclQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0tLZar1QUA+vvcNySsyW0rfaxWr2woQV7fXM/l6uVDEwEdBMdtgw//+P20sNglhU3
         iyD7SKLm3Iz9jffpJMcaScYEERBIum/EprF3MM1+3GfpD5aXy7yoPfl3eygBsfKVpA
         XSP2CPssF5zHqiaYcKY2fqCuFWxFRkkcTZMUh+mk=
Received: by mail-ej1-f50.google.com with SMTP id a2so11425437ejx.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 01:20:53 -0700 (PDT)
X-Gm-Message-State: AGi0PuYmSfSya8hSBCzEIYFyKWsSy1BfaYzYlZrhBF1ebjEJXt7D2h3V
        zt4rpbw8ChhjFVazAFutEoRm8Tb3scGMtARFsQ==
X-Google-Smtp-Source: APiQypIeMlhVPVvjZ/EzBhYNkJSsKB75b0ue/XkSPqE14oZvx51BpCqy/qg7FEkcuFRxAPFavqIR3TDtbcx1mHFl0LQ=
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr14806818ejb.201.1587889251405;
 Sun, 26 Apr 2020 01:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200420135045.27984-1-yuehaibing@huawei.com>
In-Reply-To: <20200420135045.27984-1-yuehaibing@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 26 Apr 2020 16:20:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY__km=QZQACp8g-Qr+aWZ4r0Yp7O5j7u8ZTpDpTXXfUdNw@mail.gmail.com>
Message-ID: <CAAOTY__km=QZQACp8g-Qr+aWZ4r0Yp7O5j7u8ZTpDpTXXfUdNw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mediatek: Fix Kconfig warning
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, YueHaibing:

YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> WARNING: unmet direct dependencies detected for MTK_MMSYS
>   Depends on [n]: (ARCH_MEDIATEK [=3Dy] || COMPILE_TEST [=3Dn]) && COMMON=
_CLK_MT8173_MMSYS [=3Dn]
>   Selected by [y]:
>   - DRM_MEDIATEK [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_MEDIAT=
EK [=3Dy] || ARM && COMPILE_TEST [=3Dn]) && COMMON_CLK [=3Dy] && HAVE_ARM_S=
MCCC [=3Dy] && OF [=3Dy]
>
> Add missing dependcy COMMON_CLK_MT8173_MMSYS to fix this.

From the code relationship, mediatek drm has relation with mediatek
mmsys, and mediatek mmsys has relation with medaitek clock.
So I think it's better that CONFIG_MTK_MMSYS select
CONFIG_COMMON_CLK_MT8173_MMSYS.

Regards,
Chun-Kuang.

>
> Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mmsys =
device")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/=
Kconfig
> index c420f5a3d33b..4d9b5540de68 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -6,6 +6,7 @@ config DRM_MEDIATEK
>         depends on COMMON_CLK
>         depends on HAVE_ARM_SMCCC
>         depends on OF
> +       depends on COMMON_CLK_MT8173_MMSYS
>         select DRM_GEM_CMA_HELPER
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
> --
> 2.17.1
>
>
