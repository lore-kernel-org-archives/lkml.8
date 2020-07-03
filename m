Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D5620720
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="vTgyNyGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCHoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGCHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:44:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124ECC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:44:55 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a21so2789143otq.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJUNruquod8lCt683yVuejQKs29C8gyjwm0S1vFEk6s=;
        b=vTgyNyGltANNMjyV9zloyYEpXRui/NLWoErlduHYuRfTYlazFCHpjEUH8VQ6mOnqYm
         xPa+NnsXnRxCyVrn5ZYIXn5i7latFLgISDnwIY12U90Iu1YezLv/Rs1Bzlyje1wnEp5d
         SuSYeZniNaiusn8NTGjusIXW0+SzAp199udfY+ULMO0mg+uB8N2pPaZg9vZa8IooDVaH
         iTAAzZVDjikeXb9t39JBxJJ1q50LiAAD2YkwCtV1yYjf5Jj8VGhZLrj0XLnzsix6qb8r
         ixuErhqWl78OboHWxuxueeRafcGG4/hibXwI7AKgkeXVtIIjLurASfH4jTQvMe+Xpu+4
         N0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJUNruquod8lCt683yVuejQKs29C8gyjwm0S1vFEk6s=;
        b=lLXsV2U8g6YDI5oxCtmlxnYImEhXctNFmFjnEbG1doTo2Zx/USyQ5dZuBUT3gsvHON
         2agHZyicSoQRuhF7Ux8gZVrmjRCP6FvRmUpKr6OWQqn+OaMUWDEJMZUJ76AyfclMScmx
         TsVyYYs9UscPMxcBXxo57IJhzwiNfsaZkKNiXNl3DuKWyG7WisiceMbPzf6Pj+zkJoY3
         rSeO89Xe2MomAwZW1p9qyvQp7Sr0eyFHDHdwAZgqrdScmyahkmmutiK+ZLYJBfBZU20v
         Lwby8rsD3NofEFf5iVTcMxqNXljjGdCfklp/3Xx/gITIfovYEAy82IPOj/gVPbqLNOhA
         Tv3Q==
X-Gm-Message-State: AOAM533a5GFDYks3xb3UCp1OHscwkxpLzLvKej5/o9SP6qTkx6yAofLD
        /BQX+RmhUCiHqdXeDUUH1hYd7jR9jhq4mVmLAdKYXw==
X-Google-Smtp-Source: ABdhPJySQQvEITt77PfQTvma2h+w6OARamY7QXSVOHO45DRH0thjyzyMVpq6po+6kGkzMh5DG8x5CuuIBmxC/9AuhQs=
X-Received: by 2002:a05:6830:18f6:: with SMTP id d22mr13105205otf.243.1593762294473;
 Fri, 03 Jul 2020 00:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200702103001.233961-1-robert.marko@sartura.hr>
 <20200702103001.233961-5-robert.marko@sartura.hr> <20200702133842.GK730739@lunn.ch>
 <CA+HBbNGcV0H4L4gzWOUs8GDkiMEOaGdeVhAbtfcT5-PGmVJjfA@mail.gmail.com> <42ebc500-35ba-48f6-c4d1-3743abde1852@gmail.com>
In-Reply-To: <42ebc500-35ba-48f6-c4d1-3743abde1852@gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 3 Jul 2020 09:44:43 +0200
Message-ID: <CA+HBbNGfELm9hYZgJ3KDghE4gDdr3g8Df3oqsTefEL2NvBRdYA@mail.gmail.com>
Subject: Re: [net-next,PATCH 4/4] dt-bindings: mdio-ipq4019: add clock support
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

On Thu, Jul 2, 2020 at 10:04 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 7/2/2020 12:18 PM, Robert Marko wrote:
> > On Thu, Jul 2, 2020 at 3:38 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >>
> >>> +  clock-frequency:
> >>> +    default: 100000000
> >>
> >> IEEE 802.3 says the default should be 2.5MHz. Some PHYs will go
> >> faster, but 100MHz seems unlikely!
> > This MDIO controller has an internal divider, by default its set for
> > 100MHz clock.
> > In IPQ4019 MDIO clock is not controllable but in IPQ6018 etc it's controllable.
> > That is the only combination I have currently seen used by Qualcomm.
>
> Not sure I understand here, the 'clock-frequency' is supposed to denote
> the MDIO bus output clock frequency, that is the frequency at which all
> MDIO devices are going to operate at. Is this 100MHz a clock that feeds
> into the MDIO block and get internally divided by a programmable
> register to obtain an output MDIO clock?
Yes, in this case that 100MHz comes from the GCC clock controller and
is then internally divided by the MDIO.
I do not know what is the actual output MDIO bus frequency as
datasheet only denotes that MDC divide
bits in the mode register are set for 100MHz incoming clock.
> --
> Florian
