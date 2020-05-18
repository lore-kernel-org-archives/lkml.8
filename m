Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4DDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E085D207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xANdb5EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgERQDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:03:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:03:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so45605wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kHp1jqnjDYe5WVMr5QDuCWYGK2hgWg9rc5IEJIxKk3w=;
        b=xANdb5EU+o0BhxfOF0MxnStOFmxwzeL5BktfbSReTzGwrOzIXZjmIPslw/JewW3qYs
         GZI2mWcOSEeF+2mZTyMqjIOlw+VZvZ8/Ji78lNKTzDjakAKU9U3kGm6PxNUgpXWnzHOU
         fBojVaPg9nMm1DEiexnfdG2wd6bPAlwO/8bjR10Z5fqdErSt9IZmLh6vVp1di0sbhw54
         ecepgS7+UaoQr4TY6odYUi+/nVC8cZDxQ3ZhAwpsVKkH47PsrW8uGKfuKN73hzLzyY45
         I74SZggJgEHtXLIHi0RwsXg7TZmuZsg+4rYqSbms8lcIgIodi5KRqEsIsrawKtqKTlXE
         e8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kHp1jqnjDYe5WVMr5QDuCWYGK2hgWg9rc5IEJIxKk3w=;
        b=pGf++vi86sMyxRrnv3uoOXIRatmygHSRePqIenPhlObNFuB2WPRctPMWmdJ4Kc3q+g
         45uB5q42uTKzQ9ZQhXrZt+nXfGmFAOJxF8ga4VqthDjHeu4RWo3HFbDB3zhL/SRozT8c
         WK+/MOLoE0Lju7FmMxLhWaEH+MN8aqyB67TgMqDB1Jl7NEHv5qLP9Fi8lfYh4m90Qb+V
         hfPObZ33/+d34lf5mZ5kQVaAYvHcKjD2fjbiTZYIyhoH5MX/2uAvli7nYBUSbvTANG/o
         pcW7nz1yq2wkUe7g9uvJsUrFcfa0P77hU1fZm7x/6KN12YnvFHV4K43Z3+Tbt4rNqeei
         qvyQ==
X-Gm-Message-State: AOAM531yE08L44jO0sQ4lOyh4FGPojqtLGAxgOPdoDdonz8brh44nYu0
        lt/0XEBiCkouLtu8ppTkYO+Mlw==
X-Google-Smtp-Source: ABdhPJz+tML2+MA0h6epElsjzpBYHR7aAK55wbLH9UOQc87ETu0yWvrF/5P42QSgZ1c73Yj5cn0Sqw==
X-Received: by 2002:a1c:b354:: with SMTP id c81mr83974wmf.136.1589817782874;
        Mon, 18 May 2020 09:03:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id w12sm19493wmk.12.2020.05.18.09.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 09:03:02 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] clocksource/drivers/timer-atmel-tcb: add sama5d2
 support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20200506080554.283177-1-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f0feb409-11fb-08de-cc06-216a16de994a@linaro.org>
Date:   Mon, 18 May 2020 18:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506080554.283177-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

I would like to take the whole series but I need Rob's blessing for the
DT parts.

On 06/05/2020 10:05, Alexandre Belloni wrote:
> This series mainly adds sama5d2 support where we need to avoid using
> clock index 0 because that clock is never enabled by the driver.
> 
> There is also a rework of the 32khz clock handling so it is not used for
> clockevents on 32 bit counter because the increased rate improves the
> resolution and doesn't have any drawback with that counter width. This
> replaces a patch that has been carried in the linux-rt tree for a while.
> 
> Changes in v3:
>  - Moved the child node documentation to the parent documentation
> 
> Changes in v2:
>  - Rebased on v5.7-rc1
>  - Moved the binding documentation to its proper place
>  - Added back the atmel,tcb-timer child node documentation
> 
> Alexandre Belloni (8):
>   dt-bindings: atmel-tcb: convert bindings to json-schema
>   dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible
>   ARM: dts: at91: sama5d2: add TCB GCLK
>   clocksource/drivers/timer-atmel-tcb: rework 32khz clock selection
>   clocksource/drivers/timer-atmel-tcb: fill tcb_config
>   clocksource/drivers/timer-atmel-tcb: stop using the 32kHz for
>     clockevents
>   clocksource/drivers/timer-atmel-tcb: allow selecting first divider
>   clocksource/drivers/timer-atmel-tcb: add sama5d2 support
> 
> Kamel Bouhara (1):
>   ARM: at91: add atmel tcb capabilities
> 
>  .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 -------
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 150 ++++++++++++++++++
>  arch/arm/boot/dts/sama5d2.dtsi                |  12 +-
>  drivers/clocksource/timer-atmel-tcb.c         | 101 +++++++-----
>  include/soc/at91/atmel_tcb.h                  |   5 +
>  5 files changed, 219 insertions(+), 105 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
