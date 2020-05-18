Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0E620657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chu9Reaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgERJtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgERJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:49:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6005C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:49:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so10994257wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ENajwhYLgh6sOiUIP9e6Xj0EhfOD2GHJT5X8M/vf8Bk=;
        b=chu9ReajW6HqxpiFU5X/Xq7ycdbAJTYXqrXhd/98jAkFWbBicg3eCnxNwkS81jVo1d
         9qXWhcMySsBbOn0orMwWV6SbBNZclVKmJ5S22Avx1W8yBWJO9mB3RQYfp/P7zaKT44ht
         PhyEImaP0Bc0xSGqE3OpaU0M1c34EndgWocJ7zSYMIQmKoTLIKET/bH1Td/X8hT/g9Jn
         aoZfyWIDZgBc7ZIVrctUbu/HP4PjDd9l/aYVkmv6enQioY8Ms7J6TbY8n/cH8XnKGoEf
         XO/VKcTbXghBNlFDxM+yYD4Y/i/sHc3sfjjx3kqTG973fFRXDcveox2xsDCoWD70wYfV
         agUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=ENajwhYLgh6sOiUIP9e6Xj0EhfOD2GHJT5X8M/vf8Bk=;
        b=g2QWexoRFIBl1iFqhyinm8M8NK1JdwG7odj/m2m042Xc9jQwnvG7+1KHU2eLQjYv00
         2deh+3MEoxNdRUwN3DZW7CqbxyyFL1lQGFDzfq2tM1kV9D1S/g8zsHhggve2LvgbFG6v
         cNSmZUONdOxTq6mJHk7IoN0SdJ9xTMY7VHvzclGmeryDRtNAuTGqv3xD9q3v9v6McPqU
         nIcf30/pKYeIbQ7DPyEP8DDA7aF40ozRU+Qc5M2r8RrG/LnSH5Dwex34ajZJAPHaqxjD
         kOBYlUHT2tCmPxv9wV6lGgZKAKJ/8+LLUNNQ2ynwuZQgPl0o/snE0ugpoDiwSZlioTAY
         ZIpw==
X-Gm-Message-State: AOAM5331kudD/AQOzaV8j6ib7B3NfBl1+PCI5aseDjZs7ozyN/M3MgaT
        nhj1hscbQ0XAQoQep2beS/ftU0AYYnY=
X-Google-Smtp-Source: ABdhPJx2XKbq7KkL41aumny2mb2gN4FSdUPlh42S2nUjjgI6dDC3vnddICzIiSo0P7gUCnJZQXDTsA==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr20122647wrv.166.1589795377819;
        Mon, 18 May 2020 02:49:37 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f128sm16679392wme.1.2020.05.18.02.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:49:37 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] ASoC: qcom: lpass: Use regmap_field for i2sctl and
 dmactl registers
To:     Ajit Pandey <ajitp@codeaurora.org>, broonie@kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: =?UTF-8?Q?=3c=1c1586592171-31644-1-git-send-email-ajitp=40codeau?=
 =?UTF-8?Q?rora=2eorg=1d=3e_=3c1589474298-29437-1-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e_=3c1589474298-29437-5-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e?=
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a3527251-cafd-6d8f-3f96-0549b220af09@linaro.org>
Date:   Mon, 18 May 2020 10:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/2020 17:38, Ajit Pandey wrote:
> I2SCTL and DMACTL registers has different bits alignment for newer
> LPASS variants of SC7180 soc. Instead of adding extra overhead for
> calculating masks and shifts for newer variants registers layout we
> changed the approach to use regmap_field_write() API to update bit.
> Such API's will internally do the required bit shift and mask based
> on reg_field struct defined for bit fields. We'll define REG_FIELD()
> macros with bit layout for both lpass variants and use such macros
> to initialize register fields in variant specific driver callbacks.
> Also added new bitfieds values for I2SCTL and DMACTL registers and
> removed shifts and mask macros for such registers from header file.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> ---
>   sound/soc/qcom/lpass-apq8016.c   |  61 ++++++++++++
>   sound/soc/qcom/lpass-cpu.c       | 114 +++++++++++++---------
>   sound/soc/qcom/lpass-lpaif-reg.h | 203 ++++++++++++++++++++++++---------------
>   sound/soc/qcom/lpass-platform.c  |  86 +++++++++++------
>   sound/soc/qcom/lpass.h           |  30 ++++++
>   5 files changed, 340 insertions(+), 154 deletions(-)
> 

Thanks for moving this to regmap fields, looks clean!
However this patch just removed support to lpass-ipq806x.c variant, 
which should to be taken care of while doing patches that apply to all 
variants.


> diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
> index 8210e37..3149645 100644
> --- a/sound/soc/qcom/lpass-apq8016.c
> +++ b/sound/soc/qcom/lpass-apq8016.c
> @@ -124,6 +124,32 @@
>   	},
>   };
>   
> +static int apq8016_init_dmactl_bitfields(struct lpaif_dmactl *dmactl,
> +					 struct regmap *map,
> +					 unsigned int reg)
> +{
> +	struct reg_field bursten = DMACTL_BURSTEN_FLD(reg);
> +	struct reg_field wpscnt = DMACTL_WPSCNT_FLD(reg);
> +	struct reg_field fifowm = DMACTL_FIFOWM_FLD(reg);
> +	struct reg_field intf = DMACTL_AUDINTF_FLD(reg);
> +	struct reg_field enable = DMACTL_ENABLE_FLD(reg);
> +	struct reg_field dyncclk = DMACTL_DYNCLK_FLD(reg);
> +
> +	dmactl->bursten = regmap_field_alloc(map, bursten);
> +	dmactl->wpscnt = regmap_field_alloc(map, wpscnt);
> +	dmactl->fifowm = regmap_field_alloc(map, fifowm);
> +	dmactl->intf = regmap_field_alloc(map, intf);
> +	dmactl->enable = regmap_field_alloc(map, enable);
> +	dmactl->dyncclk = regmap_field_alloc(map, dyncclk);

My idea was to move this all regmap fields to variant structure and 
common code will do the regmap_filed_alloc rather than each variant 
duplicating the same code for each variant, also am guessing some of the 
members in the lpass_variant structure tp become redundant due to regmap 
field which can be removed as well.

ex :

struct lpass_variant {
	...
	struct reg_field bursten
	...
};

in lpass-apq8016.c

we do
static struct lpass_variant apq8016_data = {

	.bursten = REG_FIELD(reg, 11, 11),
	...
}

in lpass-cpu.c we can do the real regmap_field_alloc	
asoc_qcom_lpass_cpu_platform_probe



> +
> +	if (IS_ERR(dmactl->bursten) || IS_ERR(dmactl->wpscnt) ||
> +	    IS_ERR(dmactl->fifowm) || IS_ERR(dmactl->intf) ||
> +	    IS_ERR(dmactl->enable) || IS_ERR(dmactl->dyncclk))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata,
>   					   int direction)
>   {
> @@ -158,6 +184,39 @@ static int apq8016_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
>   	return 0;
>   }
>   
> +static int sc7180_init_i2sctl_bitfields(struct lpaif_i2sctl *i2sctl,
> +					struct regmap *map, unsigned int reg)
> +{
Should this be apq8016_init_i2sctl_bitfields

Please make sure that you compile the code before sending it out!

--srini

> 
