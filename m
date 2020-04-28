Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98994C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E7E2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588089950;
	bh=ha74p5osPq/Fc3CF17rmXyTy7T6X5ysJvW80Tys9jaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=twnvcqUpFBIn4HQOfqpO2s1M5OJ7BUvmVEYF+a/ttT2FmcClfxOM0H5Zfz4Sa3hzM
	 RSWuw7MfCSYsCbVTpqg7lFVTMcihpRYl4Ue0+haoOmxnfpdjWCCGpAnGxngUP23eXt
	 b5A021TIUQEXdAr7PLPTu7/wJxywhYoJVznHGvWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgD1QFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgD1QFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:05:49 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F81D21D7D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588089948;
        bh=ha74p5osPq/Fc3CF17rmXyTy7T6X5ysJvW80Tys9jaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0dbcMJdky6/KE5oqf7xFxKV0nvxCb348kb1V53yMGUJLFKWOd99FZ18n6s9Cczajr
         wdThMp0nDIOERbNXcnSnT6pkavy7nlA3ZNrb6GMRPc/rjX+ChkfWr9ZpJG5/MkQA9t
         W6nkvGowbT6pbDsVK2HQ+a48pjG1aiPKGAaH52XY=
Received: by mail-ed1-f49.google.com with SMTP id t12so16842245edw.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:05:48 -0700 (PDT)
X-Gm-Message-State: AGi0PuYoEBKgeqUfmwSo5on2PX0tViB6N92ILYvH8hDmXynIdWqG4+GI
        oCg88XliAlh3lmtgHBP9kwNA2OaFovXQ+rCICg==
X-Google-Smtp-Source: APiQypKHSVjOdbrgmCD0Ai4eyQOpggee1czWxlBZjdwbOJTigW/nq8+SgqWYpQTsun99LAQNf5hO0fvn3WJwMJdxsNA=
X-Received: by 2002:aa7:dd95:: with SMTP id g21mr22982067edv.148.1588089946412;
 Tue, 28 Apr 2020 09:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200420135045.27984-1-yuehaibing@huawei.com> <CAAOTY__km=QZQACp8g-Qr+aWZ4r0Yp7O5j7u8ZTpDpTXXfUdNw@mail.gmail.com>
 <20200428145507.GQ3456981@phenom.ffwll.local>
In-Reply-To: <20200428145507.GQ3456981@phenom.ffwll.local>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 29 Apr 2020 00:05:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-tNGOaKT9tqT7YSf1hWjShCSMaDxmU2vAqNAGMqPTPBQ@mail.gmail.com>
Message-ID: <CAAOTY_-tNGOaKT9tqT7YSf1hWjShCSMaDxmU2vAqNAGMqPTPBQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mediatek: Fix Kconfig warning
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter <daniel@ffwll.ch> =E6=96=BC 2020=E5=B9=B44=E6=9C=8828=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sun, Apr 26, 2020 at 04:20:39PM +0800, Chun-Kuang Hu wrote:
> > Hi, YueHaibing:
> >
> > YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > WARNING: unmet direct dependencies detected for MTK_MMSYS
> > >   Depends on [n]: (ARCH_MEDIATEK [=3Dy] || COMPILE_TEST [=3Dn]) && CO=
MMON_CLK_MT8173_MMSYS [=3Dn]
> > >   Selected by [y]:
> > >   - DRM_MEDIATEK [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_ME=
DIATEK [=3Dy] || ARM && COMPILE_TEST [=3Dn]) && COMMON_CLK [=3Dy] && HAVE_A=
RM_SMCCC [=3Dy] && OF [=3Dy]
> > >
> > > Add missing dependcy COMMON_CLK_MT8173_MMSYS to fix this.
> >
> > From the code relationship, mediatek drm has relation with mediatek
> > mmsys, and mediatek mmsys has relation with medaitek clock.
> > So I think it's better that CONFIG_MTK_MMSYS select
> > CONFIG_COMMON_CLK_MT8173_MMSYS.
>
> select is very strongly discouraged and should only be used for Kconfig
> symbols not visible to users.

Okay, maybe the better solution is that DRM_MEDIATEK depend on MTK_MMSYS.

Regards,
Chun-Kuang.

> -Daniel
>
> >
> > Regards,
> > Chun-Kuang.
> >
> > >
> > > Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mm=
sys device")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/media=
tek/Kconfig
> > > index c420f5a3d33b..4d9b5540de68 100644
> > > --- a/drivers/gpu/drm/mediatek/Kconfig
> > > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > > @@ -6,6 +6,7 @@ config DRM_MEDIATEK
> > >         depends on COMMON_CLK
> > >         depends on HAVE_ARM_SMCCC
> > >         depends on OF
> > > +       depends on COMMON_CLK_MT8173_MMSYS
> > >         select DRM_GEM_CMA_HELPER
> > >         select DRM_KMS_HELPER
> > >         select DRM_MIPI_DSI
> > > --
> > > 2.17.1
> > >
> > >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
