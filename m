Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6614C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981D9206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DByr5n6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDCU6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:58:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35293 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:58:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id r17so3372882lff.2;
        Fri, 03 Apr 2020 13:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8l9T+todbhyGC0Ch41GMpkg51bRDZTNStCd7TTDpixQ=;
        b=DByr5n6EhyfXHuQJXJITYG3qU/WAnu73MxUeDoW/Wc2BqUNB9eZmvnbrjh6RLKkTD+
         gqMIkXNk1NRFFpjQ2ZVG8vRIf0G5L4OVeBfDFQvGaudAO/tCd2WpL5JD0ybFEdJ2xcdB
         OL/Wc5CmFFvH8CiRCjP9RXPxxysQgi3phX3Abk7NUWhFxYl8FSxs7OdH/EqjdFt3cBpN
         rzPXNK4b/XxZ6Z4p1sRYeFqlQ4xSsAHlr8Y1VlrjOURyZEEE+mHfVGLvzbAnKp0wOlfc
         k2elTtSJ6NPUlHzrpCd2a2lyMQhRdKjfpn5B3tAQfkRbw4sh4rHuo9fPa5VcXAmkE4cP
         XvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8l9T+todbhyGC0Ch41GMpkg51bRDZTNStCd7TTDpixQ=;
        b=eYfP1HevljecHpJtuS9jH+kAWAMFcKx4hLEtMPj/CHbASbmwhHDN/mKjQz+2yh8QGF
         KfyI7mLWt2vzSv1m4NIvjuip92STIw78rBsvIhqAc2JoPd+J9S9sMBq3kXSdqzCINIRi
         FXO8xe1F0oJejGMWYL/Xaootk335HRmpI6PCzoJuECeqptD7GVdP6IauMRpf1OKBg14F
         xsIEnsQzqU6pRlGzuZ1KddX0I5a+dZJy9k871D+HpF0Tu2Qad2VQmVmn5ffl/7Vj/qsT
         eOXrkregN8TJz5vz7SGsiTX8/P/s199QZS1yFbqHWob4uQRnwhpnOlUVMReTv+8tKZP8
         RL+w==
X-Gm-Message-State: AGi0PuYB+4kdFTZxOCfGby3AcTzmFe6nISZyUWqnZOlQFbVoCJI46hqg
        mDMb/9suvLHZpWs9jRiC4k65lD4j
X-Google-Smtp-Source: APiQypIP4feAzcNaLipaxLLCk8SMJdL0Hnq+HeHGqTrL1v1NlKcpFt9MeikawbQvt2aA4g7VM1OIpA==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr6146614lfi.172.1585947521710;
        Fri, 03 Apr 2020 13:58:41 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id j14sm6694325lfc.32.2020.04.03.13.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 13:58:41 -0700 (PDT)
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
Message-ID: <894dbbd4-be96-13ce-96b9-432b5d71f06b@gmail.com>
Date:   Fri, 3 Apr 2020 23:58:40 +0300
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
> +static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
> +				    unsigned int timeout)
> +{
> +	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
> +
> +	if (watchdog_active(&wdt->base))
> +		tegra186_wdt_disable(wdt);

Could this and other tegra186_wdt_enable/disable occurrences race with
the interrupt handler?

Shouldn't IRQ be disabled/enable in a such cases to avoid the races?

> +	wdt->base.timeout = timeout;
> +
> +	if (watchdog_active(&wdt->base))
> +		tegra186_wdt_enable(wdt);
> +
> +	return 0;
> +}
