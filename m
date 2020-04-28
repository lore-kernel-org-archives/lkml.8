Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A866EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F34206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588070310;
	bh=yDonmdUzWYPcb8/jEh5I01BK7PHfuq8AcsBy6JJlYd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uqS7/Nx6bpEtzMLi3u2OrGNhj6ElGM/xale0ZbH6nvc8+ORKXgTUlMOdtjCYDadRc
	 H2ePAthXPVPxxrY8mjcHVUsbox0aEURlBYI8OE7h2qY9DAcXCHtfKsyi1XmvVfvC4M
	 PMlXEadWnCy5thV5EAQ5cjVWbZMSLAj0VuEfQSqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgD1Kia convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:38:30 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44216 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgD1Ki3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:38:29 -0400
Received: by mail-ej1-f66.google.com with SMTP id n4so16817321ejs.11;
        Tue, 28 Apr 2020 03:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QS4c9ls6yzOR+yRWTJD8hrerOuMZYga2B1YWCy646HU=;
        b=KPn0OiwONCQAwz5nUHDNOtVYJUiP7T9EjuXuyU5OAT0SJr5aFbkPYGsFKQm9fFPd1D
         SAiVyHSpoQpTafHX6qb17fXrOxhyQHc0A7rnzNGiGgEbR3PPA1vQD4FMxlbt3AgEpA5Z
         hsrhJCTvIaXOY7UuOVuWJfdkoteTswYfZj3u57IyLUWX0epZ8N/2cw21tS8f88qpvInp
         YbafhK1gt9aDdbn95dxcingmQ40tcw8AKZ4bdPTxz6FJrLbqEPTXnb3lKFQrihoTALsM
         xREsri6LKRqLRMThykghGZeApI7fDVhpYy3K+B0FZMcxg+DwZWFwdTjYHiVmbBkU1/dt
         Kjfg==
X-Gm-Message-State: AGi0PubJQ62f/YH7OSktw42V91KPfyfsH99uR+4K21ClgExUidc5N5yR
        LKsmlJame39289198ZfaV+Q=
X-Google-Smtp-Source: APiQypIJTK4SUmp8jTM+oNe7+uJOVbtyCyJrubIWc/QoIsByKo+wNj3JnrX0SttughUGYKSrljqd1w==
X-Received: by 2002:a17:906:9706:: with SMTP id k6mr24724371ejx.103.1588070307272;
        Tue, 28 Apr 2020 03:38:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id qo12sm411994ejb.14.2020.04.28.03.38.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 03:38:26 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:38:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] S5PV210 and Aries DTS improvements
Message-ID: <20200428103824.GF23963@kozik-lap>
References: <BN6PR04MB06601A5656CF70A4DCA7998BA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <BN6PR04MB06601A5656CF70A4DCA7998BA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:35:51AM -0700, Jonathan Bakker wrote:
> This patchset makes several improvements to Aries devices which are
> based on S5PV210.  Several pulls on GPIOs were incorrect/not specified,
> sleep GPIO configurations have been added, and more devices have been
> added.
> 
> Touching the common S5PV210 DTSI are the addition of the ADC node
> as well as fixes to the FIMC definitions and a sleep GPIO helper
> added.
> 
> The patches have been tested on both a GT-i9000 as well as an
> SGH-T959P and both can now suspend/resume properly.
> 
> Jonathan Bakker (12):
>   arm: dts: s5pv210: Add helper define for sleep gpio config
>   arm: dts: s5pv210: fascinate4g: Add sleep GPIO configuration
>   arm: dts: s5pv210: galaxys: Add sleep GPIO configuration
>   arm: dts: s5pv210: aries: Set keep-power-in-suspend for SDHCI1
>   arm: dts: s5pv210: aries: Disable pulls on GPIO i2c adapters
>   arm: dts: s5pv210: aries: Add support for more devices
>   arm: dts: s5pv210: aries: Disable pull for vibrator ena GPIO
>   arm: dts: s5pv210: Add an ADC node
>   arm: dts: s5pv210: aries: Enable ADC node
>   arm: dts: s5pv210: Assign clocks to MMC devices
>   arm: dts: s5pv210: Correct FIMC definitions
>   arm: dts: s5pv210: aries: Set MAX8998 GPIO pulls
> 
> Paweł Chmiel (1):
>   arm: dts: s5pv210: galaxys: Add si470x fmradio

Thanks for the patches, nice work!

I commented on some of them. The other look good but I will wait with
applying for v2. When resending everything, change the subject of each
patch to match subsystem, so:
	ARM: dts: s5pv210:

Best regards,
Krzysztof

