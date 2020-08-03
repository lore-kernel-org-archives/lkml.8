Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB69C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA3420792
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHCQan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:30:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:37810 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgHCQam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:30:42 -0400
IronPort-SDR: Uxp3AY0pp3KkxwkPVouH2XOfi1tdOLhtMrRd1rL2mqn57TUdxDVs6tmuIcNTP0dYG3gSlJuMN4
 xeKqqKBjeHQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="149587745"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="149587745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 09:30:40 -0700
IronPort-SDR: HYIrMYEm8lBMNO8V4ckOAoQA8pQWSmFdA/9ZOER3Om2htaswTIXrYE6n0X7b83p99gu4U0XKGj
 4qS1E0oGdiww==
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="274054331"
Received: from ksramesh-mobl.amr.corp.intel.com (HELO [10.252.128.191]) ([10.252.128.191])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 09:30:38 -0700
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
To:     "Lu, Brent" <brent.lu@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63bca214-3434-16c6-1b60-adf323aec554@linux.intel.com>
Date:   Mon, 3 Aug 2020 10:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3642B5BC2E1E0708088526D8974D0@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/20 8:00 AM, Lu, Brent wrote:
>>>>
>>>> Again, is this fixed 240 is a must?  Or is this also an alignment issue?
>>> Hi Takashi,
>>>
>>> I think it's a must for Chromebooks. Google found this value works
>>> best with their CRAS server running on their BSW products. They
>>> offered this patch for their own Chromebooks.
>>
>> Hrm, but it's likely a worse choice on other sound backends.
>>
>> Please double-check whether this fixed small period is a must, or it's an
>> alignment issue.
> Hi Takashi,
> 
> I've double checked with google. It's a must for Chromebooks due to low
> latency use case.

I wonder if there's a misunderstanding here?

I believe Takashi's question was "is this a must to ONLY accept 240 
samples for the period size", there was no pushback on the value itself. 
Are those boards broken with e.g. 960 samples?
