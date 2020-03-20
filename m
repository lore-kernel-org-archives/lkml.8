Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF111C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D220753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCTQga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:36:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:36248 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgCTQga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:36:30 -0400
IronPort-SDR: SBDdAuGwEmVgtW0uilVVb7kQ5/oE4gMYEnc9y6czHgVRE1mYsmPp19AXYEzmuiEFO0SooH0+7o
 LXugFZi6smUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 09:36:29 -0700
IronPort-SDR: OxQvFv6Y9TtecqmiOWaWSvgFu6JCPAAdXBFe2Vfj0jidcVYUlllK7JFot1VBJp3OQXFtagmHg7
 JRVZ/iRQHfVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="392204315"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12]) ([10.255.34.12])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 09:36:26 -0700
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200305063646.GW4148@vkoul-mobl>
 <eb30ac49-788f-b856-6fcf-84ae580eb3c8@linux.intel.com>
 <20200306050115.GC4148@vkoul-mobl>
 <4fabb135-6fbb-106f-44fd-8155ea716c00@linux.intel.com>
 <20200311063645.GH4885@vkoul-mobl>
 <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
 <20200313115011.GD4885@vkoul-mobl>
 <4cb16467-87d0-ef99-e471-9eafa9e669d2@linux.intel.com>
 <20200314094904.GP4885@vkoul-mobl>
 <3c32830c-cd12-867f-a763-7c3e385cb1e9@linux.intel.com>
 <20200320153334.GJ4885@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <70d6e0cb-22a6-5ada-83a8-b605974bdd84@linux.intel.com>
Date:   Fri, 20 Mar 2020 11:36:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320153334.GJ4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/20 10:33 AM, Vinod Koul wrote:
> On 16-03-20, 14:15, Pierre-Louis Bossart wrote:
>>
>>
>>>> It's really down to your objection to the use of 'struct driver'... For ASoC
>>>> support we only need the .name and .pm_ops, so there's really no possible
>>>> path forward otherwise.
>>>
>>> It means that we cannot have a solution which is Intel specific into
>>> core. If you has a standalone controller you do not need this.
>>
>> A 'struct driver' is not Intel-specific, sorry.
> 
> We are discussing 'struct sdw_master_driver'. Please be very specific in
> you replies and do not use incorrect terminology which confuses people.
> 
> Sorry a 'struct sdw_master_driver' IMHO is. As I have said it is not
> needed if you have standalone controller even in Intel case, and rest of
> the world.

You're splitting hair without providing a solution.

Please see the series [PATCH 0/5] soundwire: add sdw_master_device 
support on Qualcomm platforms

This solution was tested on Qualcomm platforms, that doesn't require 
this sdw_master_driver to be used, so your objections are now invalid.
