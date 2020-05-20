Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA80206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0FsjpGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgETIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:25:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E9C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:25:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f134so1720885wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LxFRCFTkrb+G0HDikrHcwFkk3yaTX3pmxH+SfB37T68=;
        b=g0FsjpGSa+JsPc7oehIpfxgPUnCNrcuUq03NRWJHlkUUQkjB2ldg7shm7Xj0owINhH
         vK7iEubnl0jmZncQmjVILLLy9ELCELgsOkkE/sm0vIAMTPZoCPylJsrVpHrJQ7gR9EKj
         KUWQCsthewh7lw4ztBEaeQrk/PcoBGJd74N9gQB33c4N1Ygpvy5LNFpWyLH5NcMbLOKs
         RdOG6ohfYeIzoBoUWlvymjTbrTRmQIHA8JC4CU+Tnts6Gk30sZNg5tYtCptlvnqeLLcR
         Xb0QVRW0d8wEzS/I0UjX86nyua9DbTDD13l/285qXh1zp4n8UqVcOM9JavFdTvCE+nrM
         w1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LxFRCFTkrb+G0HDikrHcwFkk3yaTX3pmxH+SfB37T68=;
        b=qHGbFhUQAUgL3GPASkpy0lU/d5LY/DIQLr6c44C6g4IrQE6rvVg4qznHTFdk6ZoMxJ
         Z2lJiIx8OEQ3MNfRwSU3k5L4DsRL8wyW5gPNz+4XnfIxrwG3RlQON/f0Bo+SCB3pAy72
         H9AgWIiBdMhNU/0dEpXkkl0a5kPIpSV2ZJzbKTZPqlMymrAv9cFlE1rCDSk5K06ooKrK
         qc6kXGp7AVI2LZm5SFA9e+Fil0vOg8vVCAB/EI415GYfECyQDy5tSBeCjW5u96HT4e2j
         vLLqMcPPWvUbAPaeh9LKk2dIZF6oHmoctctXa4taKxuKZRWVnQySATxnLKRt6aiWvBuk
         4p2Q==
X-Gm-Message-State: AOAM530Pu+TOqJak3iYwxiztRQUamK2EAiKHDCrY/pO8kL98RIF/tG+Q
        xXPiwbvrK9oC7TlCWdQoIkL+Fg==
X-Google-Smtp-Source: ABdhPJzf2qudx5LUCbWi1Wqf+Glz0axagZEBlnOOCrOla5Hv1XXPTqqNfT/7cFdJvkQ2cXNML3NF4A==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr3371570wmp.7.1589963157344;
        Wed, 20 May 2020 01:25:57 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id q4sm2341506wma.9.2020.05.20.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:25:56 -0700 (PDT)
Date:   Wed, 20 May 2020 09:25:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for ROHM power management ICs
Message-ID: <20200520082554.GA271301@dell>
References: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
 <e11366fd280736844ae63791b6193bb84d6205bf.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
 <20200520063541.GY271301@dell>
 <e50cbe739c3394bfc0bba77b3ea4b522b6011dd0.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e50cbe739c3394bfc0bba77b3ea4b522b6011dd0.camel@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020, Vaittinen, Matti wrote:

