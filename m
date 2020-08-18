Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A01BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819E2204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHRMJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:09:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:46057 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgHRMJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:09:44 -0400
IronPort-SDR: mmmdvIUZushEk/qYYbXX2z8Gd7rJK9+ntXq/6e4i9HIrGcB34CabCWTMpqKD9V/+HvBiy6gKyJ
 /mP2UOwrTTdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154858783"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154858783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:09:44 -0700
IronPort-SDR: nE7KDIMg9QlBsdRoU29DOvkkZeyvCbLlCKWCcoa2bwJdcra3a1uGTS6k/nIb8mxGuhU4DUbT8K
 LGh5G+j7mBxQ==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471783463"
Received: from kumaraaj-mobl1.amr.corp.intel.com (HELO [10.251.23.85]) ([10.251.23.85])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:09:42 -0700
Subject: Re: [PATCH 2/2] soundwire: fix port_ready[] dynamic allocation in
 mipi_disco and ASoC codecs
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
References: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
 <20200817174727.15139-3-yung-chuan.liao@linux.intel.com>
 <20200818063659.GW2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e9f12e13-49e0-5306-a975-b1b854baef02@linux.intel.com>
Date:   Tue, 18 Aug 2020 07:09:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818063659.GW2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/20 1:36 AM, Vinod Koul wrote:
> On 18-08-20, 01:47, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> The existing code allocates memory for the total number of ports.
>> This only works if the ports are contiguous, but will break if e.g. a
>> Devices uses port0, 1, and 14. The port_ready[] array would contain 3
>> elements, which would lead to an out-of-bounds access. Conversely in
>> other cases, the wrong port index would be used leading to timeouts on
>> prepare.
>>
>> This can be fixed by allocating for the worst-case of 15
>> ports (DP0..DP14). In addition since the number is now fixed, we can
>> use an array instead of a dynamic allocation.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
>> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
>> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
>> ---
>>   drivers/soundwire/mipi_disco.c  | 18 +-----------------
>>   drivers/soundwire/slave.c       |  4 ++++
>>   include/linux/soundwire/sdw.h   |  2 +-
>>   sound/soc/codecs/max98373-sdw.c | 15 +--------------
>>   sound/soc/codecs/rt1308-sdw.c   | 14 +-------------
>>   sound/soc/codecs/rt5682-sdw.c   | 15 +--------------
>>   sound/soc/codecs/rt700-sdw.c    | 15 +--------------
>>   sound/soc/codecs/rt711-sdw.c    | 15 +--------------
>>   sound/soc/codecs/rt715-sdw.c    | 33 +--------------------------------
> 
> This looks fine, but the asoc changes are not dependent, so maybe we
> should split them up and then can go thru Mark. Or Mark acks, either way
> would work for me

There are 3 dependencies that we tracked between SoundWire and ASoC 
subsystems:

a) addition of SDCA control macro (needed before SDCA codec drivers can 
be shared)
b) this series - we could indeed submit the codec changes to Mark's tree 
separately, but then the SoundWire tree would be broken: the codec 
drivers would still try to allocate dynamically what is now a fixed-size 
array.
c) configuration of the interrupt masks in codec drivers instead of 
hard-coded in bus driver + spurious parity error workaround (not posted 
yet but ready).

The changes in ASoC codecs are really only on the initialization part 
(either removing a dynamic allocation or setting masks), there's no 
functional change otherwise.

I think the simplest to avoid multiple back-and-forth is to have these 
small interface/initialization changes merged through the SoundWire 
subsystem, then merged by Mark from a single immutable tag. Would this 
work for everyone?

In addition, there's a WIP change to regmap to add support for SoundWire 
1.2 MBQ-based register access, but this only affects regmap and ASoC 
trees, all handled by Mark.

I don't think we have any other cross-tree changes planned for now, the 
SDCA infrastructure plumbing is still rather open.
