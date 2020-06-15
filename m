Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D736BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A27206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZbL0b71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgFOJq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbgFOJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:46:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD428C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:46:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so13960795wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5vLWjaHiJRQUv9HYjet2Ro+847tC7bWZlp/6gW1hp+k=;
        b=pZbL0b71fcZ3qeaiBqM/qq+IDxdbXYez5t3AVkIiOmdBi++z4mHjQDXEXhwqoYcDnK
         pqCHPF8yJpKHiEavtbv8GSZNfCToqcM9JvTNalNTZWjtUIhAJCWW2BdlN8TCZZ3iYJWw
         4BdZS7MiiM7ILKJeQpqkPTY+U2dUbq8UXL8JRLWC708S28kPAEbeIWjieut4ENeM/X9U
         Ynx7C417tFzQrlljDidRsl6sRtANLuDgYshOvHVhehv78gleILZEdW5PtWNVUtfqOLs5
         TyLZ9iEYnTO9Q0iGCWQC4frTtkeezkbukYMGrDrs2nZOr8JLhIJckPiCuB9cUW7StRfb
         dHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5vLWjaHiJRQUv9HYjet2Ro+847tC7bWZlp/6gW1hp+k=;
        b=m70x6P8VDoQSwWtgl17qMOv8xGL5jel6bOXOZ4m7YFfew9mdj6AevbgS8sQTwTBV2L
         4COkMmqcszZR1BgLsSy6uhH3Cqys4FAciRn0+8BFNivt8zA/f4izo+VbgTMI0g8GPJIq
         i5qDRtDHHB/orRyIbya27++rXt76tcF+23kQE9T6LGFsDsuiKBrChK7mH2ctUu01/Mzg
         2GPRzBrAuw+U/89Ga2TzKvfRYjNrt4F5iu7WN+9zIpkMHBsT4GjOcWF11DJhpy+6MACt
         wkiuhrp+FH2LfTETI6Jr0dW72TDYB0Z5hAV3J7di6YisUI/gtAHFpmoQWwtmH4QVaQbR
         q8ug==
X-Gm-Message-State: AOAM530eNiYOHTEiislb5KQwYk+gVIl6PhU2VtASB7zIu8huhn0o5WTP
        2qHgmUkO01bLv0f3GLumapkgShnQTPE=
X-Google-Smtp-Source: ABdhPJy35U//0vDfeb7NBwQoHw2dAPfMraqx8xyFJshCpSUg/dci31/5vabPF+lADyR2Fg6PWyKM6w==
X-Received: by 2002:a1c:dc06:: with SMTP id t6mr12512135wmg.118.1592214381839;
        Mon, 15 Jun 2020 02:46:21 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id g187sm23677843wma.17.2020.06.15.02.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 02:46:21 -0700 (PDT)
Subject: Re: [PATCH] media: ov2740: add NVMEM interface to read customized OTP
 data
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, bingbu.cao@linux.intel.com
References: <1591954922-14006-1-git-send-email-bingbu.cao@intel.com>
 <20200615092923.GT16711@paasikivi.fi.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f4204020-3b84-c138-6648-1e22e194138e@linaro.org>
Date:   Mon, 15 Jun 2020 10:46:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200615092923.GT16711@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2020 10:29, Sakari Ailus wrote:
>> +	ret = ov2740_register_nvmem(client);
>> +	if (ret)
>> +		dev_err(&client->dev, "register nvmem failed, ret %d\n", ret);
>> +
>>   	/*
>>   	 * Device is already turned on by i2c-core with ACPI domain PM.
>>   	 * Enable runtime PM and turn off the device.
> Could you add #ifdefs for CONFIG_NVMEM so this compiles when it's disabled?

NVMEM already has dummy functions. IMO its better to report an error to 
user as the current code does. This will atleast alert the users of 
existing nvmem provider that has been disabled!

However with ifdef users have to really look into code to be able to 
understand that there is nvmem provider as part of this driver.


Unless you have tight memory restrictions I see no great advantage of 
adding #ifdefs

--srini
> It's bool so a simple #ifdef will do. I think ov2740_register_nvmem() could
> have a dummy implementation so this wouldn't litter the probe function.
> 
> Thanks.
