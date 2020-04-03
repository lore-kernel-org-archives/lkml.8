Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575CAC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB2D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ausdS3Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404506AbgDCQZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:25:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42242 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403971AbgDCQZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:25:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id s13so6271532lfb.9;
        Fri, 03 Apr 2020 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u7P0dsxmLlwmCnuhltg/uqrvRo4yoGJh1knnxv/mnF4=;
        b=ausdS3HwKnqEo0svXRS60uo2DUISom82uTCbTiCDyjvqP4f7KtzZTvAB2fMnG9Lt5N
         87B1CIW24mYQL4yK0JHZouy0UxvBBfoWyRTTsVcFonHOyCnGHy4atVPjsYhQDW/TQjJf
         V4uLaVe1fQ3V/oFsQXfFE0HG8oit5FF8+umM0qKyGHKlwu3CEWhhsV4WBlf/VhXLQCGq
         VXvrEr1JtkCzurVd5yU2f1xzofTQG/tet8UjPO6R18/+AiWZFKUN1+9GwyYZ2BY+YVCF
         nhQM3XvF31EV7o5AbVnJ8by9wnXKtUp1e044Z0/wIydXQawPzXx9raleZfGN/SC27+0g
         uiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u7P0dsxmLlwmCnuhltg/uqrvRo4yoGJh1knnxv/mnF4=;
        b=Zi6ALK6Ad/mPATUnwVB/HHfXjk6V4rDJyzi3L5X8IH5W06bZbNIBNWEwPr3QO9WTO2
         FGDib/adFBmXA/g80i9Karw5nTLAYCBCqvPRjkUhsbdCs3r0Ki/U9qCBDEaKZ2Zt2vK3
         zwHcYWuMEqxPrXmPfl2wM2HeJdpaM0XIh2VP1bJ7v5XNKT4+j/JRXjYIWVSqub2ksVjZ
         q+ixTE2bZVETuynhR9VzC15STqhgNhdDXMEnNAPRRThgveCAeWRhbbAxhbLhk8f+zsc8
         0a1VGxlxQ8NSUzXJTQ45c9aJG7OEpcybpf4l4z/MiTUFI5ubZustFdKFR+gN3hRRDnwc
         wUUQ==
X-Gm-Message-State: AGi0PuYtGs3Ccrgu2XfhV2cVvQ9hKRI3NpRxRHVUdUh9KonO/TxVxL6h
        rMLCbowCkuQP1JGxtXUARvlno4Mb
X-Google-Smtp-Source: APiQypJJSXDhKFLZlI12icRGHHnXFRst1hlTrBfaZ8PVUrhvBcix1+mubcHb53j7ECG31VFXplCIyw==
X-Received: by 2002:a19:9141:: with SMTP id y1mr5899567lfj.168.1585931097643;
        Fri, 03 Apr 2020 09:24:57 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id q6sm5325848ljp.21.2020.04.03.09.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:24:57 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] clocksource: Add Tegra186 timers support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
 <20200331221914.2966407-3-thierry.reding@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <edf08b18-ad19-7191-020d-a06d57747c45@gmail.com>
Date:   Fri, 3 Apr 2020 19:24:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331221914.2966407-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.04.2020 01:19, Thierry Reding пишет:
...
> +static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
> +				    unsigned int timeout)
> +{
> +	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
> +
> +	tegra186_wdt_disable(wdt);
> +	wdt->base.timeout = timeout;
> +	tegra186_wdt_enable(wdt);

Why changing timeout enables the watchdog?

> +	return 0;
> +}
> +
> +static const struct watchdog_ops tegra186_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = tegra186_wdt_start,
> +	.stop = tegra186_wdt_stop,
> +	.ping = tegra186_wdt_ping,
> +	.set_timeout = tegra186_wdt_set_timeout,
> +};

...
> +static int __maybe_unused tegra186_timer_suspend(struct device *dev)
> +{
> +	struct tegra186_timer *tegra = dev_get_drvdata(dev);
> +
> +	if (tegra->wdt)
> +		tegra186_wdt_disable(tegra->wdt);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused tegra186_timer_resume(struct device *dev)
> +{
> +	struct tegra186_timer *tegra = dev_get_drvdata(dev);
> +
> +	if (tegra->wdt)
> +		tegra186_wdt_enable(tegra->wdt);

What if watchdog is in a stopped state? Why it's enabled unconditionally?

> +	return 0;
> +}


