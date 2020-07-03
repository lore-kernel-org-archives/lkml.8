Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C51C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B3220772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="gwcpJzWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGCLiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGCLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:38:00 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579C1C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 04:38:00 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 18so26466611otv.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyp1m58oAyQtsHXm22tL6xxuBEsc0oVbE4YcBDP5SuA=;
        b=gwcpJzWtocnEZpNrUX3T+fJGP8MREn3ffK4uAC5bYVo/jo2LcOKAEIK0I56mXw8Yf+
         PTWj6fZ2LirhELghw8oVXWL24pbM7Ghp/9E4BY1cpElUCsZf3tCd+CEBZho0wKzMjpWM
         6Fq1fH+kMkTB1zHXgu3MlJ+iHmVMN+UxjjRJz4Ugccu5hkhDK+EF3rfHExECUg7hRYBn
         HLtpMtFVIACf/JkE2ur7k0QK7NJ3+AL5jFSjXMKHgQZlgvEYjq+aPznKfFHnvkY1shaL
         jaUUgtdQgbFhI8J6NuwfDwXiyH2i1Hxkm6oB34xlbZYhR15Udv/Nk9yIrWCWxoTO8cL+
         xzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyp1m58oAyQtsHXm22tL6xxuBEsc0oVbE4YcBDP5SuA=;
        b=CEH9HyGTcLsXcKw1dh8Ca5LYFX6/Ji2L9JMZnfsuxvGULprC3ycKwXqYrUcr9IUMv+
         sfmQVV6F8c4WFw7YP6WWJ12Xh9A5csHMQwJBI+wx+ysDf2n7+JpdUDOuh95J61UGq2hA
         FXy5SohzF5y2EEk4XSH/jSc92M2Eilux24gakIyG3NXQX6SjO8LEZwrZqTjfuABFnHZv
         01RypPGkECnxCDxsyzZVhUdlHhM9QD6gDvmeOy+RbOR0E42mgLUBPd0eVKEfAV1HmU/L
         LW9q6y00Kw08rxmO4H+YhyNfH+X6zATBA7bgH+Wd4iT3saNFvgqiX0cMw4ijmoXHnegE
         F0Mg==
X-Gm-Message-State: AOAM530qbHAfVG99CrfcVEf67SC1GUZhfO3lR8JQuCxNIH/2AJC9WB9G
        x0/VOStlzaufP/Jwv1rbj7yxel3cdMx3crls5P84Ew==
X-Google-Smtp-Source: ABdhPJy8b53E4/ch5xCgMcf3cIE+8dqAJ1flSUnTR++fzzjUTdp0KDGByy6n2PThI12LZgWutzc4FGsaIDtXmwNDXqo=
X-Received: by 2002:a05:6830:18f6:: with SMTP id d22mr13766166otf.243.1593776279661;
 Fri, 03 Jul 2020 04:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200702103001.233961-1-robert.marko@sartura.hr>
 <20200702103001.233961-3-robert.marko@sartura.hr> <e4921b83-0c80-65ad-6ddd-be2a12347d9c@gmail.com>
In-Reply-To: <e4921b83-0c80-65ad-6ddd-be2a12347d9c@gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 3 Jul 2020 13:37:48 +0200
Message-ID: <CA+HBbNHbyS3viFc90KDWW=dwkA9yRSuQ15fg9EzApmrP8JSR3Q@mail.gmail.com>
Subject: Re: [net-next,PATCH 2/4] net: mdio-ipq4019: add clock support
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 9:59 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 7/2/2020 3:29 AM, Robert Marko wrote:
> > Some newer SoC-s have a separate MDIO clock that needs to be enabled.
> > So lets add support for handling the clocks to the driver.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/net/phy/mdio-ipq4019.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/mdio-ipq4019.c b/drivers/net/phy/mdio-ipq4019.c
> > index 0e78830c070b..7660bf006da0 100644
> > --- a/drivers/net/phy/mdio-ipq4019.c
> > +++ b/drivers/net/phy/mdio-ipq4019.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/iopoll.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_mdio.h>
> > +#include <linux/clk.h>
> >  #include <linux/phy.h>
> >  #include <linux/platform_device.h>
> >
> > @@ -24,8 +25,12 @@
> >  #define IPQ4019_MDIO_TIMEOUT 10000
> >  #define IPQ4019_MDIO_SLEEP           10
> >
> > +#define QCA_MDIO_CLK_DEFAULT_RATE    100000000
>
> 100MHz? Is not that going to be a tad too much for most MDIO devices out
> there?
This is not the actual MDIO bus clock, that is the clock frequency
that SoC clock generator produces.
MDIO controller has an internal divider set up for that 100MHz, I
don't know the actual MDIO bus clock
frequency as it's not listed anywhere.
> --
> Florian
