Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626F9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3249B206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbBj1mWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCXQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:58:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55399 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCXQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:58:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id v25so2179732wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fcKTtzzKji9c9XNYOWFuZoh2VuIHjU5tnEWXTkyl2mI=;
        b=fbBj1mWzQ0EXEjikZVBjhISRBfYqUM34AmyqYSrJnYcb0j7XAeE9Of1XR/oWDft8MA
         PASTbUS+qkIAXFuvgP6we35AzquIA6e5vKCTMh17VQOUzUdWXfhRK/vk0YU7Hxw1FAjJ
         ixfaAafUZhPe0+kE2MTLDyoQdTkQdad13rB/Gq4Q2HnO/COXI3b9iu+erxI4KwybRz4Y
         jMC4fHcO89XzVWSaGeeqAChy8GeTtX5T0w0vnBGnt2nhPWSgFXfDgIl/ewZsVW6OGTol
         whhe0V3CTd0O9MeoXfRI9K7bB3aVwotehM8gBJ+ep9qhHwFsVABuUpJ3dvynN6w1rwdl
         RBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fcKTtzzKji9c9XNYOWFuZoh2VuIHjU5tnEWXTkyl2mI=;
        b=eywR61r/WsXlyobU1tia5dCBUMhJDJq+RSsS2n+FE5nEhdBIBpA5OeO8YVylO6kXcL
         G9DKthFsNdAGgtCPg1EmPR4h/AvAbDnn7akJKoiP7PGl9Xq/1GZrjLjdzT2galylhVnJ
         FwUio4eLxB7pgMt5nWgX57l+7gNVgul+iEJwDk1aotpZHoz/9A7Zvx7TsL6rcRm2A0b+
         id98a+fGFHhGjz+M7geM5oOHYr3fETqjzbgwmtCVpSi5OtnFoVVxRecIQ5bwUld0bGzI
         qAcVJt7PqggCzy3BQCvxz8Dq79Bj74YefVhSt+ldt+TWHUvxy3J0V7+lA3GP+gQdBV1K
         /HLA==
X-Gm-Message-State: ANhLgQ1ULKbrVwsy9MZIk2+5u8D+HoTq6yWFp3VT9f6pEoQdDvv7USAG
        Nr8Blyo4ODrtaM/3PhrVD5eHH5QJgQI=
X-Google-Smtp-Source: ADFU+vs2R2xRRs7U3Sw5mhut6OVBEplfNXf8X5OKc3Gwd+LDMsa3yMxvc887bM/9ecy2Ets46/EjKA==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr6535688wmd.123.1585069125252;
        Tue, 24 Mar 2020 09:58:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s8sm25146243wrv.97.2020.03.24.09.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:58:44 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
 <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
 <20200324122939.GA2348009@kroah.com>
 <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
 <PSXP216MB04387C07F1E4C827245DE98380F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <45ae656e-aeac-ecbd-b882-496ea2a2e655@linaro.org>
Date:   Tue, 24 Mar 2020 16:58:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB04387C07F1E4C827245DE98380F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2020 14:24, Nicholas Johnson wrote:
>> Am guessing you are referring to is_bin_visible callback?
>>
>> I will try to clean this up!
> I am still onboard and willing do the work, but we may need to discuss
> to be on the same page with new plans. How do you wish to do this?
I have done some cleanup of old code to use is_bin_visible.

https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=topic/is_bin_visible

Can you try these two patches along with your new patch?

--srini
