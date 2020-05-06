Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFA4C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AAA206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588724906;
	bh=DWQzwXVi5jSpdNgL+w7PmIh4LeFt4VjFCSEDXC+7SwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FZcMDrqQ/eOgBVjPaH3V7v1DnNicxKqEkuOhndigNUdOTv0SWdCHivAZvEbisbv+s
	 IHb6Himu/ZdHiw+N4hNWb6Jet/L8gr6hmHRFvb/XUDZK3ezMnuf7JejrBxK976CxBB
	 i3yeEQ/ORrMSK9rynW1t/luFWx+ARACWmRhP+MMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgEFA2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgEFA2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:28:25 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0901F2084D
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 00:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588724904;
        bh=DWQzwXVi5jSpdNgL+w7PmIh4LeFt4VjFCSEDXC+7SwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vPCVMxIGYGpadnCM+jgzVaFSvA1I9nglgBugGqwTM3AYb8hIYe2W3SZl4IeGrLHmp
         ALmred5Ng+DkaSqvPL2SlH2RYZYvWSgFroa04P1rPR5NGspbED9JIipwoyskh7uTFJ
         Q7ujj2Ue3DGl3Huxa5UGjol3FvS1V1HrZcjlK21o=
Received: by mail-ed1-f49.google.com with SMTP id k22so452692eds.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:28:23 -0700 (PDT)
X-Gm-Message-State: AGi0PuZmA9PXrx/ymduJzHW2U1/mvjyfk8PE1BBMHFzkq++6cP53s+zG
        fBmicbfXorikgFJPLy9De9od88/fT2fYu+fgMg==
X-Google-Smtp-Source: APiQypIved3V8B2EWfluqDx98u8I6Wi+wk4pSnJc5XXqvvRqIaWvQAH7HQXR1ZWrM4QKK2OpRJ3waUIbH7TnOFtz2C0=
X-Received: by 2002:aa7:c649:: with SMTP id z9mr5024685edr.288.1588724902330;
 Tue, 05 May 2020 17:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200420135045.27984-1-yuehaibing@huawei.com> <20200429071337.49528-1-yuehaibing@huawei.com>
 <CAAOTY__5rwRQhuy4vT8OiAKMM2bQtCb7w5AW9B5rqL+UVdVpsg@mail.gmail.com>
In-Reply-To: <CAAOTY__5rwRQhuy4vT8OiAKMM2bQtCb7w5AW9B5rqL+UVdVpsg@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 6 May 2020 08:28:09 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Zaa4ecbmzpP+ikw435ig5c9tR1vZH6mK8bGo2dVGVew@mail.gmail.com>
Message-ID: <CAAOTY_-Zaa4ecbmzpP+ikw435ig5c9tR1vZH6mK8bGo2dVGVew@mail.gmail.com>
Subject: Re: [PATCH v3 -next] drm/mediatek: Fix Kconfig warning
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.orc,
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

Hi, YueHaibing:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B44=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:15=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, YueHaibing:
>
> YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:14=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > WARNING: unmet direct dependencies detected for MTK_MMSYS
> >   Depends on [n]: (ARCH_MEDIATEK [=3Dy] || COMPILE_TEST [=3Dn]) && COMM=
ON_CLK_MT8173_MMSYS [=3Dn]
> >   Selected by [y]:
> >   - DRM_MEDIATEK [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_MEDI=
ATEK [=3Dy] || ARM && COMPILE_TEST [=3Dn]) && COMMON_CLK [=3Dy] && HAVE_ARM=
_SMCCC [=3Dy] && OF [=3Dy]
> >
> > Make DRM_MEDIATEK depend on MTK_MMSYS to fix this.
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> >
> > Fixes: 2c758e301ed9 ("soc / drm: mediatek: Move routing control to mmsy=
s device")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> > v3: make DRM_MEDIATEK depends on MTK_MMSYS
> > v2: select COMMON_CLK_MT8173_MMSYS instead of adding DRM_MEDIATEK depen=
dency
> > ---
> >  drivers/gpu/drm/mediatek/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediate=
k/Kconfig
> > index c420f5a3d33b..aa74aac3cbcc 100644
> > --- a/drivers/gpu/drm/mediatek/Kconfig
> > +++ b/drivers/gpu/drm/mediatek/Kconfig
> > @@ -6,12 +6,12 @@ config DRM_MEDIATEK
> >         depends on COMMON_CLK
> >         depends on HAVE_ARM_SMCCC
> >         depends on OF
> > +       depends on MTK_MMSYS
> >         select DRM_GEM_CMA_HELPER
> >         select DRM_KMS_HELPER
> >         select DRM_MIPI_DSI
> >         select DRM_PANEL
> >         select MEMORY
> > -       select MTK_MMSYS
> >         select MTK_SMI
> >         select VIDEOMODE_HELPERS
> >         help
> > --
> > 2.17.1
> >
> >
