Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBBC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5AB20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pl2d5IzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391088AbgDCQOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:14:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33251 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390975AbgDCQOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:14:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so1765111lfc.0;
        Fri, 03 Apr 2020 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LNlGrhFs6WaBVtCi4AoyR7qa2EvwLZbv34oQz9zHV1w=;
        b=pl2d5IzGSighqHDwmLXHdqnILWHrTY3AkSH0vZOM0f0WTbLtUVI6VzDLZnSHJd8jFe
         6kSV7Zia88Il7Ua4WTtLvQeKmEtq0Mwr61n0iV552b3FImQWcSvMtuTRYFCw+BGwtwCG
         +Deguo414wgo9uBP9Akuxg9l5o2s1bqOksgLNSNYkaN0Ed+82BWjVX4qItvY51Bo/eDh
         9VrUg+QhciKjHIKyPqIWj8peK+kKnWqefSj6KylzvVF1YkbpogP2rcu6XutMUlaS0fK9
         CeUaiKohXcp43O9/9mEbi1rJzyXVYpuif9PE445/Wm8Em6WU5rp+MEgMFWYirVkEoz1G
         7UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LNlGrhFs6WaBVtCi4AoyR7qa2EvwLZbv34oQz9zHV1w=;
        b=oK0IOTtZIN66v6PY5zkrI2Vg4bytTYzMpLLQU7kGQAcvxWyH0EMKjU2/r37YHjFImr
         5FwmlVlF/Y5Tdxb1maa52/hn8IQ5+3mCqUDw022r1LjUa+NF9FEAn0RLMVPPZ61Basvr
         djTr+yWhQu7eAxdyNWDTcgpKIxstOyhaobmF66BmE3djupupGDV5R0OZtbzC0toVJbhW
         yVTDX6zP50olsdr7l61xibp/v0kHGxCBntTbpICqQHSaCxfq3MXiqmN82CS8e6dlHjmo
         ka8l/zduyoZHceapwy30eTe/ABfbVCHl6gS6eFVIdAGeRI5RhVp4+DTNBjZIBLRNIKJe
         3hYA==
X-Gm-Message-State: AGi0Puaxk+mb4FzjauXngD0Ry6ibwAEcZoHXb9v84W+LzjLDfxxYEXOJ
        kSFTm2gJDlYWz0OC+1Mqi71QtyMu
X-Google-Smtp-Source: APiQypI5tO4VK9kA5fvK4ArCZlp0YFsaezp5Hns2PIhrdGpX8b/bglY4qvkIDEqUyJLyr/jCpjPt1w==
X-Received: by 2002:a19:4a03:: with SMTP id x3mr5970057lfa.159.1585930480114;
        Fri, 03 Apr 2020 09:14:40 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id v22sm5222691ljj.67.2020.04.03.09.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 09:14:39 -0700 (PDT)
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
Message-ID: <de97ce0c-3fa3-9f13-2b0e-f4369f94e113@gmail.com>
Date:   Fri, 3 Apr 2020 19:14:33 +0300
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
> +static void tmr_writel(struct tegra186_tmr *tmr, u32 value, unsigned int offset)
> +{
> +	writel(value, tmr->regs + offset);

relaxed?

> +}
> +
> +static void wdt_writel(struct tegra186_wdt *wdt, u32 value, unsigned int offset)
> +{
> +	writel(value, wdt->regs + offset);

relaxed?

> +}
> +
> +static u32 wdt_readl(struct tegra186_wdt *wdt, unsigned int offset)
> +{
> +	return readl(wdt->regs + offset);

relaxed?

> +}

...
> +static irqreturn_t tegra186_timer_irq(int irq, void *data)
> +{
> +	struct tegra186_timer *tegra = data;
> +
> +	if (tegra->wdt) {

Why this check is needed? Please see more below in regards to
devm_request_irq().

> +		tegra186_wdt_disable(tegra->wdt);
> +		tegra186_wdt_enable(tegra->wdt);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tegra186_timer_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tegra186_timer *tegra;
> +	int err;
> +
> +	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
> +	if (!tegra)
> +		return -ENOMEM;
> +
> +	tegra->soc = of_device_get_match_data(dev);
> +	dev_set_drvdata(dev, tegra);
> +	tegra->dev = dev;
> +
> +	tegra->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(tegra->regs))
> +		return PTR_ERR(tegra->regs);
> +
> +	err = platform_get_irq(pdev, 0);
> +	if (err < 0) {
> +		dev_err(dev, "failed to get interrupt #0: %d\n", err);

Duplicated error message isn't needed for platform_get_irq().

> +		return err;
> +	}
> +
> +	tegra->irq = err;
> +
> +	err = devm_request_irq(dev, tegra->irq, tegra186_timer_irq,
> +			       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,

Why IRQF_ONESHOT?

And IRQF_TRIGGER_HIGH?.. the interrupt-level should come from the
device-tree.

> +			       "tegra186-timer", tegra);
> +	if (err < 0) {
> +		dev_err(dev, "failed to request IRQ#%u: %d\n", tegra->irq, err);
> +		return err;
> +	}

Interrupt should be requested at the end of tegra186_timer_probe(),
otherwise probe order isn't correct, leading to a potential race conditions.

> +	/* create a watchdog using a preconfigured timer */
> +	tegra->wdt = tegra186_wdt_create(tegra, 0);
> +	if (IS_ERR(tegra->wdt)) {
> +		err = PTR_ERR(tegra->wdt);
> +		dev_err(dev, "failed to create WDT: %d\n", err);
> +		return err;
> +	}
> +
> +	err = tegra186_timer_tsc_init(tegra);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register TSC counter: %d\n", err);
> +		return err;
> +	}
> +
> +	err = tegra186_timer_osc_init(tegra);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register OSC counter: %d\n", err);
> +		goto unregister_tsc;
> +	}
> +
> +	err = tegra186_timer_usec_init(tegra);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register USEC counter: %d\n", err);
> +		goto unregister_osc;
> +	}
> +
> +	return 0;
> +
> +unregister_osc:
> +	clocksource_unregister(&tegra->osc);
> +unregister_tsc:
> +	clocksource_unregister(&tegra->tsc);

Looks like there is an opportunity for devm_clocksource_register_hz().

> +	return err;
> +}
> +
> +static int tegra186_timer_remove(struct platform_device *pdev)
> +{
> +	struct tegra186_timer *tegra = platform_get_drvdata(pdev);
> +
> +	clocksource_unregister(&tegra->usec);
> +	clocksource_unregister(&tegra->osc);
> +	clocksource_unregister(&tegra->tsc);
> +
> +	return 0;
> +}
> +
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

Could tegra->wdt ever be NULL?

> +		tegra186_wdt_enable(tegra->wdt);
> +
> +	return 0;
> +}
