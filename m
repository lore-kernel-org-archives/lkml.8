Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683FAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4155A20772
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHJPDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:03:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:38032 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgHJPDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:03:10 -0400
IronPort-SDR: wWHoqf6ltRmFMz3QjQMdD1POQtu2tal+juHHNOJfckx7BgmxbCBEruqYTZJQXP9Bdc/PkIjjm6
 Pp5FyHYZYilw==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="152760447"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="152760447"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 08:03:09 -0700
IronPort-SDR: 12GPmA8BCeQKGz3X7oWrHdalm2jYaMpo7RLVvb4zhfL6Ek6UshgXWdDmlDGRZyMjLYfytOv4Ny
 v8l1ys7ZGACg==
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="438722426"
Received: from schen8-mobl.amr.corp.intel.com (HELO [10.212.235.58]) ([10.212.235.58])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 08:03:07 -0700
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
To:     "Lu, Brent" <brent.lu@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-1-git-send-email-brent.lu@intel.com>
 <1596198365-10105-3-git-send-email-brent.lu@intel.com>
 <s5h5za3ajvb.wl-tiwai@suse.de>
 <DM6PR11MB3642AE90DF98956CCEDE6C2F974F0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hd04a90o4.wl-tiwai@suse.de>
 <DM6PR11MB3642B5BC2E1E0708088526D8974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com>
 <DM6PR11MB3642D9BE1E5DAAB8B78B84B0974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <s5hpn873by6.wl-tiwai@suse.de>
 <DM6PR11MB36423A9D28134811AD5A911F974A0@DM6PR11MB3642.namprd11.prod.outlook.com>
 <6466847a-8aae-24f7-d727-36ba75e95f98@linux.intel.com>
 <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
Date:   Mon, 10 Aug 2020 10:03:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/20 11:41 AM, Lu, Brent wrote:
>>
>> I don't get this. If the platform driver already stated 240 and 960 samples why
>> would 432 be chosen? Doesn't this mean the constraint is not applied?
> 
> Hi Pierre,
> 
> Sorry for late reply. I used following constraints in V3 patch so any period which
> aligns 1ms would be accepted.
> 
> +	/*
> +	 * Make sure the period to be multiple of 1ms to align the
> +	 * design of firmware. Apply same rule to buffer size to make
> +	 * sure alsa could always find a value for period size
> +	 * regardless the buffer size given by user space.
> +	 */
> +	snd_pcm_hw_constraint_step(substream->runtime, 0,
> +			   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 48);
> +	snd_pcm_hw_constraint_step(substream->runtime, 0,
> +			   SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 48);

432 samples is 9ms, I don't have a clue why/how CRAS might ask for this 
value.

It'd be a bit odd to add constraints just for the purpose of letting 
userspace select a sensible value.
