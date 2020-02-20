Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8316C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9860C208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWjkmVvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBTLF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:05:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45808 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTLF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:05:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so4070944wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BU42bw+Dgu0RlgBgffTsz8dDeoClFdyzDhVIEgI7g18=;
        b=vWjkmVvsmZ9VPtxL25APBPL4B5hmacS/NXLVVpCBiksO4825PCUcpNycB082OAz84d
         8gFxM6kZiWW4LCa8WI9Cjytha4AD9ueTiot2PckuMba9KMfvHWecQdtzQWhm/312hw29
         nW1sRbl9QbEh1U9pULemvqx7DLQcKXezi9/lt+wErDw6vxbObKAvvineQfKy9IKIgA7K
         g2qWgak3neymBc4fc4fHDcR5Z2yRHWWhIjlVkbQ0jNm/qtoa3HJ3simXBH+m3PTJWoaL
         wqGa2zZlVzsFm5TKBqpjgUN+DdJQ5eQOq+eXYfJPEYM+TLSowGiBPJcLWYMxG9vaIvdb
         X0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BU42bw+Dgu0RlgBgffTsz8dDeoClFdyzDhVIEgI7g18=;
        b=peI5kKwH5QFx36KAoIWf8qw66jvFBa9g+5x2AH4WzFnnSYD2YYWvhCyTNRrqN2LEBw
         Kyvw1+4kqht0rMwWKtKEM5IuvhBLXUskf1/TzbSAihD8l2Oo7WSpRvlFoCxVureNA+RM
         Wk32XH2RuPoKQyWgVFmojX4fzoM4UJOgC952fAk8nofOndHcp/mKCPpz9JdGOGhcE1wY
         LtNvPrard92+U7FLh1kQXXhs3/lSW/yhPAJel1GAoDBgivExyPMEorpMig75UTSvIRRU
         2oYqskq0FwAfd2wJVcpfUY04ENT+xvhz1akCA0jWk8jkl9B3kRV0/7/7mSpVdtPKzNym
         fp9g==
X-Gm-Message-State: APjAAAU2VwG/lmHBw1Hjk1074LbYnrx8pkx0nOCBH/PBrvTzVUwuZAVf
        2hVhTY1tTC2LufLqx0D5X65Etw==
X-Google-Smtp-Source: APXvYqxUGdl/VXdVNrTcJJDFjgVeTZWAmNAqHqSCXFTeHuZoE5SUTS7rZoX21pdE+g6Gvy5/EWb+7Q==
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr43094191wrs.423.1582196726030;
        Thu, 20 Feb 2020 03:05:26 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1d8d:74ba:7173:f47f? ([2a01:e34:ed2f:f020:1d8d:74ba:7173:f47f])
        by smtp.googlemail.com with ESMTPSA id w13sm3934952wru.38.2020.02.20.03.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 03:05:25 -0800 (PST)
Subject: Re: [PATCH v4 3/3] clocksource: Add Low Power STM32 timers driver
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Pascal PAILLET-LME <p.paillet@st.com>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-4-benjamin.gaignard@st.com>
 <687ab83c-6381-57aa-3bc1-3628e27644b5@linaro.org>
 <9cc4af9e-27d0-96c3-b3f1-20c88f89b70a@st.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ee131515-cd4c-00b2-5e1f-3abefb634bdd@linaro.org>
Date:   Thu, 20 Feb 2020 12:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9cc4af9e-27d0-96c3-b3f1-20c88f89b70a@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2020 11:45, Benjamin GAIGNARD wrote:

[ ... ]

>>> +{
>>> +	struct stm32_lp_private *priv = to_priv(clkevt);
>>> +
>>> +	/* disable LPTIMER to be able to write into IER register*/
>>> +	regmap_write(priv->reg, STM32_LPTIM_CR, 0);
>>> +	/* enable ARR interrupt */
>>> +	regmap_write(priv->reg, STM32_LPTIM_IER, STM32_LPTIM_ARRMIE);
>>> +	/* enable LPTIMER to be able to write into ARR register */
>>> +	regmap_write(priv->reg, STM32_LPTIM_CR, STM32_LPTIM_ENABLE);
>>> +	/* set next event counter */
>>> +	regmap_write(priv->reg, STM32_LPTIM_ARR, evt);
>>> +
>>> +	/* start counter */
>>> +	if (is_periodic)
>>> +		regmap_write(priv->reg, STM32_LPTIM_CR,
>>> +			     STM32_LPTIM_CNTSTRT | STM32_LPTIM_ENABLE);
>>> +	else
>>> +		regmap_write(priv->reg, STM32_LPTIM_CR,
>>> +			     STM32_LPTIM_SNGSTRT | STM32_LPTIM_ENABLE);
>> The regmap config in stm32-lptimer is not defined with the fast_io flag
>> (on purpose or not?) that means we can potentially deadlock here as the
>> lock is a mutex.
>>
>> Isn't it detected with the lock validation scheme?
> It wasn't a problem with other parts of the mfd and I don't notice 
> issues so I guess it is ok.

Given your comment below, the case can't happen I agree but there is
still a heavy operation with the locking.

>>> +	return 0;
>>> +}
>>> +static int stm32_clkevent_lp_remove(struct platform_device *pdev)
>>> +{
>>> +	return -EBUSY; /* cannot unregister clockevent */
>>> +}
>> Won't be the mfd into an inconsistent state here? The other subsystems
>> will be removed but this one will prevent to unload the module leading
>> to a situation where the mfd is partially removed but still there
>> without a possible recovery, no?
> We can't enable the timer part of the mfd at the same time than the 
> other features.

Hmm, interesting case. The DT binding does not give this information,
especially in the example. You should fix the DT by giving two examples IMO.

Rob, how do you describe this situation (exclusive properties)?

> It has be exclusive and that exclude the problem you describe above.

Ok, the regmap_write is not a free operation and in this case you can
get rid of all the regmap-ish in this driver.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

