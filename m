Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43C3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B670120691
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFLO4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:56:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:22980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLO4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:56:14 -0400
IronPort-SDR: h8lMnBsfWzjtfZjvLRYWWupsKPAOcfmn3krDb3CAMtkpmMDZVMvrgn+k5w00gHFaZC/lm+yE/D
 f0Vv2uzfGMRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 07:56:11 -0700
IronPort-SDR: asisTQgMwswpJfxS/ZiJlY5lEmVksHF6rrVuDzDH7o1EIu3myWbGMGgaZFSQt6NV8iBf0sso0X
 q+2wJTdsUvvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="315148421"
Received: from rrhill-mobl1.amr.corp.intel.com (HELO [10.254.71.222]) ([10.254.71.222])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2020 07:56:09 -0700
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
To:     Mark Brown <broonie@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
 <7cd79261-6f8d-cad0-c65b-57570a40a6b6@linux.intel.com>
 <20200612144646.GJ5396@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <26a99d25-4333-9496-ad5d-b96f7b7e2a33@linux.intel.com>
Date:   Fri, 12 Jun 2020 09:56:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612144646.GJ5396@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/20 9:46 AM, Mark Brown wrote:
> On Fri, Jun 12, 2020 at 08:54:11AM -0500, Pierre-Louis Bossart wrote:
> 
>> I think that those configuration errors are the problem and should be fixed
>> as a prerequisite to the removal of the duplication between
>> dpcm_playback/dpcm_capture/playback_only/capture_only. it may be painful and
>> generate noise for a while, but if we only throw a warning what are the odds
>> all those configuration errors will eventually be fixed?
> 
> Yeah, I'm kind of pessimistic about the likelyhood of people paying
> attention to warnings.
> 
>> If we need more time for validation on all platforms, then maybe we can
>> first relax the check for 5.8-rc1 as suggested by John, but re-add the
>> -EINVAL on -next to give a target of 5.9 with all configurations fixed?
> 
> I can't help feeling that it'd be postponing the inevitable, but perhaps
> I'm being overly pessimistic here.  The change did obviously go in quite
> late though so it's not the worst idea if you want to send the patch?

I see patches from Srinivas to fix the issue reported by John, so maybe 
apply those patches first and if we see another issue on another 
platform we relax the check?
