Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEEAC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30DA20842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEqUPqIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgAKPcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:32:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37185 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbgAKPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:32:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so5253133ljg.4;
        Sat, 11 Jan 2020 07:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jzwxp3lWZeyeoVo+7adSEFYxLkJCA6sCkYkRhViRSF4=;
        b=WEqUPqINVv8iSLFS7PGBWB0tCktQhyTKsxEAX2Hut6ihWFSzNO9B7XQFwzJc/b6bCy
         6d9qK6otsCJyMu74C7I6i5PQDwUFog69bZVU5zYz9lYfZEoLKG2Yn/hlz7JJYrHVWAIg
         wpWT83V1yBDp2uYSSoMpEpjsDLEKo7s9Z1p7+j4CeD3F6zsTNcGIag3yxNuui2SUnY/P
         ICK5Gb832cKL1x3VePNWO1zMnQDVr+AE0wshMPUX2JBJFFDiuGaYg1cfZYg8mlPwZV81
         0joAxyaW0t6s++vzIiadLscFoYbOdw8LlxN+OaYafgo7reKk4wwie/SMysivS7/PxPoL
         pk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jzwxp3lWZeyeoVo+7adSEFYxLkJCA6sCkYkRhViRSF4=;
        b=qsrShAcAbFND1zuutDYGkaP+NLPNt/Vy0G4PxLp+Dg/OtsYSlpDyLrsddPKuj8BhO7
         ewHLI1a0prvhfJ6S3BrsD9kL1Crdstg2UUGRMJdt2DcMRTGqTzesfXbeEHh17hwU5bDR
         rq+2UPN9utNeB05R2xzLJGdh0D009aY47cp0W0t8gNLyVK/0GzD0NdWRmOpwl1DKK+0t
         hvfYbqc9wKp8KndG3TfiWXTRHYFHkrz/3K6+YuvED9ZLVHupmJ96X/8Pe9enSxk+TYQ2
         cffxM7OXfUk1Rw1uGKkFRhADGTBzdMtX5gCp4W6SVSvkU4UdELJ6FFoyyXuOAutngm5T
         dPZQ==
X-Gm-Message-State: APjAAAUqXKTvbxh8A7m2aw9k3PWozs3gs4RXOkzFNgw1g7ffURcKnZMO
        QIFcvQuQM1Aprc704yfx6OR+nVnr
X-Google-Smtp-Source: APXvYqz7GKZn3IvrC1VjsoXBOdrMCrzr8YTMIOnxEhesELZ/ZaMW6I+1WG0TxSzkPry/rXlXazFEkA==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr6129684ljk.186.1578756727755;
        Sat, 11 Jan 2020 07:32:07 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d4sm2845137lfn.42.2020.01.11.07.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 07:32:07 -0800 (PST)
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
 <9bca6c3e-bfe0-7130-b233-3f25c436f76e@gmail.com>
 <dcfd35f3-7fdd-fdc9-1c77-bcb63bcabd5b@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1319c4d2-7929-43e1-c036-45396f28c2fa@gmail.com>
