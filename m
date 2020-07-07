Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3654AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159AD206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEgzrmFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGLgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgGGLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:36:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4FC08C5E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:36:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so24526479lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaUdPMwTbym0/FOb53irCXsw858iJMpd+U7fSCxbrZw=;
        b=EEgzrmFOPBRJPWSIHRYyePa9lAGoPCoxXqN3mLLCIQDZuRhWVmoWdIo9koYco7oq32
         vFLlttQN2LTQr2685xKsPGTcpR+SI/aGR9ptBAspLpMDLtnyIVcelAgEmNvUgUNT3Aw2
         5gDlCgfPKeKuRHTfhOvblO0quMu/M2GIaqhvEdyA4m0TtDrgBd9nLiKs+XRoNuQIxx5r
         xFw4hBR6ouQOf264O3KjYNKNtoiN1ZXqrS8VAVcqrL9tKo7cEpwCl77SdvW1KJAEuA12
         ZXDeXEgnbXWq7SkuqBrrVcROSIOaA257MsCDJHIFHBVIM8DlWdeE3/nbJvAeiXXL5aXt
         fYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaUdPMwTbym0/FOb53irCXsw858iJMpd+U7fSCxbrZw=;
        b=h5JPNM2nNQ4wrUQ0bPYaOYCZjBJQwpzWEljzoDitSo6DenWLsC40lvzbcFAqUx5dGZ
         2XWhh/Dv2t2XdtD0m72p1a2x6Uf+IJlYLcg9a92sJ9wULqRpMuu6+lH3JJHh9nvxEPD0
         Hg0foRI9tcZJiIyH8jpG8Zdw+xlJSqYr1mUqsCoGRCS2UbXUQl1IFpBfFAb74kkxcE77
         DzdMIMeY67xF7vGiG6rpA+snIlp2IoVi6WJP71a5+KGwoGn73Xt/Z4IUrm33VJlCKaaE
         JwPACtAEFXOMyMWHXx+OZ0zK4DnF3ATyasgXGALdhmjRCQ+oJVkLXeL38MbJs00ZNiXb
         wQCA==
X-Gm-Message-State: AOAM531Najq574DlqHAVONLl1i047RIMHdtDYR5m5a/P7vvEXLWjRTos
        YkjtWUcAr+5asCx6jpy0XKAYcz1vOpa1SpSat6AOSkKoMwg=
X-Google-Smtp-Source: ABdhPJwURK8xxItk20LIQyik7OCxh3Na7DKcSEzSy2t02n+xFYxkh4Kdd3MsRtyCZLblZdRY6s0fjloV3UCAX3MmsHk=
X-Received: by 2002:a19:7407:: with SMTP id v7mr31140846lfe.4.1594121771982;
 Tue, 07 Jul 2020 04:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <1592480018-3340-1-git-send-email-hanks.chen@mediatek.com> <1592480018-3340-6-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1592480018-3340-6-git-send-email-hanks.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 13:36:01 +0200
Message-ID: <CACRpkdZc+PVGOXwba=ocs-VBh-sJT_1dpEVSxnjdwbmM_d0LFw@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] pinctrl: mediatek: add mt6779 eint support
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Andy Teng <andy.teng@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, wsd_upstream@mediatek.com,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 1:34 PM Hanks Chen <hanks.chen@mediatek.com> wrote:

> add driver setting to support mt6779 eint
>
> Acked-by: Sean Wang <sean.wang@kernel.org>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>

Patch applied.

Yours,
Linus Walleij
