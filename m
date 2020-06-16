Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66100C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6A720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fd+q13dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgFPRTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgFPRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:19:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA700C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:19:30 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e16so16095937qtg.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wWTEVC4IvADhgC8WKAFdPBJMykXtWuEzpH/Aah85Qcs=;
        b=fd+q13dnpRb7sosklNefJkvA0FgEtbX+514cFpXpLhhiNOAvyS/H0qQcCQx7cfQRZa
         4rh9Q/ZoLUFe0x7JUpc361CfeuZK/IAZud2gStzhirNsoDffnc2VZVHaTihzVXmP3wqE
         W4h4PmzaSlA5SXNbb1860nwCQOOwf1EZw5Pz89AXzvU86IydYIKA3GHIBnmWdy+vpU9t
         3+kfMcxSKGu00Aa0iG7gvZtvRzhO/TbhNKd1QkdN/KFxYeqijSeeAI55jwazR6hriiRB
         56xUWZXy6kVPqQ57aqcuOMqHTxnV3wxH1D+rVTeNzAtv4xr0oH4BCIBYKjVdllNkMxPT
         q9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWTEVC4IvADhgC8WKAFdPBJMykXtWuEzpH/Aah85Qcs=;
        b=JNhB92ouZUo8eqF/1oJ6HrO+wAQLa6hLYUba1t9pg6lzP6/N9KHWHEXr7VO/sdzD2y
         6P/0ChWEDLbXrmgjK6Seodv2cSRZG65BzfNIR//fRFByTbKIzS7UcSUGcyR5WY8mdqzS
         J+BHKlO1sssAdUuyxsapiE67oNWQ6LxRSEntE9KD7OpW2Uto/OufHj/bRzHrStlJC7yr
         e2E90KgffAER6n8z+0JBc7WOiWtS6xpGBTUn9u9+D/il7Tqr/5zARKz20+ydWe/OCoup
         Ttpt3IGuZM+4UliW8QqRGyGOdSri4Jnr7Ja2aXEhUF5MQ/P85W40LHDTfj6mBz1BpQEo
         i7aA==
X-Gm-Message-State: AOAM532Q9l3bB47zdn3s0v0VQe05W2pbNTN02c8NtQvOhO/1kCIB/e7B
        F2CFc3PT7q5pAJFpKd/qHRLAHIMY1D8=
X-Google-Smtp-Source: ABdhPJy8Ml+SRDOIpfMU19h6AyD4PHxw4EEAdOlfy7DVyy6x5lPuP4K3JL/v7tdCndKeai3czWUJcg==
X-Received: by 2002:ac8:339b:: with SMTP id c27mr21285530qtb.210.1592327969918;
        Tue, 16 Jun 2020 10:19:29 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q187sm14335126qka.34.2020.06.16.10.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 10:19:29 -0700 (PDT)
Subject: Re: [PATCH v6 2/6] soc: qcom: rpmhpd: Introduce function to retrieve
 power domain performance state count
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200604015317.31389-1-thara.gopinath@linaro.org>
 <20200604015317.31389-3-thara.gopinath@linaro.org>
 <CAPDyKFqxV20Fv2X7wJ5zKa_csDgSBL5KN9HtrA6+EFpgYPhxyg@mail.gmail.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <6ce39992-2b24-ba55-521b-6f27e52b9f6e@linaro.org>
Date:   Tue, 16 Jun 2020 13:19:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqxV20Fv2X7wJ5zKa_csDgSBL5KN9HtrA6+EFpgYPhxyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/20 5:21 AM, Ulf Hansson wrote:
> On Thu, 4 Jun 2020 at 03:53, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Populate .get_performance_state_count in genpd ops to retrieve the count of
>> performance states supported by a rpmh power domain.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks Ulf for all the reviews.
> 
> Kind regards
> Uffe
> 


-- 
Warm Regards
Thara
