Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D0C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158D920737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgGWNR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:17:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:36647 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgGWNR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:17:26 -0400
IronPort-SDR: kD4X+p4srIKIw5IvCo7bVA9c3htJlxS+EIHYEvU/MJGd69WwXTkImapx1YwiKCzSYr7h2QZEYh
 EPJr6HRVd1EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="149693503"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="149693503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 06:17:25 -0700
IronPort-SDR: zbgCTcp4IHYwpFjzqAPenzobnSdjqR7FCNur+48Vt9nKvjlryi0J9tzZbQcNUZim/zBCp4RJGk
 PdPB2hRN0uxQ==
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="284574257"
Received: from sxholi-mobl1.amr.corp.intel.com (HELO [10.254.76.108]) ([10.254.76.108])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 06:17:24 -0700
Subject: Re: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting
 codec parameters
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        ckeepax@opensource.cirrus.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
 <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
 <9bbfebf9-9a70-46e3-1808-413d04aa6b2c@linaro.org>
 <19cfe3fe-4b99-0976-679d-28523d7b9990@linux.intel.com>
 <20200723044734.GU12965@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8afd732a-750f-08d6-87a0-3088b4957f82@linux.intel.com>
Date:   Thu, 23 Jul 2020 08:17:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723044734.GU12965@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/20 11:47 PM, Vinod Koul wrote:
> On 22-07-20, 10:36, Pierre-Louis Bossart wrote:
>>
>>>>>     * and the stream properties
>>>>> + * @set_codec_params: Sets the compressed stream codec
>>>>> parameters, Optional
>>>>> + * This can be called in during gapless next track codec change
>>>>> only to set
>>>>> + * codec params
>>>>
>>>> Would it be clearer if this was called set_next_codec_params()? or
>>>> set_next_track_codec_params()?
>>>>
>>>> Having set_params() and set_codec_params() is a bit confusing since
>>>> the semantic difference is not captured in the callback name.
>>>
>>> set_next_track_codec_params seems more sensible as its next track params.
>>> Will change this in next version!
>>
>> maybe set_params() and set_next_track_params() are enough, not sure if the
>> codec reference helps?
> 
> params typically refers to whole set of compress parameters which
> includes buffer information and codec parameters, so codec reference
> would help.

then add the codec reference to both...
