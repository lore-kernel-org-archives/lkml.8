Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3B4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86602137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgDQH7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:59:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:36834 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbgDQH7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:59:07 -0400
IronPort-SDR: pIvkX25qjTXyhgBwnloZQmhSEJHk11sWJgRKTs7q9xewTt3nK6Z9IGhsc2AL9IL2SMXyij/3PV
 0/fIN10tz7HA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 00:59:06 -0700
IronPort-SDR: CGPJrXmmq3ECcjShtzPW6vzAtxidCY36qeeTf6HCrzk4Vn/CjVw0j2WuzpQisWGCVq37CqdCIg
 M3co0DPSyWuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; 
   d="scan'208";a="333120399"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.31.36]) ([10.213.31.36])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2020 00:59:02 -0700
Subject: Re: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
To:     "Lu, Brent" <brent.lu@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>
References: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
 <9a484795-ea4a-e559-4ea9-3de24417ec9b@linux.intel.com>
 <BN6PR1101MB21320F655CFC1C271CCA9CE097DD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <4b9455cb-d0d2-f5d8-f04c-df6e5abb4441@linux.intel.com>
 <BN6PR1101MB2132BBB45C6683D6BE1FBCD897D90@BN6PR1101MB2132.namprd11.prod.outlook.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <95d0a64e-d2e9-7117-75c5-6c68b1426f93@intel.com>
Date:   Fri, 17 Apr 2020 09:59:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB2132BBB45C6683D6BE1FBCD897D90@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-17 03:32, Lu, Brent wrote:
>>
>> It seems like a generic problem on all Broadwell devices so let's solve with
>> one a single patchset.
>>
>> Shouldn't we just add the 2ch constraints for broadwell.c and bdw-rt5677.c,
>> and the 2 or 4ch constraint for bdw-rt5650.c? Would this work for you?
>>
>> Thanks
>> -Pierre
> 
> Hi Pierre,
> 
> Are you saying submitting a new patch to add constraints to all three broadwell.c,
> bdw-rt5650.c, and bdw-rt5677.c?
> 
> 
> Regards,
> Brent
> 

What Pierre suggested is that you submit a series of patches instead - 
one for each of BDW machine boards. If the same problem exists on all of 
them, there is no reason to left other boards unattended.

Czarek
