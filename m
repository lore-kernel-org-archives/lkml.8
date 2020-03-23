Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22EDC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F792072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrN4Rh7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCWQK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:10:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44104 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgCWQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:10:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id w4so15187218lji.11;
        Mon, 23 Mar 2020 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/0zBfx6rPy6OaV/sXxMDO20sjUMqldTKMQQQm3+A82I=;
        b=rrN4Rh7B0bHYQOV4Lv/fuRsTdQ1n5kDuqAjCjuhsg4+Ca1zFHIDh/hKTh3VwNy1fzh
         wA1l6GDBMYY0BRn/tha/sGCxzQB+r+1ms08cWiulZefWcqGlwBd4imWOzF0mHvpM4e/y
         +4RWolBHffTjIHaburArg2euBHkwpmk1w8TSYKjf9Ujilv1k1tjD22ui6wLanKcMbQl6
         Atj8QCIJnkCwDk8rbRJ4m+v+ulNZpnDYom+rdYDog6c3PKemA7+6xonTpXPxBi/bVvWP
         4VAOZ540fZENa796ZqCZ3N7r2TaWyKh5Y/y6sojlRxOhreiR3yqckCUJN3vxQn4OeBJt
         QoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/0zBfx6rPy6OaV/sXxMDO20sjUMqldTKMQQQm3+A82I=;
        b=ljXCVu5Q5y1UHC6vZNP8aLvx2Vk/eTcZV5PBbjpotRSHAEzfY3jediLjUA8sZf0tT9
         ubL8i3YBt1E5hrKExliAR5E6QqgciF2rBi1/YUaoz2Iz1M6BY7BzvWDCu9RmWUGRs9y2
         qPzFXtFc7Z4kRpXtgj/xW9WANaQVPs0EUXSh+BakLX2LiWhSPFqj5ER1mWWugtyMmU8K
         IgjTHCeZOXBNm0ySRM6oMnGJFEU/TGKpSA1KuhzbDrOr0+VuDfzV19+naWPwKbfyP+4d
         vhjGbN2cdJj/ruw2F/0uTf04l0Sbld02QTxd5QsJIW8rOwFRBsx0zrZbnlN65be2Phm5
         G/WQ==
X-Gm-Message-State: ANhLgQ3KYFX9CUGr9BEDv00w1GFLwYCI/YBuERGfY7b1AoxBusbYEJix
        tIOsLHFX0vLHAcU7+i5VCgbhBlA5
X-Google-Smtp-Source: ADFU+vtrKhhRT9bnt9GY9LLloFRbJ6fchh+JM5a53YXxlh9MQy43zjdZ1FFxsAVFpnqPmZvKwOHxjw==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr13393902ljk.66.1584979854347;
        Mon, 23 Mar 2020 09:10:54 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id t7sm7444717lfg.93.2020.03.23.09.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 09:10:53 -0700 (PDT)
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-3-thierry.reding@gmail.com>
 <48b2099c-dd83-d4dc-aab4-8c6f68a215cf@gmail.com>
 <da2a0501-664a-c5d0-7b13-174e5347eaf7@gmail.com>
 <20200323134221.GI3883508@ulmo>
 <b3859b98-02a3-d197-735c-2c9a9fbe597c@gmail.com>
Message-ID: <23f9ba4f-0e6b-a946-a52d-eea1916a38ef@gmail.com>
Date:   Mon, 23 Mar 2020 19:10:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b3859b98-02a3-d197-735c-2c9a9fbe597c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.03.2020 16:45, Dmitry Osipenko пишет:
> 23.03.2020 16:42, Thierry Reding пишет:
>> On Fri, Mar 20, 2020 at 06:38:32PM +0300, Dmitry Osipenko wrote:
>>> 20.03.2020 18:11, Dmitry Osipenko пишет:
>>>> 20.03.2020 16:34, Thierry Reding пишет:
>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>
>>>>> Currently this only supports a single watchdog, which uses a timer in
>>>>> the background for countdown. Eventually the timers could be used for
>>>>> various time-keeping tasks, but by default the architected timer will
>>>>> already provide that functionality.
>>>>>
>>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>>> ---
>>>>
>>>> ...
>>>>> +config TEGRA186_TIMER
>>>>> +	bool "NVIDIA Tegra186 timer driver"
>>>>
>>>> tristate?
>>>>
>>>>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>>>
>>>> depends on WATCHDOG && WATCHDOG_CORE?
>>>
>>> Actually `select WATCHDOG_CORE` for the WATCHDOG_CORE.
>>
>> WATCHDOG_CORE is user-visible, so it's not safe to select it. Any reason
>> depends on WATCHDOG && WATCHDOG_CORE wouldn't work? I guess a dependency
>> on WATCHDOG_CORE would be enough because that itself already depends on
>> WATCHDOG.
> 
> It looks to that should be much better if you could factor out all the
> watchdog functionality into the drivers/watchdog, like it's done in a
> case of MC / SMMU drivers for example.

Also, please see drivers/watchdog/Kconfig where each individual driver
selects WATCHDOG_CORE on by as-needed basis.
