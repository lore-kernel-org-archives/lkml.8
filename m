Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF543C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9651320770
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M7wdL6CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIJIqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgIJIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:45:08 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F70C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:45:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so6166954iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc9DogxoLgngfubJ0u33iUTXXgPBqlfWnxisJuHVigk=;
        b=M7wdL6CNysKj2I2uFNxFP98crOR6oki0Kv9eRzGJ/PUHBswh1K2Yef8UbV955S99ID
         CtqGAsbh6F1xTWPhc6/mzKjL8BLWEH41oqA7SEHhpbQr9ftZ+z7DZWEIjmkFp1Ft+YVc
         k8p/nOP2BaHgcfiFrb0kKX0UeiprgHQqBSDwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc9DogxoLgngfubJ0u33iUTXXgPBqlfWnxisJuHVigk=;
        b=qly5C/nTi3oJ/1cscWUtRqwhGRsCYmCF525x2+EEcWGWUzTxVO+QmYfLs+gyhr95xB
         mR44AgpHEAZAQ385wPMgpBWWx7pu5UT3nDEHhAHgcNxfOzIM9tmd0n8Hd/dyV7BROAgW
         2QvWxB+/nRuFa/DOZ4z3pDT2p9HBSniCPbFjB8H3el4VRv0tdSJazrfEdMRUTKsH5Q9u
         YPswdxzBoXnH5ti0pLHXv6CqhkmL5FwY0fcMQ1mFP5wCogz+l9YIUanKb9Zv/uUWtJWL
         DafsusDmF4hhNtWlhTrIm8CGZhX2Ivl0rPH+JKr9cCoI9nSMVjvxeQOo4QSq5zVYK3q/
         3Dsg==
X-Gm-Message-State: AOAM532iHe5suD++9ompoKzR+QNjbeeBSH9pxp4P7ODAmhWP5vqK9LA6
        nAKmjB30OHZECOz+M6C1txGxZ49saPonsijiyV6GQg==
X-Google-Smtp-Source: ABdhPJz/GqbhJlGBoiOlJ5GNckLlLrZXvPr+cXRexeJo/NhSRwi3XrdA0NDkw8Xgcs52YM7DxFPmui+9bnlO4Y0Zf7w=
X-Received: by 2002:a5e:930d:: with SMTP id k13mr6689385iom.40.1599727505770;
 Thu, 10 Sep 2020 01:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054635.3337487-1-hsinyi@chromium.org> <ba77586c-7902-9ce4-0f4f-ad1743596d85@collabora.com>
 <CAJMQK-j_Syejw1Bc53fN8OuRYppns7g_=EQW+PUDkQDhnwxvSw@mail.gmail.com> <944325c1-818e-934c-907d-7ff0493446b4@collabora.com>
In-Reply-To: <944325c1-818e-934c-907d-7ff0493446b4@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 10 Sep 2020 16:44:39 +0800
Message-ID: <CAJMQK-gVO53a1SnsjsJPu-ZR-NoNb4TGXrOpb-naD71pmjExCw@mail.gmail.com>
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

On Thu, Sep 10, 2020 at 4:16 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Hsin-Yi,
>
> On 10/9/20 9:57, Hsin-Yi Wang wrote:
> > On Thu, Sep 10, 2020 at 3:20 PM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Hsin-Yi,
> >>
> >> On 10/9/20 7:46, Hsin-Yi Wang wrote:
> >>> Set uart0 iotype to mmio32 to make earlycon work with stdout-path.
> >>>
> >>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> index a5a12b2599a4a..d54e62f72c65d 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> >>> @@ -1160,6 +1160,8 @@ &thermal {
> >>>  };
> >>>
> >>>  &uart0 {
> >>> +     reg-io-width = <4>;
> >>> +     reg-shift = <2>;
> >>
> >> I am wondering if these properties are common enough to go to mt8173.dtsi
> >> instead of here.
> >>
> > Since stdout-path is set on elm.dtsi (using uart0), so I add this
> > attribute here.
> >
>
> Why needs to be defined in the same place that stdout-path is set?
>
> My guess is that reg-io-width and reg-shift are SoC specific, as they define how
> the IO access to the register is done. In fact, I think that these properties
> should be added in all the uarts, not only the one that has defined the stdout-path.
>
Okay, I'll apply them to all uart. Thanks.
