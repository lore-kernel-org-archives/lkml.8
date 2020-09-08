Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D590C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F682067C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599590978;
	bh=/PlDYc73I5PrW5B6uIA1VQLp4BTV4oHIIammujpUcdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r7q6pHNuBLiTmmQKPKoBwwxsaQ25iE36su0mzqIF2LLWTEudSxJgmncfSbWXnwC76
	 BZ5tDO2OE/Y2SeKy6snhaleklayjzsIzAAaqXqulUUudjyUv58jA1EVtsLA9C3uWeX
	 igKdOejxNDiOFLQcP5puokiuoRlOWST4+5KkohHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgIHStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgIHSt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:49:28 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB5E20936;
        Tue,  8 Sep 2020 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599590968;
        bh=/PlDYc73I5PrW5B6uIA1VQLp4BTV4oHIIammujpUcdc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HmSGh740yu0BG3o8RZaACSnauoPWIiTMdYNbvbpK4Xfg6Qt9yp/9PbedxzmcGP1yU
         gjizIm8AsQYWnKT1w1+JMCOEXMD/RPG6Jr9ca5fIF/zf5pk2X5m86NCTO0LFqcI8lB
         P6LtCYENiYCraQuMzg/RpFnCp6zLi/BfcHykm6AI=
Received: by mail-oo1-f44.google.com with SMTP id z1so4181677ooj.3;
        Tue, 08 Sep 2020 11:49:27 -0700 (PDT)
X-Gm-Message-State: AOAM532iPabKuWaYeillxffAAa72ppM/1YaQjXNc4X/BJpJ3VJsejRFm
        VBevMGUBvyAQ9tAMiuD3W3e/aAsCAvODS9sabg==
X-Google-Smtp-Source: ABdhPJya9363hct12OY48mS3oy3MugvGqPp1r0CFLg7IaMo8S66bOWAkKXuaqZ594ecf4YPBAZ2NNNnWHCf5O70mBZA=
X-Received: by 2002:a4a:d38c:: with SMTP id i12mr3445oos.81.1599590967271;
 Tue, 08 Sep 2020 11:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-3-crystal.guo@mediatek.com> <20200825190219.GA1125997@bogus>
 <1598440183.30048.14.camel@mhfsdcap03> <6c292056-1cb1-bc6c-0422-46e047dcf08f@ti.com>
In-Reply-To: <6c292056-1cb1-bc6c-0422-46e047dcf08f@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Sep 2020 12:49:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKuL7XM2CL3z0OQdRua5YJO2ZRdsoE3fdAH948mKGfWnA@mail.gmail.com>
Message-ID: <CAL_JsqKuL7XM2CL3z0OQdRua5YJO2ZRdsoE3fdAH948mKGfWnA@mail.gmail.com>
Subject: Re: [v4,2/4] dt-binding: reset-controller: ti: add
 'mediatek,infra-reset' to compatible
To:     Suman Anna <s-anna@ti.com>
Cc:     Crystal Guo <crystal.guo@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <Yingjoe.Chen@mediatek.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        =?UTF-8?B?WW9uZyBMaWFuZyAo5qKB5YuHKQ==?= <Yong.Liang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 5:26 PM Suman Anna <s-anna@ti.com> wrote:
>
> Hi Rob,
>
> On 8/26/20 6:09 AM, Crystal Guo wrote:
> > On Wed, 2020-08-26 at 03:02 +0800, Rob Herring wrote:
> >> On Mon, Aug 17, 2020 at 11:03:22AM +0800, Crystal Guo wrote:
> >>> The TI syscon reset controller provides a common reset management,
> >>> and is suitable for MTK SoCs. Add compatible 'mediatek,infra-reset',
> >>> which denotes to use ti reset-controller driver directly.
> >>>
> >>> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> >>> index ab041032339b..5a0e9365b51b 100644
> >>> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> >>> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> >>> @@ -25,6 +25,7 @@ Required properties:
> >>>                         "ti,k2l-pscrst"
> >>>                         "ti,k2hk-pscrst"
> >>>                         "ti,syscon-reset"
> >>> +                       "mediatek,infra-reset", "ti,syscon-reset"
> >>
> >> You need your own binding doc. If you can use the same driver then fine,
> >> but that's a separate issue. There's also reset-simple driver if you
> >> have just array of 32-bit registers with a bit per reset.
> >>
> >> Don't repeat 'ti,reset-bits' either.
> >
> > Do you mean I should add a Mediatek reset binding doc, although Mediatek
> > reuse the TI reset controller directly?
>
> Hmm, how do you envision not repeating the same bits in a separate binding?

I mean 'ti,reset-bits' isn't really something that should have been in
DT in the first place, but rather implied by the compatible string.

> Does it help if I convert this to YAML first without a ti, prefix in the file name?

No, I don't think this should be a shared binding. The driver may be
able to be shared, but that's independent from the binding.

Rob
