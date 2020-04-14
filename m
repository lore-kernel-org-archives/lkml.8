Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F295BC38A2D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBE320768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586906333;
	bh=TIDIviyEYvN23MqFWk6rl7nwsfElsevepgo9cj0fDa0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uLruOS/sNfW4QguZ/qyPExIoWos0Utu4+xUHYK4n081kj9rDgerfKgAgPxs9Z6LaX
	 3gTbplC8rb7hkRrteeepxLKmn3sdRngBPWXeeqWCDuXMgwZ0jKwnQ84mwcxQoYMXTQ
	 NsTGSa6Q6B7TjgYdpbGFPcsd7KN2GQ7gZYrfI1ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392106AbgDNXSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392083AbgDNXSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:18:51 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D68C2072D;
        Tue, 14 Apr 2020 23:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586906330;
        bh=TIDIviyEYvN23MqFWk6rl7nwsfElsevepgo9cj0fDa0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BlTi57WWPhRfW7sJMv5MxtonFNkCoY3uTo3bX4GCktl3OJfOEMkXo/jFDOgJC3Xhx
         YYZwkDurIo88TwaWUqFS6rvVSLyvaJpZb+mYFSf0te1Mrgh938AILR0wS/rK6kk+wG
         zu0wwxVhweZhfP5OXayIki3MMJ01LkvWJNk014kg=
Received: by mail-ed1-f44.google.com with SMTP id s10so1941321edy.9;
        Tue, 14 Apr 2020 16:18:50 -0700 (PDT)
X-Gm-Message-State: AGi0PuaXBhiHzKA+fXdcC18G/yCx4pfV5NTJRnBkoXF4KiJeysm0wNhl
        QYzYb1EV/IczxYeoL+msTnchvztQi0CDJpk6UA==
X-Google-Smtp-Source: APiQypLlqRYq43AAFMZg/IO4wBtIyFmNe19LoGBoUzW3+lEwF9tJ5dD9i42daP7Zkk0pVFZPG7mhoy00oQKf+v9hKRU=
X-Received: by 2002:aa7:c649:: with SMTP id z9mr8144084edr.288.1586906328844;
 Tue, 14 Apr 2020 16:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200414030815.192104-1-hsinyi@chromium.org> <20200414030815.192104-2-hsinyi@chromium.org>
In-Reply-To: <20200414030815.192104-2-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 15 Apr 2020 07:18:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY__oL1LxFxmBSp+cC__ZcGVifQ3f+gPKSWFZKJV4aRCDJw@mail.gmail.com>
Message-ID: <CAAOTY__oL1LxFxmBSp+cC__ZcGVifQ3f+gPKSWFZKJV4aRCDJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] media: mtk-mdp: Use correct aliases name
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B44=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:08=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> aliases property name must include only lowercase and '-'. Fix in dts
> and driver.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/medi=
a/platform/mtk-mdp/mtk_mdp_comp.c
> index 14991685adb7..58abfbdfb82d 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> @@ -15,10 +15,10 @@
>
>
>  static const char * const mtk_mdp_comp_stem[MTK_MDP_COMP_TYPE_MAX] =3D {
> -       "mdp_rdma",
> -       "mdp_rsz",
> -       "mdp_wdma",
> -       "mdp_wrot",
> +       "mdp-rdma",
> +       "mdp-rsz",
> +       "mdp-wdma",
> +       "mdp-wrot",
>  };
>
>  struct mtk_mdp_comp_match {
> --
> 2.26.0.110.g2183baf09c-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
