Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A346C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E17B206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qY200Gdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgD1Lv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgD1Lv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:51:27 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F02C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:51:27 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m18so32007989otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YV5X7b0RVx9UtJZqWhbhycNNkPCol2NhsoVPXumvChw=;
        b=qY200Gdh14KWjuFl7nMHJc5Y6JPsMnKXb+yEm+ncWoJ2UZOZXise3+Js8HeoWMi7cc
         IgwtEqKjPLAGBnHEg5HKFHjRoxSnELVv8kn45MyI9kIFqYgVS6zPiJ2M85fAOg22GyyE
         819bOa4POc+oTD+ZXBHOQGapNKnxVaE7fpJUkb9oIedVVdxYBRu0336uweqMWwyfBhRd
         cg4cmOHFVMgLu/3Xr/MNVw4TRUgxCW2aFT9eVid1r0DJvVrHL5ecakv39CU7qdZADE2/
         mV9188VWARK8Oe7oA39H1FZ1UhXWmfyCwoT9EmxMJFgimfGqXL9yyKrEStKAlQkAgLsZ
         rJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YV5X7b0RVx9UtJZqWhbhycNNkPCol2NhsoVPXumvChw=;
        b=AVpINAXYlx1W7aC+kqTj00uDXPqhXVFUXBvvElK4xmR1bakYJFWrDSOGOC3ebD7WcD
         9KviRY3ISopNygaq3DKKaV8NY+BaWiS3ksHpwb30crONZnh7to0Dq1uzwt7ykZvpJFbE
         VpRvj7NNhJ+PCf2L57QsfkTRd6GHJhGuLsYzlH5FMtmdRVQHwupgXd1RbHhwXcmu6Vl2
         DsqXh+5JfB7iMvdINr/e/tPQ69HfSetFv0X0fAgmgnyVOK/dUgE5w1DLVev3dLjorJ0G
         i03LoJJiAnZnvUoy6XuPCY8IXaIDtBHEb4aLZNvgISsXkrWggvB6VDjNfdIi9/NCFLjI
         xaew==
X-Gm-Message-State: AGi0PubwPRPZjGi5c5s0PTiz9lgJKGFkjLPeWT/7OBM7pvSBL42OAWpp
        VnQH/VTT43EGxuWc+itiSx++YmIWq2KvSJYdSc0Vbw==
X-Google-Smtp-Source: APiQypIGTUh/5sCvlDOhvI/LG4JE8NTFr9y4EW8BlYgrxb5QHasXcsr59vMAsl3o74ezgCVEiF3BiSVV/FTK4Mkh01Y=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id e14mr21811872otj.91.1588074686391;
 Tue, 28 Apr 2020 04:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200408110816.2712841-1-robert.foss@linaro.org>
 <20200408110816.2712841-2-robert.foss@linaro.org> <20200415160729.GA4438@bogus>
 <20200415162110.bmorj4u4hkqohqjx@pengutronix.de> <CAG3jFysg34=HJ7xefuAKw4Uq6W0POm5TsJmzQku6WwkhH_j=-w@mail.gmail.com>
 <20200428075504.ovzugt2mbgan7z3k@gilmour.lan> <20200428082505.GA22489@pengutronix.de>
In-Reply-To: <20200428082505.GA22489@pengutronix.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 28 Apr 2020 13:51:15 +0200
Message-ID: <CAG3jFysKKfu564y4jnfh3unT-6xPLSeBPjfGX5KRY5s=avp1mg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] media: dt-bindings: ov8856: Document YAML bindings
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Maxime Ripard <maxime@cerno.tech>, Rob Herring <robh@kernel.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, sorry. I was thinking of the 'port' property and replying to that.

assigned clocks are definitely being removed.

On Tue, 28 Apr 2020 at 10:25, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 20-04-28 09:55, Maxime Ripard wrote:
> > On Mon, Apr 27, 2020 at 05:13:42PM +0200, Robert Foss wrote:
> > > On Wed, 15 Apr 2020 at 18:21, Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > >
> > > > On 20-04-15 11:07, Rob Herring wrote:
> > > > > On Wed, Apr 08, 2020 at 01:08:14PM +0200, Robert Foss wrote:
> > > > > > From: Dongchun Zhu <dongchun.zhu@mediatek.com>
>
> ...
>
> > > > > > +  clock-names:
> > > > > > +    description:
> > > > > > +      Input clock for the sensor.
> > > > > > +    items:
> > > > > > +      - const: xvclk
> > > > > > +
> > > > > > +  assigned-clocks:
> > > > > > +    description:
> > > > > > +      Input clock for the sensor.
> > > > > > +
> > > > > > +  assigned-clock-rates:
> > > > > > +    description:
> > > > > > +      Frequency of the xvclk clock in Hertz.
> > > > >
> > > > > These 2 should have a 'maxItems: 1'
> > > >
> > > > Don't know why those properties are needed here.. IMHO this shouldn't be
> > > > part of the binding or at least it should be optional and not required.
> > > > All we need is the clocks and the clock-names property.
> > >
> > > Thanks Marco, I'll make it optional for the next revision.
> >
> > Well, the whole discussion we had was about removing them entirely?
>
> +1 from my side. It is part of the system integration and not part of
> this device.
>
> Regards,
>   Marco
>
> > Maxime
