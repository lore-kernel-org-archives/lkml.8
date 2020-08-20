Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04098C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F9A20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597965829;
	bh=bdKBK2uOPKO413Z0iX2NJvBT7lzP8LgAKIxVU9ocXyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ERZNLPpmhUyiIKafT/IWiJzYSSD30If8Jxv2R7N6OeSIAXslSS3AdUFha3xKvOKSm
	 RFlf5bKpTZKRc35V+P3BHFSM1wCSDvGG/+cYPlCon6yEl0X+FapgjKB+9w3hGzf8dV
	 gFOCK013msjn/OyFH/LxHAQtOW2ZUvjy6WuD5rqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgHTXXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTXXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:23:42 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9B4C208E4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597965822;
        bh=bdKBK2uOPKO413Z0iX2NJvBT7lzP8LgAKIxVU9ocXyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KLLu9WjZQkSJfZ95kIb7q9gMoregri4wHkrkaYg6DER7LjANfLyLhwgW0SWwymYij
         CkNzyxCvpvzX025rioWD9TSShWnjGlBZhxQ4l0Fkt7k2FVXTDyLDNG28+PT10M1XuT
         LmwvziwbM4Jw2B/ZrqyrT2P4wviCvlpt4PenfN0c=
Received: by mail-ed1-f46.google.com with SMTP id b2so1663843edw.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 16:23:41 -0700 (PDT)
X-Gm-Message-State: AOAM530XW4XIGHJlaFn5MT3KWVMAJw+6hAF2ZbF7I4yCNWbCppA+Bdyl
        o6hyYWsoFT9dzIk+lM4NdMDix6EGU5fD/lWU6g==
X-Google-Smtp-Source: ABdhPJxdccf74kgFcrZ/UdWvxCfzmoCcixKQh8r0jcPn1sNOj1J2tB6qrHBNGNgYsoCMJ/EVSE/dUxdjnOVE9JgYNwQ=
X-Received: by 2002:a50:d9c6:: with SMTP id x6mr126778edj.271.1597965820452;
 Thu, 20 Aug 2020 16:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200819025829.57545-1-wanghai38@huawei.com>
In-Reply-To: <20200819025829.57545-1-wanghai38@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 21 Aug 2020 07:23:28 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8-iB9sg4+-AyFpGACc2pW+ZzsJqUbvgReNcfu5kSX6Qw@mail.gmail.com>
Message-ID: <CAAOTY_8-iB9sg4+-AyFpGACc2pW+ZzsJqUbvgReNcfu5kSX6Qw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mediatek: remove duplicate include
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Wang Hai:

Wang Hai <wanghai38@huawei.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8819=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8811:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Remove mtk_drm_ddp.h which is included more than once
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index 040a8f393fe2..a34fd805ce6d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -27,7 +27,6 @@
>
>  #include "mtk_drm_crtc.h"
>  #include "mtk_drm_ddp.h"
> -#include "mtk_drm_ddp.h"
>  #include "mtk_drm_ddp_comp.h"
>  #include "mtk_drm_drv.h"
>  #include "mtk_drm_gem.h"
> --
> 2.17.1
>
