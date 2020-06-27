Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF30C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB3520724
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OZAAoIDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgF0SC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 14:02:26 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52057 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgF0SCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 14:02:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593280944; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: From: References: Cc: To: Subject:
 Sender; bh=rh/RzCkxDxGOtEhur6n0ua62CiLZl8TIulvjxC0+MdQ=; b=OZAAoIDk95ytDi5IUWoOPMoUgTlAQJMQ3xaLM5YnIyV4ZpZdj9dUyiLDv4oo4pzrqRDml8vK
 h+RnaXlpMPr8ph29F/Hl59r7eDlkhHyhAt0ltYIID5ngoRQQelMz1XgeJqJ6frnOS1PxA40y
 SNJMXs9eIWylKyKC7hx/awhckJs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ef789a98fe116ddd9a82031 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 27 Jun 2020 18:02:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 136C0C433CB; Sat, 27 Jun 2020 18:02:16 +0000 (UTC)
Received: from [192.168.0.129] (unknown [183.83.142.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B766C433C8;
        Sat, 27 Jun 2020 18:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B766C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v2 4/7] ASoC: qcom: lpass: Use regmap_field for i2sctl and
 dmactl registers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ajit Pandey <ajitp@codeaurora.org>, broonie@kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: =?UTF-8?Q?=3c=1c1586592171-31644-1-git-send-email-ajitp=40codeau?=
 =?UTF-8?Q?rora=2eorg=1d=3e_=3c1589474298-29437-1-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e_=3c1589474298-29437-5-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e_=3ca3527251-cafd-6d8f-3f96-0549b220af09=40linaro?=
 =?UTF-8?B?Lm9yZz4=?=
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <3c4093c5-d538-8508-ae98-c313ffdea250@codeaurora.org>
Date:   Sat, 27 Jun 2020 23:32:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Srini for reviewing the change.


On 5/18/2020 3:19 PM, Srinivas Kandagatla wrote:
>
>
> On 14/05/2020 17:38, Ajit Pandey wrote:
>> I2SCTL and DMACTL registers has different bits alignment for newer
>> LPASS variants of SC7180 soc. Instead of adding extra overhead for
>> calculating masks and shifts for newer variants registers layout we
>> changed the approach to use regmap_field_write() API to update bit.
>> Such API's will internally do the required bit shift and mask based
>> on reg_field struct defined for bit fields. We'll define REG_FIELD()
>> macros with bit layout for both lpass variants and use such macros
>> to initialize register fields in variant specific driver callbacks.
>> Also added new bitfieds values for I2SCTL and DMACTL registers and
>> removed shifts and mask macros for such registers from header file.
>>
>> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
>> ---
>>   sound/soc/qcom/lpass-apq8016.c   |  61 ++++++++++++
>>   sound/soc/qcom/lpass-cpu.c       | 114 +++++++++++++---------
>>   sound/soc/qcom/lpass-lpaif-reg.h | 203 
>> ++++++++++++++++++++++++---------------
>>   sound/soc/qcom/lpass-platform.c  |  86 +++++++++++------
>>   sound/soc/qcom/lpass.h           |  30 ++++++
>>   5 files changed, 340 insertions(+), 154 deletions(-)
>>
>
> Thanks for moving this to regmap fields, looks clean!
> However this patch just removed support to lpass-ipq806x.c variant, 
> which should to be taken care of while doing patches that apply to all 
> variants.
>
Right. I will make the change as part of next patchset.
>
>> diff --git a/sound/soc/qcom/lpass-apq8016.c 
>> b/sound/soc/qcom/lpass-apq8016.c
>> index 8210e37..3149645 100644
>> --- a/sound/soc/qcom/lpass-apq8016.c
>> +++ b/sound/soc/qcom/lpass-apq8016.c
>> @@ -124,6 +124,32 @@
>>       },
>>   };
>>   +static int apq8016_init_dmactl_bitfields(struct lpaif_dmactl *dmactl,
>> +                     struct regmap *map,
>> +                     unsigned int reg)
>> +{
>> +    struct reg_field bursten = DMACTL_BURSTEN_FLD(reg);
>> +    struct reg_field wpscnt = DMACTL_WPSCNT_FLD(reg);
>> +    struct reg_field fifowm = DMACTL_FIFOWM_FLD(reg);
>> +    struct reg_field intf = DMACTL_AUDINTF_FLD(reg);
>> +    struct reg_field enable = DMACTL_ENABLE_FLD(reg);
>> +    struct reg_field dyncclk = DMACTL_DYNCLK_FLD(reg);
>> +
>> +    dmactl->bursten = regmap_field_alloc(map, bursten);
>> +    dmactl->wpscnt = regmap_field_alloc(map, wpscnt);
>> +    dmactl->fifowm = regmap_field_alloc(map, fifowm);
>> +    dmactl->intf = regmap_field_alloc(map, intf);
>> +    dmactl->enable = regmap_field_alloc(map, enable);
>> +    dmactl->dyncclk = regmap_field_alloc(map, dyncclk);
>
> My idea was to move this all regmap fields to variant structure and 
> common code will do the regmap_filed_alloc rather than each variant 
> duplicating the same code for each variant, also am guessing some of 
> the members in the lpass_variant structure tp become redundant due to 
> regmap field which can be removed as well.
>
> ex :
>
> struct lpass_variant {
>     ...
>     struct reg_field bursten
>     ...
> };
>
> in lpass-apq8016.c
>
> we do
> static struct lpass_variant apq8016_data = {
>
>     .bursten = REG_FIELD(reg, 11, 11),
>     ...
> }
>
We can keep reg_field in lpass_variant, but assignment in the struct 
will be a problem as

reg is variable here. So, we need to expose an API in lpass_variant to 
assign reg_field.

regmap_field will still be in dmactl/i2sctl structs as it differs for 
different dma channel/i2s port

respectively. Please share your thoughts.

> in lpass-cpu.c we can do the real regmap_field_alloc
> asoc_qcom_lpass_cpu_platform_probe
>
Yes, I will move regmap_field_alloc to lpass_cpu.c in next patchset.
>
>
>> +
>> +    if (IS_ERR(dmactl->bursten) || IS_ERR(dmactl->wpscnt) ||
>> +        IS_ERR(dmactl->fifowm) || IS_ERR(dmactl->intf) ||
>> +        IS_ERR(dmactl->enable) || IS_ERR(dmactl->dyncclk))
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>>   static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata,
>>                          int direction)
>>   {
>> @@ -158,6 +184,39 @@ static int apq8016_lpass_free_dma_channel(struct 
>> lpass_data *drvdata, int chan)
>>       return 0;
>>   }
>>   +static int sc7180_init_i2sctl_bitfields(struct lpaif_i2sctl *i2sctl,
>> +                    struct regmap *map, unsigned int reg)
>> +{
> Should this be apq8016_init_i2sctl_bitfields
>
> Please make sure that you compile the code before sending it out!
>
Will take care in next patchset.

>
> --srini
>
>>
Thanks,

Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