Date:   Sat, 11 Jan 2020 18:32:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <dcfd35f3-7fdd-fdc9-1c77-bcb63bcabd5b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.01.2020 02:14, Sowjanya Komatineni пишет:
> 
> On 1/10/20 3:02 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 11.01.2020 01:13, Sowjanya Komatineni пишет:
>>> On 1/10/20 2:05 PM, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 10.01.2020 20:04, Sowjanya Komatineni пишет:
>>>>> On 1/9/20 10:52 AM, Sowjanya Komatineni wrote:
>>>>>> On 1/7/20 10:28 PM, Sameer Pujar wrote:
>>>>>>> On 1/8/2020 11:18 AM, Sowjanya Komatineni wrote:
>>>>>>>> On 1/7/20 9:34 PM, Sameer Pujar wrote:
>>>>>>>>> On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
>>>>>>>>>> mclk is from clk_out_1 which is part of Tegra PMC block and pmc
>>>>>>>>>> clocks
>>>>>>>>>> are moved to Tegra PMC driver with pmc as clock provider and
>>>>>>>>>> using
>>>>>>>>>> pmc
>>>>>>>>>> clock ids.
>>>>>>>>>>
>>>>>>>>>> New device tree uses clk_out_1 from pmc clock provider.
>>>>>>>>>>
>>>>>>>>>> So, this patch adds implementation for mclk fallback to extern1
>>>>>>>>>> when
>>>>>>>>>> retrieving mclk returns -ENOENT to be backward compatible of new
>>>>>>>>>> device
>>>>>>>>>> tree with older kernels.
>>>>>>>>>>
>>>>>>>>>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>>>>> ---
>>>>>>>>>>     sound/soc/tegra/tegra_asoc_utils.c | 11 ++++++++++-
>>>>>>>>>>     1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>>> index 9cfebef74870..9a5f81039491 100644
>>>>>>>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>>>>>>>> @@ -183,7 +183,16 @@ int tegra_asoc_utils_init(struct
>>>>>>>>>> tegra_asoc_utils_data *data,
>>>>>>>>>>         data->clk_cdev1 = devm_clk_get(dev, "mclk");
>>>>>>>>>>         if (IS_ERR(data->clk_cdev1)) {
>>>>>>>>>>             dev_err(data->dev, "Can't retrieve clk cdev1\n");
>>>>>>>>> This error print can be moved inside below if, when this actually
>>>>>>>>> meant to be an error condition.
>>>>>>>>>
>>>>>>>> Want to show error even if mclk retrieval returns ENOENT to clearly
>>>>>>>> indicate mclk does not exist along with message of falling back to
>>>>>>>> extern1.
>>>>>>> Yes, but falling back essentially means 'mclk' is not available and
>>>>>>> fallback print is not an error.
>>>>>>> Not a major issue though, you can consider updating. Otherwise LGTM.
>>>>>>>
>>>>>> Will update
>>>>>>>>>> -        return PTR_ERR(data->clk_cdev1);
>>>>>>>>>> +        if (PTR_ERR(data->clk_cdev1) != -ENOENT)
>>>>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>>>>> +        /* Fall back to extern1 */
>>>>>>>>>> +        data->clk_cdev1 = devm_clk_get(dev, "extern1");
>>>>>>>>>> +        if (IS_ERR(data->clk_cdev1)) {
>>>>>>>>>> +            dev_err(data->dev, "Can't retrieve clk extern1\n");
>>>>>>>>>> +            return PTR_ERR(data->clk_cdev1);
>>>>>>>>>> +        }
>>>>>>>>>> +
>>>>>>>>>> +        dev_err(data->dev, "Falling back to extern1\n");
>>>>>>>>> This can be a info print?
>>>>>> Will use dev_info
>>>>>>>>>>         }
>>>>>>>>>>           /*
>>>>>> Dmitry/Rob, there was discussion in v3 regarding backporting mclk
>>>>>> fallback.
>>>>>>
>>>>>> Dmitry wanted Rob to confirm on this
>>>>>>
>>>>>> I think openSUSE Leap could be one of those distros that use LTS
>>>>>> kernel
>>>>>> with newer device-trees, but that's not 100%. Maybe Rob could help
>>>>>> clarifying that.
>>>>>>
>>>>>> Dmitry/Rob, Can you please confirm if mclk fallback patch need
>>>>>> backport to have new device tree work with old kernels?
>>>>>>
>>>>> Dmitry,
>>>>>
>>>>> Can you please confirm if we need to backport this mclk fallback
>>>>> patch?
>>>>>
>>>> Seems only T210 was making use of the CaR's TEGRA*_CLK_CLK_OUT_*, thus
>>>> the backporting isn't needed.
>>> Thanks Dmitry
>>>> Also, please use 'git rebase --exec make ...' to make sure that all
>>>> patches are compiling without problems. The removal of the legacy clock
>>>> IDs should be done after the device-trees changes, otherwise it looks
>>>> like DTBs compilation will fail. It's possible that the order of the
>>>> patches could be changed if Thierry will chose to split this series
>>>> into
>>>> several pull requests, nevertheless all patches should compile and work
>>>> in the original order.
>>> OK, Will move patches of device tree updates to use new DT ID prior to
>>> removal of old ID.
>> Oh, wait. But then the newer device-trees won't work with the stable
>> kernels, so it actually won't hurt to backport this change.
> ok will add Fixes tag to have this mclk fallback patch backported.
>>
>> Secondly, please move the "Use device managed resource APIs to get the
>> clock" after the ASoC patches with the stable tags, such that the stable
>> patches could be applied cleanly.
> OK
>>
>> Lastly, please separate the assigned-clocks change from the the audio
>> mclk enable/disable into a standalone patch. These changes are not
>> interdependent, unless I'm missing something.
> 
> But parent configuration when assigned-clock-parents are not in DT are
> needed along with mclk enable
> 
> as we are removing audio clocks parent configuration and enabling them
> together from clock driver.
> 
> So doesn't both parent configuration and enabling mclk together need to
> be in same patch to match what we are removing from clock driver?
> 

All current stable kernels happen to work without any visible problems
because of the non-critical clk-enable refcounting bug that masks the
problem. Thus the mclk will be enabled in stable kernels without any
extra changes and the assigned-clock-parents shouldn't affect that.

Please make sure that every patch in this series:

1) Compiles without any errors and warnings.

2) Works, i.e. you should be able to checkout any commit and kernel
should boot/work without any regressions.

3) Stable patches could be cherry-picked into stable kernels without
merge conflicts.

To achieve that you'll need to sort patches in the correct order and do
some basic testing.
