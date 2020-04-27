Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE700C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8F9206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVU3dM+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgD0HAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgD0HAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:00:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB2C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:00:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so19121687wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3LrBTWKR8RZnJsKdt2BtOUDXV0TQoOt0eUU0K5w5lSE=;
        b=oVU3dM+bm37jxxJCCv7t9xgHBlkV+VnyUx0PhitV+4aUyvSvxGbuKbY1MCIZSNFkvR
         T7p9ezgKUbyGfrOp4Oze9bFpL/3ydotXHT00ciKv3b86BxVITEt7m7uZj2T1wD8c/IeC
         t7QmPREZq3jeQEg1r9BHXEtttm9AZmW8ruOAnQoIle8CkJstrfLgDiAmupw6g1fTAC0D
         Ckb952dTIhkM5l3VF89XdQIOZnowREmoEnCwBqnKHcv1Kj6L9aIgn4nFMGEvuFSVTUXZ
         q1K77HYg9KMr1qsEGQnfmilHvf0fiCjko7rNtdy1zvRiKRlJp9qGH02KCYPlRKKfjFM9
         xJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3LrBTWKR8RZnJsKdt2BtOUDXV0TQoOt0eUU0K5w5lSE=;
        b=b4zy1X1QqNNuL5HhYW9Ifkr4M0qGxigwgOciEjzp/VCC0jPhD/j8aL7/3ME84C9U26
         Eq+Kfq0rhw7viRXfVGLQWIMl1w3NiIJDNBJetzZn0FuVLQm5gpi3nrlGuUTTui51gBiH
         mQ2wHSfmEJEzVv/EFWX2lpqu5qEKAfUoHCO86z300HJGloMQOaocHwUR3zATvcgko9rR
         6Cr+84W/jxjAarKknU/6JcQcQXPiBuu88FAKZ0Ks1u/jFeqUUi1pgmiIFJMVVZWEPkqj
         7WTvPyDHyLBVY5ymkdvxMHcp7L8f7haxjLaHlqjCsm4Q3TlgQT4f7odMDoXwS8GJTy8z
         2FbA==
X-Gm-Message-State: AGi0PuY2ZXu6u2uX8z3zb8eiDIk6MWo5yVbVxIRlfD8jb1GCwPrCLx+A
        V4BqpRWb0EtboN+TbrP3lGMdKQ==
X-Google-Smtp-Source: APiQypJodr4c4+fycbp55+jKelfPIyy5Mfb8pZxsys+qLWl4QK+n03MMhJxq9T3SNpJq6u+LIM4DhA==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr23845990wmj.169.1587970807729;
        Mon, 27 Apr 2020 00:00:07 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id q143sm15169085wme.31.2020.04.27.00.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 00:00:07 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-microchip-pit64b: Select
 CONFIG_TIMER_OF
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, claudiu.beznea@microchip.com
References: <20200426124356.3929682-1-mpe@ellerman.id.au>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <50114298-7788-79bf-b9a8-26f399437c63@linaro.org>
Date:   Mon, 27 Apr 2020 09:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426124356.3929682-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2020 14:43, Michael Ellerman wrote:
> This driver is an OF driver, it depends on OF, and uses
> TIMER_OF_DECLARE, so it should select CONFIG_TIMER_OF.
> 
> Without CONFIG_TIMER_OF enabled this can lead to warnings such as:
> 
>   powerpc-linux-ld: warning: orphan section `__timer_of_table' from
>   `drivers/clocksource/timer-microchip-pit64b.o' being placed in
>   section `__timer_of_table'.
> 
> Because TIMER_OF_TABLES in vmlinux.lds.h doesn't emit anything into
> the linker script when CONFIG_TIMER_OF is not enabled.
> 
> Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
> Cc: stable@vger.kernel.org # v5.6+
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Applied, thanks

>  drivers/clocksource/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index f2142e6bbea3..f225c27b70f7 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -709,6 +709,7 @@ config MICROCHIP_PIT64B
>  	bool "Microchip PIT64B support"
>  	depends on OF || COMPILE_TEST
>  	select CLKSRC_MMIO
> +	select TIMER_OF
>  	help
>  	  This option enables Microchip PIT64B timer for Atmel
>  	  based system. It supports the oneshot, the periodic
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
