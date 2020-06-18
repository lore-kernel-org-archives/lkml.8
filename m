Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A1F82070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1N4X47a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgFRMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgFRMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:35:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C6C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:35:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so6217496ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abF6OHbZnM7Q08OSXibHTxV15MlmdycHsIUv8D1tav8=;
        b=h1N4X47aPUwFQwS2Mc5NzhUIk+Bs+X6bsXwxwA2AzzEY+0YaOIwLv36kv2NTGtQKgk
         Io6/9xE4BPRlAhQEAlqdq1+Yw0CvLAcXYane9bTsjd5HKbUOChp/YES+P3hEi4ES2ndB
         uW/W6wCFtAAluYTlm8iFGgu5akQ7Jb3f+w2Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abF6OHbZnM7Q08OSXibHTxV15MlmdycHsIUv8D1tav8=;
        b=dBOK9JmBOE38IF1awvxQGwF0NSP966ttuyp/hhOr2NBo25M3OmKjnGF0iOeRP3OHZl
         +b5osIXSgLl464ZcLdF0HEfvdl0Kojv3Uvo8PUTHyVq+S5fO4N3Wcq8k70/10uPGNVlM
         LLkAEoZkdnRET6jJKN6DuTBfLy2ou5BE2iyVmuG1XpI/ptn5C7CJ22SYLiUqYv0zI3f2
         Pk2CgBBjRH6//O8gtDWy8T4hmEBQ3mH7CIJ2yPbyLufJ1dg65KWnUL5SocT0UZz6mNRv
         GqWc8otbzCghe/yhZzQkaU0UyauqJACfEw2fDYkVdv2NR0EaR/Y32Y9ZrQOmnMaLar6s
         f5vQ==
X-Gm-Message-State: AOAM533oMGGcAZaTisggjJV2llqUukcjD/HKX5H1an8SUCRh26v6/vfv
        /Ez0B1jfsKslCGSuwa5Sy9KTJhYi0y6oDw==
X-Google-Smtp-Source: ABdhPJwncMXtB4Mt/9krMG510CKafVdzq3fy5ctIqsIEyh6qBNGuR5a/Gr/IhQ0t9PrYFB8qq8IrLQ==
X-Received: by 2002:a17:906:6403:: with SMTP id d3mr3626452ejm.386.1592483703198;
        Thu, 18 Jun 2020 05:35:03 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id o4sm2029901edt.15.2020.06.18.05.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:35:02 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id u26so6576347wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:35:01 -0700 (PDT)
X-Received: by 2002:a1c:4189:: with SMTP id o131mr3620052wma.183.1592483701237;
 Thu, 18 Jun 2020 05:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200403094033.8288-1-xia.jiang@mediatek.com> <20200403094033.8288-12-xia.jiang@mediatek.com>
 <20200521160046.GJ209565@chromium.org> <1592451616.15355.25.camel@mhfsdcap03>
In-Reply-To: <1592451616.15355.25.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 18 Jun 2020 14:34:50 +0200
X-Gmail-Original-Message-ID: <CAAFQd5Axc7RKcY_p-368GC7awx=SRKDTxxjjCibPwSOQ2FXpsA@mail.gmail.com>
Message-ID: <CAAFQd5Axc7RKcY_p-368GC7awx=SRKDTxxjjCibPwSOQ2FXpsA@mail.gmail.com>
Subject: Re: [PATCH v8 11/14] media: dt-bindings: Add jpeg enc device tree
 node document
To:     Xia Jiang <xia.jiang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        mojahsu@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <maoguang.meng@mediatek.com>, Sj Huang <sj.huang@mediatek.com>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 5:43 AM Xia Jiang <xia.jiang@mediatek.com> wrote:
>
> On Thu, 2020-05-21 at 16:00 +0000, Tomasz Figa wrote:
> > Hi Xia,
> >
> > On Fri, Apr 03, 2020 at 05:40:30PM +0800, Xia Jiang wrote:
> > > Add jpeg enc device tree node document
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Xia Jiang <xia.jiang@mediatek.com>
> > > ---
> > > v8: no changes
> > >
> > > v7: no changes
> > >
> > > v6: no changes
> > >
> > > v5: no changes
> > >
> > > v4: no changes
> > >
> > > v3: change compatible to SoC specific compatible
> > >
> > > v2: no changes
> > > ---
> > >  .../bindings/media/mediatek-jpeg-encoder.txt  | 37 +++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
> > >
> >
> > Thank you for the patch. Please see my comments inline.
> Dear Tomasz,
>
> Sorry for missing this message. Replied below.
> >
> > > diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
> > > new file mode 100644
> > > index 000000000000..fa8da699493b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
> > > @@ -0,0 +1,37 @@
> > > +* MediaTek JPEG Encoder
> > > +
> > > +MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> > > +
> > > +Required properties:
> > > +- compatible : should be one of:
> > > +               "mediatek,mt2701-jpgenc"
> > > +               ...
> >
> > What does this "..." mean?
> "..." means that compatible name is not just "mediatek,mt2701-jpgenc",
> different project has different compatible name(for example the MT8173's
> compatible name may be "mediatek,mt8173-jpgenc").

The bindings need to list all the currently defined compatible strings
explicitly.

> >
> > > +               followed by "mediatek,mtk-jpgenc"
> > > +- reg : physical base address of the JPEG encoder registers and length of
> > > +  memory mapped region.
> > > +- interrupts : interrupt number to the interrupt controller.
> > > +- clocks: device clocks, see
> > > +  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
> > > +- clock-names: must contain "jpgenc". It is the clock of JPEG encoder.
> >
> > nit: In principle the clocks should be named after the function the clock
> > performs on the consumer side, i.e. the JPEG block in this case, I guess
> > here it's just a generic clock that does everything, but I guess it comes
> > from somewhere. Is it the AHB clock or something? In that case it would
> > normally be called "ahb".
> I have confirmed with hardware designer that the jpeg clock is not AHB
> clock,it follows subsys clock(because 2701 is the old IC,I didn't get
> the source name).It has the same source with venc clock.We can see that
> the clocks = <imgsys CLK_IMG_VENC>, Should I name it "venc" or the
> orignal "jpgenc"?

The clock name of the device-side bindings is the name of the input of
the device itself, no matter where the clock comes from in the SoC. I
guess if there is no specific purpose of this clock, "jpgenc" is as
good as any other name (e.g. "clock"), so feel free to keep it.

> >
> > > +- power-domains: a phandle to the power domain, see
> > > +  Documentation/devicetree/bindings/power/power_domain.txt for details.
> > > +- mediatek,larb: must contain the local arbiters in the current SoCs, see
> > > +  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
> > > +  for details.
> >
> > I believe this isn't necessary anymore, because larbs are added
> > automatically by the MTK IOMMU driver using device links. +CC Yong who
> > worked on that.
> Yes,I have confirmed with Yong that he will help me to modify this.Is it
> ok that I keep the orignal larb code?

I guess it depends on the order of landing the patches. If we intend
to land this series before the larb removal series, the binding should
stay as is. If the other way around, this should be removed. Please
coordinate with Yong.

Best regards,
Tomasz
