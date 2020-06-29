Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58A5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3F220663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgF2T2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:28:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:4711 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbgF2T2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:28:00 -0400
IronPort-SDR: axONr3dzOZxBB0FcL2BR7NmIdsILfZE04A+GUKmzHhzldvE/d5s2GLDgQi1Qo6M8v5YqjpIAks
 AayGYxLav09w==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144994055"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="144994055"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:05:54 -0700
IronPort-SDR: IHiZZ/2uBuE5q2uzoxtbPOUbIzaP7Wo9/jcAKm7ZJOpzRcmOePKvJX5Ce58yg769rkZSCPsxuC
 /y1DUk+xeuiQ==
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="424751636"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.138.39]) ([10.249.138.39])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:05:52 -0700
Subject: Re: [PATCH v4 1/3] ALSA: compress: document the compress audio state
 machine
To:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20200629075002.11436-1-vkoul@kernel.org>
 <20200629075002.11436-2-vkoul@kernel.org>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <c29b3199-cebd-2153-5530-e75f76aa8b4b@linux.intel.com>
Date:   Mon, 29 Jun 2020 11:05:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629075002.11436-2-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2020 9:50 AM, Vinod Koul wrote:
> So we had some discussions of the stream states, so I thought it is a
> good idea to document the state transitions, so add it documentation
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   .../sound/designs/compress-offload.rst        | 51 +++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> index ad4bfbdacc83..b6e9025ae105 100644
> --- a/Documentation/sound/designs/compress-offload.rst
> +++ b/Documentation/sound/designs/compress-offload.rst
> @@ -151,6 +151,57 @@ Modifications include:
>   - Addition of encoding options when required (derived from OpenMAX IL)
>   - Addition of rateControlSupported (missing in OpenMAX AL)
>   
> +State Machine
> +=============
> +
> +The compressed audio stream state machine is described below ::
> +
> +                                        +----------+
> +                                        |          |
> +                                        |   OPEN   |
> +                                        |          |
> +                                        +----------+
> +                                             |
> +                                             |
> +                                             | compr_set_params()
> +                                             |
> +                                             v
> +         compr_free()                   +----------+
> +  +------------------------------------|          |
> +  |                                    |   SETUP  |
> +  |          +------------------------>|          |<-------------------------+
> +  |          | compr_drain_notify()    +----------+                          |
> +  |          |         or                   ^                                |
> +  |          |      compr_stop()            |                                |
> +  |          |                              | compr_write()                  |
> +  |          |                              |                                |
> +  |          |                              |                                |
> +  |          |                         +----------+                          |
> +  |          |                         |          |   compr_free()           |
> +  |          |                         |  PREPARE |---------------> A        |
> +  |          |                         |          |                          |
> +  |          |                         +----------+                          |
> +  |          |                              |                                |
> +  |          |                              |                                |
> +  |          |                              | compr_start()                  |
> +  |          |                              |                                |
> +  |          |                              v                                |
> +  |    +----------+                    +----------+                          |
> +  |    |          |    compr_drain()   |          |        compr_stop()      |
> +  |    |  DRAIN   |<-------------------|  RUNNING |--------------------------+
> +  |    |          |                    |          |                          |
> +  |    +----------+                    +----------+                          |
> +  |                                       |    ^                             |
> +  |          A                            |    |                             |
> +  |          |              compr_pause() |    | compr_resume()              |
> +  |          |                            |    |                             |
> +  |          v                            v    |                             |
> +  |    +----------+                   +----------+                           |
> +  |    |          |                   |          |         compr_stop()      |
> +  +--->|   FREE   |                   |  PAUSE   |---------------------------+
> +       |          |                   |          |
> +       +----------+                   +----------+
> +
>   
>   Gapless Playback
>   ================
> 

Line containing compr_free (between SETUP and FREE) seems to be misaligned?

If you move prepare to the left and drain in place of drain, it feels 
like you won't need this weird indirection with A
Something like:

 >> +                                             v
>> +         compr_free()                   +----------+
>> +  +------------------------------------|          |
>> +  |                                    |   SETUP  |
>> +  |          +------------------------>|          |<-------------------------+
>> +  |          | compr_write()           +----------+                          |
>> +  |          |                              ^                                |
>> +  |          |                              | compr_drain_notify() or        |
>> +  |          |                              | compr_stop()                   |
>> +  |          |                              |                                |
>> +  |          |                              |                                |
>> +  |          |                         +----------+                          |
>> +  |          |                         |          |                          |
>> +  |          |                         |  DRAIN   |                          |
>> +  |          |                         |          |                          |
>> +  |          |                         +----------+                          |
>> +  |          |                              ^                                |
>> +  |          |                              |                                |
>> +  |          |                              | compr_drain()                  |
>> +  |          |                              |                                |
>> +  |          |                              |                                |
>> +  |    +----------+                    +----------+                          |
>> +  |    |          |    compr_start()   |          |        compr_stop()      |
>> +  |    |  PREPARE |------------------->|  RUNNING |--------------------------+
>> +  |    |          |                    |          |                          |
>> +  |    +----------+                    +----------+                          |
>> +  |          |                            |    ^                             |
>> +  |          | compr_free()               |    |                             |
>> +  |          |              compr_pause() |    | compr_resume()              |
>> +  |          |                            |    |                             |
>> +  |          v                            v    |                             |
>> +  |    +----------+                   +----------+                           |
>> +  |    |          |                   |          |         compr_stop()      |
>> +  +--->|   FREE   |                   |  PAUSE   |---------------------------+
>> +       |          |                   |          |
>> +       +----------+                   +----------+
>> +

but this makes me question PREPARE state, how do you enter it?
