Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C8BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B6720758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxAWC9wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgERUSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgERUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:18:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C2C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:18:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so13329393wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BuJAIlJzNVfUnKFpYlKJrQaksovEb6r2MOQ70C3Y5sE=;
        b=SxAWC9wD97Nx9RF3x3Gt/iZfKa8M2cx51v1EjKYupLeGpf+OXQcl28YEfu07NNYBzp
         oG+fZxxrewBemj4QfFHPCIkMV+hJAXiaAzGtFMWoKqaKX9APTvHFWnpqBpvZStJP6MY5
         ZJL49q+YvgR1TsQW6DuEjc0vHci857/8g7zyBbXevlDpKtC16cdZUMFYwaSBtu/Azadr
         hcWfZEHCdEnqumpagVLp+S3vV4xtpbduKy+4NNZEuG21ZOK5ZrWQACre05Eqq834JNCW
         Tr0rVO6giGivX1D6FKN3hG2Y2HP0AELLOVuUdTe7C7HDFMMswLp//vZnCo7l4qyKIsq0
         HEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BuJAIlJzNVfUnKFpYlKJrQaksovEb6r2MOQ70C3Y5sE=;
        b=c96CBqGOFMMmLkq/Dr8s1clxPDvNhqpPD8F4JChGiCniriXUOn1p+8jNRh5acILnTS
         ABpWhVt0zTDtFBw2TDTNC8tmFLasrTalDeqhDcx+g0lLfkO5PlWpD7F9a1lApjpJoIhv
         EIkhhhJgatpO2O00KzjTh+n3tQW8bfxcWSkGBYfJ/Vp0ip7xgaNWmfao08zDiysTphDR
         hnFbR1tZ+l0hj/pQK79Chg+mm7Qz7yLCJw/2ElPrJElnjn3gBo6BlilUhbNxLuuBH8aJ
         Ud3lqosWEBXHwBXhWF3Kd7tR0gsh820/WzpX08x/3Ggi8JBLH16weI6rhoiJBJA1UAKz
         4a+g==
X-Gm-Message-State: AOAM5301UuXibGMXhJFkClO801rch4RNQoXK0Yd7TfNiY0jHCrml0taT
        YKjnRno4z4cIBCrrLxjwxPvpkxohqAs=
X-Google-Smtp-Source: ABdhPJwPiPMglSYT2/xaOY59iHe2nTbksNb6WmRUz9mJuUv5IbPqRFkca7BsAXDI/I3ojYQVTFNCww==
X-Received: by 2002:adf:806e:: with SMTP id 101mr21994991wrk.225.1589833107923;
        Mon, 18 May 2020 13:18:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id z11sm17107463wrr.32.2020.05.18.13.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 13:18:27 -0700 (PDT)
Subject: Re: [PATCH v7 5/6] clocksource: Add Low Power STM32 timers driver
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        fabrice.gasnier@st.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, tglx@linutronix.de
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Pascal Paillet <p.paillet@st.com>
References: <20200420121620.2099-1-benjamin.gaignard@st.com>
 <20200420121620.2099-6-benjamin.gaignard@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9f737934-d92c-9ddf-f6fb-3ee64057ea18@linaro.org>
Date:   Mon, 18 May 2020 22:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420121620.2099-6-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2020 14:16, Benjamin Gaignard wrote:
> From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> 
> Implement clock event driver using low power STM32 timers.
> Low power timer counters running even when CPUs are stopped.
> It could be used as clock event broadcaster to wake up CPUs but not like
> a clocksource because each it rise an interrupt the counter restart from 0.
> 
> Low power timers have a 16 bits counter and a prescaler which allow to
> divide the clock per power of 2 to up 128 to target a 32KHz rate.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
