Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF7AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918F12067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgHQPOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:14:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:55009 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:14:34 -0400
IronPort-SDR: TwljEyUIosj63YTOzdTki3H/MzsDQYXcdUCy+1SVjabBJxu+bumm7qOtjS+FEu+YLEbKPJkAlV
 YtJMXSdSTuyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134245421"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="134245421"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 08:14:33 -0700
IronPort-SDR: M4lPcSqU1VGRY+xlpUR0D5GOIZi7NVdcxGRGA+jje3kW1lS9sGTjNmwWqdLPOO0NgbHR43uGp4
 IxaBfgbmEaOQ==
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="310124183"
Received: from jhor-mobl.gar.corp.intel.com (HELO [10.209.166.196]) ([10.209.166.196])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 08:14:31 -0700
Subject: Re: [PATCH v2] soundwire: SDCA: add helper macro to access controls
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
References: <20200816201058.9687-1-yung-chuan.liao@linux.intel.com>
 <20200817121411.GR2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2ab412c5-bf96-5ba3-c193-5a8ad9071bbb@linux.intel.com>
Date:   Mon, 17 Aug 2020 10:14:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817121411.GR2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> The upcoming SDCA (SoundWire Device Class Audio) specification defines
>> a hiearchical encoding to interface with Class-defined capabilities,
> 
> typo hiearchical

ok

>> based on which audio function, entity, control and channel being used.
> 
> Can you please elaborate on what do these terms refer to?
> 
> Also can we have some documentation for this and how Linux is going to
> use it..

These are concepts in the SDCA draft spec, and that should be the 
reference. We worked with MIPI so that this spec will be available with 
a click-through agreement when ratified, for now it's only available to 
contributors per MIPI bylaws.

If you do not have access to this specification, then that's a real 
problem. Maybe you need to let Bard take care of this part as a 
co-maintainer?

The goal with this macro is to enable a first set of codecs drivers 
using these concepts to be released upstream. All you need to know at 
this point is that controls are defined in a hierarchical way and 
accessed with a read/write transaction from/to the address created with 
the following macro.

>> +/* v1.2 device - SDCA address mapping */
>> +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
>> +						 (((fun) & 0x7) << 22) |	\
>> +						 (((ent) & 0x40) << 15) |	\
>> +						 (((ent) & 0x3f) << 7) |	\
>> +						 (((ctl) & 0x30) << 15) |	\
>> +						 (((ctl) & 0x0f) << 3) |	\
>> +						 (((ch) & 0x38) << 12) |	\
>> +						 ((ch) & 0x07))
>> +
> 
> how about adding an underscore to the arguments here:
> 
> #define SDW_SDCA_CTL(_fun, _ent, _ctl, _ch)
> and so on..

I checked the SoundWire defines and the vast majority of the macros 
don't use underscores, and when they do there's no consistency between 1 
or 2 underscores.

