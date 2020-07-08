Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428D22063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgGHQ62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:58:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:50803 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHQ62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:58:28 -0400
IronPort-SDR: 2E9sGbbmlDZbh0AuCHFKBOF2YqHzGuhL7Gp9NggbspfwobICaWsN149psnq8hYg+OQtcSRLt7I
 yapTvW2KveiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="149360287"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="149360287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:58:23 -0700
IronPort-SDR: roGAQ+C7dQ+FJJZSqTi34AQnhgyYC0DtG4s6q1coKI7tPOCpFfdRkjC2CATJp7RkOUcJVllJ5L
 f+1n0hQF6NXA==
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="358162394"
Received: from sare-mobl.amr.corp.intel.com (HELO [10.251.7.246]) ([10.251.7.246])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:58:23 -0700
Subject: Re: [PATCH 10/11] ASoC: qdsp6-dai: add gapless support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
 <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
 <04a7f696-e23d-5563-7cc3-aedfaf2c7636@linaro.org>
 <cf9b2d33-9b63-f3d2-2e51-a88c528dad53@linux.intel.com>
 <e6d10009-d01e-d506-1aa3-a915ef42a693@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b0aa1cff-33c9-a44d-b17b-d2e4e42d60f1@linux.intel.com>
Date:   Wed, 8 Jul 2020 11:58:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e6d10009-d01e-d506-1aa3-a915ef42a693@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> right, but the key point is 'switch between streams'. That means a 
>> more complex/capable implementation that should be advertised as such 
>> to applications. This is not the default behavior assumed initially: 
>> to allow for minimal implementations in memory-constrained devices, we 
>> assumed gapless was supported with a single decoder.
>>
>> Maybe the right way to do this is extend the snd_compr_caps structure:
>>
>> /**
>>   * struct snd_compr_caps - caps descriptor
>>   * @codecs: pointer to array of codecs
>>   * @direction: direction supported. Of type snd_compr_direction
>>   * @min_fragment_size: minimum fragment supported by DSP
>>   * @max_fragment_size: maximum fragment supported by DSP
>>   * @min_fragments: min fragments supported by DSP
>>   * @max_fragments: max fragments supported by DSP
>>   * @num_codecs: number of codecs supported
>>   * @reserved: reserved field
>>   */
>> struct snd_compr_caps {
>>      __u32 num_codecs;
>>      __u32 direction;
>>      __u32 min_fragment_size;
>>      __u32 max_fragment_size;
>>      __u32 min_fragments;
>>      __u32 max_fragments;
>>      __u32 codecs[MAX_NUM_CODECS];
>>      __u32 reserved[11];
>> } __attribute__((packed, aligned(4)));
>>
>>
>> and use a reserved field to provide info on capabilities, and filter 
>> the set_codec_params() addition based this capability - i.e. return 
>> -ENOTSUP in 'traditional' implementations based on a single 
>> 'stream'/decoder instance.

I think this is also what Mark was referring to earlier.

> Sounds good!
> I will give it a go and see how it ends up!

Glad to see this discussion progressing.

We may also want to document the 3 possible ways of supporting gapless 
playback while we are at it:
a) with the existing single decoder assumption
b) with your suggested solution with a switch at the DSP level
c) with 2 streams at the userspace level and a switch/x-fade at the DSP 
level - which may simplify userspace quite a bit and was the initial 
design in a non-Linux OS.
