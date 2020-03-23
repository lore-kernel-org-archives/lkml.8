Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B6C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053C520753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7CQfX6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgCWNqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:46:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35505 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgCWNqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:46:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id u12so14634843ljo.2;
        Mon, 23 Mar 2020 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+t6LbeYmWe6FOR6WNmkiSgnr61aopdEFTKbqZNI0KU=;
        b=X7CQfX6lthXqqPf71rg06/+uDy5kRW5FnUG0OYxdhhaVsybhm1R4aq1Pci4Ze7emQK
         FW8Ywl2ZhxVeSwLYxlL8tNuZmd0+Up6exYyiBVXkMtwKtqXjjHzX+sc19v/OtjsqTFnS
         nHBoXut0ZX7bWL2FKgR3pf+uC9YriOKhcTt6RtM+YeLDIpjU/DFYuw7RB2Us1TciozAC
         1bWbXELgBNiZbUu0dnmwFSxYkRaVYqv5Vw6l6abxCbcGO7P4FCe7kCTsiXCCo5PlDHB4
         TX0sC8oMiGcYQCzVpwTot4V8KwR81ihDPK9bD1OJGS59GiWI5vArKvb3k1cNfDRstMkg
         NvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+t6LbeYmWe6FOR6WNmkiSgnr61aopdEFTKbqZNI0KU=;
        b=o2NMT7lCWBuP3v5Ee0lNDuTMEUV5iKGWVuj9SQtC2+0FbC8Rp3vDUU8KXIOLlozG9u
         y4wBH1A9heEqO+gc0nWqGpAeXrWnu6p56/EX5x3AO1ya0439CCBbvX8/5RaMLUej/oQm
         PopBvAG9YADz1csyXcajVPRKHR+7MCPKsw7yhYmNtBITSjhzzmyON/giAS4TTgjE2G9Z
         iCjgl5I0m1p/M9wzOPWa/m7MKsgJ4MymMhpwPSrcAn6f3lXbh3SZw16DtszvepFkFQko
         CFJPftobdmNlnUtA3xNR2SP9iy8gn75WoBdRpBRk36W8ts+t5SsgFjhIrgYuVyE61Mt6
         utIA==
X-Gm-Message-State: ANhLgQ1RB6qxZEnFAq7VIkFvv5wUeObdIcR2UZR/DgfSJ0ZUXwzKFlPk
        EpZOWCtlQGHtTyOqs9tOtSy6cTnw
X-Google-Smtp-Source: ADFU+vsX+Y/lZA2JE2slu72//LVcgZYy97TgLh48GZuQn1/NL0ViTBboN5LCMje/F0D1W1g/Nl+yzQ==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr14207072ljg.144.1584971158468;
        Mon, 23 Mar 2020 06:45:58 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id 64sm8363379ljj.41.2020.03.23.06.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 06:45:57 -0700 (PDT)
Subject: Re: [PATCH 2/7] clocksource: Add Tegra186 timers support
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b3859b98-02a3-d197-735c-2c9a9fbe597c@gmail.com>
Date:   Mon, 23 Mar 2020 16:45:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323134221.GI3883508@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.03.2020 16:42, Thierry Reding пишет:
> On Fri, Mar 20, 2020 at 06:38:32PM +0300, Dmitry Osipenko wrote:
>> 20.03.2020 18:11, Dmitry Osipenko пишет:
>>> 20.03.2020 16:34, Thierry Reding пишет:
>>>> From: Thierry Reding <treding@nvidia.com>
>>>>
>>>> Currently this only supports a single watchdog, which uses a timer in
>>>> the background for countdown. Eventually the timers could be used for
>>>> various time-keeping tasks, but by default the architected timer will
>>>> already provide that functionality.
>>>>
>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>> ---
>>>
>>> ...
>>>> +config TEGRA186_TIMER
>>>> +	bool "NVIDIA Tegra186 timer driver"
>>>
>>> tristate?
>>>
>>>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>>
>>> depends on WATCHDOG && WATCHDOG_CORE?
>>
>> Actually `select WATCHDOG_CORE` for the WATCHDOG_CORE.
> 
> WATCHDOG_CORE is user-visible, so it's not safe to select it. Any reason
> depends on WATCHDOG && WATCHDOG_CORE wouldn't work? I guess a dependency
> on WATCHDOG_CORE would be enough because that itself already depends on
> WATCHDOG.

It looks to that should be much better if you could factor out all the
watchdog functionality into the drivers/watchdog, like it's done in a
case of MC / SMMU drivers for example.
