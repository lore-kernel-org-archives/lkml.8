Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4D8C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E9B2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599058729;
	bh=gBVOTaKneMMxgCAgGNfhmmESJjJgjZ9QwPp7zryvhx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=13hrmGVIwReumx69ybuU0+d087beRsP7FGtXi0AAAkDKjZbgQZDCEAi+InXNH6+YX
	 Rp7Y5spSxAo1MurnCs2iT1ltOLek+XW7hSE+aZPQxXQRMYE68Fs5ZP4Hrv07OcEwcR
	 t8m2AknY1i1wvIpzWVEK05cZh4Kig4Wk/uWR7/F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgIBO6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgIBO60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:58:26 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AACE20BED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599058705;
        bh=gBVOTaKneMMxgCAgGNfhmmESJjJgjZ9QwPp7zryvhx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vvv9VrQO6bAgn8luFm9R9vLPl4jT3Er12xrknUnKuH7s0mLDQU2npW7WpfS3lp9fT
         d4sqZlLyfPThi4M21T8Mknx+giVMK0V51cautJcqGVba+1gB1kezmgapcdeaLP+crj
         1IKtYbNzd2j7sKL0PTIIGPxoHh9JGIq6q3e3rk2g=
Received: by mail-ed1-f48.google.com with SMTP id q21so5252394edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM533Suz58SEWMAdEoKA9gt0yFYfOows0e3Toeyjde6sOVlI9UTNfE
        p5lAASLtOIaSTMPGoMNuTKGhQYSKN5YuDAuOXg==
X-Google-Smtp-Source: ABdhPJxiUKeT463CKXMbKNOTTXvuh8ChtIWwveqT19sIFc5GWW6eJtVKFAP6EJWl77VhTt3QaOUa/DVGqW+rN6PfNI0=
X-Received: by 2002:a50:ef15:: with SMTP id m21mr474435eds.300.1599058704159;
 Wed, 02 Sep 2020 07:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200823014830.15962-1-chunkuang.hu@kernel.org>
In-Reply-To: <20200823014830.15962-1-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 2 Sep 2020 22:58:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9ELMBK7zPeeBQ39QjJ9g4PsOhpHXsTBHgcq=kNk8bRxA@mail.gmail.com>
Message-ID: <CAAOTY_9ELMBK7zPeeBQ39QjJ9g4PsOhpHXsTBHgcq=kNk8bRxA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Move Mediatek HDMI PHY driver from DRM folder to
 PHY folder
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=889:48=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> mtk_hdmi_phy is currently placed inside mediatek drm driver, but it's
> more suitable to place a phy driver into phy driver folder, so move
> mtk_hdmi_phy driver into phy driver folder.

For this series, applied to mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Changes in v5:
> - Fixup indent in Kconfig.
> - Refine config help message.
> - Refine Makefile.
>
> Changes in v4:
> - Rebase onto 5.9-rc1
> - Remove mtk_hdmi_conf_mt8173.
>
> Changes in v3:
> - Modify [PATCH v2 3/4] prefix.
>
> Changes in v2:
> - include module.h in mtk_hdmi.c
>
> CK Hu (3):
>   drm/mediatek: Move tz_disabled from mtk_hdmi_phy to mtk_hdmi driver
>   drm/mediatek: Separate mtk_hdmi_phy to an independent module
>   phy: mediatek: Move mtk_hdmi_phy driver into drivers/phy/mediatek
>     folder
>
> Chun-Kuang Hu (1):
>   MAINTAINERS: add files for Mediatek DRM drivers
>
>  MAINTAINERS                                   |  1 +
>  drivers/gpu/drm/mediatek/Kconfig              |  2 +-
>  drivers/gpu/drm/mediatek/Makefile             |  5 +----
>  drivers/gpu/drm/mediatek/mtk_hdmi.c           | 21 +++++++++++++++----
>  drivers/gpu/drm/mediatek/mtk_hdmi.h           |  1 -
>  drivers/phy/mediatek/Kconfig                  |  7 +++++++
>  drivers/phy/mediatek/Makefile                 |  5 +++++
>  .../mediatek/phy-mtk-hdmi-mt2701.c}           |  3 +--
>  .../mediatek/phy-mtk-hdmi-mt8173.c}           |  2 +-
>  .../mediatek/phy-mtk-hdmi.c}                  |  3 ++-
>  .../mediatek/phy-mtk-hdmi.h}                  |  2 --
>  11 files changed, 36 insertions(+), 16 deletions(-)
>  rename drivers/{gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c =3D> phy/mediatek=
/phy-mtk-hdmi-mt2701.c} (99%)
>  rename drivers/{gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c =3D> phy/mediatek=
/phy-mtk-hdmi-mt8173.c} (99%)
>  rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.c =3D> phy/mediatek/phy-mt=
k-hdmi.c} (98%)
>  rename drivers/{gpu/drm/mediatek/mtk_hdmi_phy.h =3D> phy/mediatek/phy-mt=
k-hdmi.h} (95%)
>
> --
> 2.17.1
>
