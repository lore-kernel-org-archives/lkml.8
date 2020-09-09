Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFCC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65FC21919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgIIRBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:01:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:42301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731255AbgIIRBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:01:07 -0400
IronPort-SDR: bHno9ZgnHJF7A5usV6zlKzWavmLmaJjnf133iDWCMZGZi7SAMEiDivWmTbolxeDsMq78ZHKAOu
 D7L1NO5jVqqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="157652638"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="157652638"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 10:01:01 -0700
IronPort-SDR: /N/heFDKxKb2HFDk4yR30nCvJc4feNSfGOv8JktzCfqUo5uUbej66lwTOSnK38lIgTO2iLeICJ
 sITk8ooDxFwQ==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="505516346"
Received: from rsetyawa-mobl1.amr.corp.intel.com (HELO [10.212.20.145]) ([10.212.20.145])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 10:01:00 -0700
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
 <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
 <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ed88432c-e21c-b5fc-3abc-5f574769b722@linux.intel.com>
Date:   Wed, 9 Sep 2020 12:00:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/20 10:54 AM, Srinivas Kandagatla wrote:
> 
> 
> On 09/09/2020 15:39, Pierre-Louis Bossart wrote:
>>
>>>>> Currently slave devices are only added either from device tree or acpi
>>>>> entries. However lets say, there is wrong or no entry of a slave 
>>>>> device
>>>>> in DT that is enumerated, then there is no way for user to know all
>>>>> the enumerated devices on the bus.
>>>>
>>>> Sorry Srinivas, I don't understand your point.
>>>>
>>>> The sysfs entries will include all devices that are described in 
>>>> platform firmware (be it DT or ACPI).
>>>
>>> yes that is true, but it will not include all the enumerated devices 
>>> on the bus!
>>>
>>> In my case on a new board I was trying to figure out what devices are 
>>> on the bus even before even adding any device tree entries!
>>
>> We've seen this before but dynamic debug provides all the information 
>> you need. see e.g. the logs from 
>> https://sof-ci.01.org/linuxpr/PR2425/build4447/devicetest/
>>
>> jf-cml-rvp-sdw-1 kernel: [  289.751974] soundwire sdw-master-0: Slave 
>> attached, programming device number
>> jf-cml-rvp-sdw-1 kernel: [  289.752121] soundwire sdw-master-0: SDW 
>> Slave Addr: 10025d070000 <<< HERE
> 
> Yes, I have noticed this too! This will be printed for every call to 
> sdw_extract_slave_id()!
> 
> ...
>>
>> Now I get your point but
>> a) you already have a dynamic debug trace to list all devices
>> b) adding 'undeclared' devices would make things quite murky and is 
>> only half of the solution. We already struggle because we already have 
>> 'ghost' devices in sysfs that are not physically present, and no way 
>> to differentiate between the two. If we did add those entries, then 
>> we'd need two new sysfs attributes such as
>> 'declared' and 'enumerated'.
> 
> I totally agree with you on dealing with the undeclared devices, which 
> is unnecessary mess!

It's not necessarily that bad.
- if the intent is to have a single platform firmware that can deal with 
different boards, it's a good thing.
- but if it's just sloppy platform firmware that just does copy-paste 
from platform to platform then indeed it becomes a mess.

> May be we could make the enumerated devices discovery bit more verbose!

Maybe adding a device number sysfs entry would help, e.g. reporting
NotAttched or a value in [0,11] would tell you if the device is actually 
present.


