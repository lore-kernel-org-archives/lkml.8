Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D342051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzOMS/zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395508AbgAPSVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:21:25 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:55048 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390150AbgAPSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:21:21 -0500
Received: by mail-wm1-f41.google.com with SMTP id b19so4772955wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5JU0rlbweRkXKIG5ENBhNK1Ab5N5J6i6Y8hX19ZYXqg=;
        b=zzOMS/zAMGiNY0Et/KUejcjpUCYKJU5OkQrJLbYHgtcJoCJjuC6M6puHj0go53DEkY
         CBwTISI3ek+zl0pP1S4ZnJdIJZPcWMVuJ8LcBYjSZAF50mS5YsKuJmeBQQrOy6AQHnxK
         LMKcyVDD0RoJoCA3XF7LlkpA+xs9UQvt4ttZAbrb/mj8hmG4IdPNDGij/ExY0Shk8R+e
         qQu8rWWnVKt/LDSaDzvQgxCzI1so6UIyZp1FH/6kKyAiUgDDtB0xdJjpHgqjSKiTBcYr
         1z8DFyTWMLM4t+fL4/QvD5rJsI1qSCS4XCiRjGczKHLe/Tzko4Sx1z1UIWp4Dehq26Nd
         yuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=5JU0rlbweRkXKIG5ENBhNK1Ab5N5J6i6Y8hX19ZYXqg=;
        b=cmOMYyAVZKeNW7HSI5hBAdsyxl+6sH04OlVL1WOOynBrdFEXdcLldV7Y5BUIEH6Ds1
         CJhMsTSbzAk2tIw7XgtIBQZs1ZupAkIVQdJxn8+1Txy2M8CyXKhQbPfVVvh4f85/wy80
         EUf00YGyrZHg/BcDggBglft0J2/y3R0TQcGMhIo/BBfXC7eRXZSfcrT4cZi5Qo8+z5l9
         HPOSEljZB2RzmeGMgbfR+zSRNzncKcOOB+znW33reW6MRAlwLQV7qQEKp8dOANLPStr5
         5RomK4abRC8QPr7HSWhcsSRhZLsAShpuyRJfiPaE+ZgUOPHiczVQW9B3cZ7dNKG7KFkE
         ximA==
X-Gm-Message-State: APjAAAWW6x6M5CInfetXEzRbRl4S/Lmb3M39uLM2BOExW02Ggyao5Fg2
        ie+7ZiYOoUiRqKDNYNQJgwm2/A==
X-Google-Smtp-Source: APXvYqxkaiFrJErASbCITsFFUK5xBCAwJ+ddUICzBDadtQskGc1iNy53Sw8XW5vkFpcuPr9ZOx31hw==
X-Received: by 2002:a05:600c:220e:: with SMTP id z14mr358359wml.114.1579198878788;
        Thu, 16 Jan 2020 10:21:18 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f? ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.googlemail.com with ESMTPSA id 16sm5564644wmi.0.2020.01.16.10.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 10:21:18 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Colin King <colin.king@canonical.com>,
        Tony Lindgren <tony@atomide.com>,
        Andrea Parri <parri.andrea@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for 5.6
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
Date:   Thu, 16 Jan 2020 19:21:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e0333ae38eeb42249e10f95d209244a6e22ac9f:

  clocksource/drivers/hyper-v: Set TSC clocksource as default w/
InvariantTSC (2020-01-16 19:09:02 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.5-rc6

for you to fetch changes up to 9e0333ae38eeb42249e10f95d209244a6e22ac9f:

  clocksource/drivers/hyper-v: Set TSC clocksource as default w/
InvariantTSC (2020-01-16 19:09:02 +0100)

----------------------------------------------------------------
- Add suspend/resume for Hyper-V clocksource (Dexuan Cui)

- Fix Kconfig indentation (Krzysztof Kozlowski)

- Add SoC specific bindings for RZ/G2N (r8a774b1) (Biju Das)

- Add Microchip PIT64B support (Claudiu Beznea)

- Convert the cadence ttc driver to a platform driver to initialize
  later (Rajan Vaja)

- Fix a memory leak when the initialization fails on bcm2835 (Colin
  Ian King)

- Use the combo devm_platform_ioremap_resource() function for em-sti,
  ti-dm and switch to platform_get_irq (Yangtao Li)

- Fix Exynos naming in the driver (Krzysztof Kozlowski)

- Fix an uninitialized pointer access in ti-dm timer (Tony Lindgren)

- Fix a sparse warning in microchip-pit64b (Claudiu Beznea)

- Code reorg without functional changes for Hyper-V clocksource
  (Andrea Parri)

- Decrease the Hyper-V clocksource rating in order to let the stable
  TSC to be selected instead (Andrea Parri)

----------------------------------------------------------------

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

