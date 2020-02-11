Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF212C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93506206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgBKSIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:08:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:56663 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728832AbgBKSIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:08:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 10:08:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="222014389"
Received: from mahaling-mobl.amr.corp.intel.com (HELO [10.254.185.201]) ([10.254.185.201])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2020 10:08:34 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
To:     "Lu, Brent" <brent.lu@intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        "cychiang@google.com" <cychiang@google.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
Date:   Tue, 11 Feb 2020 10:30:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Could ensure? This change seems specific to Intel DSP based systems, at
>> least from the description. Having looked through the core, the trigger code
>> for a codec is seemingly always called before the trigger for the CPU. How will
>> this work for other platforms, assuming their clocks are enabled in the CPU
>> DAI trigger function by default?
>>
>> Can we always guarantee the CPU side isn't going to send anything other
>> than 0s until after SRM has locked?

Not with the default mode for the SSP, all clocks are enabled at trigger 
time.
We can enable the MCLK and BCLK ahead of time (which would require a 
change in firmware). But if we want to enable the FSYNC (word-clock), 
then we have to trigger DMA transfers with pretend-buffers, this is a 
lot more invasive.

So just to be clear, which of the MCLK, BCLK, FSYNC do you need enabled?

> I think the patch is for those systems which enable I2S clocks in pcm_start instead
> of pcm_prepare. It has no effect on systems already be able to turn on clocks in
> supply widgets or set_bias_level() function.
> 
> If the trigger type in the DAI link is TRIGGER_PRE, then the trigger function of FE port
> (component or CPU DAI) will be called before codec driver's trigger function. In this
> case we will be able to turn on the clock in time. However, if the trigger type is
> TRIGGER_POST, then the patch does not help because just like what you said, codec
> driver's trigger function is called first.

IIRC we recently did a change to deal with underflows. Ranjani, can you 
remind us what the issue was?
Thanks
-Pierre
