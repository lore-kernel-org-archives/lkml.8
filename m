Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1491C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C80520781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vJnZCQjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHMHRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:17:30 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:23627 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgHMHR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:17:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597303049; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=7+SupX1KdeOjMckzG2kriiII+B/Pn9nxUz4H7+p3Lew=; b=vJnZCQjlQ3z7r2VLw/lQd+E1JIhfpF8ZPEmsEu4TG9gC674JV9b06BYSlgnp68K1zdm9bI25
 ekkDlUZF2okyc0TFbUAlY5dhEL79UaORm0wq1rHRVIX1y+9cgNbjQZWp6JU+OJVw/wAMacit
 2yfPkKl1qt3wo8jaBmWlC8oiZ8E=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f34e907440a07969a35cb8e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 07:17:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBD26C43391; Thu, 13 Aug 2020 07:17:26 +0000 (UTC)
Received: from [192.168.29.129] (unknown [49.36.77.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FFB5C433C6;
        Thu, 13 Aug 2020 07:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FFB5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v4 2/7] pinctrl: qcom: Use return value from irq_set_wake
 call
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org>
 <1597058460-16211-3-git-send-email-mkshah@codeaurora.org>
 <159717444178.1360974.6520145243224264090@swboyd.mtv.corp.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <aa506a3d-3e89-08ed-2d66-7098f6e5af91@codeaurora.org>
Date:   Thu, 13 Aug 2020 12:47:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159717444178.1360974.6520145243224264090@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/12/2020 1:04 AM, Stephen Boyd wrote:
> Quoting Maulik Shah (2020-08-10 04:20:55)
>> msmgpio irqchip is not using return value of irq_set_wake call.
>> Start using it.
> Does this work when the irq parent isn't setup in a hierarchy?
yes it works fine even when parent isn't setup in hierarchy.
> I seem to
> recall that this was written this way because sometimes
> irq_set_irq_wake() would fail for the summary irq so it was a best
> effort setting of wake on the summary line.
Thanks for pointing this.

It was written this way since previously GIC driver neither had 
IRQCHIP_SKIP_SET_WAKE flag nor it implemented .irq_set_wake callback,

so the call to irq_set_irq_wake() to set_irq_wake_real() used to return 
error -ENXIO in past.

I see this is already taken care now in GIC drivers by adding 
IRQCHIP_SKIP_SET_WAKE flag.

>
>> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-msm.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 90edf61..c264561 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -1077,12 +1077,10 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>>           * when TLMM is powered on. To allow that, enable the GPIO
>>           * summary line to be wakeup capable at GIC.
>>           */
>> -       if (d->parent_data)
>> -               irq_chip_set_wake_parent(d, on);
>> -
>> -       irq_set_irq_wake(pctrl->irq, on);
>> +       if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
>> +               return irq_chip_set_wake_parent(d, on);
> So this bit is probably fine.
>
>>   
>> -       return 0;
>> +       return irq_set_irq_wake(pctrl->irq, on);
> But this one is probably not fine.

As per above both of them are fine.

Thanks,
Maulik

>
>>   }
>>   
>>   static int msm_gpio_irq_reqres(struct irq_data *d)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

