Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D11BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA16206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFLNyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:54:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:1771 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLNyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:54:13 -0400
IronPort-SDR: gNmQgvGGfcuLLcteRZO90T7juy8DowFBomZpiKZ9d0iK4q+2qfjSiC+nsDny2KExKOcUbwVEQO
 z1iOhFnQER3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 06:54:13 -0700
IronPort-SDR: iU+h/Z8i+sjCatce5NdcOtdhdZZDJIOZGF71b5m5MN4vThRRmEjquCTlpE/3j38okJWWhCb356
 YC6OBGMqmNhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="315134584"
Received: from rrhill-mobl1.amr.corp.intel.com (HELO [10.254.71.222]) ([10.254.71.222])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2020 06:54:11 -0700
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
To:     Mark Brown <broonie@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
References: <s5himfxet1c.wl-tiwai@suse.de>
 <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
 <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
 <20200612121946.GE5396@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7cd79261-6f8d-cad0-c65b-57570a40a6b6@linux.intel.com>
Date:   Fri, 12 Jun 2020 08:54:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612121946.GE5396@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/20 7:19 AM, Mark Brown wrote:
> On Thu, Jun 11, 2020 at 05:49:29PM -0700, John Stultz wrote:
>> On Thu, Jun 11, 2020 at 5:13 PM John Stultz <john.stultz@linaro.org> wrote:
> 
>>>   I've bisected it down to the following commit from this pull req:
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b73287f0b0745961b14e5ebcce92cc8ed24d4d52
> 
> For the benefit of readers that's "ASoC: soc-pcm: dpcm: fix
> playback/capture checks".
> 
>> I don't know the backgroun again, but would something like the
>> following make sense?
>> https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=7e49b248db77b5ed29b2aa278268e77650c75482
> 
> That's a small out of tree test patch which has no changelog so I'm not
> entirely clear what the intent or motivation is but it looks like the
> goal is to change so that we only warn when a link says it supports
> playback/capture but some of the DAIs lack the capability instead of
> returning an error.  I'm not sure I understand how that helps, it seems
> like the link is still misconfigured and we still have a warning which
> isn't great?  Surely the issue is that we've flagged the link as
> supporting capture when it doesn't?

Indeed the addition of stricter checks will expose cases where the links 
are not well configured, probably for years. The patch "ASoC: soc-pcm: 
dpcm: fix playback/capture checks" did not add those checks, only fixed 
them for the multi-dai case.

I think that those configuration errors are the problem and should be 
fixed as a prerequisite to the removal of the duplication between 
dpcm_playback/dpcm_capture/playback_only/capture_only. it may be painful 
and generate noise for a while, but if we only throw a warning what are 
the odds all those configuration errors will eventually be fixed?

If we need more time for validation on all platforms, then maybe we can 
first relax the check for 5.8-rc1 as suggested by John, but re-add the 
-EINVAL on -next to give a target of 5.9 with all configurations fixed?
