Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE849C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EBF20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgG3QGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:06:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:40777 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbgG3QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:06:44 -0400
IronPort-SDR: HIB19okkwdv0B++yF+hBK/S8PzwWnQwWp/VL4KMkkpLe4XOSmh30ic9BQPgkvQrgwZ5+6lfQaR
 Y836zFFNgyzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131696622"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="131696622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:06:27 -0700
IronPort-SDR: ejShz7BMEPqgf95S0ALom3X9wqT/C/PZYI1PT1rAVp8F+2RgVitq7bjfhUSjl7ou61cA1T0jin
 8WcinSlwiMvQ==
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="465308149"
Received: from jrwang2-mobl.amr.corp.intel.com (HELO [10.212.82.25]) ([10.212.82.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:06:25 -0700
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, zhangn1985@outlook.com,
        linux-amlogic@lists.infradead.org
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
 <20200729154639.1983854-1-jbrunet@baylibre.com>
 <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
 <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
Date:   Thu, 30 Jul 2020 11:06:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 4:04 AM, Jerome Brunet wrote:
> 
> On Wed 29 Jul 2020 at 17:56, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> 
>> On 7/29/20 10:46 AM, Jerome Brunet wrote:
>>> commit b73287f0b0745 ('ASoC: soc-pcm: dpcm: fix playback/capture checks')
>>> changed dpcm_playback and dpcm_capture semantic by throwing an error if
>>> these flags are not aligned with DAIs capabilities on the link.
>>>
>>> The former semantic did not force the flags and DAI caps to be aligned.
>>> The flag previously allowed card drivers to disable a stream direction on
>>> a link (whether or not such feature is deemed useful).
>>>
>>> With change ('ASoC: core: use less strict tests for dailink capabilities')
>>> an error is thrown if the flags and and the DAI caps are not aligned. Those
>>> parameters were not meant to aligned initially. No technical reason was
>>> given about why cards should now be considered "broken" in such condition
>>> is not met, or why it should be considered to be an improvement to enforce
>>> that.
>>>
>>> Forcing the flags to be aligned with DAI caps just make the information
>>> the flag carry redundant with DAI caps, breaking a few cards along the way.
>>>
>>> This change drops the added error conditions and restore the initial flag
>>> semantics.
>>
>> or rather lack thereof.
> 
> Again, why ? All there is so far is your personal preference. no facts.

What would be the meaning/purpose of a dailink with .dpcm_capture set, 
with only dais that support playback only?

What would be the meaning/purpose of a dailink with .capture_only set, 
but with a dai that supports playback?

What happens if none of these flags are set?

What happens when all these flags are set?

No one seems to know, so my suggestion is to align first on consistent 
configurations, then see what can be removed.

>   * What we had gave capabilities to the link, independent of the DAI
>     components. ASoC just computes the intersection of all that to
>     determine which direction needs to be enabled. Seems rather simple
>     and straight forward.

that's what my last patch did, and when there is no intersection it 
complains. Please clarify what you expect when there is no overlap 
between dai and dailink capabilities. Keep in mind that we have a mix of 
hard-codec configuration and DT-created ones, your case is not the 
general one.

>   * It worked for every user of DPCM so a far.

Not completely true, when Morimoto-san added snd_soc_dai_stream_valid() 
it exposed tons of cases where the information on direction was not 
provided in a reliable at the DAI level. I will assert that we are still 
finding out cases with broken DAI configurations, and as a result we 
will also find broken dailink configurations. Your picture of DPCM as a 
perfectly functional system that I broke is a distortion of reality.

The reality is that we have to work in steps, first make sure all DAIs 
are properly described, then work on the dailinks and optimize at a 
later point. we will need warnings to find out what the problem cases 
are, and move slowly.

