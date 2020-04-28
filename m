Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EAEC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2E1206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BZjH9ieY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgD1OzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727775AbgD1OzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:55:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6BC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:55:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so3135937wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6jFGKnF82v8suNis8fMuokycBjbhGzKZuUKxIPnz6aU=;
        b=BZjH9ieYve/gpLatbRDZvJ5mYMgq6YUzTeqo/oWKI+CvmthCFiA2MHvBErEm7R56zX
         yGznMbgkGKeZ+H/WGkmuaje2vBjRkQceSGF3pHEBbC5mX9V583N7EswiLWe5KsmKjLY1
         7ME8A6V8IBT7cX79iEnfogPbJkUN3SvScH9Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6jFGKnF82v8suNis8fMuokycBjbhGzKZuUKxIPnz6aU=;
        b=E1C8krR5qJT7oQuKdtmtX6s55QU/DSAYxggZ4mdgFWqpmdiCabe2c4kJKo5BW7vWzq
         X7F4A8ZZLHumwSW8jB24xSNzORfodCW3kEKjcwHTFIFM44qdVZau3TfmAqhkrhgTW7mn
         zlseaognlpYwcYw590lsouxq0sfufcSMCFanGu0jNm+j4eOFAW/3QU/vZ16Iiurklv/L
         xxXMy6sa4IUD+W28bUGpUhgKAxkUAbfLgn3tbacUoxpOiGmwP/0JAOO6xflXYZ3vt9hD
         NPqc6gn+Ox5SohIGFpoN0P5ewcHFKWPklXHObss1hLnAzTOLgOtxeUt7eX51MbpoYFPJ
         7Mkw==
X-Gm-Message-State: AGi0PuYzYBTarI9tddOms7IHDUSgUO+znBY1ez+R8QYqfWD2N8+iDe+h
        iiK4O44T9bDdTy6AA5+C7tVJwQ==
X-Google-Smtp-Source: APiQypLVWUTBQ/2GQLWlB4vZEl5cImSOrQr/pNFn43Y9nr0LlTg+bI/kjjQbJ752mXJz4e4Gw8vG/Q==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr4825208wmj.169.1588085709816;
        Tue, 28 Apr 2020 07:55:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p190sm3680671wmp.38.2020.04.28.07.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 07:55:09 -0700 (PDT)
Date:   Tue, 28 Apr 2020 16:55:07 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
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
Subject: Re: [PATCH -next] drm/mediatek: Fix Kconfig warning
Message-ID: <20200428145507.GQ3456981@phenom.ffwll.local>
Mail-Followup-To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
References: <20200420135045.27984-1-yuehaibing@huawei.com>
 <CAAOTY__km=QZQACp8g-Qr+aWZ4r0Yp7O5j7u8ZTpDpTXXfUdNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOTY__km=QZQACp8g-Qr+aWZ4r0Yp7O5j7u8ZTpDpTXXfUdNw@mail.gmail.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 04:20:39PM +0800, Chun-Kuang Hu wrote:
> Hi, YueHaibing:
> 
> YueHaibing <yuehaibing@huawei.com> 於 2020年4月20日 週一 下午10:04寫道：
> >
> > WARNING: unmet direct dependencies detected for MTK_MMSYS
> >   Depends on [n]: (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && COMMON_CLK_MT8173_MMSYS [=n]
> >   Selected by [y]:
> >   - DRM_MEDIATEK [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_MEDIATEK [=y] || ARM && COMPILE_TEST [=n]) && COMMON_CLK [=y] && HAVE_ARM_SMCCC [=y] && OF [=y]
> >
> > Add missing dependcy COMMON_CLK_MT8173_MMSYS to fix this.
> 
> From the code relationship, mediatek drm has relation with mediatek
> mmsys, and mediatek mmsys has relation with medaitek clock.
> So I think it's better that CONFIG_MTK_MMSYS select
> CONFIG_COMMON_CLK_MT8173_MMSYS.

select is very strongly discouraged and should only be used for Kconfig
symbols not visible to users.
-Daniel

> 
> Regards,
> Chun-Kuang.
> 
> >
> > Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mmsys device")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/gpu/drm/mediatek/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
> > index c420f5a3d33b..4d9b5540de68 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -6,6 +6,7 @@ config DRM_MEDIATEK
> >         depends on COMMON_CLK
> >         depends on HAVE_ARM_SMCCC
> >         depends on OF
> > +       depends on COMMON_CLK_MT8173_MMSYS
> >         select DRM_GEM_CMA_HELPER
> >         select DRM_KMS_HELPER
> >         select DRM_MIPI_DSI
> > --
> > 2.17.1
> >
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
