Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79109C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC23206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgHSMva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:51:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:54684 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbgHSMvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:51:23 -0400
IronPort-SDR: SSBKDOW7Cn88tsLacciSZ65qKRDDFpQb6ZwoI+/TxE3/32wsgoMdBXiCAMbrKh4GOiF5HIyJ9Q
 WuanUnlyYKlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="155066293"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="155066293"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 05:51:23 -0700
IronPort-SDR: 3dy8y2A8oSdidDSnXqM8E134GtdCXR5NIuRm42jFP9i1sA+ZCssbcc/hzHJphPqZGGvrtGUr9J
 G7kJTHnooNlw==
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="472222927"
Received: from mdessai-mobl1.amr.corp.intel.com (HELO [10.209.78.93]) ([10.209.78.93])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 05:51:21 -0700
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
 <20200819090637.GE2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
Date:   Wed, 19 Aug 2020 07:51:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819090637.GE2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/20 4:06 AM, Vinod Koul wrote:
> On 18-08-20, 06:23, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> In system suspend stress cases, the SOF CI reports timeouts. The root
>> cause is that an alert is generated while the system suspends. The
>> interrupt handling generates transactions on the bus that will never
>> be handled because the interrupts are disabled in parallel.
>>
>> As a result, the transaction never completes and times out on resume.
>> This error doesn't seem too problematic since it happens in a work
>> queue, and the system recovers without issues.
>>
>> Nevertheless, this race condition should not happen. When doing a
>> system suspend, or when disabling interrupts, we should make sure the
>> current transaction can complete, and prevent new work from being
>> queued.
>>
>> BugLink: https://github.com/thesofproject/linux/issues/2344
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 24 +++++++++++++++++++++++-
>>   drivers/soundwire/cadence_master.h |  1 +
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 24eafe0aa1c3..1330ffc47596 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -791,7 +791,16 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
>>   			     CDNS_MCP_INT_SLAVE_MASK, 0);
>>   
>>   		int_status &= ~CDNS_MCP_INT_SLAVE_MASK;
>> -		schedule_work(&cdns->work);
>> +
>> +		/*
>> +		 * Deal with possible race condition between interrupt
>> +		 * handling and disabling interrupts on suspend.
>> +		 *
>> +		 * If the master is in the process of disabling
>> +		 * interrupts, don't schedule a workqueue
>> +		 */
>> +		if (cdns->interrupt_enabled)
>> +			schedule_work(&cdns->work);
> 
> would it not make sense to mask the interrupts first and then cancel the
> work? that way you are guaranteed that after this call you dont have
> interrupts and work scheduled?

cancel_work_sync() will either
a) wait until the current work completes, or
b) prevent a new one from starting.

there's no way to really 'abort' a workqueue, 'cancel' means either 
complete or don't start.

if you disable the interrupts then cancel the work, you have a risk of 
not letting the work complete if it already started (case a).

The race is
a) the interrupt thread (this function) starts
b) the work is scheduled and starts
c) the suspend handler starts and disables interrupts in [1] below.
d) the work initiates transactions which will never complete since 
Cadence interrupts have been disabled.

So the idea was that before disabling interrupts, the suspend handler 
changes the status, and then calls cancel_work_sync(). the status is 
also used to prevent a new work from being scheduled if you already know 
the suspend is on-going. The test on the status above is not strictly 
necessary, I believe the sequence is safe without it but it avoid 
starting a useless work.

If you want to follow the flow it's better to start with what the 
suspend handler does below first, then look at how the interrupt thread 
might interfere. The diff format does not help, might be also easier to 
apply the patch and look at the rest of the code, e.g the 3 mask updates 
mentioned below are not included in the diff.

> 
>>   	}
>>   
>>   	cdns_writel(cdns, CDNS_MCP_INTSTAT, int_status);
>> @@ -924,6 +933,19 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
>>   		slave_state = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
>>   		cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave_state);
>>   	}

[1]

>> +	cdns->interrupt_enabled = state;
>> +
>> +	/*
>> +	 * Complete any on-going status updates before updating masks,
>> +	 * and cancel queued status updates.
>> +	 *
>> +	 * There could be a race with a new interrupt thrown before
>> +	 * the 3 mask updates below are complete, so in the interrupt
>> +	 * we use the 'interrupt_enabled' status to prevent new work
>> +	 * from being queued.
>> +	 */
>> +	if (!state)
>> +		cancel_work_sync(&cdns->work);
>>   
>>   	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, slave_intmask0);
>>   	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, slave_intmask1);
>> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
>> index fdec62b912d3..4d1aab5b5ec2 100644
>> --- a/drivers/soundwire/cadence_master.h
>> +++ b/drivers/soundwire/cadence_master.h
>> @@ -133,6 +133,7 @@ struct sdw_cdns {
>>   
>>   	bool link_up;
>>   	unsigned int msg_count;
>> +	bool interrupt_enabled;
>>   
>>   	struct work_struct work;
>>   
>> -- 
>> 2.17.1
> 
