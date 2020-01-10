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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C42EC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356952072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubkzjegv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgAJXDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:03:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40887 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAJXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:03:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id i23so2681588lfo.7;
        Fri, 10 Jan 2020 15:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LIfOt2/H9o4TTylsMEhxFyK9SgreyZMevB6yzbjwKbI=;
        b=ubkzjegvG3dqELIcb4AmPudiOofr2lyNnfFetYJTit+CMRY5udjJEH9gCUVYn5TwUY
         P9hQtzYmaI32BlAFvZaOT3bwB3C1OoAOw3sHoe99bTVqjkZaefxbjZGrWAJDtGWSqi3e
         4PXZvty9sfIsF+vQUkR2/yy9oa27sg+fIPWfiVflnqmlCs8l7XTHWFY0++PQyG1iNXAW
         JhOG8FaPfyCM9JXXRkSLTS0bfo797Z2prIfrTRnYh7QE6K48fvF3pSrCguc0mTJWGw3j
         Jk75tIXrUTVkvQ4QhH72Ac/G0lGOI//WAyTRPLMVUqBjA3H2eQbseKhEu6NsSlL5r7VM
         Exyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LIfOt2/H9o4TTylsMEhxFyK9SgreyZMevB6yzbjwKbI=;
        b=bTowMViNmTIxkJm9KUTf6I91lgq8rz3xi/qkYSk4P4na1yBqjfrxEfUnl2UX2YS//Y
         qKNiMFV2lLfEm4qVStOHCSlNNwHD5JxestHd/70L+50o19rPg66dVZnIl2CHgwop9Z0K
         q/NHO7ogZgIlMRoNUgDCtbd9fr5AyqRliUXgxZhf4FbZjuZMV1kPLRw9zs2k26n1MVrm
         n4RPfk6yQLxH3OLBEVLjyvGnoj4oaavd6FzwtO/enUPcc5JINEBrxpXBkTCgTAeq9s3W
         A1N+9F2vhGpFYpOcOuDM7ISOQHIFJyR3GR7yjwnwf5p8X2iUx61fTBRZaECdU/9H3dn8
         d7SA==
X-Gm-Message-State: APjAAAVn2+6jY/8zVJeAUDb9HYFDEs/7TZyVZoBCfyu8yGL/ulSIa54x
        xm30zJtSt26algTp39ahVVFwsyLe
X-Google-Smtp-Source: APXvYqwt12uR3kPf6mwgmKJNqx+Sr3i+nO5lvG+ZnOGBJVMTp5uTXSl23AnwSoLoxhGxT6gApz9g3Q==
X-Received: by 2002:ac2:5605:: with SMTP id v5mr3760197lfd.136.1578697376884;
        Fri, 10 Jan 2020 15:02:56 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id t13sm1602788ljk.78.2020.01.10.15.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 15:02:55 -0800 (PST)
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
 <135f0c0b-86d1-9b1a-af02-c14c4b5308c4@gmail.com>
 <575aa30e-1b5a-2a2d-5893-3f6832f416f1@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9bca6c3e-bfe0-7130-b233-3f25c436f76e@gmail.com>
Date:   Sat, 11 Jan 2020 02:02:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <575aa30e-1b5a-2a2d-5893-3f6832f416f1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.01.2020 01:13, Sowjanya Komatineni пишет:
> 
> On 1/10/20 2:05 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 10.01.2020 20:04, Sowjanya Komatineni пишет:
>>> On 1/9/20 10:52 AM, Sowjanya Komatineni wrote:
>>>>
>>>> On 1/7/20 10:28 PM, Sameer Pujar wrote:
>>>>> On 1/8/2020 11:18 AM, Sowjanya Komatineni wrote:
>>>>>> On 1/7/20 9:34 PM, Sameer Pujar wrote:
>>>>>>> On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
>>>>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc
>>>>>>>> clocks
>>>>>>>> are moved to Tegra PMC driver with pmc as clock provider and using
>>>>>>>> pmc
>>>>>>>> clock ids.
>>>>>>>>
>>>>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>>>>
>>>>>>>> So, this patch adds implementation for mclk fallback to extern1
>>>>>>>> when
>>>>>>>> retrieving mclk returns -ENOENT to be backward compatible of new
>>>>>>>> device
>>>>>>>> tree with older kernels.
>>>>>>>>
>>>>>>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>> ---
>>>>>>>>    sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> index 9cfebef74870..9a5f81039491 100644
>>>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct
>>>>>>>> tegra_asoc_utils_data *data,
>>>>>>>>        data->clk_cdev1 = devm_clk_get(dev, "mclk");
>>>>>>>>        if (IS_ERR(data->clk_cdev1)) {
>>>>>>>>            dev_err(data->dev, "Can't retrieve clk cdev1\n");
>>>>>>> This error print can be moved inside below if, when this actually
>>>>>>> meant to be an error condition.
>>>>>>>
>>>>>> Want to show error even if mclk retrieval returns ENOENT to clearly
>>>>>> indicate mclk does not exist along with message of falling back to
>>>>>> extern1.
>>>>> Yes, but falling back essentially means 'mclk' is not available and
>>>>> fallback print is not an error.
>>>>> Not a major issue though, you can consider updating. Otherwise LGTM.
>>>>>
>>>> Will update
>>>>>>>> -        return PTR_ERR(data->clk_cdev1);
>>>>>>>> +        if (PTR_ERR(data->clk_cdev1) != -ENOENT)
>>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>>> +        /* Fall back to extern1 */
>>>>>>>> +        data->clk_cdev1 = devm_clk_get(dev, "extern1");
>>>>>>>> +        if (IS_ERR(data->clk_cdev1)) {
>>>>>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        dev_err(data->dev, "Falling back to extern1\n");
>>>>>>> This can be a info print?
>>>> Will use dev_info
>>>>>>>>        }
>>>>>>>>          /*
>>>> Dmitry/Rob, there was discussion in v3 regarding backporting mclk
>>>> fallback.
>>>>
>>>> Dmitry wanted Rob to confirm on this
>>>>
>>>> I think openSUSE Leap could be one of those distros that use LTS kernel
>>>> with newer device-trees, but that's not 100%. Maybe Rob could help
>>>> clarifying that.
>>>>
>>>> Dmitry/Rob, Can you please confirm if mclk fallback patch need
>>>> backport to have new device tree work with old kernels?
>>>>
>>> Dmitry,
>>>
>>> Can you please confirm if we need to backport this mclk fallback patch?
>>>
>> Seems only T210 was making use of the CaR's TEGRA*_CLK_CLK_OUT_*, thus
>> the backporting isn't needed.
> Thanks Dmitry
>>
>> Also, please use 'git rebase --exec make ...' to make sure that all
>> patches are compiling without problems. The removal of the legacy clock
>> IDs should be done after the device-trees changes, otherwise it looks
>> like DTBs compilation will fail. It's possible that the order of the
>> patches could be changed if Thierry will chose to split this series into
>> several pull requests, nevertheless all patches should compile and work
>> in the original order.
> OK, Will move patches of device tree updates to use new DT ID prior to
> removal of old ID.

Oh, wait. But then the newer device-trees won't work with the stable
kernels, so it actually won't hurt to backport this change.

Secondly, please move the "Use device managed resource APIs to get the
clock" after the ASoC patches with the stable tags, such that the stable
patches could be applied cleanly.

Lastly, please separate the assigned-clocks change from the the audio
mclk enable/disable into a standalone patch. These changes are not
interdependent, unless I'm missing something.
