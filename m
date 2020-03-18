Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F7C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FE82076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCRKRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:17:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:21179 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbgCRKRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:17:41 -0400
IronPort-SDR: gffmtxI7C6Fj+5FwShjeN+lPYmdXTwDgWbXBuvU3Q4eDfsbBCKMreO4jQccv27vwalQtrqeKUT
 4haj78V8ke9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 03:05:26 -0700
IronPort-SDR: PVmGYa6s/4SlBw7rAL0UALyV4G0Zc+YoYHVpfMvuAd7hV4GpJ7RsaIQBgu/+YxAA236+zZsEG4
 K2JPwMnApV8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; 
   d="scan'208";a="248122449"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222]) ([10.249.155.222])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2020 03:05:22 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <66c719b3-a66e-6a9f-fab8-721ba48d7ad8@intel.com>
 <20200318095745.GA133849@light.dominikbrodowski.net>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <fafed002-5f7f-dd2b-0787-265da7ec7c7a@intel.com>
Date:   Wed, 18 Mar 2020 11:05:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318095745.GA133849@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 10:57, Dominik Brodowski wrote:
>>>
>>> Unfortunately, I cannot bisect this issue easily -- i915 was broken for
>>> quite some time on this system[*], prohibiting boot...
>>
>> Hmm, sounds like that issue is quite old. DSP for Haswell and Broadwell is
>> available for I2S devices only, so this relates directly to legacy HDA
>> driver. Compared to Skylake+, HDAudio controller for older platforms is
>> found within GPU. My advice is to notify the DRM guys about this issue.
>>
>> Takashi, are you aware of problems with HDMI on HSW/ BDW or should I just
>> loop Jani and other DRM peps here?
> 
> Well, it works on v5.5, so this issue is not really "quite old" (the "no
> context buffer need to restore!" message seen there seems harmless).
> 
> Thanks again, and best wishes,
> 	Dominik
> 

Was commenting the "i915 was broken for quite some time on this 
system[*], prohibiting boot...". Unless I misunderstood you, this ain't 
a DSP driver issue but HDAudio/iDisp one. Essentially, these are two 
issues you mentioned here.

Czarek
