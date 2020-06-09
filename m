Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB78C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E4B20812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="iUVWtgaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgFILcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgFILcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:32:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29565C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 04:32:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g28so20390529qkl.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OJYZy0qeiiXbqWyW0tBnmc5IWhN4IwKx0EYM7GJeXgs=;
        b=iUVWtgaTkQaF9q/dHk+kpfeq+yoFcpJvLE3QDOmXb9atvJTluYv/B/9eV/rQquHK//
         zy7Xb+klbuxA4m3p3pGdSVd4xJ1LC0nwzJnoOqPeWRXXk8O5tnLkMnrUy6qNVR4d5V2s
         tVNYXRlYxyVnJtfxS67DWeAF4Wt/NTH8qSdZDVIjJXLmldIn0dWthhYzFe0g9zS1u7Vi
         Zor8wXTKbOsT0m2Q7DJORJMPTouGxh/AaEBOpCNsAR23dGaZc3Gw2vGfKQpvfThGJtaI
         AMkxVvJvFGpcnKyg+INyleZ4e3olaVfaxB02/42b2uY1LrV0VytHfCKHIrbxw2oKfCW5
         3/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OJYZy0qeiiXbqWyW0tBnmc5IWhN4IwKx0EYM7GJeXgs=;
        b=aA70nzPJzelbZXa3xSamPdZY/K2Yv440uWRozNAVrdBEsBPfjkAr18ZtvgKy8DHs89
         P5RBWzWOp15FwdUI3Bwf07NMJhQulj+9J0FInyyxc4hLUhk9dhWBhKDf+HYIkB2BX9Fi
         2w41gNxnejkor15OVTKwgKcv3ifdRL/BwHy2zuY6RZXDUSAUizX0qXjPWnvi2qPyKvAO
         hmy5xHnDovS2ZJauOlqp/SEw1pasooKx2vpV9UnZC8wfi3Ut1JWmyVELt8lBu26+fD+E
         DczAQ4NNgYUBdIzwyA06ONC2t9+KIQvHmnGrEDMFNtEyaxexywW9RB+vinbFNF3a1GeZ
         0QVg==
X-Gm-Message-State: AOAM530UfAq4u+foqNt+TVDCgsYka4Dh79KcQ53tGLZeyzmBVXns/Zt4
        eemB/tOSIPZmI7KfbV45mBOe8Q==
X-Google-Smtp-Source: ABdhPJxkNwprmQKp1lyv0TPOCjKAw4CzftOtCXN5jTFdrmB3/xs+13QiJt1Rd4fU8zfp1FLWRsoN2g==
X-Received: by 2002:a37:9f0b:: with SMTP id i11mr26063168qke.481.1591702370277;
        Tue, 09 Jun 2020 04:32:50 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id w68sm9363397qkc.68.2020.06.09.04.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:32:49 -0700 (PDT)
Subject: Re: [PATCH 4/5] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-5-jonathan@marek.ca>
 <f3eabdb9-da43-9502-352a-1696babc114d@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <dc8f59c6-2fa9-f3a3-6d77-2d03a6d2776b@marek.ca>
Date:   Tue, 9 Jun 2020 07:33:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f3eabdb9-da43-9502-352a-1696babc114d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 5:52 AM, Srinivas Kandagatla wrote:
> 
> 
> On 08/06/2020 21:43, Jonathan Marek wrote:
>> The driver may be used without slimbus, so don't depend on slimbus.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/soundwire/Kconfig | 1 -
>>   drivers/soundwire/qcom.c  | 5 +++++
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
>> index fa2b4ab92ed9..d121cf739090 100644
>> --- a/drivers/soundwire/Kconfig
>> +++ b/drivers/soundwire/Kconfig
>> @@ -33,7 +33,6 @@ config SOUNDWIRE_INTEL
>>   config SOUNDWIRE_QCOM
>>       tristate "Qualcomm SoundWire Master driver"
>> -    depends on SLIMBUS
>>       depends on SND_SOC
> 
> Why not move this to imply SLIMBUS this will give more flexibility!
> 
> 

If you mean to change it to "select SLIMBUS", I'd prefer not to, because 
this would increase code size unnecessarily in my kernel.

>>       help
>>         SoundWire Qualcomm Master driver.
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 14334442615f..ac81c64768ea 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -769,13 +769,18 @@ static int qcom_swrm_probe(struct 
>> platform_device *pdev)
>>       if (!ctrl)
>>           return -ENOMEM;
>> +#ifdef CONFIG_SLIMBUS
>>       if (dev->parent->bus == &slimbus_bus) {
>> +#else
>> +    if (false) {
>> +#endif
> 
> May be you can do bit more cleanup here, which could endup like:
> 
> 
> ctrl->regmap = dev_get_regmap(dev->parent, NULL);
> if (!ctrl->regmap) {
>      res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>      if (res) {
>          ctrl->mmio = devm_ioremap_resource(dev, res);
>          if (IS_ERR(ctrl->mmio)) {
>              dev_err(dev, "No valid mem resource found\n");
>              return PTR_ERR(ctrl->mmio);
>          }
> 
>          ctrl->reg_read = qcom_swrm_cpu_reg_read;
>          ctrl->reg_write = qcom_swrm_cpu_reg_write;
>      } else {
>          dev_err(dev, "No valid slim resource found\n");
>          return -EINVAL;
>      }
> } else {
>      ctrl->reg_read = qcom_swrm_ahb_reg_read;
>      ctrl->reg_write = qcom_swrm_ahb_reg_write;
> }
> 
> 
> 
> thanks,
> srini

I don't think this is better, it feels more obfuscated, and I think its 
possible we may end up with the mmio sdw having a parent with a regmap. 
(it is not how I did things up in my upstream stack, but in downstream 
the sdw nodes are inside the "macro" codec nodes)

I understand the '#ifdef CONFIG_SLIMBUS'/'dev->parent->bus == 
&slimbus_bus' is ugly, but at least its clear what's going on. Unless 
you have a better suggestion?

>>           ctrl->reg_read = qcom_swrm_ahb_reg_read;
>>           ctrl->reg_write = qcom_swrm_ahb_reg_write;
>>           ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>>           if (!ctrl->regmap)
>>               return -EINVAL;
>>       } else {
>> +
>>           res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>           ctrl->reg_read = qcom_swrm_cpu_reg_read;
>>
