Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9031C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB602080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581361331;
	bh=HQvf9C9JUKRMovsbBiBUc6zfyh56zjlGJgXiSmdc+e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dKhdj6dLsEWvDr1d3IpaC2ayFVukJf6em9fvQvLYkqsYYAQjSa9YroVGICcvbfFMh
	 Sc3/Z9fEvAI4/5ZZ+ZznCMmU/IyX1++N9h9vV3Kzhrt1rsxdvO/xImNYfA8R7QqfFo
	 NgGZuhIrUGaEDEtU42h/WLlC3G1VRVyD/LyZdlBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBJTCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:02:11 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38831 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgBJTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:02:11 -0500
Received: by mail-ed1-f68.google.com with SMTP id p23so1617696edr.5;
        Mon, 10 Feb 2020 11:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cf+4qQjBnlkEW/EJTW7h2vLgsgp1JMVDelx9bM1U3Q=;
        b=ZtS11vuHhd0zOId95mWyRGX3HsEJ7ltYzXkSSgCuBn0Es8gycoJ6/gspYeBXcrP+iN
         G5Uzbye3SktOKnpVOeGPe5aAPB1Q8Y5XibaC0+TOzdDrfVShiVmIOCT5ICk8jL0oFexM
         yGzNMsuJtwOi49ejM1zzN9QKmm2FHAkFBgVkwQOv3uH5d11XRkzfKafOtGvHj/Ja8K/2
         rzt97/QRbSGWGLtF7ZKzoz7wsWatC7cPPJGZ16I8Gse63rZ3719lgiaH07IzH2qZM7MC
         pRWcbnxLh4TqOJ749e+c2t34Tz28qPvRlch3hCmsA3P1ZFEK5eVGePEdRiQVxJwx4K1y
         jWsA==
X-Gm-Message-State: APjAAAXHz9ZYlXnsIAucY+va5Sn3LNzGmHM3JH+v+KCektru3WvmWQuK
        ZkH9TnyCcIX1xDxwroSkTWYE8JuB6QY=
X-Google-Smtp-Source: APXvYqwg0KeN1+Nwj6pBAd2zwMoQwpurX7DGIJkYt84IeruJJh8EyS0rccVKqJspTu7bUwyIu3L+rg==
X-Received: by 2002:aa7:df04:: with SMTP id c4mr2519354edy.385.1581361328652;
        Mon, 10 Feb 2020 11:02:08 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id r23sm74834edp.15.2020.02.10.11.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 11:02:07 -0800 (PST)
Date:   Mon, 10 Feb 2020 20:02:05 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 0/3] Add support for suspend clk for Exynos5422 SoC
Message-ID: <20200210190205.GB16433@kozik-lap>
References: <20200210105108.1128-1-linux.amoon@gmail.com>
 <20200210135612.GB2163@pi3>
 <CANAwSgT9aq123H-pO2u6iN2E8towsWUFcWDsA9TbVqP30j=10w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgT9aq123H-pO2u6iN2E8towsWUFcWDsA9TbVqP30j=10w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:38:52PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Mon, 10 Feb 2020 at 19:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2020 at 10:51:05AM +0000, Anand Moon wrote:
> > > Long time ago I tried to add suspend clk for dwc3 phy
> > > which was wrong appoch, see below.
> > >
> > > [0] https://lore.kernel.org/patchwork/patch/837635/
> > > [1] https://lore.kernel.org/patchwork/patch/837636/
> > >
> >
> 
> Thanks for your review comments.
> 
> > You ignored parts of my review from these previous patches. I asked for
> > describing WHY are you doing this and WHAT problem are you trying to
> > solve. I asked for this multiple times. Unfortunately I cannot find the
> > answers to my questions in this patchset...
> >
> > Best regards,
> > Krzysztof
> 
> I dont know how to resolve this issue, but I want to re-post
> some of my changes back for review. let me try again.
> 
> My future goal is to add #power-domain for FSYS and FSYS2
> which I am trying to resolve some issue.
> Also add run-time power management for USB3 drivers.

You can start by describing why FSYS and FSYS2 power domains cannot be
added right now. Maybe this patchset allows this later?

> 
> Here is the clk diagram for FSYS clk as per Exynos5422 user manual.
> [0] https://imgur.com/gallery/zAiBoyh
> 
> As per the USB 3.0 Architecture T I.
> 
> 2.13.1 PHY Power Management
> The SS PHY has power states P0, P1, P2, and P3, corresponding to the
> SS LPM states of U0, U1, U2,and U3. In the P3 state,SS PHY does not drive
> the default functional clock,instead, the *susp_clk* is used in its place.
> 
> So enable the suspend clk help control the power management
> states for the DWC3 controller.

That's too vague because clock usually cannot "help"... The wording is
wrong and the actual problem is not described.

I could guess from your description and driver behavior that SCLK has to
be on during USB DRD suspend.

Best regards,
Krzysztof

