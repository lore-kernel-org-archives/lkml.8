Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA5BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C6D20791
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="aIFbPxKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGaXdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:33:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26426 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726807AbgGaXdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:33:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596238399; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=vF/ZfSy0GW8C+ioPXlIi2t6ZaQN9VfKaJ+Oof9fc1KQ=; b=aIFbPxKziWtkbFxytgYbUaEWPOGFc2jgXVwp3DPh2qN/dh8cI8mVsRk/eou+/SpG9tCq3w59
 bmWTJIn+8mTqdoTsQPA9HGtQL6EKNXzk4h27iIP5PdPfNH5DumWf9mSEENkAn5dQfZWb5pzW
 gnZPfS3jneH8Pkt9QoEtgPOLD5M=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5f24a9d990893260dd39d2f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 23:31:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7DBDAC43395; Fri, 31 Jul 2020 23:31:36 +0000 (UTC)
Received: from [10.110.121.73] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C569EC433C9;
        Fri, 31 Jul 2020 23:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C569EC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v6 1/4] usb: typec: Add QCOM PMIC typec detection driver
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        jackp@codeaurora.org
References: <20200729071340.7673-1-wcheng@codeaurora.org>
 <20200729071340.7673-2-wcheng@codeaurora.org>
 <159601160976.1360974.10172804658083744292@swboyd.mtv.corp.google.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <e11fc325-7f82-b13f-3e8a-f444ddc50257@codeaurora.org>
Date:   Fri, 31 Jul 2020 16:31:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159601160976.1360974.10172804658083744292@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2020 1:33 AM, Stephen Boyd wrote:
> Quoting Wesley Cheng (2020-07-29 00:13:37)
>> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
>> index 559dd06117e7..3e375f82849d 100644
>> --- a/drivers/usb/typec/Kconfig
>> +++ b/drivers/usb/typec/Kconfig
>> @@ -73,6 +73,18 @@ config TYPEC_TPS6598X
>>           If you choose to build this driver as a dynamically linked module, the
>>           module will be called tps6598x.ko.
>>  
>> +config TYPEC_QCOM_PMIC
>> +       tristate "Qualcomm PMIC USB Type-C driver"
>> +       depends on ARCH_QCOM
> 
> Can you add || COMPILE_TEST here?
> 

Sure, will do.

>> +#include <linux/err.h>
>> +#include <linux/regmap.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/of_irq.h>
> 
> Is this include used?
> 
>> +#include <linux/platform_device.h>
>> +#include <linux/of_device.h>
> 
> Is this include used?
> 

Reviewed which includes I used, and removed the ones that were not needed.

>> +static void qcom_pmic_typec_enable_vbus_regulator(struct qcom_pmic_typec
>> +                                                       *qcom_usb, bool enable)
>> +{
>> +       int ret = 0;
> 
> Please don't assign and then reassign before testing this variable.
> 

I will just remove the assignment here.

>> +       if (stat & CC_ATTACHED) {
>> +               orientation = ((stat & CC_ORIENTATION) >> 1) ?
> 
> Do we really need to shift >> by 1? Seems useless for a test.
> 

Agreed, we can remove the shift.

>> +       ret = of_property_read_u32(dev->of_node, "reg", &reg);
>> +       if (ret < 0) {
>> +               dev_err(dev, "missing base address");
> 
> Please add newlines at the end of printk messages.
> 

Done.

>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0) {
>> +               dev_err(dev, "Failed to get CC irq\n");
> 
> platform_get_irq() already prints an error message. Please remove this.
> 

Got it.

>> +static const struct of_device_id qcom_pmic_typec_table[] = {
>> +       { .compatible = "qcom,pm8150b-usb-typec" },
>> +       { },
> 
> Nitpick: Drop the comma here so nothing can come after without causing a
> compile error.
> 

Sure.

>> +static struct platform_driver qcom_pmic_typec = {
>> +       .driver = {
>> +               .name = "qcom,pmic-typec",
>> +               .of_match_table = qcom_pmic_typec_table,
>> +       },
>> +       .probe = qcom_pmic_typec_probe,
>> +       .remove = qcom_pmic_typec_remove,
>> +};
>> +
> 
> Another nitpick: Drop the newline and make module_platform_driver()
> follow directly after the driver.
> 

Ok, will do.

Thanks for the review/feedback, Stephen.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
