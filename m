Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301EC20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WTR0UU+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGHSzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgGHSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:55:53 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F59FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:55:53 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q74so24600020iod.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXGMQZ+ve6vZ2ipClDFItUU2Pup1l9wXtQM6u8l2wRM=;
        b=WTR0UU+cLf/XEP87GLSFBm7SBz61LfJDERL7qcx5aNGpJ4xKKFcfpXrp1VM6+ndif4
         vboYGkDtU7eYOijYqByrCREubsQoF9vgkH0BIYlODGvvdhM/iap/4z+bYI98qdZrpnlG
         dge/8N3LXSf6ugqKZqcKGDhvdEaPiAeiyF2Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXGMQZ+ve6vZ2ipClDFItUU2Pup1l9wXtQM6u8l2wRM=;
        b=pnTYvFxQc5kTvvmg7fCuWSyVobPSG2Mz6dg01P9+9frpaYRLOFenxhHvsxhjFOCcxS
         u3OfNsUBDLX2z6ewziNbGBNWJrKoauWjuH4Btxm0BIOm9XLVTrAqpbzwU3FIabozgU53
         lNnfIUksYiRj/TGXDF1V3f18JeQyxQrLM8INATPpwbywAC6Gf7lRBK6LqC5Vlp53FXAk
         AhejrtEGLMw7CB7Ip6Uyd45WXHHteGkLGAK1DngqEC4YM4TLnmp0+DNEO0DKDrGJPOTL
         BJl8Z0H7C75izMswDsOQ9RPJ3n2t3f9xjNbMd0t56eiNIqYIvLlxC7PBxFM77IYkW32O
         OAAg==
X-Gm-Message-State: AOAM532QkXvUz/g2pzqSpa5UyBB+zUVXTWQ/Z0dWCPX86Q+zkpEQh9Ps
        L8PafFzKbJRtmkKGvLXiquTbl2W/ekO7kUA7EqgTnA==
X-Google-Smtp-Source: ABdhPJzdCydagjZvwmwK0JpNPyAeyndzEPr04+dzCQTBNIw3Ti5enn4p2nsuhiQVZuzypoOF9uSyxTYnUmkeedTcbEo=
X-Received: by 2002:a5d:9347:: with SMTP id i7mr18216963ioo.40.1594234552664;
 Wed, 08 Jul 2020 11:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200706083705.2343150-1-hsinyi@chromium.org> <71bc5fa2-0869-5d91-6bb8-e8d59176e19c@gmail.com>
In-Reply-To: <71bc5fa2-0869-5d91-6bb8-e8d59176e19c@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 9 Jul 2020 02:55:26 +0800
Message-ID: <CAJMQK-iGwXFwkvY_1nYiVQ6D-N5yU8YNqxeaSy-1XNMJHj1H0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: Re-measure capacity-dmips-mhz
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ikjoon Jang <ikjn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 1:01 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 06/07/2020 10:37, Hsin-Yi Wang wrote:
> > Re measure capacity-dmips-mhz on elm and hana:
> >
> > cpu 1:  9502 DMIPS @ 1703 Mhz
> > cpu 3: 16250 DMIPS @ 2106 Mhz
> >
> > ==> 740 : 1024
>
> I have some trouble to match the commit message to the actual patch. Commit
> message talks about cpu 1 but patch changes cpu0. Where are the values of the
> other CPUs?

Small cpu on 8173 is cpu0 & cpu1, while big cpu is cpu2 & cpu3.
Small cpu: 9502 DMIPS @ 1703 Mhz
Big cpu:   16250 DMIPS @ 2106 Mhz

9502/1703 : 16250/2106 = 740 : 1024 (scale big cpu to 1024), and this patch
changes the small cpu value to 740.



>
> Regards,
> Matthias
>
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index 70b1ffcab7f0..5e046f9d48ce 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -167,7 +167,7 @@ cpu0: cpu@0 {
> >                                <&apmixedsys CLK_APMIXED_MAINPLL>;
> >                       clock-names = "cpu", "intermediate";
> >                       operating-points-v2 = <&cluster0_opp>;
> > -                     capacity-dmips-mhz = <526>;
> > +                     capacity-dmips-mhz = <740>;
> >               };
> >
> >               cpu1: cpu@1 {
> > @@ -182,7 +182,7 @@ cpu1: cpu@1 {
> >                                <&apmixedsys CLK_APMIXED_MAINPLL>;
> >                       clock-names = "cpu", "intermediate";
> >                       operating-points-v2 = <&cluster0_opp>;
> > -                     capacity-dmips-mhz = <526>;
> > +                     capacity-dmips-mhz = <740>;
> >               };
> >
> >               cpu2: cpu@100 {
> >
