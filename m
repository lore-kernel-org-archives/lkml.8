Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E09C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D9720838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3aq3HJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgCaLkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:40:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53252 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgCaLko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:40:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so2077639wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:cc:references:to:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=96JYl3KSNsUfZrkMXq/N5BBkP1ga/A3AUJ/uxviEhfE=;
        b=i3aq3HJTSK9sLD9ZPc/A5yc2GptAEs8tMGE5Wb8mF9XXCxJ+oL4BOT7B19cmRYebUC
         WvFpLFeeE8Od6Mab7IiaaL3SBiREPyvqmzJdb4RWFcvRZUrj703kA8Jl2GL28WpHxrgy
         0dsLk+ig4uRkRkgTaNgRSLLsTdK0RwZVeaS8ZwpqlM8n0nrixk41SQqLi2lhtA/K9rHh
         xK4MisbGuev3Ikw2HpFhLfnYSMHI1MwAtj0FyGwO3bmAmi5toF2hQTMT8moDnG+yxZUn
         x6XvOxGcA4Qr7HHbOAvCB3nsxKYdyv14GRqur45eLOwaYVFYnPppXoBRVp9uSHWVC3jb
         UfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=96JYl3KSNsUfZrkMXq/N5BBkP1ga/A3AUJ/uxviEhfE=;
        b=O1zbZW1WHean6yp/4/p9MhpbnTUohuXRHblc6u1ZD32RldJ8BVM5Owf4nabQaIeYhS
         FW2qBjlqgqUMUFeFylSUb+pspisCIyLZ1y6WIagw4qD0RtxodDMQurrc+xPUyaHDY6fB
         eLEE16zZ+X4pwEjlDcBJrvO+vGWeTKOKDuCG9rGNqanOggMAANQxSOhPa52My6wtZNWy
         67NfHW1n9gLZ4XCUDYFkafRUag/GqdLLcFb6rmbEAuf/7B76x0+STY28uYYubvDfBWzb
         G9Zn2fnnr6TPIepDQOa6dQQH9EETORusm6oI3rXV/sWyoOkxSHbtDiaFrJLZghgtawmx
         /jjg==
X-Gm-Message-State: ANhLgQ2nG0RGapsdj9xW4YKJRzOeAnuWrq/nG4XCADLV8yL5LY2bED5/
        PK7ZzRUbnGe5iHuLtbnfVl7Avka6gI8=
X-Google-Smtp-Source: ADFU+vvEHtK79nM4A9yQaGSoOioU0WcSelPS5FZfgDh8/ijtZB1RCKTLJYwrJ7KOc57sk5qSC7u/Lg==
X-Received: by 2002:a05:600c:295e:: with SMTP id n30mr2980940wmd.78.1585654840433;
        Tue, 31 Mar 2020 04:40:40 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8997:743a:1d8a:53c9? ([2a01:e34:ed2f:f020:8997:743a:1d8a:53c9])
        by smtp.googlemail.com with ESMTPSA id p10sm26936705wrm.6.2020.03.31.04.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 04:40:39 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-vf-pit: Fix build error
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202003230153.VzOyvdbR%lkp@intel.com>
 <20200323061130.GA6286@afzalpc>
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5616c931-1c44-d6b5-8baa-24c66f334e28@linaro.org>
Date:   Tue, 31 Mar 2020 13:40:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323061130.GA6286@afzalpc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

I was about to send a PR with the revert and this patch. As you picked
up the revert, do you mind to pick also this one?

Thanks

  -- Daniel


On 23/03/2020 07:11, afzal mohammed wrote:
> Recently all usages of setup_irq() was replaced by request_irq().
> The replacement in timer-vf-pit.c missed closing parentheses
> resulting in build error (vf610m4_defconfig). Fix it.
>
> Fixes: cc2550b421aa ("clocksource: Replace setup_irq() by
> request_irq()") Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com> ---
> drivers/clocksource/timer-vf-pit.c | 2 +- 1 file changed, 1
> insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-vf-pit.c
> b/drivers/clocksource/timer-vf-pit.c index
> 7ad4a8b008c2..1a86a4e7e344 100644 ---
> a/drivers/clocksource/timer-vf-pit.c +++
> b/drivers/clocksource/timer-vf-pit.c @@ -129,7 +129,7 @@ static int
> __init pit_clockevent_init(unsigned long rate, int irq)
> __raw_writel(PITTFLG_TIF, clkevt_base + PITTFLG);
>
> BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER |
> IRQF_IRQPOLL, -			   "VF pit timer", &clockevent_pit); +			   "VF
> pit timer", &clockevent_pit));
>
> clockevent_pit.cpumask = cpumask_of(0); clockevent_pit.irq = irq;
>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
