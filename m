Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F871C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE84206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgGFPDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:03:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:26303 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgGFPDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:03:17 -0400
IronPort-SDR: nuocK0PEOkFbPxu/yWYn3qwge7vk5jY1lfG5gagcyUs+ldKtKPIY82UHYINflZz8id/lRZ84P2
 N0m3oI9oIB5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="144932261"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="144932261"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 08:03:16 -0700
IronPort-SDR: L2Z3VR5sFl9G4jx008pgy5I4rdrzbvcEZVVZuOT1zJtYIDuouKToK++PVl7NF1i3/4++i90Gb7
 TBDYFAOfGVFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="313986367"
Received: from aislam-mobl1.amr.corp.intel.com ([10.212.167.133])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 08:03:15 -0700
Subject: Re: [PATCH 3/8] ASoC: samsung: pcm: fix kernel-doc
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
 <CGME20200702165920eucas1p236c3c4c82424ea459ea88ebacf9b8a6e@eucas1p2.samsung.com>
 <20200702165901.164100-4-pierre-louis.bossart@linux.intel.com>
 <d6980967-5def-58c9-39a9-239a5c671f3f@samsung.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7b485413-98f1-fb13-2e82-4eeacbfff6dc@linux.intel.com>
Date:   Mon, 6 Jul 2020 10:03:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <d6980967-5def-58c9-39a9-239a5c671f3f@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 1:47 PM, Sylwester Nawrocki wrote:
> On 02.07.2020 18:58, Pierre-Louis Bossart wrote:
>> Fix W=1 warnings - missing fields in structure
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/samsung/pcm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
>> index a5b1a12b3496..86eefbc89e9e 100644
>> --- a/sound/soc/samsung/pcm.c
>> +++ b/sound/soc/samsung/pcm.c
>> @@ -104,8 +104,13 @@
> 
> Thank you for the patch, I have some suggestions to improve the comments.
> 
>>   /**
>>    * struct s3c_pcm_info - S3C PCM Controller information
>> + * @lock: Spin lock
> 
> @lock: Spin lock to serialize access to the device registers and @idle_clk
> 
>>    * @dev: The parent device passed to use from the probe.
>>    * @regs: The pointer to the device register block.
>> + * @sclk_per_fs: number of sclk per frame sync
>> + * @idleclk: Whether to keep PCMSCLK enabled even when idle(no active xfer)
> 
> How about adding space before the opening parenthesis?
> 
>> + * @pclk: the pclk pointer
> 
> @pclk: the PCLK_PCM (pcm) clock pointer
> 
>> + * @cclk: the clck pointer
> 
> @cclk: the SCLK_AUDIO (audio-bus) clock pointer
> 
>>    * @dma_playback: DMA information for playback channel.
>>    * @dma_capture: DMA information for capture channel.
>>    */
>   
> With above changes feel free to add:
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I wasn't really happy with the lame comments I added for pclk and cclk, 
thanks for suggesting a better wording. Will fix in a v2.

