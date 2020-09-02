Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CCC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882C32084C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yhqz5khI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBJyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:54:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54979C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:54:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w2so3773626wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M8TcxUyh3FwDr1kvEIkJvkbvWI5FAt8CTFrE3ll+7dc=;
        b=Yhqz5khIb730Hw/NZPk0CzwgE1uf+OzLd3XnuJ/A5Nd4t14o+2zuEeAM7oI3IWojWj
         s/J32VPnBjf/1Q7yqUNT+EiSREHO9JXevgzinGyMCZKDAYgELrM4nSCvrt5FVHI33p+2
         342y8/XYe1v6exWPjhdEq/0ndzwQLVE+FMQXcBCkuFXBeOUGZ6LFH1oGRCrtbyXnKRZQ
         Mk43GSfd3auCbXq2gEcROtjQWzH0FGYonOqTFCzBV+PBrl61SqEkT6xRiuXOwzLfsoWb
         RO/V4MTKBmoKLqZYGT2kgw55ZqObWM+P45RBzXoapFpsvabMbX3VqUTxyrbqq42f8g64
         t6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M8TcxUyh3FwDr1kvEIkJvkbvWI5FAt8CTFrE3ll+7dc=;
        b=C7nchV1hUAYnqU5c/s0Tv2yiAPpDwG4OYI8bbEXdflPIaGpG7IjMz/rqV0bW4iBwp5
         eOf5dsrhBSwh0xjcdWvQA3AgajJbGvSPh1GZXJzZpuiA7aMwPtRsPgklIMABq1gxSBrs
         6kP/OUZD44d/34J0vQb4rKjHVUV+kEeTGj2FZPiGv/PGh1Q/OLcd9fgxsDgXMhQIExqK
         H/YLBVahNfx+vY2S7U1KaslkViUhb11GJDDMEVBdxC4Lp7pnwbiavsy8/0h1Y2xxXBJc
         jWTlL3Jq/zQJ2kZfVfGT0Bj0VcQR0hfnvC0vtSU+6ZOIQ7NRBsenjO0PaMZ+Hdw1CZc1
         4vYg==
X-Gm-Message-State: AOAM533pxvJiyz36iDiadEMYQOPj8PB1h/rz/QT6hHHFvaSzJLzNe7D8
        8TUkeQn5gAXf/q/za4bugrhvqA==
X-Google-Smtp-Source: ABdhPJzidzZcJbtSblI1fVOA5IWxK7eDzxi7ZZLnT1lE/sVjG8wzghGcunr0siyIXU9SNK88ljnUiw==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr6252389wmh.21.1599040445433;
        Wed, 02 Sep 2020 02:54:05 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j10sm6299078wrn.2.2020.09.02.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:54:04 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:54:02 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andrey Lebedev <andrey@lebedev.lt>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: pwm-sun4i: PWM backlight is not turned off on shutdown
Message-ID: <20200902095402.pombrirqqjdew34b@holly.lan>
References: <ae58976c-a8d7-0d00-fe72-d21579b37240@lebedev.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae58976c-a8d7-0d00-fe72-d21579b37240@lebedev.lt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:55:28PM +0300, Andrey Lebedev wrote:
> Hello,
> 
> I think I'm experiencing problem with pwm-sun4i module. I'll describe
> the symptoms first.
> 
> I have a device, based on Allwinner A20 (Cubieboard 2) with LVDS display
> that has a PWM-based backlight. The problem is: when linux shuts down,
> the backlight stays on. I expect it to be turned off. This used to work
> as expected on kernel 5.2-rc2, but after upgrade to 5.8 the backlight
> does not turn off anymore (most of the times, see below).
> 
> The backlight is configured in the device tree [1]. The brightness can
> be changed by writing to "brightness" file on sysfs. So, linux can
> control the PWM line. Backlight sysfs directory also has a "bl_power"
> file, which can accept "0" to power on or "4" to power off the backlight
> (according to [2]).
> 
> Now, writing "4" to bl_power sometimes turns the backlight off and
> sometimes not. I've found that the probability of backlight turning off
> pretty much correlates with the current screen brightness: on 100%
> brightness it will never turn off, on 50% brightness it will turn off on
> about half of the times. When backlight does not turn off, it goes on
> full brightness. It feels like the line, controlled by pwm stays in
> whatever state it was the moment backlight was powered down - either
> full 1 or 0.
> 
> The pwm backlight device driver (pwm_bl) requests to set the duty cycle
> to 0 and disable the pwm with the same request [3], but I suspect the
> implementation driver (pwm-sun4i) does not actually set the duty cycle
> to 0 before disabling the pulse width modulation.
> 
> Is there anything that can be done to fix this?

There's some rather odd logic in sun4i_pwm_apply() that results in the
PWM being disabled twice... once when it applies the initial config
and again after waiting for a duty_cycle.

I suspect disabling the initial disable would solve your issue... but it
might provoke some new ones!

Anyhow, try removing the else clause starting at line 299 and see what
happens:
https://elixir.bootlin.com/linux/v5.8/source/drivers/pwm/pwm-sun4i.c#L299


Daniel.
