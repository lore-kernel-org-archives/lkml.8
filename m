Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC23C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEAF206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598828644;
	bh=DBjDH6+zNvjW34pmAg6ijFdsfR7eAU1XQ0DB71Y2mMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y+Twi72r2zEcY/9GpDKCgdvSQ8+hgAMbWFCMCbZC5UB+FKVIOlo0joEzs/x82lBlE
	 2WJT6CHwvmO/yAwQpkLj+nIIQt41cNqIr3d15NaAJMY0Apky3g5R2z8SQXbIcm5swT
	 QiETL2JtW+qU5Sxd75aT86CZavaS8YZUUegLVy0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgH3XEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 19:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgH3XEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 19:04:01 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9700E20EDD
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598828640;
        bh=DBjDH6+zNvjW34pmAg6ijFdsfR7eAU1XQ0DB71Y2mMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AdG2GicfwHXYVdmq7SKuxLonnI4a9+7yvIkyYxp3DjSRp7aFPuweycg9/1ITRS7oY
         nzNBkUZh/wFOSW1SL7FnH6wiO7DWC6oiyAr08piI9cqjGjOXzRqxdSHk4WpQRfh4mG
         efpT+VfmT+dJ8fr90dngXby4e/RbnbEu5Bb0GC7o=
Received: by mail-ed1-f43.google.com with SMTP id l21so3778588eds.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:04:00 -0700 (PDT)
X-Gm-Message-State: AOAM530DUxot2O6/aB9VhAuDMEVAVU6dqsfgA89S8ZnAYw9NsIgQPdil
        iERRg47mBNMy97EYE04f5/3XutUzAxGWe1sjuA==
X-Google-Smtp-Source: ABdhPJyrriOATdP4S++pL2NTqHge5RYs7u29ox2n6iMcVOciI+MvuGLn2MncSErExi+ry6qYh9bfMAMxiAAU5uTIJCs=
X-Received: by 2002:a05:6402:7d1:: with SMTP id u17mr8802306edy.48.1598828639253;
 Sun, 30 Aug 2020 16:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200823014830.15962-1-chunkuang.hu@kernel.org> <20200823014830.15962-5-chunkuang.hu@kernel.org>
In-Reply-To: <20200823014830.15962-5-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 31 Aug 2020 07:03:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8_GFMa9R5CP_Vy6g3E3vEJ4qvCbZ=2vkafh4+4NTziLw@mail.gmail.com>
Message-ID: <CAAOTY_8_GFMa9R5CP_Vy6g3E3vEJ4qvCbZ=2vkafh4+4NTziLw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] MAINTAINERS: add files for Mediatek DRM drivers
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

Hi, Chunfeng & Kishon:

How do you feel about this patch?

Regards,
Chun-Kuang.

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=889:48=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Mediatek HDMI phy driver is moved from drivers/gpu/drm/mediatek to
> drivers/phy/mediatek, so add the new folder to the Mediatek DRM drivers'
> information.
>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index deaafb617361..191bacf02209 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5793,6 +5793,7 @@ L:        dri-devel@lists.freedesktop.org
>  S:     Supported
>  F:     Documentation/devicetree/bindings/display/mediatek/
>  F:     drivers/gpu/drm/mediatek/
> +F:     drivers/phy/mediatek/phy-mtk-hdmi*
>
>  DRM DRIVERS FOR NVIDIA TEGRA
>  M:     Thierry Reding <thierry.reding@gmail.com>
> --
> 2.17.1
>
