Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F115C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF9D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgBFRFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:05:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:28475 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbgBFRFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:05:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 09:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="432281666"
Received: from rrmuthya-mobl1.amr.corp.intel.com (HELO [10.251.129.34]) ([10.251.129.34])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2020 09:05:28 -0800
Subject: Re: sound/pci/hda/patch_hdmi.c:1086: undefined reference to
 `snd_hda_get_num_devices'
To:     Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202002061809.r3UYBZGx%lkp@intel.com>
 <alpine.DEB.2.21.2002061531350.2957@eliteleevi.tm.intel.com>
 <s5hr1z7q12m.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <02d655fe-dd21-3fcb-6f5d-4ecde51f3240@linux.intel.com>
Date:   Thu, 6 Feb 2020 11:05:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <s5hr1z7q12m.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/20 7:48 AM, Takashi Iwai wrote:
> On Thu, 06 Feb 2020 14:40:17 +0100,
> Kai Vehmanen wrote:
>>
>> Hey,
>>
>> On Thu, 6 Feb 2020, kbuild test robot wrote:
>>
>>>     ld: sound/pci/hda/patch_hdmi.o: in function `intel_not_share_assigned_cvt':
>>>>> sound/pci/hda/patch_hdmi.c:1086: undefined reference to `snd_hda_get_num_devices'
>>>>> ld: sound/pci/hda/patch_hdmi.c:1098: undefined reference to `snd_hda_get_dev_select'
>>>>> ld: sound/pci/hda/patch_hdmi.c:1099: undefined reference to `snd_hda_set_dev_select'
>>
>> hmm, this seems similar case as the previous one today w.r.t
>> hda_dsp_common.c:76. Patch_hdmi.c is built-in while snd-hda is a module.
>> Maybe we need to just drop the dependency from the ASoC board files to
>> SND_HDA_CODEC_HDMI. We don't have one for SND_HDA_CODEC either.
> 
> The problem is that SOF tries to do reverse-select the legacy HD-audio
> codec, but it doesn't work in general.  Or it must be done very
> carefully.
> 
> If something gets selected, all dependencies have to be
> reverse-selected, too.  But the legacy HDA is built up in a way of
> standard top-down selection (i.e. SND_HDA_CODEC_* depends on SND_HDA,
> not other way round).

It's the same issue as the other one reported earlier, and adding the 
dependency on SOF_HDA makes the unmet dependency go away.
