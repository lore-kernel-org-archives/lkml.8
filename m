Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A78C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B40F217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX+aDlpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389097AbgBNVQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:16:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40230 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgBNVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:16:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so12545305wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=O6rVs3FSQr6qLFWf2o+70D+00D8MT1uwoIbDaVTOClg=;
        b=IX+aDlpJcdOktmlKGBlvumCd8zrWc7m3oDDAoZoxvGxpnWVxCJ7tWMQija+kyN7ZkT
         9evGHtz3YV33U23OBrthaFc+0qh5Bw6sahvbsVCWcS4C8T5o42v0lY/2oLNeg3MVPRYV
         bmkSIY+DG5vfuXwHCVvc31BAoid5FXLHgsAYT8yWD5SBkUCCo22Q7cWaUCJj8Z8ft2Dx
         1sQh8YW/+cc3o5LyOMkqbn/NC2Be4JoS2/aSOe86OIsPSgBPtRf9uVMspEw24DHkKko0
         P7CdsSJJw4KSWXJwFHU5FO6oKsX0zC8wynTGQZWRHiVMdbe98BxlWIgeEDA5WJpp3vzD
         VbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O6rVs3FSQr6qLFWf2o+70D+00D8MT1uwoIbDaVTOClg=;
        b=lNeeqwvm8/m/q7m9jJ1Yj3P7VZAniga6zbIEdIpidPiFaloM4hbQmgRvDfL50Jc4aa
         IG3hUw7AmG+eHNsFxxqWlESLu5XB4iwWHNF9YLKBIXIKaNVfxwhe+6hwdWMRkwPboJ5b
         O4yz8keIoSv3RFphr4WasflwCCsOImaOPv1pur37Iy3Vuo0ctibC3Z/iTDRu6sAh7YOI
         8Odb7nX4PjC0MR7HgwWh+EI0JPeIY00fb9w2oN3P5McUKfdWxI7xT0yaTXo4vENxmBa9
         lmgF7d1MeyvTVczlkQQIEgP34iVLAJFRwXtE8niL6oaEGk9L8wQJjW7OBjzgmZ61r0sg
         RAJw==
X-Gm-Message-State: APjAAAUKC//kyT6A0l8gqThoN4DDRt0MqzuuuzqURfo5l0yqNUlMbDg7
        /EWGHiaLD/L8CgB8F8IAZSY5HH08
X-Google-Smtp-Source: APXvYqxaItlJc029efHXJiWcBTb9vbqA9vmAQXjlJuIchQ6NpEdHQDRTz5LWaNqPbAjJr7lPmkm1Vw==
X-Received: by 2002:a5d:5152:: with SMTP id u18mr5797039wrt.214.1581715009522;
        Fri, 14 Feb 2020 13:16:49 -0800 (PST)
Received: from [192.168.0.104] (p5B3F6B6B.dip0.t-ipconnect.de. [91.63.107.107])
        by smtp.gmail.com with ESMTPSA id a5sm8742910wmb.37.2020.02.14.13.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 13:16:48 -0800 (PST)
Subject: Re: [PATCH RFT] regulator: mp5416: Fix output discharge enable bit
 for LDOs
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20200212150223.20042-1-axel.lin@ingics.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <33fe095a-4aab-fe8a-bb5e-77050ffa0551@gmail.com>
Date:   Fri, 14 Feb 2020 22:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212150223.20042-1-axel.lin@ingics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/02/20 4:02 pm, Axel Lin wrote:
> The .active_discharge_on/.active_discharge_mask settings does not match
> the datasheet, fix it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Saravanan,
> I don't have the h/w to test, please help review and test this patch.

Thanks for pointing out, I have tested this patch and works as expected.

>
> Thanks,
> Axel
>
>   drivers/regulator/mp5416.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
> index 7954ad17249b..67ce1b52a1a1 100644
> --- a/drivers/regulator/mp5416.c
> +++ b/drivers/regulator/mp5416.c
> @@ -73,7 +73,7 @@
>   		.owner			= THIS_MODULE,			\
>   	}
>   
> -#define MP5416LDO(_name, _id)						\
> +#define MP5416LDO(_name, _id, _dval)					\
>   	[MP5416_LDO ## _id] = {						\
>   		.id = MP5416_LDO ## _id,				\
>   		.name = _name,						\
> @@ -87,9 +87,9 @@
>   		.vsel_mask = MP5416_MASK_VSET,				\
>   		.enable_reg = MP5416_REG_LDO ##_id,			\
>   		.enable_mask = MP5416_REGULATOR_EN,			\
> -		.active_discharge_on	= BIT(_id),			\
> +		.active_discharge_on	= _dval,			\
>   		.active_discharge_reg	= MP5416_REG_CTL2,		\
> -		.active_discharge_mask	= BIT(_id),			\
> +		.active_discharge_mask	= _dval,			\
>   		.owner			= THIS_MODULE,			\
>   	}
>   
> @@ -155,10 +155,10 @@ static struct regulator_desc mp5416_regulators_desc[MP5416_MAX_REGULATORS] = {
>   	MP5416BUCK("buck2", 2, mp5416_I_limits2, MP5416_REG_CTL1, BIT(1), 2),
>   	MP5416BUCK("buck3", 3, mp5416_I_limits1, MP5416_REG_CTL1, BIT(2), 1),
>   	MP5416BUCK("buck4", 4, mp5416_I_limits2, MP5416_REG_CTL2, BIT(5), 2),
> -	MP5416LDO("ldo1", 1),
> -	MP5416LDO("ldo2", 2),
> -	MP5416LDO("ldo3", 3),
> -	MP5416LDO("ldo4", 4),
> +	MP5416LDO("ldo1", 1, BIT(4)),
> +	MP5416LDO("ldo2", 2, BIT(3)),
> +	MP5416LDO("ldo3", 3, BIT(2)),
> +	MP5416LDO("ldo4", 4, BIT(1)),
>   };
>   
>   /*
