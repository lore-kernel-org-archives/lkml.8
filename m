Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE506C433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9382820771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgGVPj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:39:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:8030 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgGVPjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:39:25 -0400
IronPort-SDR: E2bSXsD2uJlgqNYxTTHKdz2Jb4jG8tc6iurTJ6oPmBw5rHv5EzaDyBDgTEfB4sDtloUwttJvOS
 GmanwoWmdWWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="129920855"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="129920855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 08:39:25 -0700
IronPort-SDR: C2b6oH9BHmaHESFEJSQjOO1ebe0W9GOq0rwBYNyMB/IOzJs5StxBRs5w1vBDVlUaxH7SQzY3BD
 qF7lrsn0wNUg==
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="272042516"
Received: from asinghi-mobl2.amr.corp.intel.com (HELO [10.255.231.54]) ([10.255.231.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 08:39:24 -0700
Subject: Re: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting
 codec parameters
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        vkoul@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
 <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
 <9bbfebf9-9a70-46e3-1808-413d04aa6b2c@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <19cfe3fe-4b99-0976-679d-28523d7b9990@linux.intel.com>
Date:   Wed, 22 Jul 2020 10:36:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9bbfebf9-9a70-46e3-1808-413d04aa6b2c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>    * and the stream properties
>>> + * @set_codec_params: Sets the compressed stream codec parameters, 
>>> Optional
>>> + * This can be called in during gapless next track codec change only 
>>> to set
>>> + * codec params
>>
>> Would it be clearer if this was called set_next_codec_params()? or 
>> set_next_track_codec_params()?
>>
>> Having set_params() and set_codec_params() is a bit confusing since 
>> the semantic difference is not captured in the callback name.
> 
> set_next_track_codec_params seems more sensible as its next track params.
> Will change this in next version!

maybe set_params() and set_next_track_params() are enough, not sure if 
the codec reference helps?
