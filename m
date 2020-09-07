Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C572C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0E8215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599517204;
	bh=swIGSxMN1jDi1c8fwD9FBdsPbQw6ciSZxqdF/TkV9Hs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MNVALbtbVpepM6tUxriiE4CpmMXi/IiZI4fzW8Yg+GX5Zk3Sz8EqQasE355UBe0ya
	 0yh34xYuCxvzFTMnh0YMlYgm7ByJ7j3out79Ljmu63ELfFXeNSglCbbrZog5/ja3jy
	 rEQ9UD5eE8j0xQd/2swoiNK/UihWUr2ez8E/7jTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgIGWUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIGWT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:19:59 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8FF2177B;
        Mon,  7 Sep 2020 22:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599517198;
        bh=swIGSxMN1jDi1c8fwD9FBdsPbQw6ciSZxqdF/TkV9Hs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SRePmzTV+Gw+7ejZ5V2/+/3+ud4cxIYfIZWDTwq1yhlCIVmvNJWSzNn8fCV5oKLD3
         0Jj7TCbJ0Ks8a3mOvr8bkYSfHUL04yghaz8QZe+jI3ffk6aOuKHX7JTzYIsoD0FMo9
         yBNHWv2YVxV5VRdAggSdHLB/MFjHUIGGhRWHIk4Y=
Received: by mail-ed1-f42.google.com with SMTP id q21so14017633edv.1;
        Mon, 07 Sep 2020 15:19:58 -0700 (PDT)
X-Gm-Message-State: AOAM5314wKUmGQOxsWx490DdD+qR4LNdY9ZIIGZqoKGB5gS09iS4Nqfr
        D1tY5UfOP9YL7PAZ3j1sdcdqUI8e6BhW6b6qKA==
X-Google-Smtp-Source: ABdhPJw0U71O9xX+kGgiTo+ISsow9OgeCF69V6CdeVmbppl0sXiRcIe81jcbLFmP95q2wZ92kN3RtTuWDcmb2e/43V0=
X-Received: by 2002:aa7:dcd2:: with SMTP id w18mr24139741edu.288.1599517196951;
 Mon, 07 Sep 2020 15:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200907125646.1946282-1-fparent@baylibre.com>
 <CAAOTY_9HYvxEygv-oz9wf+JjiSfp+Zn1u5okMftz3SncfK0G5A@mail.gmail.com> <CAOwMV_xEEt+m+LuL_3dF2J8rp4m4gn2T8AR5nGLi0sDoiOC=RQ@mail.gmail.com>
In-Reply-To: <CAOwMV_xEEt+m+LuL_3dF2J8rp4m4gn2T8AR5nGLi0sDoiOC=RQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 8 Sep 2020 06:19:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9YE66Ta9Dw6AT45TwawLe1WpVMFcV2wownPYC7bG5cKg@mail.gmail.com>
Message-ID: <CAAOTY_9YE66Ta9Dw6AT45TwawLe1WpVMFcV2wownPYC7bG5cKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: add bindings for MT8167 clocks
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, masahiroy@kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        mars.cheng@mediatek.com, macpaul.lin@mediatek.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        mtk01761 <wendell.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=888=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi Chun-Kuang,
>
> > Why don't you add compatible of "mediatek,mt8167-mmsys"?
>
> I forgot to remove 'mmsys' from the commit message. I decided to add
> the documentation as part of the series that add support for MT8167 to
> drivers/soc/mediatek/mtk-mmsys.c.
>
> If you think it would be better to document it here I can add the
> bindings in the V2.

It's OK that you separate mmsys (main) and mmsys clock (sub) to
different series.
I just want to make sure nothing is missing.

Regards,
Chun-Kuang.
