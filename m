Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EA8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 23:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479802070A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 23:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596411512;
	bh=AbG/PXAqhgPVuIkQmoLq+95PIZjq2tZT6mMRiYuDpWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oke84lZYu3bIXKCwaoxhC3Sc0BG0Aa+tv3TNpgwvSt7o3rYUyhJWBolqZhtnKXFlf
	 7epJ6l5I4sjlLG+rsYIUEQ/fsjzMYXJn5k84guab5zJLl3xdSXpHBZkyMFEmRqIw0Q
	 98JZJWCB4hJytW//K2z37P3GklMQgtSWFzliztEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgHBXia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 19:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgHBXia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 19:38:30 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A248207FB
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 23:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596411509;
        bh=AbG/PXAqhgPVuIkQmoLq+95PIZjq2tZT6mMRiYuDpWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EanpZdFeb8rYupCfIPn6Fs/UavWempboc9Wa9k0ebsXRsV2H9jeABwmXiYO6CnaYH
         gyz8NtTLsPx94fS5ljo9Z1mH1kGafsh3r2+NXKbLtPuckKFideuy0iXvdqQ3tHuz8f
         jsOo28LALgxXoVrxFp4UU+SlG+lfPQ3VJHVWCpDQ=
Received: by mail-ed1-f44.google.com with SMTP id i6so348171edy.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 16:38:29 -0700 (PDT)
X-Gm-Message-State: AOAM533uRrOMIm5R4jVRmME3OAT8iRvTWYWGtAxU20mvoenlDnlvSC/R
        EcbBt9hxgONo/7mOq7mEVVC+aXbhOhbEKtuL+A==
X-Google-Smtp-Source: ABdhPJyFe20LlQFIDpRDCTfuWW+wEB+O/g/9f02O9oqUGPkMHjgGv4vDDhGCFULSLVE//K2Ox0J9Smx9kWnqwXl3DME=
X-Received: by 2002:aa7:c606:: with SMTP id h6mr713213edq.288.1596411507931;
 Sun, 02 Aug 2020 16:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200728111800.77641-1-frank-w@public-files.de>
 <20200728111800.77641-3-frank-w@public-files.de> <CAAOTY__7wCeTm0OY0P1VKZp-r7+d7yj=LLb79Nzr1pVVkOjy2g@mail.gmail.com>
 <6F0FD8AA-A582-45FC-BE1A-06B3812B3DEF@public-files.de>
In-Reply-To: <6F0FD8AA-A582-45FC-BE1A-06B3812B3DEF@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 3 Aug 2020 07:38:15 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9PZQLNFNfOPVL-YnvPNG6WjY7pcwK+wO0vEFkR=19txA@mail.gmail.com>
Message-ID: <CAAOTY_9PZQLNFNfOPVL-YnvPNG6WjY7pcwK+wO0vEFkR=19txA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] drm/mediatek: fix boot up for 720 and 480 but 1080
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=882=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8812:44=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> Am 2. August 2020 02:08:44 MESZ schrieb Chun-Kuang Hu <chunkuang.hu@kerne=
l.org>:
> >Hi, Frank:
> >> - disable tmds on phy on mt2701
> >> - support other resolutions like 1280x1024
> >
> >If this patch does two things, it should be broken into two patches.
> As far as i see,it only disable tmds and so fix specific resolutions like=
 the the one below.some other (like 1080p) does not have this Problem.

OK, this is one thing, "disable tmds on phy on mt2701 to support other
resolutions like 1280x1024"

>
> > I think every pll is default off, so you should turn on pll rather
> > than disable tmds
>
> Is disabling tmds wrong here? Which pll is needed here? What does tmds? I=
 got only the Patches for testing....

I don't know how does this pll and tmds work. I think you and me are
both not familiar with this hdmi phy. I agree this modification could
fix some problem, but does this patch have side effect which trigger
another problem? I need some reasonable description so I could have
confidence on this patch. tmds is a function in mt2701 but you disable
it. This mean you disable some function of this hardware. Why mt2701
does not need it?

Regards,
Chun-Kuang.

>
> >> without this Patch i see flickering on my TFT (1280x1024),
> >> so i guess clock is wrong.
>
> regards Frank
