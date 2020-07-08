Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B55C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E62A2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNbB0R68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGHJlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGHJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:41:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218AFC08C5DC;
        Wed,  8 Jul 2020 02:41:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so53339055ljm.11;
        Wed, 08 Jul 2020 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GPMeuDsCXTADuLJLoIy2N9qwDLdeQmuia/lSB8E0qrU=;
        b=CNbB0R68YWw0Z3iV5ixYR0bUFVXyh6U+fQXyLBCgdqqki7Eq9h09AWBWow9sICgySr
         317kdeZx6+zS+mmxbjLC3wDx3MuuMUzw3+c4mdUjLVgUoalEdSGZ4Wd+2+uMpL5MsVrd
         f/jhX7uueYD7h5Owzi+3hqqXl/+Pr70cCKAHWyLaSrPGsNb6ggIDVWCDP+LLpoGunrau
         a0+xjrqa1QKt63nYDWXvyTYNN7KTrs42EsfFRPg0phHuh5qW4i2315Ptn/gyNQv5LM7T
         7GfeHkBbJXWLJDwO7bT6k1keNOr8Jiu/0qBAWmlBpLYV+Fk5kMF42POmf9XBu4dRmZtl
         Vu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GPMeuDsCXTADuLJLoIy2N9qwDLdeQmuia/lSB8E0qrU=;
        b=IJW+WQL3dq6YanCZ8G29QxHtBtQ/+IutALXtXCobxihQEllsz13F8lGOE4CN07vUX9
         UjC9MmvTxU+T3lD6AhzwfKT/DPlQJUjlv2fSh3WPVesuyRzVq8o4zakGrXQHlNgUBX6g
         0ivUVeD9ceHx1KW5AFAduxj8kPi3JqTwhrE38BssfLRrAC286DS6mf3rPkLxg002gUT4
         7raybqqulbOEVAckQJF4wItqALQrxoUo783TChJDreWFRWTxXRQ+lzQkTXtXqtg9MdDW
         zMX/8/pSiY9cpj3esM+t81HlAZs1tPYt8dQFjJRpbHmYO1txwHqDpNlSvhcOL93slMXG
         wClg==
X-Gm-Message-State: AOAM530sGXwl1G8YJLN2S9LZ7fy8pSMng66EV1USTtAZJjxAZtdl/dem
        luF7rLLsU+xqrltyzXRY0bbPOpmg
X-Google-Smtp-Source: ABdhPJy9FcYqgP1wkWLMBvlayoKZTTo2ZClSUXVd8QkMvWexf7BV4FS5B4cDcY+5HaqBAlAQSa2csQ==
X-Received: by 2002:a2e:91ca:: with SMTP id u10mr28037948ljg.101.1594201308192;
        Wed, 08 Jul 2020 02:41:48 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id d25sm780669ljc.103.2020.07.08.02.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 02:41:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] gpio: max77620: Initialize interrupts state
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200708082634.30191-1-digetx@gmail.com>
 <20200708082634.30191-2-digetx@gmail.com>
 <CAHp75VdFVGgKxR+n5TUMuFnWDy_uEmEeG=TvR9s7Xbe=jOdObg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fc3926ec-f8a3-b408-aff6-939f3ce91ce9@gmail.com>
Date:   Wed, 8 Jul 2020 12:41:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdFVGgKxR+n5TUMuFnWDy_uEmEeG=TvR9s7Xbe=jOdObg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.07.2020 11:51, Andy Shevchenko пишет:
> On Wed, Jul 8, 2020 at 11:29 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> I noticed on Nexus 7 that after rebooting from downstream kernel to
>> upstream, the GPIO interrupt is triggering non-stop despite of interrupts
>> being disabled for all of GPIOs. This happens because Nexus 7 uses a
>> soft-reboot, meaning that bootloader should take care of resetting
>> hardware, but bootloader doesn't do it well. In a result, GPIO interrupt
>> may be left ON at a boot time. Let's mask all GPIO interrupts at the
>> driver's probe time in order to resolve the issue.
> 
> ...
> 
>> +               err = regmap_update_bits(mgpio->rmap, GPIO_REG_ADDR(i),
>> +                                        MAX77620_CNFG_GPIO_INT_MASK, 0);
>> +               if (err < 0)
> 
> Does ' < 0' meaningful here?

Not really, although [1] explicitly says that regmap_update_bits()
returns either 0 or a negative error code. The positive value will be an
unexpected return code here.

[1]
https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/base/regmap/regmap.c#L2910

This variant of ' < 0' is consistent with all other similar occurrences
in the driver's code, so should be better to keep it as-is, IMO.

>> +                       dev_err(mgpio->dev, "failed to disable interrupt: %d\n",
>> +                               err);
> 
> One line.

This will make this line inconsistent with the rest of the driver's code.

Secondly, this line won't fit to display using my multi-file view-edit
setup.

I know that 80 chars isn't warned by checkpatch anymore, but still it's
a preferred width for all cases where it doesn't hurt readability, which
is the case here, IMO.
