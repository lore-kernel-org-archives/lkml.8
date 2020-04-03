Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3410E20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7SDuK2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgDCUpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:45:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41194 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:45:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so8344487lji.8;
        Fri, 03 Apr 2020 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gyX/O2Ze4URKpHvdvcUbunyVeBFLNpqM1D+xSUQcU20=;
        b=l7SDuK2vWHtYAVjGxUg8CK0CatllCqvrOh7YX0Y/PoTbJ9J+kP7XRzDykjgt/ggoze
         lPhVhljtKOw2Vts0Z6ldnIeCh2mWJdaa4sLjP12SG0mOoMB5ymXU1soWqLase82rRVJF
         huaz3xvH6jtvEes8ZHBvIP4E6zVr2D2gh3Q11xAZnR3nPTlcRtrvbGBrhZBq3LvlQLM0
         sfr5KdOkf9wInypHHEqhJez+naqmlfp0Nk4uuJ8q6u+FUAlF1eLU+tMG+9VUOVplEEYK
         QClMKd5r1xwC2krQv8dp64NChunjpU7lKTtf0+q+sMJwIc73JIKW2MqmvFD2XqRoAKLa
         oQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gyX/O2Ze4URKpHvdvcUbunyVeBFLNpqM1D+xSUQcU20=;
        b=VIuC5tkrkXvZuFSw10yUSg+IgmM73WfMJJg7+6Ip/TxuhUpEsO/rPO9FuY6Dr90SAV
         5v3cjS0owKSG2n+S2ryyh8MnwvmPAlDN7N/gAzH+NJiTOY2kD5VGW1BQro5Rm5oht+JX
         BpMTwBeozs2oCsZQ+cNythT7h9fo8QOHG2Wo4MLoNP3GVi5M9Qvom0nMWOO9kdCMjRMS
         9Uk5+x4L6JVcxeRs7Nwy5KJtpmMMcNQz3ADB5qs3knMR/IBSezth8rK+EFW78/awx1VS
         oWE8LuIDJWVO45byfD+7CjdWrdYiYi9NxrP0QBPKl1/veJMlZtQ2vToO43TTZ+rTDB/d
         fSag==
X-Gm-Message-State: AGi0PuZeYsQzD9t2agAcxP3IZg9Xe1xjRMCDYTzTkLSz3hqe0rxSyKFz
        XTYWur6PJ3jVj3FyMuDxHdRkji7j
X-Google-Smtp-Source: APiQypKMj0aqmaeAInyOZIsDaLF0J+4JL/6tvSSQ8+cWUfCtwi2YnSM2jY4khJgvVESjgw6Xly1Fiw==
X-Received: by 2002:a05:651c:310:: with SMTP id a16mr5465268ljp.275.1585946707554;
        Fri, 03 Apr 2020 13:45:07 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id r24sm5522163ljn.25.2020.04.03.13.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 13:45:06 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] clocksource: Add Tegra186 timers support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200403202209.299823-1-thierry.reding@gmail.com>
 <20200403202209.299823-3-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <82a08b57-c151-daf8-0719-1034be07538c@gmail.com>
Date:   Fri, 3 Apr 2020 23:45:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403202209.299823-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.04.2020 23:22, Thierry Reding пишет:
...
> +config TEGRA186_TIMER
> +	tristate "NVIDIA Tegra186 timer driver"
> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	depends on WATCHDOG && WATCHDOG_CORE
> +	help
> +	  Enables support for the timers and watchdogs found on NVIDIA
> +	  Tegra186 and later SoCs.

Personally, I'd like to see this in drivers/watchdog/ because I've seen
cases where subsys maintainers are doing bulk-changes to drivers and
missing those that reside outside of the subsys directory.

But, that's not to me to decide, so I don't really mind.

...
> +static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
> +{
> +	struct tegra186_timer *tegra = wdt->tmr->parent;
> +	u32 value;
> +
> +	/* unmask hardware IRQ, this may have been lost across powergate */
> +	value = TKEIE_WDT_MASK(wdt->index, 1);
> +	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));

Perhaps this one also could be relaxed, for consistency. Sorry for
missing it in v2 :)
