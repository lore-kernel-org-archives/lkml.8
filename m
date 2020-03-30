Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250FAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D8E2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgC3Phh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:37:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:59646 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgC3Phh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:37:37 -0400
IronPort-SDR: NOuWRtCXOrIUeQjaWe8HTJ7PTNyOBQhdNTbTwLAOPyTASfYCZuuLmkO+IwkOWgD+XepVgvkIkr
 PrqYtNIdnTlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 08:37:21 -0700
IronPort-SDR: rGfofEL0vyso2snjbsChk1/bvhIJvttkOoY8nj2MoiAnlDgt4nwnA7l4+c1eagK7/WENaaEzKM
 L9ExIccj2JDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,324,1580803200"; 
   d="scan'208";a="395160763"
Received: from sgobriel-mobl.amr.corp.intel.com (HELO [10.212.145.94]) ([10.212.145.94])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2020 08:37:20 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
        curtis@malainey.com, tiwai@suse.com,
        Keyon Jie <yang.jie@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com
References: <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <20200330102356.GA16588@light.dominikbrodowski.net>
 <43c098c9-005e-b9f4-2132-ed6e4a65feee@intel.com>
 <20200330113929.GF4792@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <85dca962-58ad-6e00-c84b-10859ea127fe@linux.intel.com>
Date:   Mon, 30 Mar 2020 10:37:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330113929.GF4792@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/20 6:39 AM, Mark Brown wrote:
> On Mon, Mar 30, 2020 at 01:10:34PM +0200, Cezary Rojewski wrote:
>> On 2020-03-30 12:23, Dominik Brodowski wrote:
> 
>>> Seems this patch didn't make it into v5.6 (and neither did the other ones
>>> you sent relating to the "dummy" components). Can these patches therefore be
>>> marked for stable, please?
> 
> I sent my pull request already sorry - once it hits Linus' tree I'd send
> a request to stable.
> 
>> While one of the series was accepted and merged, there is a delay caused by
>> Google/ SOF folks in merging the second one.
> 
>> Idk why rt286 aka "broadwell" machine board patch has not been merged yet.
>> It's not like we have to merge all (rt5650 + rt5650 + rt286) patches at
>> once. Google guys can keep verifying Buddy or whatnot while guys with Dell
>> XPS can enjoy smooth audio experience.
> 
> My scripting is set up to merge things sent to me as a patch series and
> we didn't get positive review from Pierre on any of it with the review
> on that one patch seeming to suggest it might also be waiting go go
> through a test farm.  TBH I also wasn't expecting it to take quite so
> long to get reviewed when it came in, it's been over 2 weeks now...

There are multiple problems with Broadwell and device-specific issues on 
suspend-resume - in which Cezary is involved. The tests are not 
automated so depend on people availability.

I tested this series last Friday and I didn't find any new problem on my 
side, so we should probably merge this series.

Everyone should be aware though that suspend-resume is far from stable 
on Broadwell, and if it works on Dell XPS 13 it doesn't work reliably on 
Chrome devices.
