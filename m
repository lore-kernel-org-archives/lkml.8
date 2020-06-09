Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8449D2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="yy6lP6vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgFILEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgFILEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:04:05 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DD8C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 04:04:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n141so20323606qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FUbD1hcVcPbnPun6PBCVIx0Ht2zCmKmDBbH5Z3sFvOM=;
        b=yy6lP6vs08nS7FeDvrnPdx0yKjfD+ShIyb1E+9Gnyf/sJaiau+d1vdUiMBzo3WAy7r
         RGJlMkR1FFSLtDUeShrARCAzIf/qyXvv6EJ10vdoZZGA2hemnUspib320JpDdmI6++eK
         No486PMTsADE0isEqV1zOkhzh6I+5A8pFf6k5JiYd8vZJXqPK91Qo3aQJEiMwCWZxPtr
         O9uNo4WUGNkMerG8o0FY+bSCATW0qwNfMEXd7bVO/WukG6bB1avoKigpQYTXrZTbL3wX
         lmc3aAPWeQWPbb8PIt7V51LfcKYHof9UEg5gEvkglSBXUpYUMhMmWBERcRrh4GkYq3xN
         Jt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUbD1hcVcPbnPun6PBCVIx0Ht2zCmKmDBbH5Z3sFvOM=;
        b=cRAdG52oenDuNkbPXNCwwGoYjJTBAWD/Iv42bOcfWdECBEBfTd1lURM7E8Vq/yCXHY
         xg7Xh0doMrv6BmyxWz31p3jN1eruf0fZIR6lwhG5KmihbcTRfi5AaOOaqMQRdKPkuV9h
         6c6uvQl346l2EXFKZ5t7YZXYJHliJoI7jD5GlihIO5M5fiE3y6hksilHEWXW+TIW0B9k
         940mKlwGboY3sApcY2ulKZdq7/pF6+4ul2sIFZD9fqKnOJY5gjh5cjqg4GjWLQ2QuaJr
         7rpYvI4wtCTnTx93os/XuvRbe8pbx59E7WkPcSdJJPOy7MKKLeYfCbafyhPoejMUUp8t
         gxdA==
X-Gm-Message-State: AOAM531YnzJSz3ngC9o0kJ9KEo+oZaH3ZdSiZIhbt6zWHDSiY6tudfTT
        z0dGpg5e8ykBf8vRBODFDT4fdILRwe4=
X-Google-Smtp-Source: ABdhPJzVP/VSTlS3oR2RXDNjAgvgFJkJGGymfO50aefBhyTaFFEWDxk4bJsnOh1sX1aJUK4mXE15JQ==
X-Received: by 2002:a37:9f0b:: with SMTP id i11mr25948765qke.481.1591700642784;
        Tue, 09 Jun 2020 04:04:02 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id u25sm10050138qtc.11.2020.06.09.04.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:04:02 -0700 (PDT)
Subject: Re: [PATCH 2/5] soundwire: qcom: add support for mmio soundwire
 devices
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-3-jonathan@marek.ca>
 <1b29db61-2394-8f88-9ebb-219568fb9306@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <009dd6c1-276f-4ac5-b68b-1fe2de50ad8c@marek.ca>
Date:   Tue, 9 Jun 2020 07:04:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1b29db61-2394-8f88-9ebb-219568fb9306@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 5:19 AM, Srinivas Kandagatla wrote:
> 
> 
> On 08/06/2020 21:43, Jonathan Marek wrote:
>> Adds support for qcom soundwire devices with memory mapped IO registers.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
> 
> In general patch itself looks pretty trivial, but I would like to see 
> what 1.5.1 controller provides in terms of error reporting of SoundWire 
> slave register reads/writes. On WCD based controller we did not have a 
> mechanism to report things like if the read is ignored or not. I was 
> hoping that this version of controller would be able to report that.
> 
> I will be nice to those patches if that is something which is supported 
> in this version.
> 
> --srini
> 

It does seem to support additional error reporting (it gets an error 
during enumeration after finding the 2 WSA slaves). However the 
downstream driver seems to disable this by setting BIT(31) in 
FIFO_CFG_ADDR (the comment says "For SWR master version 1.5.1, continue 
execute on command ignore"). Outside of the initial enumeration, it 
doesn't seem to produce any extra errors (still relying on the timeout 
mechanism to know if read/write is ignored).

>>   drivers/soundwire/qcom.c | 25 +++++++++++++++++++++++--
>>   1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index f38d1fd3679f..628747df1c75 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -90,6 +90,7 @@ struct qcom_swrm_ctrl {
>>       struct sdw_bus bus;
>>       struct device *dev;
>>       struct regmap *regmap;
>> +    void __iomem *mmio;
>>       struct completion *comp;
>>       struct work_struct slave_work;
>>       /* read/write lock */
>> @@ -154,6 +155,20 @@ static int qcom_swrm_ahb_reg_write(struct 
>> qcom_swrm_ctrl *ctrl,
>>       return SDW_CMD_OK;
>>   }
>> +static int qcom_swrm_cpu_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
>> +                  u32 *val)
>> +{
>> +    *val = readl(ctrl->mmio + reg);
>> +    return SDW_CMD_OK;
>> +}
>> +
>> +static int qcom_swrm_cpu_reg_write(struct qcom_swrm_ctrl *ctrl, int reg,
>> +                   int val)
>> +{
>> +    writel(val, ctrl->mmio + reg);
>> +    return SDW_CMD_OK;
>> +}
>> +
>>   static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 
>> cmd_data,
>>                        u8 dev_addr, u16 reg_addr)
>>   {
>> @@ -746,6 +761,7 @@ static int qcom_swrm_probe(struct platform_device 
>> *pdev)
>>       struct sdw_master_prop *prop;
>>       struct sdw_bus_params *params;
>>       struct qcom_swrm_ctrl *ctrl;
>> +    struct resource *res;
>>       int ret;
>>       u32 val;
>> @@ -760,8 +776,13 @@ static int qcom_swrm_probe(struct platform_device 
>> *pdev)
>>           if (!ctrl->regmap)
>>               return -EINVAL;
>>       } else {
>> -        /* Only WCD based SoundWire controller is supported */
>> -        return -ENOTSUPP;
>> +        res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +        ctrl->reg_read = qcom_swrm_cpu_reg_read;
>> +        ctrl->reg_write = qcom_swrm_cpu_reg_write;
>> +        ctrl->mmio = devm_ioremap_resource(dev, res);
>> +        if (IS_ERR(ctrl->mmio))
>> +            return PTR_ERR(ctrl->mmio);
>>       }
>>       ctrl->irq = of_irq_get(dev->of_node, 0);
>>
