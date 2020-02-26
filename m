Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD8C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7361224670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBZQiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:38:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:52388 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgBZQiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:38:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 08:38:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="410671937"
Received: from nkaburla-mobl.amr.corp.intel.com (HELO [10.252.133.245]) ([10.252.133.245])
  by orsmga005.jf.intel.com with ESMTP; 26 Feb 2020 08:38:01 -0800
Subject: Re: [PATCH] soundwire: bus: provide correct return value on error
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200225164907.23358-1-pierre-louis.bossart@linux.intel.com>
 <20200226080326.GU2618@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <69a06304-c869-0539-0c85-9ab154807269@linux.intel.com>
Date:   Wed, 26 Feb 2020 08:54:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226080326.GU2618@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/20 2:03 AM, Vinod Koul wrote:
> On 25-02-20, 10:49, Pierre-Louis Bossart wrote:
>> From: Bard Liao <yung-chuan.liao@linux.intel.com>
>>
>> It seems to be a typo. It makes more sense to return the return value
>> of sdw_update() instead of the value we want to update.
>>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index 13887713f311..b8a7a84aca1c 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -1070,7 +1070,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
>>   	if (ret < 0) {
>>   		dev_err(slave->bus->dev,
>>   			"SDW_DP0_INTMASK read failed:%d\n", ret);
>> -		return val;
>> +		return ret;
> 
> good catch. But can we optimize it to:
>>   	}
>>   
>>   	return 0;
> 
> make this as below and remove the return above.

ok, will resend as v2.
