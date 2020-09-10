Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1DC2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F3F20872
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HHQ0KEJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIJH6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgIJH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:58:13 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A04C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:58:13 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p13so4849263ils.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tai8qFjVTbhhMUuPlONXFVjFgWeR4r6/lSqQDCLq2Ok=;
        b=HHQ0KEJWk1ralebxe9GR2V01kcrVKprxD80d3zhG0zDJlDbWa9ZKlHRw5Ek9+YgTFE
         g4rJm2dV+c95CN7Fc7NsqQh6fzmVSt1VL9/9QhLdmRBciKqnWJMIfwDXYUBZMkwHcVI6
         qzq8M89gNp9EI0BZB84MzWbdZmibXau0F4SCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tai8qFjVTbhhMUuPlONXFVjFgWeR4r6/lSqQDCLq2Ok=;
        b=BtuYzjkHH96CelDalaq/bam+jukRxziGiFDAm1+p6AmNdYLv9DVLDLnxdY59xBx9hp
         eJO3vE3qW1xn6UT1l1iSmlbFyW0P7cKLzdDG/0iVpV1nwOmB4fSc6TmRo2t80RfsWcF3
         FqnnYmPWNmEvkEIxLWQ7zDJJO2nfncFvPSwPLVUCvlfwYtrxYCbbTuVVwDqSBOlO0ygJ
         H4nHL2skYITELcwfd+4CJ+NwF7DvhlO6F/CYswgkC1x8g95iFWXKWiU4junZNlJwZump
         iM8g7k+Q9cMvQK9CCs9z2FogXC3jvwy2RKHkd62NneSuPqvRGeaf0Tq2U1mhDGq24StE
         Tugg==
X-Gm-Message-State: AOAM533iqNt8VHfW9pRKH4Pc3BswSLJGTe64n05JYoZ2M3RbKY3+B/p4
        Ks4VTG+syHhw6zdB6IDTOzyTrSBREvO93mBxgHj0Dw==
X-Google-Smtp-Source: ABdhPJyPFdwKoALShiSo00RiIsvWpaoDC6tNAVzVFRh5HuKKh0MkaY3m7URBqCj+sI1i+vLSoqqISiWX5+cWI3mCkyw=
X-Received: by 2002:a92:906:: with SMTP id y6mr7173891ilg.106.1599724692310;
 Thu, 10 Sep 2020 00:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054635.3337487-1-hsinyi@chromium.org> <ba77586c-7902-9ce4-0f4f-ad1743596d85@collabora.com>
In-Reply-To: <ba77586c-7902-9ce4-0f4f-ad1743596d85@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 10 Sep 2020 15:57:46 +0800
Message-ID: <CAJMQK-j_Syejw1Bc53fN8OuRYppns7g_=EQW+PUDkQDhnwxvSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mt8173: elm: Set uart0 to mmio32 iotype
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 3:20 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Hsin-Yi,
>
> On 10/9/20 7:46, Hsin-Yi Wang wrote:
> > Set uart0 iotype to mmio32 to make earlycon work with stdout-path.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > index a5a12b2599a4a..d54e62f72c65d 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> > @@ -1160,6 +1160,8 @@ &thermal {
> >  };
> >
> >  &uart0 {
> > +     reg-io-width = <4>;
> > +     reg-shift = <2>;
>
> I am wondering if these properties are common enough to go to mt8173.dtsi
> instead of here.
>
Since stdout-path is set on elm.dtsi (using uart0), so I add this
attribute here.
