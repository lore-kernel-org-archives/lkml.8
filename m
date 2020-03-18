Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08ACC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D2820674
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCRJlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:41:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:32288 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgCRJlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:41:47 -0400
IronPort-SDR: mUEOjIbPACRYj1nzmCBLTuxLmJibW9swawMSSt7jE05SUMMReCnJWlXX95nfK5ZfEVR1J5S2B1
 oJlA3cuowBfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 02:41:46 -0700
IronPort-SDR: ORroYAM1KHIe5G6nl1CYBrtbrzPa8jYhFyIQ6qqrD+QGHGs+Q8O/LQlNvfrX8z0P0CccpA88s0
 Om4sJrb4I/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; 
   d="scan'208";a="248117273"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222]) ([10.249.155.222])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2020 02:41:43 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>, tiwai@suse.com
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200318063022.GA116342@light.dominikbrodowski.net>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <66c719b3-a66e-6a9f-fab8-721ba48d7ad8@intel.com>
Date:   Wed, 18 Mar 2020 10:41:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318063022.GA116342@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 07:30, Dominik Brodowski wrote:
> Hi!
> 
> While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
> some sound-related trouble: after boot, the sound works fine -- but once I
> suspend and resume my broadwell-based XPS13, I need to switch to headphone
> and back to speaker to hear something. But what I hear isn't music but
> garbled output.
> 
> A few dmesg snippets from v5.6-rc6-9-gac309e7744be which might be of
> interest. I've highlighted the lines differing from v.5.5.x which might be
> of special interest:
> 

Thank you for the report, Dominik. You definitely got our attention.

I've checked the market: Dell XPS 13 9343, yes? Once you confirm model 
id, I'll order a piece immediately to our site.

In regard to logs, thanks for highlighting important lines. Build is of 
'rc' so bugs can still be in plenty - any reason for switching to 
cutting-edge kernel on production stuff? Our CI didn't detect any 
anomalies yet as it is running on 5.5.

I'll direct your ticket on todays meeting. On the first look, issue 
seems to be connected with recent changes to /drivers/dma/dmaengine.c. 
DesignWare DMA controller drv - which HSW/BDW makes use of - might not 
have been updated accordingly. Will dig further on that.

One more, just to make it clear for the rest of the viewers:

 > 	haswell-pcm-audio haswell-pcm-audio: Direct firmware load for 
intel/IntcPP01.bin failed with error -2
 > 	haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not 
available(-2)

Back in the ancient days of DSP (HSW/BDW are actually the very first 
audio DSP hws for Intel) topology was part of FW - SW could not 
configure it and probably that's why library IntcPP01 is attempted to be 
loaded on every boot, even if it's not part of configuration for given 
hw. Maybe we could make it quieter though..

> 
> (these last two messages already are printed a couple of time after boot, and then
> again during a suspend/resume cycle. On v.5.5.y, there are similar messages
> "no context buffer need to restore!"). Everything is built-in, no modules
> are loaded.
> 
> Unfortunately, I cannot bisect this issue easily -- i915 was broken for
> quite some time on this system[*], prohibiting boot...

Hmm, sounds like that issue is quite old. DSP for Haswell and Broadwell 
is available for I2S devices only, so this relates directly to legacy 
HDA driver. Compared to Skylake+, HDAudio controller for older platforms 
is found within GPU. My advice is to notify the DRM guys about this issue.

Takashi, are you aware of problems with HDMI on HSW/ BDW or should I 
just loop Jani and other DRM peps here?

Czarek
