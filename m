Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E5AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A17620639
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgIIQDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:03:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:12310 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730845AbgIIQDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:03:17 -0400
IronPort-SDR: HKl1DivXqlVXKm0dIHHkPlBxJbflXQ2chWLlLxcNCLDiWdpl+4R1A+pQddHgAdhf8XYdomAdVF
 gVtwZLqY2JIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155811594"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155811594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 07:39:27 -0700
IronPort-SDR: GCSL0Ela4Jea3HKxxVgV9QfVD1pxCMqZXJtu2wol68k9I9lZ4TGaJNC5CJ0ZPDrkyaIqa4e/tr
 efe1lYen/FNQ==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="505473210"
Received: from rsetyawa-mobl1.amr.corp.intel.com (HELO [10.212.20.145]) ([10.212.20.145])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 07:39:26 -0700
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
Date:   Wed, 9 Sep 2020 09:39:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Currently slave devices are only added either from device tree or acpi
>>> entries. However lets say, there is wrong or no entry of a slave device
>>> in DT that is enumerated, then there is no way for user to know all
>>> the enumerated devices on the bus.
>>
>> Sorry Srinivas, I don't understand your point.
>>
>> The sysfs entries will include all devices that are described in 
>> platform firmware (be it DT or ACPI).
> 
> yes that is true, but it will not include all the enumerated devices on 
> the bus!
> 
> In my case on a new board I was trying to figure out what devices are on 
> the bus even before even adding any device tree entries!

We've seen this before but dynamic debug provides all the information 
you need. see e.g. the logs from 
https://sof-ci.01.org/linuxpr/PR2425/build4447/devicetest/

jf-cml-rvp-sdw-1 kernel: [  289.751974] soundwire sdw-master-0: Slave 
attached, programming device number
jf-cml-rvp-sdw-1 kernel: [  289.752121] soundwire sdw-master-0: SDW 
Slave Addr: 10025d070000 <<< HERE
jf-cml-rvp-sdw-1 kernel: [  289.752122] soundwire sdw-master-0: SDW 
Slave class_id 0, part_id 700, mfg_id 25d, unique_id 0, version 1

  > In second case I had a typo in the device tree entry and sysfs 
displayed
> devices with that typo rather than actual enumerated device id.

That's a feature, not a bug? We use what address the platform firmware 
provides. If it's inaccurate then nothing can work.

>> If you add to sysfs entries unknown devices which happen to be present 
>> on the bus, then what? How would you identify them from the devices 
>> that are described in firmware?
> 
> Both of them should be displayed in sysfs, core should be able to 
> differentiate this based on the presence of fw_node or of_node and not 
> bind!

Core yes but user not so much. If the intent is to list the devices 
present on the bus, your patch still requires manual work.

>> Also the sysfs entries describe properties, but if you haven't bound a 
>> driver then how would this work?
> 
> This is would be informative, atleast in cases like me!
> 
> All I want to know is the list of enumerated devices on the bus, If 
> doing this way is not the right thing, then am happy to try any suggestion!
> 
> For now I have managed to figure out enumerated device ids on the bus 
> with this patch, I was hoping that other people would also hit such 
> issue, so I sent this patch!

Now I get your point but
a) you already have a dynamic debug trace to list all devices
b) adding 'undeclared' devices would make things quite murky and is only 
half of the solution. We already struggle because we already have 
'ghost' devices in sysfs that are not physically present, and no way to 
differentiate between the two. If we did add those entries, then we'd 
need two new sysfs attributes such as
'declared' and 'enumerated'.
