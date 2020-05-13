Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D513C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A1F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YqXul73G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgEMA2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:28:49 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61072 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729215AbgEMA2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:28:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589329727; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Z3nO1YYjG4OzAJinMUwKPc2jdr9tytUGBG603ShGi4Y=; b=YqXul73GNz2yCW/K4KGhXhaSyDt93Sk+ROqDiUMpGxgVTbif56r+qSkExOAP/APnk034Blzh
 tredwZgR1VkKfYv1Ir6k6R/kagCW6Z+R4hcx/Z4ssH7NGty9a/mbeqdIc+BS4QLf/ra21Ims
 MnWusRqGcUnenO/UbrvRTYxLkMM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebb3f3e.7f2dc4442c70-smtp-out-n03;
 Wed, 13 May 2020 00:28:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5079AC433BA; Wed, 13 May 2020 00:28:46 +0000 (UTC)
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A89D4C433CB;
        Wed, 13 May 2020 00:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A89D4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v1 3/5] bus: mhi: core: Skip handling BHI irq if MHI reg
 access is not allowed
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
 <1589248989-23824-4-git-send-email-hemantk@codeaurora.org>
 <20200512065349.GE4928@Mani-XPS-13-9360>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <5e9a15ed-4bad-744a-af07-b28c3bcc47c4@codeaurora.org>
Date:   Tue, 12 May 2020 17:28:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200512065349.GE4928@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 5/11/20 11:53 PM, Manivannan Sadhasivam wrote:
> On Mon, May 11, 2020 at 07:03:07PM -0700, Hemant Kumar wrote:
>> Driver continues handling of BHI interrupt even if MHI register access
>> is not allowed. By doing so it calls the status call back and performs
>> early notification for the MHI client. This is not needed when MHI
>> register access is not allowed. Hence skip the handling in this case and
>> return. Also add debug log to print device state, local EE and device EE
>> when reg access is valid.
>>
>> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
>> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   drivers/bus/mhi/core/main.c | 21 ++++++++++++++-------
>>   1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
>> index 9ec9b36..467c0ba 100644
>> --- a/drivers/bus/mhi/core/main.c
>> +++ b/drivers/bus/mhi/core/main.c
>> @@ -369,22 +369,29 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev)
>> +irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>>   {
>> -	struct mhi_controller *mhi_cntrl = dev;
>> +	struct mhi_controller *mhi_cntrl = priv;
>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>   	enum mhi_state state = MHI_STATE_MAX;
>>   	enum mhi_pm_state pm_state = 0;
>>   	enum mhi_ee_type ee = 0;
>>   
>>   	write_lock_irq(&mhi_cntrl->pm_lock);
>> -	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
>> -		state = mhi_get_mhi_state(mhi_cntrl);
>> -		ee = mhi_cntrl->ee;
>> -		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
>> +	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
>> +		write_unlock_irq(&mhi_cntrl->pm_lock);
> 
> write_lock is only used for protecting 'mhi_cntrl->ee' but here we are not
> updating it if reg access is not valid. So there is no reason to hold this lock.
Original code is using write_lock to protect pm_state as well as 
mhi_cntrl->ee. This patch is keeping the lock same as original code. 
Just if condition logic is negated here due to that write_unlock_irq is 
added under if condition.
> 
>> +		goto exit_intvec;
>>   	}
>>   
>> +	state = mhi_get_mhi_state(mhi_cntrl);
>> +	ee = mhi_cntrl->ee;
>> +	mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
> 
> But it is needed here.
> 
> Thanks,
> Mani
> 
>> +	dev_dbg(dev, "local ee:%s device ee:%s dev_state:%s\n",
>> +		TO_MHI_EXEC_STR(mhi_cntrl->ee), TO_MHI_EXEC_STR(ee),
>> +		TO_MHI_STATE_STR(state));
>> +
>>   	if (state == MHI_STATE_SYS_ERR) {
>> -		dev_dbg(&mhi_cntrl->mhi_dev->dev, "System error detected\n");
>> +		dev_dbg(dev, "System error detected\n");
>>   		pm_state = mhi_tryset_pm_state(mhi_cntrl,
>>   					       MHI_PM_SYS_ERR_DETECT);
>>   	}
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
