Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC5C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23806206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1fwGhZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgD0JeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbgD0JeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:34:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384EEC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:34:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so19638945wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0buJB0z9KapxfIQw0uykwUPzio93i7DItEUMqAKMBfM=;
        b=W1fwGhZArB3B2+DBQNDEv9V+64OQ8DMPBLuaXDWDexY6GwpJKHGPvP8QLOUqJ+eecd
         LYwlEk4y61byAflGZJCxNnwv3M2D+V1DztpkRmr9NaPLjsNBtmMcpx+gKhE1FWJtbzeq
         E8mV63nPZ1voS1aaGRarY9DDHM4XhYzJxs7aMD/iJsXGEsmw6xpUx70SLa82zLMJwHNO
         BYTX66NO4EIVZXhcCKREjOgrM9CwPEaLbgjUFj+4OQ4VnoWIQzGwpv9LKLfIXTAN+VCf
         TyaAWmq/DugD7/QYX6WHZtMtCJ82zmWZnAEtI+VwJHIKY86oGOxOpLmSdCV7WlgZiNXe
         0fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0buJB0z9KapxfIQw0uykwUPzio93i7DItEUMqAKMBfM=;
        b=Ah1GaGlAd9U6hdTSm3aAn2FltR9pPQOMaNOHGlnQtWUruhD66kNxA6OVvXwy7b29TW
         uwmpKFyi5s+3eZDE2E/kL1WcDR1wF2a5XoyvoQ4wu7p952rJH0aGP6Q2E/EXESG+ilzp
         eIcyUnTIul1H6P8ekSRMxFCd7jizjAyI+7Qx7he+QptpKOW092IpTo1GhtCTUc/+Jlqq
         S048RdZCj8a0URV5PJoLzeOgPXsIm+2oDwjzht+wOhAbEgxqTSiLgA/m/Jbeh8v6/ghd
         dZ9wf0KQLVZIYM3cMCwmn8buAomA2PwMEp+NcFJs2twzaVT7csrmh/mlzAQHBV272md/
         ai1w==
X-Gm-Message-State: AGi0Pua2HhEKkd59A9W3CBMWWeSNRp5Mu8jQvvsDK0imSQeHMIEy9qwF
        5O/EQ+fak9dSFcYOoJcwQS+/0jrMTVI=
X-Google-Smtp-Source: APiQypLLiKGcwY6bfTUQkodr+bdMNcsML1oG2j45dEjWZ1PUrpbvP951LYVzgT5rF/pECH7ry6RLdA==
X-Received: by 2002:a1c:7c10:: with SMTP id x16mr24540443wmc.74.1587980052807;
        Mon, 27 Apr 2020 02:34:12 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id s12sm14131667wmc.7.2020.04.27.02.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 02:34:12 -0700 (PDT)
Subject: Re: [PATCH] clocksource: versatile: Allow CONFIG_CLKSRC_VERSATILE to
 be disabled
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20200417212045.16917-1-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1d9c0b7a-cb40-9f66-e438-5e38293398b6@linaro.org>
Date:   Mon, 27 Apr 2020 11:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417212045.16917-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2020 23:20, Rob Herring wrote:
> The timer-versatile driver provides a sched_clock for certain Arm Ltd.
> reference platforms. Specifically, it is used on Versatile and 32-bit
> VExpress. It is not needed for those platforms with an arch timer (all
> the 64-bit ones) yet CONFIG_MFD_VEXPRESS_SYSREG does still need to be
> enabled. In that case, the timer-versatile can only be disabled when
> COMPILE_TEST is enabled which is not desirable. Let's use the sub-arch
> kconfig symbols instead.
> 
> Realview platforms don't have the sysregs that this driver uses so
> correct the help text.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This is part of a larger effort to modularize Versatile Express support, 
> but this change doesn't have any dependency, so it can be applied 
> independently.

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
