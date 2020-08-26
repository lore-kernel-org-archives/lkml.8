Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A62C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 748A420707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgHZPLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:11:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:9758 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgHZPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:11:24 -0400
IronPort-SDR: AxVSGKCavgPvVemR11xD3T77ZwggUX+pzQxoM26uzLvT03+reuVnP0dcMgO9LnBD0We9+Vu9Ua
 5djlRqx0i+5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153729694"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153729694"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:23 -0700
IronPort-SDR: 8BOuzBscj9k1lVGdB5yJS0/sLIDM5VLn6aH07+vWPTj0D+L0nElcFtADnHP9l4yhtte+n6Vrfd
 A7qzJE3PNBsQ==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="299505123"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51]) ([10.255.231.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:22 -0700
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
        srinivas.kandagatla@linaro.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
 <20200826095600.GA4965@sirena.org.uk> <s5ha6yhu3af.wl-tiwai@suse.de>
 <20200826101301.GB4965@sirena.org.uk> <s5h8se1u2or.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <927c93bc-9ad8-7e5d-a5ea-d566e5f543df@linux.intel.com>
Date:   Wed, 26 Aug 2020 10:05:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5h8se1u2or.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>> checkpatch is broken.
>>
>>> Heh, I'm not objecting it :)
>>
>>> OTOH, it's also true that ENOTSUPP is no good error code if returned
>>> to user-space.  Unfortunately many codes (including what I wrote) use
>>> this code mistakenly, and they can't be changed any longer...
>>
>> It's also used internally in various places without being returned to
>> userspace, that's what's going on here - the regmap core has some
>> specific checks for -ENOTSUPP.
> 
> Sure, for such an internal usage any code can be used.
> The question is a case like this -- where the return code might be
> carried to outside.  Though, looking through the grep output, all
> callers simply return -EINVAL for any errors, so it doesn't matter
> much for now.

I assumed this change to -EOPNOTSUPP reflected a consensus in 
kernel-land, it's obviously not the case. This patch was supposed to be 
a trivial clean-up...

So to be clear, what is the direction for existing code
a) keep -ENOTSUPP as is?
b) move to -EOPNOTSUPP?

And what is the preference for new code?
