Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41A3C433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F772065D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbgGVPjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:39:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:8030 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgGVPjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:39:24 -0400
IronPort-SDR: KNR6T1adjXyaJ6aOV2EgKtOsS/OISF3vfEr7vAhRKCy+XAk/J1PMdgaAiuNn6yzm+JMpDmJ18C
 AavDTXt+ffAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="129920849"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="129920849"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 08:39:23 -0700
IronPort-SDR: MsNqFHz8q1bHKMvZOTP2vEUpscZSheDN/J+yc70nwRaOKUgxioD6xzDP091iR7B1Lx0PSL6GGL
 RlIS4wosbJoQ==
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="272042508"
Received: from asinghi-mobl2.amr.corp.intel.com (HELO [10.255.231.54]) ([10.255.231.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 08:39:22 -0700
Subject: Re: [PATCH v2 8/9] ASoC: qdsp6-dai: add gapless support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        vkoul@kernel.org
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
 <20200721165306.29082-9-srinivas.kandagatla@linaro.org>
 <868d9768-a4c4-71c1-28fd-ca0e2f6564bf@linux.intel.com>
 <eadfd218-be93-0dc9-df94-a64ea494c6bf@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d572887f-8550-89dd-02f0-986ef081bf40@linux.intel.com>
Date:   Wed, 22 Jul 2020 10:31:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eadfd218-be93-0dc9-df94-a64ea494c6bf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>> @@ -917,6 +1018,14 @@ static int q6asm_dai_compr_trigger(struct 
>>> snd_soc_component *component,
>>>           ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
>>>                          CMD_PAUSE);
>>>           break;
>>> +    case SND_COMPR_TRIGGER_NEXT_TRACK:
>>> +        prtd->next_track = true;
>>> +        prtd->next_track_stream_id = (prtd->stream_id == 1 ? 2 : 1);
>>
>> it's rather odd, the initialization above uses next_track_stream_id = 0?
> 
> Vaild stream ids start from 1, So we are toggling this between 1 and 2.
> So when we set next_track_stream_id to 0, that means we have opened the 
> new next stream id and is set to prtd->stream_id. This logic is to 
> ensure that we are not going to open next stream id twice!

ok, adding a comment would be good to show this was intentional and not 
a mistake.
