Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174BEC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE92246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="cYfmVt6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgB1Izc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:55:32 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35573 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1Izc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:55:32 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so712767ual.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yG3mf6LB9a/9xK+auG2ENhJV3nByoLN3L6ABYDFphIE=;
        b=cYfmVt6G2PkgbuStmNktcBKViFfntND+jPOtOsqUXukLVEBRGX4y1OUq+glYisQEDf
         sXKxSiTKnmkLeM+yBhuUBoA3/fqRn08UAE7ESPLPlx0LuLvIbP2DYluC5ksh539ydIpl
         WRBNSpsEJU96iOGSbtD/ZtYNLvZ6mWnP5iRl2GUXKoL47Ju6blYAx4snrQJc5hmAcwjn
         N687kT6PtdGloHVsu4UruYooQAfp4T9e1/BNg7K4ALDDWCVedUjFiRsCXE4wcWexzKS5
         lwP91z0KhiopN2re9zUX6bTQy5emckn1llNCG2yFSn/SDsYQQIz0W35bHdhApWTUmtxQ
         tDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yG3mf6LB9a/9xK+auG2ENhJV3nByoLN3L6ABYDFphIE=;
        b=aaZ4PL7tIK934QoHRDeXNT+4iUslkErcW1ElXnhFn42CDVGP/T5dkIZtvCjjyMk6+d
         RaJGC1qZau0qDqmqqvnua2/KQ6h7L+MpVoe3k3QcDm49t+ituU1qM+77IPd0jvRRdvEM
         1j9luzZZRsSnx66s0Yr67RUDRXg9ppG1GGDxMifG9FFcV0JvGucIGkD9q/whU4h80TpR
         vwqK0Y8vcayjlxTJEK5gXlmFkIJPKWjrszUjhYXk6zB9uQaBgIQN0rZDIDz/WNL256S4
         /bPxsNbMYmeoGes4ETyhnfVpBG/xC3zbfiBNtUkYtvLJ73yQINLRZOyz/Ox5aj4TC8wo
         mUkA==
X-Gm-Message-State: ANhLgQ34GynHiwdeo6dIWNDrr1agbhPeDU2AC9HTUN9kS+Mi/L8KUvIY
        ZdrGpjvhq004M0b+TPYRylgQBnFeJHQ6+GdMLRJQBg==
X-Google-Smtp-Source: ADFU+vsLztMWpfaKINtTsKF68z+sMLM4PaaIv6oFTVvgFaKU7aareFJM7t6ZDu97PwZJduqdizT78uxAIc6c2M5WIBk=
X-Received: by 2002:ab0:2758:: with SMTP id c24mr501689uap.94.1582880129628;
 Fri, 28 Feb 2020 00:55:29 -0800 (PST)
MIME-Version: 1.0
References: <1582646384-1458-1-git-send-email-okukatla@codeaurora.org>
 <1582646384-1458-4-git-send-email-okukatla@codeaurora.org> <20200227171226.GJ24720@google.com>
In-Reply-To: <20200227171226.GJ24720@google.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 28 Feb 2020 14:25:18 +0530
Message-ID: <CAHLCerPMmEQCTU1+K6p01o+PJ1BAf2244Dze2gVLjLQ+cUxpAQ@mail.gmail.com>
Subject: Re: [V4, 3/3] arm64: dts: sc7180: Add interconnect provider DT nodes
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Odelu Kukatla <okukatla@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        daidavid1@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, seansw@qti.qualcomm.com,
        Alex Elder <elder@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:42 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Tue, Feb 25, 2020 at 09:29:44PM +0530, Odelu Kukatla wrote:
> > Add the DT nodes for the network-on-chip interconnect buses found
> > on sc7180-based platforms.
> >
> > Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180.dtsi | 95 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > index cc5a94f..3e28f34 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>
> v2 had:
>
> +#include <dt-bindings/interconnect/qcom,sc7180.h>
>
> I think we still want that, otherwise some patch that adds an
> interconnect configuration for SC7180 needs to add it (see also
> https://patchwork.kernel.org/patch/11386485/#23187545)

Thanks Matthias. That fixed the build.
