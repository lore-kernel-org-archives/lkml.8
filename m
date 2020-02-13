Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FEBC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB7920661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608609;
	bh=VB61Cnre32YZs17GqjOvsXq0m51tzpaI4sAI2/jxhPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sC/kLvKrncNNNFd6fUe4RUD7oHcFw0lXkg3H5DY4D6ANKKxCzkbCMTj/jM5Y7Velh
	 MoII2eD6CMYPeywJHCnHxLlEVSWrqmsiTqw0ubismcIyDA+rmUUEgHfgpisely0boj
	 D3rB5YGzgrqXRlutTnb1Lp2aVy0Z7OcqVsiT6KPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgBMPn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:43:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44807 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgBMPnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:43:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so7309976eds.11;
        Thu, 13 Feb 2020 07:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xWjlmZnVBt/ZlK8vapzAQmz9T3RLkyLlYRSHtgLmYd4=;
        b=CzVCjzh+FuyLd7kL9fHAM6HRWMCvbGLuy7tvQittfhNBsrvqkFhGl6KgQ5tZ/XHVRF
         HzNqMi5hUxJ933xS2w0oPK0P8yhpl+z4E9+4s17hzVt9HHHlux49i8ES/aaensIlKhs0
         6jYGbOCkFjtIuUZiuXJLY5A7J3FNXm1kEcPPkI42XF99GfmyRLCKtmIBlrw3rdhCj0Pi
         6OQIkDwFcJ33Jsx6EF4xAhKX6W3nNlmuVRSpYpxjuSFRnTengdFqMrncA9FrWDxITuBg
         5kyS2mSAaT0qzZgX1eW/+I372xPPrJFiwVKoHULommFOlPsbNmC1VIP6tyNCoZH/wjiW
         wJtA==
X-Gm-Message-State: APjAAAWEaGsk8ekv2+QI2i/4BWG9nbNEpROqM8sI0EKLSf2NcG3spr6E
        63om7lV5GmPlYQhi0DdJDL4=
X-Google-Smtp-Source: APXvYqxC6vfH1GEp1GXd5aDVxuhj2SoNdVlypepsj2HdRdhqBL5BWW5qSOnvNylv+AF9dT1OutTu0w==
X-Received: by 2002:a50:9b03:: with SMTP id o3mr16345398edi.371.1581608597930;
        Thu, 13 Feb 2020 07:43:17 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id w18sm293112eja.57.2020.02.13.07.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 07:43:17 -0800 (PST)
Date:   Thu, 13 Feb 2020 16:43:14 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCHv1 0/2] Add FSYS2 power domain for MMC driver
Message-ID: <20200213154314.GA7215@kozik-lap>
References: <20200212120237.1332-1-linux.amoon@gmail.com>
 <20200213101744.GA11087@kozik-lap>
 <CANAwSgR+PFiE0=FEhDY__FDx+470pe0OsbUXcSG64JDuG++ccQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgR+PFiE0=FEhDY__FDx+470pe0OsbUXcSG64JDuG++ccQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 06:58:51PM +0530, Anand Moon wrote:
> hi Krzysztof,
> 
> On Thu, 13 Feb 2020 at 15:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, Feb 12, 2020 at 12:02:35PM +0000, Anand Moon wrote:
> > > This patches add the power domain for MMC driver,
> > > but somehow the suspend/resume feature is broken
> > > so any input on how to fix this.
> >
> > I think S2R was working on XU3-family after Marek's fixes, so you mean
> > that these patches break it?
> >
> Yes I my testing mmc driver failed to come up after suspend.

Patches breaking systems should be clearly marked as work in progress,
e.g.  by using RFC instead of PATCH in the title.

This patchset cannot be applied.

You probably have to figure out some missing dependencies, e.g. in
clocks/power domains/pinctrl.

Best regards,
Krzysztof

