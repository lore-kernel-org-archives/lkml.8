Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F229C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E680A2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 04:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YtzQLMTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733207AbgAMEoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 23:44:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33248 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbgAMEoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:44:23 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so8075786qto.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 20:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyRzsNkAooAl3CXmjsa9W0SlFMm2BfQr/u0cFTqztIs=;
        b=YtzQLMTYi/kldBF6YYcIPuroqqYIvxXUvFONigR4Dfl8w2speTLhMOoGxcDZYw9OM1
         FgtbFKU2OvsDiZvseynxkHwklMLh5YKPOusMg0dToNRHh+bLHTwU9e0XaYmOYIn/vI94
         dEcwcU+iGg0HkoyHc5LThywaVg+FZ5hhITBYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyRzsNkAooAl3CXmjsa9W0SlFMm2BfQr/u0cFTqztIs=;
        b=tCz1DDe38AklYy1M7iIkdoX6BO7FbHkQUszfTkPC3G7kTe3uC5kvFfqor6MKomqC0c
         ziihRCT2JCwNHAUEr2pZv/3LWM9iAObTMLJHLGiVJBuJAlCwDetNjnDgJUG88se2y+fG
         lOAyqam22W7lVIVPo9cXIgdEnukmO4j7xH3by6fD4z5P/oswp223RKgg8leZ+wTowU7T
         na5GVfhuxx6t/6MSlH0bMbMJwzKZCmHDpuGATs1cnTlpttn/prMMS1++v0qbYuCkbn0n
         w2mAWtS5rhFsZiTjuwx3tcUW3AWly0//52L3iEoHaeRL0zzZi/Zk2XcJsWwzN4hW36vd
         oucA==
X-Gm-Message-State: APjAAAWtuxkmnyFBSmIjkUofcPFfWRsofKWA7A/EiVssY6HntrtplJ39
        t0RfjgpibMmu/l33/7Je8CCpNJznq2GA1MzNv4iO1w==
X-Google-Smtp-Source: APXvYqy3LB6U150QIptmA2JsO9/a4I+iPJJewaoaUQbDRBc1Zx9V28Z/ANjOmYw2SHIkmhQ0FjMPTtUiqVGwYQaYARk=
X-Received: by 2002:ac8:750b:: with SMTP id u11mr12533148qtq.174.1578890662186;
 Sun, 12 Jan 2020 20:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20191227141405.3396-1-yong.liang@mediatek.com>
 <20191227141405.3396-2-yong.liang@mediatek.com> <CANMq1KD=jAPn4Y7zQZrsg9FB7Cq6tNX0R8OF4qX21Sjy2=0Naw@mail.gmail.com>
 <CANMq1KB4PzAUdp03go0Ur_khi2bM3+oNUhHtMK=--V6DmGXiDA@mail.gmail.com> <2bbd8f47-fe68-574c-cbe9-bcc680dd4c84@gmail.com>
In-Reply-To: <2bbd8f47-fe68-574c-cbe9-bcc680dd4c84@gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 13 Jan 2020 12:44:11 +0800
Message-ID: <CANMq1KCXMUP=5ijqLsZ67MvO2ROFkG0vSX64KqmWtYKm7w8f2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] amr64: dts: modify mt8183.dtsi
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yong Liang <yong.liang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 6:09 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 08/01/2020 10:14, Nicolas Boichat wrote:
> > On Wed, Jan 8, 2020 at 4:56 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >>
> >> minor nit, s/amr64/arm64/ in the commit title.
> >>
> >> On Fri, Dec 27, 2019 at 10:15 PM Yong Liang <yong.liang@mediatek.com> wrote:
> >>>
> >>> From: "yong.liang" <yong.liang@mediatek.com>
> >>>
> >>> 1. Include mt8183-reset.h and add reset-cells in infracfg
> >>> in dtsi file
> >
> > Err, wait, doesn't this depend on
> > http://lists.infradead.org/pipermail/linux-mediatek/2020-January/026170.html
> > ?
> >
>
> That's all a bit confusing, I thought we are fine to add the reset cells to
> infracfg as we have the resets defined in
> 64ebb57a3df6 ("clk: reset: Modify reset-controller driver")

You're right, we're fine. But at least in theory, we should still have
the binding documentation that I linked above.

I will try to pick up all the required patches, split them across
8183/2712 and resend as one series.

> That's why I took this part from:
> https://lore.kernel.org/linux-mediatek/20191226093930.22413-1-yong.liang@mediatek.com/
>
> Please let me know if I'm wrong and I'll drop it.
>
> Regards,
> Matthias
>
> >>> 2. Add watchdog device node
> >
> > Can we have a patch with just this change instead, since you're
> > sending the binding with it.
> >
> >>>
> >>> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> >>
> >> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
> >>
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>> [snip]
