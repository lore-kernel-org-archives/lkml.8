Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF171C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7EC20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oyjcz7J8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgGUPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:45:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FF8C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:45:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so24587669ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/ndzqOyPQqpEB3yJC19z8dj8c5+fFPGDOTd0jEhmBpw=;
        b=oyjcz7J8tCcoUK2pmKvdElrTGri27wMTEkEyO06pn+bQ3XkVXFfl9cjKhwwgvQWH3q
         AZyp/fhkvAtCriocyMxenMlElRvOdo9GqKaX/aM8EhLTHvofo2OhtP26QmAoG3Fs6ayx
         X6tImKXaOYoOMqzcJqR8MnvPIzPRCtqqgRuLcTXgfR8O2SYwZNabXYteut+lerbchz9c
         TQzW01Hr5PCE8HtLQL2JGQjVl8b4LMiJ8QYxNxulcoVKPtHFDwCDpkOcZZpC8HnuNk8/
         RIdjp1GGa+7V0/ZcfStUiTeVKX+i+crZYRDREc2Rl9AuCaiTOJnk3nAs4JqNq/Tfqv1D
         kgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ndzqOyPQqpEB3yJC19z8dj8c5+fFPGDOTd0jEhmBpw=;
        b=Tz8pFGcRoal9Ydkr359UbaROc06rPI2emv9qQbEgTmhIUM+FzIp9tHMR7vlZOqvTJp
         OrxOU7GVVG8a4Z1J3+EZu+Xs6FC7uIX8UFE+3JZuJDnp1XKEo5OB9PGG3lxsMrWkdKwV
         tlc1t6UqMN0RmEH5ZMpd7mRq+8S1FiBrkWFUT6L0/0O2jwiRuegPAtCfwiqc3/rhmrw+
         /9Euifde2XAhdpdl7jCI9SXGzQAJ++ivPnZhIsX6dm3N/qvLserZxgTtx9oMqTw0LqEn
         NIkV+99iQyEBSmJBCModwX2coaQjyFLG+8VaT5DsC/5rY4OqEFDYnlBzPQm1+n5LCbG7
         kfmQ==
X-Gm-Message-State: AOAM532vjiCP17FLgdofEbYZ2pFGVEzUFl+WJeDoIZ/CtoIYBKk13e2z
        k18cMMCdxfELWS5l9d40piL/7Q==
X-Google-Smtp-Source: ABdhPJw8o7n4jwqLpbx2pwQXXpRN4itJmlmVLovLVQGL0ZLT2w+D8MktaWe4OZye5Y7XUxt3EQNgLA==
X-Received: by 2002:a05:651c:2046:: with SMTP id t6mr12073045ljo.217.1595346303883;
        Tue, 21 Jul 2020 08:45:03 -0700 (PDT)
Received: from [192.168.1.211] ([94.25.229.9])
        by smtp.gmail.com with ESMTPSA id 204sm3272346lfm.86.2020.07.21.08.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:45:03 -0700 (PDT)
Subject: Re: [PATCH v3 00/14] Enable GPU for SM8150 and SM8250
To:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Deepak Katragadda <dkatraga@codeaurora.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, Vinod Koul <vkoul@kernel.org>
References: <20200709135251.643-1-jonathan@marek.ca>
 <159531808502.3847286.3510600528777978505@swboyd.mtv.corp.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <f5c470ef-54d9-8d1c-8088-8f22d0cc98e1@linaro.org>
Date:   Tue, 21 Jul 2020 18:45:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159531808502.3847286.3510600528777978505@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2020 10:54, Stephen Boyd wrote:
> Quoting Jonathan Marek (2020-07-09 06:52:31)
>> This series adds the missing clock drivers and dts nodes to enable
>> the GPU on both SM8150 and SM8250.
>>
>> Note an extra drm/msm patch [1] is required for SM8250.
>>
>> As noted by Dmitry, GMU init fails with newer firmware, needs this patch [2].
>>
>> [1] https://patchwork.freedesktop.org/series/78968/
>> [2] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sm8250&id=01331f2ccbe7e6c4719dbe038a5fb496db32646d
> 
> Vinod, can you test this patch series? And Taniya, can you review it?

On SM8250:

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
