Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D488C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DD82072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 22:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz1/Pb4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgAJWHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:07:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44727 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgAJWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 17:05:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id u71so3637096lje.11;
        Fri, 10 Jan 2020 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8pDdBlhWNVam1EjlfmhvY4SQpYPYOi2Ig/s8K41IUaw=;
        b=Qz1/Pb4pC7P03RqKsGpIAItdR8xSpvEw582sN51S+81oV/Cg0oj3Wbre36Ai2mjRpu
         rV9CgEg+Oy4cvqaQfakp1zaqFz1he+s2WuQgWrTQo/xLQks+ABogBFcBsT6/5cRPsivB
         UWDR+rIfTXKqSm22Ycz4I5nVpPb2SBPC7Vr6E+6dRiJuI8Pr2kCPure9YrWJXHToykki
         v6S1/BG4U34CMKYXuzWqU0epDaK9G5Voe7CQhay/gaO/7FnfvZODb6VsDThPn2s8nDW1
         Y57yG9U2VAnkOmbbbPpwV00YHkn4cVxzCwA6WWwJoRhose2uVMgBVZ5+cpsLQEYO7zJe
         iyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8pDdBlhWNVam1EjlfmhvY4SQpYPYOi2Ig/s8K41IUaw=;
        b=UwDWQE2N/t3bB14+bgzGUHCHa7qmSCIfWfCsds5QgxlYs9/senIO2+3ohzCxIhjmgs
         oyN4sOMW6R5BGj9S/YV3x4iXme5c8yGIiKilfR+0Hptwik96ARrKW2D3TeWOR1CdJ93j
         HpHtZ5nc6zT4tq+Efz0p9PdRrjf8nPVaROAS+G1TBifVQ5piTZQfK7HEwwyipd9yfi1g
         Re6Tfd4iCUqLzf8SrcE6Ymv+xCf2vLL2rMopQeYtKswWahUI72KcXtiLbNIWTwPsJYGW
         BczvG9hSHma8f+5mMTqs234Tn/QejiANfv+D2Ni5A2QHCeiVbbOGAkxG3KIVjgwvL53l
         899A==
X-Gm-Message-State: APjAAAUrt1+OWmIO0VjsOFYk787KbkOr5dxdK7vXJkw6ujlZak2GQreZ
        RhDxsZpwqAtmOOGnY32LJLzogpxW
X-Google-Smtp-Source: APXvYqzPGa94FAtfR4u0tGbPaN4w7oHlnvLScAjWCQIR8bGDXUCVaLsQZU5pIJLQGcAwLpX58QtR0g==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr3826511ljg.166.1578693953408;
        Fri, 10 Jan 2020 14:05:53 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r2sm1654055lfn.13.2020.01.10.14.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 14:05:52 -0800 (PST)
Subject: Re: [PATCH v7 15/21] ASoC: tegra: Add fallback implementation for
 audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, josephl@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-16-git-send-email-skomatineni@nvidia.com>
 <f3f550a2-c6e0-7a78-5c83-da3e54dab309@nvidia.com>
 <d7ac6135-73b0-1087-dafa-4df558a06ef4@nvidia.com>
 <a3c5293b-9ed4-3266-f792-38b980e54b1e@nvidia.com>
 <745b8c7b-4fe3-c9ea-284e-b89546e8ad87@nvidia.com>
 <705edf9b-d1bc-8090-017e-fa4ad445f9fb@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <135f0c0b-86d1-9b1a-af02-c14c4b5308c4@gmail.com>
Date:   Sat, 11 Jan 2020 01:05:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <705edf9b-d1bc-8090-017e-fa4ad445f9fb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.01.2020 20:04, Sowjanya Komatineni пишет:
> 
> On 1/9/20 10:52 AM, Sowjanya Komatineni wrote:
>>
>>
>> On 1/7/20 10:28 PM, Sameer Pujar wrote:
>>>
>>> On 1/8/2020 11:18 AM, Sowjanya Komatineni wrote:
>>>>
>>>> On 1/7/20 9:34 PM, Sameer Pujar wrote:
>>>>>
>>>>> On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
>>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc
>>>>>> clocks
>>>>>> are moved to Tegra PMC driver with pmc as clock provider and using
>>>>>> pmc
>>>>>> clock ids.
>>>>>>
>>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>>
>>>>>> So, this patch adds implementation for mclk fallback to extern1 when
>>>>>> retrieving mclk returns -ENOENT to be backward compatible of new
>>>>>> device
>>>>>> tree with older kernels.
>>>>>>
>>>>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>> ---
>>>>>>   sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> index 9cfebef74870..9a5f81039491 100644
>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct
>>>>>> tegra_asoc_utils_data *data,
>>>>>>       data->clk_cdev1 = devm_clk_get(dev, "mclk");
>>>>>>       if (IS_ERR(data->clk_cdev1)) {
>>>>>>           dev_err(data->dev, "Can't retrieve clk cdev1\n");
>>>>>
>>>>> This error print can be moved inside below if, when this actually
>>>>> meant to be an error condition.
>>>>>
>>>> Want to show error even if mclk retrieval returns ENOENT to clearly
>>>> indicate mclk does not exist along with message of falling back to
>>>> extern1.
>>>
>>> Yes, but falling back essentially means 'mclk' is not available and
>>> fallback print is not an error.
>>> Not a major issue though, you can consider updating. Otherwise LGTM.
>>>
>> Will update
>>>>>> -        return PTR_ERR(data->clk_cdev1);
>>>>>> +        if (PTR_ERR(data->clk_cdev1) != -ENOENT)
>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>> +        /* Fall back to extern1 */
>>>>>> +        data->clk_cdev1 = devm_clk_get(dev, "extern1");
>>>>>> +        if (IS_ERR(data->clk_cdev1)) {
>>>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>> +        }
>>>>>> +
>>>>>> +        dev_err(data->dev, "Falling back to extern1\n");
>>>>>
>>>>> This can be a info print?
>>>>
>> Will use dev_info
>>>>>>       }
>>>>>>         /*
>>
>> Dmitry/Rob, there was discussion in v3 regarding backporting mclk
>> fallback.
>>
>> Dmitry wanted Rob to confirm on this
>>
>> I think openSUSE Leap could be one of those distros that use LTS kernel
>> with newer device-trees, but that's not 100%. Maybe Rob could help
>> clarifying that.
>>
>> Dmitry/Rob, Can you please confirm if mclk fallback patch need
>> backport to have new device tree work with old kernels?
>>
> Dmitry,
> 
> Can you please confirm if we need to backport this mclk fallback patch?
> 

Seems only T210 was making use of the CaR's TEGRA*_CLK_CLK_OUT_*, thus
the backporting isn't needed.

Also, please use 'git rebase --exec make ...' to make sure that all
patches are compiling without problems. The removal of the legacy clock
IDs should be done after the device-trees changes, otherwise it looks
like DTBs compilation will fail. It's possible that the order of the
patches could be changed if Thierry will chose to split this series into
several pull requests, nevertheless all patches should compile and work
in the original order.
