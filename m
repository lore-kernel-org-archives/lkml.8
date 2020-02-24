Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED3EC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C314E20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IP/4NB2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgBXLTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:19:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40153 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBXLTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:19:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so9902211wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vVRUXC9u/A5DLNgpNy0TmY7xGnxbSS2LdHcV0vtIQ9w=;
        b=IP/4NB2V96p5cK7ZEAZIyjpWd2aQhUH+RqG3KUykEhIMjYWfhRfRI0vOL+3/XqBt27
         AnGJOv5WBR8/eE0hHClDsaUsAWijH6AByJ4puFJeDRzsbDjLLSmqIww0uUUQnTAu9KjT
         9NdhpwiSmxPlquwzxPG2Ma/oIRoCKye6SnN2lf1z2T1KIjjeBsLxJIBPxWU8IS+pcj7c
         +GqutI7vfgQRodizAvK6FxX2J/KKdOf8FXqvrA4fauqYpyoIqNZsDLq8NS4Eikh8o1Xe
         4r09RDhLeH3KW8/JbMvfAx2hlPchFokl1GOoY93YZ/BSlNRVeKruXS0imYgT1FIs+A+N
         AoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vVRUXC9u/A5DLNgpNy0TmY7xGnxbSS2LdHcV0vtIQ9w=;
        b=KwuGg48VmAws+jE/yHVp6hhPbgXeZwLzBFBH+UORmw+pJedGghu+oxdHcAvT1NDrTc
         MkZ5B1aqW3gJ08waIfmjI68NHYqzank86H5c8hnWOnI4hqC4EetC9DQo+dgnCPteQTyb
         8l1c5jaV366sAQ/PZfR2OtwoYxqVlHdWQmL63pxbp5ZUgSDqvMNl5kc9hLlUY0RdaPQy
         Tvwb/SwvZYGparibLkqrswIl0Tc3mMCv9cEKNQJRs6d994rDqosoIgb7HfuiQhZolATN
         wi/xdtqmuKY1Wcn0P2U/X7xSv6zPQ/RQTsXYBS8XpLSPerSnu/2JRz38wgaQNYuw6Ut5
         phqA==
X-Gm-Message-State: APjAAAVqkEuE5e0LbRALjyB25fu2aMCvvxxqL3CqixSZUybNlw7RhJo5
        PBm8QV2K2tBYaWxOxp1FfzUVLA==
X-Google-Smtp-Source: APXvYqxscWh2g3lQVU75MYddDZiS9qAP6S4WWNDYSa5oAgaL2XIPlhyKiWkgVVRAKc+rWHMrz7ZhfA==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr9779258wrv.274.1582543145120;
        Mon, 24 Feb 2020 03:19:05 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r3sm18580182wrn.34.2020.02.24.03.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 03:19:04 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20200221222711.15973-1-robh@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <383f3a95-6ae9-ee42-d173-88ce18c35016@linaro.org>
Date:   Mon, 24 Feb 2020 11:19:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/2020 22:27, Rob Herring wrote:
>   Documentation/devicetree/bindings/nvmem/nvmem.yaml |  2 ++
for nvmem changes,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

