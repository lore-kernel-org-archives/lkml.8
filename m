Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EBAC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E332020709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgCTDVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:21:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:24463 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgCTDVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:21:19 -0400
IronPort-SDR: mBhsYZVjZNSQZ8UTmCAti8ZmW8sK8JOm8Spi8EBLW5GYLi8/QNgeYixqdqXtMrUDdnIOavvhET
 mkR2owc0Tbiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 20:21:19 -0700
IronPort-SDR: mR03DYeqvkIQcgn0WcWd2qJ7otYBW15lrJjlF8zdd6PSU699Wr5FRC2o0WZ3rL9yRLtxxBUDjJ
 ut+0mQv3w5ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,283,1580803200"; 
   d="scan'208";a="324731214"
Received: from jliu231-mobl1.ccr.corp.intel.com (HELO [10.254.208.65]) ([10.254.208.65])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2020 20:21:16 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        curtis@malainey.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
References: <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <eef45d20-3bce-184a-842c-216c15252014@linux.intel.com>
 <20200319173502.GC3983@sirena.org.uk>
From:   Keyon Jie <yang.jie@linux.intel.com>
Message-ID: <0d01b2ce-9531-1a08-e632-4608ab894fbe@linux.intel.com>
Date:   Fri, 20 Mar 2020 11:21:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319173502.GC3983@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/20 1:35 AM, Mark Brown wrote:
> On Thu, Mar 19, 2020 at 12:21:47PM -0500, Pierre-Louis Bossart wrote:
>> On 3/19/20 11:51 AM, Dominik Brodowski wrote:
> 
>>> That patch fixes the issue(s). I didn't even need to revert 64df6afa0dab
>>> ("ASoC: Intel: broadwell: change cpu_dai and platform components for SOF")
>>> on top of that. But you can assess better whether that patch needs care for
>>> other reasons; for me, this one-liner you have suggested is perfect.
> 
> Good news!
> 
>> .ignore_suspend is set for bdw-rt5677.c and bdw-rt5650.c as well. I don't
>> know if that was intentional.
> 
> The intended use case is for applications doing audio during suspend
> like telephony audio between the modem and CODEC on a phone or
> compressed audio playback.  I guess the compressed audio playback case
> could possibly apply with these systems though x86 suspend/resume is
> usually sufficiently heavyweight that it's surprising.

I think that's true, on many of SKL- intel platforms(byt, hsw, bdw), we 
are seeing this .ignore_suspend set with offload or deep buffer FE 
dai_links configured together.

So it looks we can't ignore calling codec's suspend/resume callbacks 
during the power cycle for rt286 codec(on the Dell XPS here), which is 
actually supported on Chromebook SAMUS(rt5677)?

Thanks,
~Keyon

> 
