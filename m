Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61155C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3240020775
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8Toj+Y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgGAHAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgGAHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:00:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A885C03E97B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:00:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so22630150wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+pRKYTmuOThutSuGqfNrgAamAdWYk1YESRlVS2CO28A=;
        b=j8Toj+Y1Sm33G/MY5KpRJO/4MLA6Xmjv5NEmZN881Y2JY1sddA5DRPZK6/0hHYYGcd
         krHNiAHXOdRvae6EVQZAGELUQtm8CGXJ/x+SgYHM0VvPaidxeEwowx7vTVi8h37/rb9C
         R7BfnkfDNL4HN0vdPWCRCwrMaip4v5M1lbG4IKaFHPpDzHWHhYc+HHpuyL85P/cGtTGi
         WyANo0R3IJVjvT7gqHcbR4cXVNMm9/NoowviYuOanpFmwrhD5+xp9JMNCo9TJNFskga1
         /lU/Kvj3kKhEUI3AAcKj3cvObXMNLBpVx5h/aEMMdxo8fGGXRH2H1kj9IBR9Z7shRmJe
         qOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+pRKYTmuOThutSuGqfNrgAamAdWYk1YESRlVS2CO28A=;
        b=XI8OT7PvX37pdPZ1L8BWfy1AuVxcYAHGuI9VdE3qUd1gZihxim4UUtXDwsdkxqSkly
         LFOUAy/FG/boNKikFtz6wvlICzniykfxHUT01MkwmXnoMZNjAfo0KfuLJ6MD4TaH38yz
         Tx3wFe4bo45QGghHvVu/B+KoIGBKohBoFrho3E8h4EZ/+9cOWK8OuA2/Fy+Yl2jdV981
         IF+errdWR4K3Cpst9sAqAcbAYzVwZMon4pZOWS8egUlv2W4hf81mKPv2dAuE0p2WZDNj
         +AHfR84tS+yiYssoiiLbWDaQB4bEVPBlUqexfdaSx1q6VfG+KjUxl4zrJWjxj+dJYfLk
         spHg==
X-Gm-Message-State: AOAM533Tb0OVJ/3W5O5ZoFk9vJJUL7xo5nNEYYuBqgIafLSYyb+zDunm
        HNMpKMLq6bgv58/OIurScfhd9Trc+nY=
X-Google-Smtp-Source: ABdhPJzXAeq3ERQ5grT5ciAC17dbRoZi+Anv+tNI3+3VRZcEoztY0g+mRZPxmb9Cn/QQRsS3FfyLAQ==
X-Received: by 2002:adf:828b:: with SMTP id 11mr27284990wrc.58.1593586805272;
        Wed, 01 Jul 2020 00:00:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id o205sm6355532wme.24.2020.07.01.00.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 00:00:04 -0700 (PDT)
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add maintainers for MIPS core drivers
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200617223201.23259-1-Sergey.Semin@baikalelectronics.ru>
 <20200617223201.23259-7-Sergey.Semin@baikalelectronics.ru>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e29c9643-db5c-2d89-ff56-0900091770ea@linaro.org>
Date:   Wed, 1 Jul 2020 09:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617223201.23259-7-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2020 00:32, Serge Semin wrote:
> Add Thomas and myself as maintainers of the MIPS CPU and GIC IRQchip, MIPS
> GIC timer and MIPS CPS CPUidle drivers.

Why will you add yourself in the MAINTAINERS file for those drivers when
git shows just one contribution for the mips-gic-timer for the timer
stability ?

git shortlog --numbered --summary drivers/cpuidle/cpuidle-cps.c
     4  Paul Burton
     1  Daniel Lezcano
     1  Marcin Nowakowski
     1  Matt Redfearn
     1  Thomas Gleixner

git shortlog --numbered --summary drivers/clocksource/mips-gic-timer.c
    11  Andrew Bresticker
     4  Ezequiel Garcia
     4  Matt Redfearn
     4  Paul Burton
     3  Daniel Lezcano
     3  Thomas Gleixner
     2  Linus Torvalds
     1  Alex Smith
     1  Christophe Jaillet
     1  Felix Fietkau
     1  Ingo Molnar
     1  Markos Chandras
     1  Paul Gortmaker
     1  Rafał Miłecki
     1  Richard Cochran
     1  Serge Semin
     1  Viresh Kumar
     1  YueHaibing

Also, in the cpuidle-cps.c history, there is no signed-off from Rafael,
neither an Acked-by when it was merged. That make me think the patch
went through another path than the linux-pm tree without a cpuidle
framework maintainer acknowledgement.

Perhaps it is a mistake and the patch was actually acked-by, but I would
like to remind the patches have to be acked by the upper maintainers and
being listed in the MAINTAINERS file does not give the right of override
this rule.



> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v3:
> - Keep the files list alphabetically ordered.
> - Add Thomas as the co-maintainer of the designated drivers.
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2926327e4976..20532e0287d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11278,6 +11278,17 @@ F:	arch/mips/configs/generic/board-boston.config
>  F:	drivers/clk/imgtec/clk-boston.c
>  F:	include/dt-bindings/clock/boston-clock.h
>  
> +MIPS CORE DRIVERS
> +M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-mips@vger.kernel.org
> +S:	Supported
> +F:	drivers/bus/mips_cdmm.c
> +F:	drivers/clocksource/mips-gic-timer.c
> +F:	drivers/cpuidle/cpuidle-cps.c
> +F:	drivers/irqchip/irq-mips-cpu.c
> +F:	drivers/irqchip/irq-mips-gic.c
> +
>  MIPS GENERIC PLATFORM
>  M:	Paul Burton <paulburton@kernel.org>
>  L:	linux-mips@vger.kernel.org
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
