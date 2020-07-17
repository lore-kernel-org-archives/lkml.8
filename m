Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C010C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D40206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACzxgl8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGQEVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:21:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 21:21:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so9573018wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 21:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vTU0fD0RqPTAMbppUiAJYQhElhFYod+EUa58MhwuRFg=;
        b=ACzxgl8pWNw1qfxqU9+pYlrS4eR6a5e8McuQW2jb5q8hduM5b3kyZe5bs9+gGa8hL1
         5FJtj/j+394vgNFHlQM2BW4bLEdoCF+hvyq4FnPvtaN4aX3i/NZ8W7szbOj6dDzcvx8M
         105ReGcsasNaMMmppOs7r6YbsWyMAXlUhgWkN0PKnHnMLoleD5ljIbnU2JNlI0VNQ6hn
         0mfgfFQO4eCe7L2o9yREBsMif2/QjWS24jxf0p8dmO/28uBfwiLo92hRfocfz8JAjyPN
         G9AmS9LCbInhyHoihQp3JbZwc63+NvyBXrabUky7sSWI9WzW4HcpKbe0p9kw0VocDwoa
         fN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vTU0fD0RqPTAMbppUiAJYQhElhFYod+EUa58MhwuRFg=;
        b=s97aKM0rAJ1D40loN7uwOPbxBY1WT/STun9TzflRu9lYH2Cla5uDHmnlOAev6Vl6PL
         YlIGETG1TCdH+QQv4kxXSM2PkJOcgEX2YBq67skreGst6BQMJ+GlOaR8fZD+PMP8A5wk
         DIZ5XkfiVrXtVl0hmF1AFCdoNux+A079kxHjS/2AwXQa4WgTDRLeXPHp9khHsfvzPlmi
         sxJI9NHXdaHJ9gk/bpBH0cnrMoMyLudKreL4/RPHiRFITTiuRrvJYRcpmSt85qfabcNn
         JegEpMqkyhxCAcqT/BAHq+wBj/8TxEg7OvXoFIX1fAat50H9FMbh6Vm8lNnj7VQBJ//y
         NrnA==
X-Gm-Message-State: AOAM530dt1y0SRY549zMCt1btPAlIuTDwnOrFFqU+DY2dLMpMhh86+eX
        VaqdkMq8X3SdkdHRDuJgO/xSNQ==
X-Google-Smtp-Source: ABdhPJwec3DisLdAS02+fUE6IczMefzHYliDuu268Dl6qCiJz8+nAomftZcYkwgKg4V15D7Jeop8BA==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr9050111wrl.292.1594959660912;
        Thu, 16 Jul 2020 21:21:00 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id 138sm7175510wmb.1.2020.07.16.21.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 21:21:00 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] clocksource: Ingenic: Add support for the Ingenic
 X1000 OST.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200710170259.29028-1-zhouyanjie@wanyeetech.com>
 <20200710170259.29028-3-zhouyanjie@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dd01a117-265a-e64b-5871-22f0f752834a@linaro.org>
Date:   Fri, 17 Jul 2020 06:20:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710170259.29028-3-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2020 19:02, 周琰杰 (Zhou Yanjie) wrote:
> X1000 and SoCs after X1000 (such as X1500 and X1830) had a separate
> OST, it no longer belongs to TCU. This driver will register both a
> clocksource and a sched_clock to the system.
> 
> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
> Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
> Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v1->v2:
>     Fix compile warnings.
>     Reported-by: kernel test robot <lkp@intel.com>
>     
>     v2->v3:
>     No change.
>     
>     v3->v4:
>     1.Rename "ost" to "sysost"
>     1.Remove unrelated changes.
>     2.Remove ost_clock_parent enum.
>     3.Remove ost->percpu_timer_channel/ost->global_timer_channel.
>     4.Set up independent .recalc_rate/.set_rate for percpu/global timer.
>     5.No longer call functions in variable declarations.
>     
>     v4->v5:
>     Use "of_io_request_and_map()" instead "of_iomap()".
>     Suggested-by: Paul Cercueil <paul@crapouillou.net>
>     
>     v5->v6:
>     No change.
> 
>  drivers/clocksource/Kconfig          |  11 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/ingenic-sysost.c | 539 +++++++++++++++++++++++++++++++++++
>  3 files changed, 551 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-sysost.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 91418381fcd4..1bca8b8fb30f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -696,6 +696,17 @@ config INGENIC_TIMER
>  	help
>  	  Support for the timer/counter unit of the Ingenic JZ SoCs.
>  
> +config INGENIC_SYSOST
> +	bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"

We usually use silent options and let the platform's Kconfig enable it.
We show up the option only when COMPILE_TEST is enabled.

Is there a reason to do it differently?

> +	default MACH_INGENIC
> +	depends on MIPS || COMPILE_TEST
> +	depends on COMMON_CLK
> +	select MFD_SYSCON
> +	select TIMER_OF
> +	select IRQ_DOMAIN
> +	help
> +	  Support for the SYSOST of the Ingenic X Series SoCs.
> +

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
