Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B65C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB6622522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfMihwdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgATPcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:32:53 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45858 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:32:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so29818241edw.12;
        Mon, 20 Jan 2020 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OOCggNlyS9YgNLOjDZC4k2CQrj3lgyEzbj3H+eP3SQE=;
        b=dfMihwdTWj/I8wOKg2Rs9iY5ghrDiTIiktCY71UOSpkgssYifYXSdlBSd609/u9xjS
         Ds5XiFhFGB5p8GMBSwQ9bZKjmlihWm66nuZmyaaMpi/JL+tME+w0seGaOeRaOg9fGaqW
         94iTMGe9++uLByUGQzUl2nIquM6MJ3tOFOHU9AlgX6/x2YRYSS2ZN+8HJc6IX1rzz/Iu
         FzdPETX1u4WE+J3M79HpiN/eryDdkm9hcvES6+9e4RNHGYM+kUdJv7BSLmmmTHJf9ANN
         VZUv8VfYfOyFBDcmIMWV7byCSHZ/pKFimZbXmL5h2ueObDPJ8/ZoVK+OC77fg6HNkbd0
         E+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOCggNlyS9YgNLOjDZC4k2CQrj3lgyEzbj3H+eP3SQE=;
        b=qQ5b+yjmAR3V6I6tzHB1GXQWoTcGTsYYTjrPZ5Qx0ktr7+NQ56sPUB649MADnsVbTj
         l5uVfR58jX5WfynbYHUoWPp4NK2Tae3bLyAhH0zWhiqdYYFCX+WuprRg50R3bfJ6mASx
         1rNmwKSH+sxx/4ugY7uxp8peXvOpmDHXmsqCDQ+Ot+5ucLvfGOAq4STuhHlaMt1P+qRT
         kLXfxHBPnyPjYLx+QH7S3Q0fu/ibi6RWur/PGpTFRMe3yOoYcOHfnDVVFj3mj6jJKB2G
         8js3aVh/uGT4hYDI6PXhGd9VA4b9M+latJ1Y40N3i9EaR0Vxvm3Vo2WlmsfaYTs8VpuX
         DPdA==
X-Gm-Message-State: APjAAAUss5OQji2wzM5yxyhbF5Xi9cuHCHRI8+nPNf1VX41dYATfIY+0
        bRwVphJKEhtAFqVZQtUEeXWZo52M
X-Google-Smtp-Source: APXvYqxjYvtLuxzmFSvORJMHr9PS1DmMWSmU08ILsHKVYQCqsxBngzG4LUM4tpU9XK2ZYIqVfQd7Bg==
X-Received: by 2002:a17:906:948e:: with SMTP id t14mr20975740ejx.123.1579534370408;
        Mon, 20 Jan 2020 07:32:50 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z10sm1121714ejn.16.2020.01.20.07.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 07:32:49 -0800 (PST)
Subject: Re: [PATCH v8 19/22] ASoC: tegra: Enable audio mclk during
 tegra_asoc_utils_init
To:     Sameer Pujar <spujar@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, josephl@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-20-git-send-email-skomatineni@nvidia.com>
 <3a8e609a-58aa-d2c1-c140-e1f0127dd53b@gmail.com>
 <64027c16-763b-350f-9975-4f9727450ae9@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0b13d21c-1daf-4e9d-f2c2-e78a3b8935f2@gmail.com>
Date:   Mon, 20 Jan 2020 18:32:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <64027c16-763b-350f-9975-4f9727450ae9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.01.2020 07:10, Sameer Pujar пишет:
> 
> On 1/19/2020 8:44 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 14.01.2020 10:24, Sowjanya Komatineni пишет:
>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>> through Tegra210 and currently Tegra clock driver keeps the audio
>>> mclk enabled.
>>>
>>> With the move of PMC clocks from clock driver into pmc driver,
>>> audio mclk enable from clock driver is removed and this should be
>>> taken care by the audio driver.
>>>
>>> tegra_asoc_utils_init calls tegra_asoc_utils_set_rate and audio mclk
>>> rate configuration is not needed during init and set_rate is actually
>>> done during hw_params callback.
>>>
>>> So, this patch removes tegra_asoc_utils_set_rate call and just leaves
>>> the audio mclk enabled.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   sound/soc/tegra/tegra_asoc_utils.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>> index 1dce5ad6e665..99584970f5f4 100644
>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>> @@ -216,9 +216,16 @@ int tegra_asoc_utils_init(struct
>>> tegra_asoc_utils_data *data,
>>>                data->clk_cdev1 = clk_out_1;
>>>        }
>>>
>>> -     ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
>>> -     if (ret)
>>> +     /*
>>> +      * FIXME: There is some unknown dependency between audio mclk
>>> disable
>>> +      * and suspend-resume functionality on Tegra30, although audio
>>> mclk is
>>> +      * only needed for audio.
>>> +      */
>>> +     ret = clk_prepare_enable(data->clk_cdev1);
>>> +     if (ret) {
>>> +             dev_err(data->dev, "Can't enable cdev1: %d\n", ret);
>>>                return ret;
>>> +     }
>>>
>>>        return 0;
>>>   }
>>>
>> Shouldn't the clock be disabled on driver's removal?
> 
> I am not sure if we really need to do in this series as it does not
> change the behavior from what was there earlier. Also there is already a
> FIXME item here and we end up adding clock disable in remove() path of
> multiple drivers, which is going to be removed once we address FIXME.
> 

Well, perhaps this is indeed good enough for the time being.

BTW, I didn't spot any suspend-resume problems using v8.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