> Morning Lee,
> 
> On Wed, 2020-05-20 at 07:35 +0100, Lee Jones wrote:
> > On Wed, 20 May 2020, Matti Vaittinen wrote:
> > 
> > > Add entry for maintaining power management IC drivers for ROHM
> > > BD71837, BD71847, BD71850, BD71828, BD71878, BD70528 and BD99954.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > >  MAINTAINERS | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ecc0749810b0..63a2ca70540e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14490,6 +14490,12 @@ L:	linux-serial@vger.kernel.org
> > >  S:	Odd Fixes
> > >  F:	drivers/tty/serial/rp2.*
> > >  
> > > +ROHM BD99954 CHARGER IC
> > > +R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > +S:	Supported
> > > +F:	drivers/power/supply/bd99954-charger.c
> > > +F:	drivers/power/supply/bd99954-charger.h
> > > +
> > >  ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
> > >  M:	Tomasz Duszynski <tduszyns@gmail.com>
> > >  S:	Maintained
> > > @@ -14507,6 +14513,30 @@ F:	drivers/mfd/bd9571mwv.c
> > >  F:	drivers/regulator/bd9571mwv-regulator.c
> > >  F:	include/linux/mfd/bd9571mwv.h
> > >  
> > > +ROHM POWER MANAGEMENT IC DEVICE DRIVERS
> > > +R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > +S:	Supported
> > > +F:	Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > > +F:	Documentation/devicetree/bindings/regulator/rohm,bd70528-
> > > regulator.txt
> > > +F:	drivers/clk/clk-bd718x7.c
> > > +F:	drivers/gpio/gpio-bd70528.c
> > > +F:	drivers/gpio/gpio-bd71828.c
> > > +F:	drivers/mfd/rohm-bd70528.c
> > > +F:	drivers/mfd/rohm-bd71828.c
> > > +F:	drivers/mfd/rohm-bd718x7.c
> > > +F:	drivers/power/supply/bd70528-charger.c
> > > +F:	drivers/regulator/bd70528-regulator.c
> > > +F:	drivers/regulator/bd71828-regulator.c
> > > +F:	drivers/regulator/bd718x7-regulator.c
> > > +F:	drivers/regulator/rohm-regulator.c
> > > +F:	drivers/rtc/rtc-bd70528.c
> > > +F:	drivers/watchdog/bd70528_wdt.c
> > > +F:	include/linux/mfd/rohm-shared.h
> > > +F:	include/linux/mfd/rohm-bd71828.h
> > > +F:	include/linux/mfd/rohm-bd70528.h
> > > +F:	include/linux/mfd/rohm-generic.h
> > > +F:	include/linux/mfd/rohm-bd718x7.h
> > 
> > How small can you get this list using wildcards?
> I was considering this but wildcards are somewhat error prone. I can't
> guarantee they don't match to drivers which I am not working with :(
> The BDxxxxx is common for pretty much all ROHM ICs (well, theres few
> other like BUxxxxx and BHxxxxx) - and there is huge amount of ICs.
> Hence I think it is likely the wildcards (will) match to drivers
> maintained by others.
> 
> One already existing example is:
> ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
> M:      Marek Vasut <marek.vasut+renesas@gmail.com>
> L:      linux-kernel@vger.kernel.org
> L:      linux-renesas-soc@vger.kernel.org
> S:      Supported          
> F:      Documentation/devicetree/bindings/mfd/bd9571mwv.txt          
> F:      drivers/gpio/gpio-bd9571mwv.c
> F:      drivers/mfd/bd9571mwv.c          
> F:      drivers/regulator/bd9571mwv-regulator.c
> F:      include/linux/mfd/bd9571mwv.h
> 
> also LEDs have some ROHM IC drivers which I am not familiar with.
> 
> > +F:	drivers/clk/clk-bd718x7.c
> > +F:	drivers/gpio/gpio-bd7*
> > +F:	drivers/mfd/rohm-bd7*
> > +F:	drivers/power/supply/bd7*
> > +F:	drivers/regulator/bd7*
> > +F:	drivers/regulator/rohm-regulator.c
> > +F:	drivers/rtc/rtc-bd7*
> > +F:	drivers/watchdog/bd7*
> > +F:	include/linux/mfd/rohm-*
> > 
> > Or
> > 
> > +F:	drivers/*/bd7*
> > +F:	drivers/*/*-bd7*
> > +F:	drivers/*/rohm-*
> > +F:	drivers/*/*rohm-*
> > +F:	include/linux/*/rohm-*
> > +F:	include/linux/*/*rohm-*
> > 
> > Not checked either of these.  They are just an example.
> 
> So, I am sure I can find a working match pattern for a few of the files
> - but if using wildcards is not compulsory I'd rather not do that as I
> have a feeling this will cause wrong matches...

That's fine.  So long as you've thought about it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
